USE [ProyectoBD1]
GO
/****** Object:  StoredProcedure [dbo].[BuscarMovimientoEspecifico]    Script Date: 9/12/2020 16:01:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BuscarMovimientoEspecifico]
	 @inDescripcion VARCHAR(100)
	,@inEstadoCuentaid INT
	--
	,@outMovimientoId INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
			-- se declaran variables
			--DECLARE
			--@nuevoSaldo money
			-- se inicializan variables
			SELECT
			@OutResultCode=0,
			@inDescripcion = '%'+@inDescripcion+'%';
			IF NOT EXISTS(SELECT 1 FROM dbo.EstadoCuenta E WHERE E.id=@inEstadoCuentaid)
				BEGIN
					Set @OutResultCode=50001; -- Validacion
					RETURN
				END;

			SET TRANSACTION ISOLATION LEVEL READ COMMITTED
			BEGIN TRANSACTION TBuscarMovimiento
				--SELECT * FROM dbo.MovimientoCuentaAhorro
				--WHERE Descripcion LIKE @inDescripcion and EstadoCuentaid = @inEstadoCuentaid
				SELECT M.id,M.Fecha,M.Monto,M.NuevoSaldo,M.EstadoCuentaid,M.CuentaAhorroid,TM.Nombre, TM.TipoOperacion,M.Descripcion FROM TipoMovimientoCuentaAhorro AS TM INNER JOIN MovimientoCuentaAhorro AS M ON TM.id = M.TipoMovimientoCuentaAhorroid and EstadoCuentaid = @inEstadoCuentaid and Descripcion LIKE @inDescripcion
				Set @outMovimientoId = SCOPE_IDENTITY(); --Retorna el ultimo id insertado 

			COMMIT TRANSACTION TBuscarMovimiento; -- asegura el TODO, que las todas actualizaciones "quedan" en la BD.
	END TRY
	BEGIN CATCH
			IF @@TRANCOUNT>0 -- chequeo que el errror sucedio dentro de la transaccion
				ROLLBACK TRANSACTION TBuscarMovimiento; -- asegura el Nada, deshace las actualizaciones previas al error
				INSERT INTO dbo.Errores VALUES (
					SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE()
				);
				SET @OutResultCode=50005;
	END CATCH
	SET NOCOUNT OFF
END;