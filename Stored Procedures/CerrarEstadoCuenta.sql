USE [ProyectoBD1]
GO

/****** Object:  StoredProcedure [dbo].[InsertarMovimientos]    Script Date: 12/1/2020 2:43:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[CerrarEstadoCuenta] @inEstadoCuentaId INT,
	@OutMovimientoId INT OUTPUT,
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		-- Se declaran variables
		DECLARE @SaldoFinal MONEY = 0
		DECLARE @CuentaAhorroId INT,
			@MultaSaldoMin MONEY, --Multa por el saldo minimo.
			@SaldoMin MONEY, --Saldo minimo en la cuenta.
			@NumeroRetirosHumano INT, --Cantidad de retiros maxima humano.
			@NumeroRetirosAutomatico INT, --Cantidad de retiros maxima cajero automatico.
			@MultaNumRetirosCH MONEY, --Multa por sobrepasar los retiros del cajero humano.
			@MultaNumRetirosCA MONEY, --Multa por sobrepasar los retiros del cajero automatico.
			@Interes MONEY --Intereses.

		--Se guarda en las variables los valores relacionados con el estado de cuenta.
		SELECT @CuentaAhorroId = C.id,
			@MultaSaldoMin = TC.MultaSaldoMin,
			@NumeroRetirosHumano = TC.NumRetirosHumano,
			@NumeroRetirosAutomatico = TC.NumRetirosAutomatico,
			@MultaNumRetirosCH = TC.ComisionHumano,
			@MultaNumRetirosCA = TC.ComisionAutomatico,
			@Interes = TC.Interes,
			@SaldoFinal = C.Saldo
		FROM [dbo].[EstadoCuenta] EC
		INNER JOIN [dbo].[CuentaAhorro] C ON C.id = EC.CuentaAhorroid
		INNER JOIN [dbo].[TipoCuentaAhorro] TC ON TC.id = C.TipoCuentaId
		WHERE EC.id = @inEstadoCuentaId

		--Se obtiene el saldo minimo 
		SELECT @SaldoMin = (
				CASE 
					WHEN MIN(NuevoSaldo) IS NULL
						THEN @SaldoFinal
					ELSE MIN(NuevoSaldo)
					END
				)
		FROM MovimientoCuentaAhorro
		WHERE EstadoCuentaid = @inEstadoCuentaId

		IF (@SaldoMin IS NULL)
			BEGIN 
				SELECT @SaldoFinal
				SELECT @SaldoMin
			END
		--Si la cuenta no existe
		IF NOT EXISTS (
				SELECT 1
				FROM [dbo].[CuentaAhorro]
				WHERE id = @CuentaAhorroId
				)
		BEGIN
			SET @OutResultCode = 50017 --Codigo de retorno si la cuenta no existe.

			RETURN
		END;

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TSaveCerrEst

		--Se actualiza El saldo final y el saldo minimo.
		UPDATE [dbo].[EstadoCuenta]
		SET SaldoMinimo = @SaldoMin,
			SaldoFinal = @SaldoFinal
		WHERE Id = @inEstadoCuentaId

		SET @outMovimientoId = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TSaveCerrEst;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TSaveCerrEst;

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