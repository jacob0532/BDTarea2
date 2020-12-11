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

		-- se inicializan variables		
		SET @OutResultCode = 0	--Codigo de retorno.

		--Obtiene el id del estado de cuenta
		SELECT @EstadoDeCuentaID = EC.id 
		FROM EstadoCuenta
		INNER JOIN EstadoCuenta EC ON EC.CuentaAhorroid = @inCuentaId
		WHERE @inFecha BETWEEN EC.FechaInicio
				AND EC.FechaFin

		--Se obtiene el nombre del tipo de movimiento
		SELECT @TipoMovimiento = TipoOperacion
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