USE [ProyectoBD1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarMovimientos]
	@inCuentaId INT,
	@inTipoMovimientoId INT,
	@inMonto MONEY,
	@inFecha DATE,
	@inDescripcion VARCHAR(200),
	@OutMovimientoId INT OUTPUT,
	@OutResultCode INT OUTPUT,
	@OutNuevoSaldo INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		-- se declaran variables
		DECLARE @nuevoSaldo MONEY			--Nuevo saldo.
		DECLARE @EstadoDeCuentaID INT		--Estado de cuenta.
		DECLARE @TipoMovimiento VARCHAR(20)	--Tipo de movimiento

		DECLARE @ComisionCH MONEY,			--Comision cajero humano (Tipo de cuenta)
				@ComisionCA MONEY,			--Comision cajero automatico (Tipo de cuenta)
				@NumRetirosCH INT,			--Numero de retiros cajero humano (Tipo de cuenta) 
				@NumRetirosCA INT,			--Numero de retiros cajero automatico (Tipo de cuenta)
				@NumRetirosCHEC INT,		--Contador de retiros cajero humano (Estado Cuenta)
				@NumRetirosCAEC INT			--Contador de retiros cajero automatico (Estado Cuenta)

		--Output SP multas por CA y CH 
		DECLARE @OutMovimientoIdMov INT,
				@OutResultCodeMov INT,
				@OutNuevoSaldoMov INT


		-- se inicializan variables		
		SET @OutResultCode = 0	--Codigo de retorno.

		--Obtiene el id del estado de cuenta
		SELECT	@EstadoDeCuentaID = EC.id,
				@NumRetirosCAEC = EC.RetirosCA,
				@NumRetirosCHEC = EC.RetirosCH
		FROM EstadoCuenta
		INNER JOIN EstadoCuenta EC ON EC.CuentaAhorroid = @inCuentaId
		WHERE @inFecha BETWEEN EC.FechaInicio
				AND EC.FechaFin
		
		--Numero de retiros y comisiones de cajero automatico y cajero humano.
		SELECT	@ComisionCA = TC.ComisionAutomatico,
				@ComisionCH = TC.ComisionHumano,
				@NumRetirosCH = TC.NumRetirosHumano,
				@NumRetirosCA = Tc.NumRetirosAutomatico
		FROM  [dbo].[CuentaAhorro] C
		INNER JOIN TipoCuentaAhorro TC ON C.TipoCuentaId = TC.id
		WHERE C.id = @inCuentaId

	
		--Se obtiene el nombre del tipo de movimiento
		SELECT	@TipoMovimiento = TipoOperacion
		FROM TipoMovimientoCuentaAhorro TM
		WHERE TM.id = @inTipoMovimientoId

		-- Verifica si la cuenta existe.
		IF NOT EXISTS (
				SELECT 1
				FROM dbo.CuentaAhorro C
				WHERE C.iD = @inCuentaId
				)
		BEGIN
			SET @OutResultCode = 50001;-- Cuenta no existe

			RETURN
		END;

		-- Verifica si no existe el tipo de movimiento.
		IF NOT EXISTS (
				SELECT 1
				FROM dbo.TipoMovimientoCuentaAhorro M
				WHERE M.ID = @inTipoMovimientoId
				)
		BEGIN
			SET @OutResultCode = 50002;-- Tipo de movimiento no existe

			RETURN
		END;

		--Calcula el nuevo saldo 
		SELECT @nuevoSaldo = (
				CASE 
					WHEN @TipoMovimiento = 'Credito'
						THEN CA.Saldo + @inMoNTO
					ELSE CA.Saldo - @inMonto
					END
				)
		FROM dbo.CuentaAhorro CA
		WHERE CA.Id = @inCuentaId;

		--Verifica si hay un retiro por cajero humano y verifica si se aplica multa
		IF(@inTipoMovimientoId = 8)
			BEGIN 
				SET @NumRetirosCH = @NumRetirosCH + 1

				UPDATE [dbo].[EstadoCuenta]
				SET RetirosCH = @NumRetirosCH
				WHERE id =  @EstadoDeCuentaID

				--Se aplica la multa
				IF(@NumRetirosCHEC >  @NumRetirosCH)
					BEGIN
						EXEC	[dbo].[InsertarMovimientos]
								@inCuentaId, 
								8, 
								@ComisionCH, 
								@inFecha, 
								'Comision exceso de operacion en CH', 
								@OutMovimientoIdMov OUTPUT, 
								@OutResultCodeMov OUTPUT,
								@OutNuevoSaldoMov OUTPUT
					END

			END;
		--Verifica si hay un retiro por cajero automatico y verifica si se aplica multa
		IF(@inTipoMovimientoId = 9)
			BEGIN
				SET @NumRetirosCA = @NumRetirosCA + 1

				UPDATE [dbo].[EstadoCuenta]
				SET RetirosCA = @NumRetirosCA
				WHERE id =  @EstadoDeCuentaID	

				--Se aplica la multa
				IF(@NumRetirosCAEC >  @NumRetirosCA)
					BEGIN
						EXEC	[dbo].[InsertarMovimientos]
								@inCuentaId, 
								9, 
								@ComisionCA, 
								@inFecha, 
								'Comision exceso de operacion en CA', 
								@OutMovimientoIdMov OUTPUT, 
								@OutResultCodeMov OUTPUT,
								@OutNuevoSaldoMov OUTPUT
					END				
			END;

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TSaveMov


		INSERT INTO MovimientoCuentaAhorro (
			Fecha,
			Monto,
			NuevoSaldo,
			EstadoCuentaid,
			TipoMovimientoCuentaAhorroid,
			CuentaAhorroid,
			Descripcion
			)
		VALUES (
			@inFecha,
			@inMonto,
			@NuevoSaldo,
			@EstadoDeCuentaID,
			@inTipoMovimientoId,
			@inCuentaId,
			@inDescripcion
			)


		--Se actualiza el credito en la cuenta de ahorro
		UPDATE dbo.CuentaAhorro
		SET Saldo = @nuevoSaldo
		WHERE Id = @inCuentaId

		SET @outMovimientoId = SCOPE_IDENTITY();
		SET @OutNuevoSaldo = @nuevoSaldo

		COMMIT TRANSACTION TSaveMov;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION TSaveMov;

		INSERT INTO dbo.Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;