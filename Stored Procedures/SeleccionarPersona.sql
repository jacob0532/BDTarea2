USE [ProyectoBD1]
GO
/****** Object:  StoredProcedure [dbo].[SeleccionarCuentaAhorro]    Script Date: 1/12/2020 21:49:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeleccionarPersona]
	@inUsuarioid INT
	--
	, @outPersonaId INT OUTPUT
	, @OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
			-- se declaran variables
			--DECLARE
			--@nuevoSaldo money
			-- se inicializan variables
			SELECT
			@OutResultCode=0;
			IF NOT EXISTS(SELECT 1 FROM dbo.Usuario U WHERE U.id=@inUsuarioid)
				BEGIN
					Set @OutResultCode=50001; -- Validacion
					RETURN
				END;

			SET TRANSACTION ISOLATION LEVEL READ COMMITTED
			BEGIN TRANSACTION TSeleccionarP
				SELECT * FROM dbo.Persona
				WHERE Usuarioid = @inUsuarioid
				SET @outPersonaId = SCOPE_IDENTITY(); --Retorna el ultimo id insertado 

			COMMIT TRANSACTION TSeleccionarP; -- asegura el TODO, que las todas actualizaciones "quedan" en la BD.
	END TRY
	BEGIN CATCH
			IF @@TRANCOUNT>0 -- chequeo que el errror sucedio dentro de la transaccion
				ROLLBACK TRANSACTION TSeleccionarP; -- asegura el Nada, deshace las actualizaciones previas al error
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