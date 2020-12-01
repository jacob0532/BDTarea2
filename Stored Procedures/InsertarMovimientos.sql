USE [ProyectoBD1]
GO
/****** Object:  StoredProcedure [dbo].[InsertarMovimientos]    Script Date: 11/30/2020 10:53:06 PM ******/
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
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		-- se declaran variables
		DECLARE @nuevoSaldo MONEY

		-- se inicializan variables
		SELECT @OutResultCode = 0

		-- Validacion de paramentros de entrada
		IF NOT EXISTS (SELECT 1 FROM dbo.CuentaAhorro C WHERE C.iD = @inCuentaId)
		BEGIN
			SET @OutResultCode = 50001;-- cuenta no existe
			RETURN
		END;

		IF NOT EXISTS (SELECT 1 FROM dbo.TipoMovimientoCuentaAhorro M WHERE M.ID = @inTipoMovimientoId)
		BEGIN
			SET @OutResultCode = 50002;-- tipo de movimiento no existe
			RETURN
		END;

		SELECT @NuevoSaldo = CA.Saldo + @inMoNTO
		FROM dbo.CuentaAhorro CA
		WHERE CA.Id = @inCuentaId;

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TSaveMov

		DECLARE @EstadoDeCuentaID INT
		SELECT @EstadoDeCuentaID = EC.id FROM EstadoCuenta INNER JOIN EstadoCuenta EC ON EC.CuentaAhorroid = @inCuentaId

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

		UPDATE dbo.CuentaAhorro
		SET Saldo = Saldo + @inMonto
		WHERE Id = @inCuentaId

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