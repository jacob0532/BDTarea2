CREATE TRIGGER [dbo].[PrimerEstadoCuenta]
ON [dbo].[CuentaAhorro]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO EstadoCuenta(
		CuentaAhorroid
		,NumeroCuenta
		,FechaInicio
		,FechaFin
		,SaldoInicial
		,SaldoFinal
    )
    SELECT
		C.id
		,C.NumeroCuenta
		,C.FechaCreacion
		,DATEADD(MONTH,1,FechaCreacion)
		,C.Saldo
		,0
		
    FROM CuentaAhorro C
	LEFT JOIN EstadoCuenta EC on EC.FechaInicio = C.FechaCreacion
	WHERE EC.id IS NULL

END