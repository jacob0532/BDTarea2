CREATE TRIGGER PrimerEstadoCuenta
ON CuentaAhorro
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
		,FechaCreacion
		,DATEADD(MONTH,1,FechaCreacion)
		,C.Saldo
		,0
		
    FROM CuentaAhorro C

END