USE [ProyectoBD1]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ProcesarMovimientos] 
	@inCuentaId INT
	,@inFechaInicio DATE
	,@inFechaFin DATE
	,@OutNumRetirosHumano INT OUTPUT
	,@OutNumRetirosCajero INT OUTPUT
	,@OutSaldoFinal MONEY OUTPUT
	,@OutMovimientoId INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		-- se declaran variables
		DECLARE @nuevoSaldo MONEY = 0
		DECLARE @Movimientos TABLE(Sec INT IDENTITY(1,1),MovimientoId INT, Tipo VARCHAR (20), Nombre VARCHAR (20), Monto MONEY)	--Tabla con los movimientos del mes
		DECLARE @MovimientoId INT
		DECLARE @CuentaId INT

		--Se Inicializa la tabla con los movimientos
		SELECT @CuentaId = Id FROM CuentaAhorro WHERE NumeroCuenta = @inCuentaId

		INSERT INTO @Movimientos(MovimientoId, Tipo, Nombre, Monto)
		SELECT	MC.id
				,TM.TipoOperacion
				,TM.Nombre
				,MC.Monto
		FROM MovimientoCuentaAhorro MC
		INNER JOIN TipoMovimientoCuentaAhorro TM ON TM.id = MC.TipoMovimientoCuentaAhorroid
		WHERE  MC.CuentaAhorroid = @CuentaId

		-- se inicializan variables
		SELECT @OutResultCode = 0
		SELECT @OutNumRetirosCajero = COUNT(M.Nombre) FROM @Movimientos M Where M.Nombre = 'Retiro ATM'
		SELECT @OutNumRetirosHumano = COUNT(M.Nombre) FROM @Movimientos M Where M.Nombre = 'Retiro Ventana'

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TSaveProcMov

			DECLARE @lo int = 1, @hi int
			SELECT @hi = max(sec) FROM @Movimientos
			--INICIO WHILE 
			WHILE @lo <= @hi
				BEGIN 
					SELECT @MovimientoId  = M.MovimientoId FROM @Movimientos M WHERE M.sec = @lo	--Id del movimiento que se esta iterando
					IF (SELECT Tipo From @Movimientos M Where M.Sec = @lo) = 'Credito'				--Si el tipo de movimiento actual es un credito
						BEGIN
							SELECT @nuevoSaldo = @nuevoSaldo + M.Monto FROM @Movimientos M WHERE M.sec = @lo	--Se suma el credito al nuevo saldo
						END;
					ELSE
						BEGIN
							SELECT @nuevoSaldo = @nuevoSaldo - M.Monto FROM @Movimientos M WHERE M.sec = @lo	--Se resta el debito al nuevo saldo
						END;

					--Se actualiza el movimiento en la base de datos
					UPDATE dbo.MovimientoCuentaAhorro
					SET NuevoSaldo = @nuevoSaldo
					WHERE Id = @MovimientoId

					UPDATE dbo.CuentaAhorro
					SET Saldo = @nuevoSaldo
					WHERE NumeroCuenta = @CuentaId

					--SELECT NuevoSaldo FROM MovimientoCuentaAhorro WHERE Id = @MovimientoId

					SET @lo = @lo + 1
				END
			--FIN WHILE

			SET @OutSaldoFinal = @nuevoSaldo
			SET @outMovimientoId = SCOPE_IDENTITY()
		COMMIT TRANSACTION TSaveProcMov;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION TSaveProcMov;

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