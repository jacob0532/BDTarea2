CREATE PROCEDURE dbo.CrearCuentaObjetivo
	@inFechaInicio DATE
	, @inFechaFin DATE
	, @inCosto MONEY
	, @inObjetivo VARCHAR(100)
	, @inSaldo MONEY
	, @inInteresesAcumulados MONEY
	, @inCuentaAhorroid INT
	--
	, @outCuentaObjetivoId INT OUTPUT
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
			IF NOT EXISTS(SELECT 1 FROM dbo.CuentaAhorro C WHERE C.id=@inCuentaAhorroid)
				BEGIN
					Set @OutResultCode=50001; -- Validacion
					RETURN
				END;

			SET TRANSACTION ISOLATION LEVEL READ COMMITTED
			BEGIN TRANSACTION TCrearCuentaObjetivo
				INSERT INTO CuentaObjetivo(FechaInicio, FechaFin, Costo, Objetivo, Saldo,InteresesAcumulados,CuentaAhorroid)
				VALUES (@inFechaInicio, @inFechaFin, @inCosto, @inObjetivo, @inSaldo,@inInteresesAcumulados,@inCuentaAhorroid)
				Set @outCuentaObjetivoId = SCOPE_IDENTITY(); --Retorna el ultimo id insertado 

			COMMIT TRANSACTION TCrearCuentaObjetivo; -- asegura el TODO, que las todas actualizaciones "quedan" en la BD.
	END TRY
	BEGIN CATCH
			IF @@TRANCOUNT>0 -- chequeo que el errror sucedio dentro de la transaccion
				ROLLBACK TRANSACTION TSaveMov; -- asegura el Nada, deshace las actualizaciones previas al error
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