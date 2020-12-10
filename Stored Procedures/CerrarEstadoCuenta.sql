USE [ProyectoBD1]
GO
/****** Object:  StoredProcedure [dbo].[InsertarMovimientos]    Script Date: 12/1/2020 2:43:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CerrarEstadoCuenta] 
	@inCuentaCierra INT
	,@inFechaInicio DATE
	,@inFechaFin DATE
	,@OutMovimientoId INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		-- Se declaran variables
		DECLARE @SaldoFinal MONEY = 0
		DECLARE @SaldoInicial MONEY
		DECLARE @TipoCuentaAhorroId INT
		DECLARE @CuentaId INT, @EstadoCuentaId INT
		DECLARE @MultaSaldoMin MONEY, @SaldoMin MONEY
		DECLARE @NumeroRetirosHumano INT, @NumeroRetirosAutomatico INT
		DECLARE @MultaNumRetirosCH MONEY, @MultaNumRetirosCA MONEY
		DECLARE @Interes MONEY

		-- Se inicializan variables
		SELECT @OutResultCode = 0	--Codigo de retorno
		SELECT @SaldoInicial = Saldo FROM CuentaAhorro CA WHERE CA.NumeroCuenta = @inCuentaCierra
		SELECT @CuentaId = Id FROM CuentaAhorro WHERE NumeroCuenta = @inCuentaCierra	--Id de la cuenta asociado al numero de cuenta.
		SELECT @TipoCuentaAhorroId = CA.TipoCuentaId FROM CuentaAhorro CA WHERE CA.id = @CuentaId		--El tipo de cuenta de ahorro de la cuenta
		--BUG
		SELECT @EstadoCuentaId = id FROM EstadoCuenta EC WHERE EC.CuentaAhorroid = @CuentaId AND EC.FechaInicio = @inFechaInicio AND Ec.FechaFin = @inFechaFin	--El id del estado de cuenta
		SELECT @MultaSaldoMin = T.MultaSaldoMin, @SaldoMin = T.SaldoMinimo FROM TipoCuentaAhorro T WHERE T.id = @TipoCuentaAhorroId --Multa de saldo minimo
		SELECT @NumeroRetirosHumano = NumRetirosHumano FROM TipoCuentaAhorro TC WHERE TC.id = @TipoCuentaAhorroId
		SELECT @NumeroRetirosAutomatico  = NumRetirosAutomatico FROM TipoCuentaAhorro TC WHERE TC.id = @TipoCuentaAhorroId
		SELECT @MultaNumRetirosCH  = ComisionHumano FROM TipoCuentaAhorro TC WHERE TC.id = @TipoCuentaAhorroId
		SELECT @Interes = T.Interes FROM TipoCuentaAhorro  T WHERE T.id = @TipoCuentaAhorroId
		
		IF (@CuentaId IS NULL )
			BEGIN
				SET @OutResultCode = 50017
				RETURN
			END;

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION TSaveCerrEst

			DECLARE @EstadoDeCuentaID INT
					,@OutNumRetirosHumano INT
					,@OutNumRetirosCajero INT
					,@OutSaldoFinal MONEY
					,@OutMovimientoECId INT
					,@OutResultCodeEC INT

			EXEC [dbo].[ProcesarMovimientos] 
					@inCuentaCierra
					,@inFechaInicio
					,@inFechaFin
					,@OutNumRetirosHumano OUTPUT
					,@OutNumRetirosCajero OUTPUT
					,@OutSaldoFinal OUTPUT
					,@OutMovimientoECId OUTPUT
					,@OutResultCodeEC OUTPUT

			SELECT  @SaldoFinal = @OutSaldoFinal

			DECLARE @OutMovimientoIdMov INT ,@OutResultCodeMov INT, @OutNuevoSaldo MONEY
			IF(@OutNumRetirosHumano > @NumeroRetirosHumano)	--Multa por retiros cajero humano.
				BEGIN
					EXEC	[dbo].[InsertarMovimientos] 
							@CuentaId
							,8
							,@MultaNumRetirosCH
							,@inFechaFin
							,'Multa por retiro cajero humano'
							,@OutMovimientoIdMov OUTPUT
							,@OutResultCodeMov OUTPUT
							,@OutNuevoSaldo OUTPUT

					SET @SaldoFinal = @OutNuevoSaldo
				END;

			IF(@OutNumRetirosCajero >  @NumeroRetirosAutomatico)	--Multas por retiro cajero automatico.
				BEGIN
					EXEC	[dbo].[InsertarMovimientos] 
							@CuentaId
							,9
							,@MultaNumRetirosCA
							,@inFechaFin
							,'Multa por retiro cajero humano'
							,@OutMovimientoIdMov OUTPUT
							,@OutResultCodeMov OUTPUT
							,@OutNuevoSaldo OUTPUT

					SET	@SaldoFinal = @OutNuevoSaldo
				END;

			IF(@SaldoFinal < @SaldoMin AND (@SaldoFinal - @MultaSaldoMin) > 0) -- Multa por saldo minimo
				BEGIN
					SET @SaldoFinal = @SaldoFinal - @MultaSaldoMin
					UPDATE dbo.CuentaAhorro --Solucion provisional
					SET Saldo = @SaldoFinal
					WHERE NumeroCuenta = @inCuentaCierra
				END;

			IF(@SaldoFinal > @SaldoMin) -- Intereses
				BEGIN 
					DECLARE @InteresesGanados MONEY =dbo.CalcularInteres(@SaldoFinal,@Interes)
					EXEC	[dbo].[InsertarMovimientos] 
							@CuentaId
							,7
							,@InteresesGanados
							,@inFechaFin
							,'Intereses del mes sobre saldo MInimo'
							,@OutMovimientoIdMov OUTPUT
							,@OutResultCodeMov OUTPUT
							,@OutNuevoSaldo OUTPUT
					SET @SaldoFinal = @OutNuevoSaldo
				END;
			--Se actualiza el movimiento en la base de datos
			UPDATE dbo.EstadoCuenta
			SET  SaldoFinal = @SaldoFinal
			WHERE Id = @EstadoCuentaId

			SET @outMovimientoId = SCOPE_IDENTITY();

		COMMIT TRANSACTION TSaveCerrEst;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION TSaveCerrEst;

		INSERT INTO dbo.Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
