USE [ProyectoBD1]
GO
/****** Object:  StoredProcedure [dbo].[InsertarMovimientos]    Script Date: 12/1/2020 2:43:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarMovimientos] 
	@inCuentaId INT
	,@inTipoMovimientoId INT
	,@inMonto MONEY
	,@inFecha DATE
	,@inDescripcion VARCHAR(200)
	,@OutMovimientoId INT OUTPUT
	,@OutResultCode INT OUTPUT
	,@OutNuevoSaldo INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		-- se declaran variables
		DECLARE @nuevoSaldo MONEY		--Nuevo sald.
		DECLARE @EstadoDeCuentaID INT	--Estado de cuenta.
		DECLARE @TipoMovimiento VARCHAR(20)

		-- se inicializan variables		
		SELECT @OutResultCode = 0					--Codigo de retorno en 0
			
		SELECT @EstadoDeCuentaID = EC.id			--Id del estado de cuenta
		FROM EstadoCuenta 
		INNER JOIN EstadoCuenta EC ON EC.CuentaAhorroid = @inCuentaId 
		WHERE @inFecha BETWEEN EC.FechaInicio AND EC.FechaFin	

		SELECT @NuevoSaldo = CA.Saldo + @inMoNTO	--Se calcula el nuevo saldo
		FROM dbo.CuentaAhorro CA
		WHERE CA.Id = @inCuentaId;

		SELECT @TipoMovimiento = TipoOperacion		--Tipo movimiento
		FROM TipoMovimientoCuentaAhorro TM 
		WHERE TM.id = @inTipoMovimientoId

		-- Validación de paramentros de entrada
		IF NOT EXISTS (SELECT 1 FROM dbo.CuentaAhorro C WHERE C.iD = @inCuentaId)		
			BEGIN
				SET @OutResultCode = 50001;	-- Cuenta no existe
				RETURN
			END;

		IF NOT EXISTS (SELECT 1 FROM dbo.TipoMovimientoCuentaAhorro M WHERE M.ID = @inTipoMovimientoId)
			BEGIN
				SET @OutResultCode = 50002;	-- Tipo de movimiento no existe
				RETURN
			END;

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TSaveMov
			INSERT INTO MovimientoCuentaAhorro(
					Fecha
					,Monto
					,NuevoSaldo
					,EstadoCuentaid
					,TipoMovimientoCuentaAhorroid
					,CuentaAhorroid
					,Descripcion
				)
			VALUES (
					@inFecha
					,@inMonto
					,@NuevoSaldo
					,@EstadoDeCuentaID
					,@inTipoMovimientoId
					,@inCuentaId
					,@inDescripcion
				)

			SET @outMovimientoId = SCOPE_IDENTITY();

			IF (@TipoMovimiento = 'Credito')
				BEGIN
					--Se actualiza el credito en la cuenta de ahorro
					UPDATE dbo.CuentaAhorro
					SET Saldo = @nuevoSaldo
					WHERE Id = @inCuentaId
				END;
			ELSE
				BEGIN
					--Se actualiza el debito en la cuenta de ahorro
					UPDATE dbo.CuentaAhorro
					SET Saldo = @nuevoSaldo
					WHERE Id = @inCuentaId
				END;

		SET @OutNuevoSaldo = @nuevoSaldo
		COMMIT TRANSACTION TSaveMov;-- asegura el TODO, que las todas actualizaciones "quedan"en la BD.
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 -- chequeo que el errror sucedio dentro de la transaccion
			ROLLBACK TRANSACTION TSaveMov;-- asegura el Nada, deshace las actualizaciones previas al error

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