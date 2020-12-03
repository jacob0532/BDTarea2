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
		DECLARE @TipoCuentaAhorroId INT
		DECLARE @CuentaId INT, @EstadoCuentaId INT
		DECLARE @MultaSaldoMin MONEY, @SaldoMin MONEY

		-- Se inicializan variables
		SELECT @OutResultCode = 0
		SELECT @CuentaId = Id FROM CuentaAhorro WHERE NumeroCuenta = @inCuentaCierra
		SELECT @TipoCuentaAhorroId = TipoCuentaId FROM CuentaAhorro CA WHERE CA.id = @CuentaId
		SELECT @EstadoCuentaId = id FROM EstadoCuenta EC WHERE EC.CuentaAhorroid = @CuentaId AND EC.FechaInicio = @inFechaInicio
		SELECT @MultaSaldoMin = T.MultaSaldoMin, @SaldoMin = T.SaldoMinimo FROM TipoCuentaAhorro T WHERE T.id = @TipoCuentaAhorroId 
		

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

			IF(@OutNumRetirosHumano > (SELECT NumRetirosHumano FROM TipoCuentaAhorro TC WHERE TC.id = @TipoCuentaAhorroId) )
				BEGIN
					SELECT @SaldoFinal = @SaldoFinal - (SELECT ComisionHumano FROM TipoCuentaAhorro TC WHERE TC.id = @TipoCuentaAhorroId)
				END;

			IF(@OutNumRetirosCajero > (SELECT NumRetirosAutomatico FROM TipoCuentaAhorro TC WHERE TC.id = @TipoCuentaAhorroId) )
				BEGIN
					SELECT @SaldoFinal = @SaldoFinal - (SELECT ComisionAutomatico FROM TipoCuentaAhorro TC WHERE TC.id = @TipoCuentaAhorroId)
				END;
			IF(@SaldoFinal < @SaldoMin) -- Multa por saldo minimo
				BEGIN
					SELECT @SaldoFinal = @SaldoFinal - @MultaSaldoMin
				END;

			--Se actualiza el movimiento en la base de datos
			UPDATE dbo.EstadoCuenta
			SET SaldoFinal = @SaldoFinal
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
