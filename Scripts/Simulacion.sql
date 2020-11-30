USE ProyectoBD1
--Se lee el archivo xml
DECLARE @xmlData XML
-- Nota: cambiar el path del from
SET @xmlData = (
		SELECT *
		FROM OPENROWSET(BULK 'C:\Users\dvarg\Desktop\TEC\2020\Segundo Semestre\Bases de datos\Proyectos\Proyecto 2\BDTarea2\XML\operaciones.xml', SINGLE_BLOB) 
		AS xmlData
		)

DECLARE @FechasProcesar TABLE (Sec int identity (1,1), Fecha date)		--Tabla de las fechas a procesar
INSERT @FechasProcesar(Fecha)											--Se inserta las fechas
SELECT ref.value('@Fecha', 'date')										--Se seleccionan las fechas obtenidas del xml
FROM @xmlData.nodes('Operaciones/FechaOperacion') AS xmlData(ref)		

DECLARE @lo int = 1, @hi int, @fechaOperacion date								--Variable lo, hi y fecha operacion
DECLARE @TablaFecha XML
DECLARE @CuentaCierra int
DECLARE @DiaCierreEC date
	

SELECT @hi = max(Sec) from @FechasProcesar
WHILE @lo <= @hi
BEGIN
	SELECT @FechaOperacion=F.Fecha FROM @FechasProcesar F WHERE F.sec=@lo	
	SELECT @TablaFecha = xmlData.ref.query('.') FROM @xmlData.nodes('Operaciones/FechaOperacion') AS xmlData(ref) WHERE ref.value('@Fecha','date') = @FechaOperacion --SE GUARDA EN @TablaFecha LA TABLA ACTUAL A PROCESAR.

--SE PROCESA LA  INSERCION DE CLIENTES EN LA FECHA DE OPERACION IGUAL A @FechaOperacion
	INSERT INTO Persona(Nombre
			,ValorDocIdentidad
			,Email
			,FechaNacimiento
			,Telefono1
			,Telefono2
			,TipoDocIdentidadid	
	)
	SELECT	ref.value('@Nombre', 'varchar(100)')
			,ref.value('@ValorDocumentoIdentidad', 'int')
			,ref.value('@Email', 'varchar(100)')
			,ref.value('@FechaNacimiento', 'date')
			,ref.value('@Telefono1', 'int')
			,ref.value('@Telefono2', 'int')
			,ref.value('@TipoDocuIdentidad', 'int')
	FROM @TablaFecha.nodes('FechaOperacion/Persona') AS xmlData(ref) 
	LEFT JOIN Persona P on P.ValorDocIdentidad =  ref.value('@ValorDocumentoIdentidad', 'int')
	WHERE P.ValorDocIdentidad IS NULL

--SE PROCESAN LAS CUENTAS
	INSERT INTO CuentaAhorro (
		Personaid
		,TipoCuentaId
		,NumeroCuenta
		,FechaCreacion
		,Saldo
		)
	SELECT	P.id
			,ref.value('@TipoCuentaId', 'int')
			,ref.value('@NumeroCuenta', 'int')
			,@FechaOperacion
			,0
	FROM @TablaFecha.nodes('FechaOperacion/Cuenta') AS xmlData(ref) 
	INNER JOIN Persona P on P.ValorDocIdentidad = ref.value('@ValorDocumentoIdentidadDelCliente', 'int')
	LEFT JOIN CuentaAhorro C on C.NumeroCuenta =  ref.value('@NumeroCuenta', 'int')
	WHERE C.NumeroCuenta IS NULL

--SE PROCESAN LOS BENEFICIARIOS.
	INSERT INTO Beneficiarios (
		Personaid
		,CuentaAhorroid
		,NumeroCuenta
		,ValorDocumentoIdentidadBeneficiario
		,ParentezcoId
		,Porcentaje
		,Activo
		,FechaDesactivacion
		)
	SELECT	P.id
			,C.id
			,C.NumeroCuenta
			,P.ValorDocIdentidad
			,ref.value('@ParentezcoId', 'int')
			,ref.value('@Porcentaje', 'int')
			,1
			,null
	FROM @TablaFecha.nodes('FechaOperacion/Beneficiario') AS xmlData(ref) 
	INNER JOIN Persona P on P.ValorDocIdentidad = ref.value('@ValorDocumentoIdentidadBeneficiario', 'int')
	INNER JOIN CuentaAhorro C on C.NumeroCuenta = ref.value('@NumeroCuenta', 'int')
	LEFT JOIN Beneficiarios B on B.NumeroCuenta = ref.value('@NumeroCuenta', 'int') AND P.ValorDocIdentidad = ref.value('@ValorDocumentoIdentidadBeneficiario', 'int')
	WHERE B.NumeroCuenta IS NULL

--ESTADOS DE CUENTA DE LA FECHA DE OPERACION
	DECLARE @CuentasCierran TABLE(sec int identity(1,1), codigocuenta varchar (20))
	DECLARE @lo1 int = 1, @hi1 int

	INSERT @CuentasCierran(codigocuenta)
	SELECT ref.value('@NumeroCuenta','int') 
	FROM @TablaFecha.nodes('FechaOperacion/Cuenta') AS xmlData(ref) 

--SE CREAN LOS ESTADOS DE CUENTA
		INSERT INTO EstadoCuenta(
			CuentaAhorroid
			,NumeroCuenta
			,FechaInicio
			,FechaFin
			,SaldoInicial
			,SaldoFinal
			)
		SELECT	C.id
				,ref.value('@NumeroCuenta', 'int')
				,@fechaOperacion
				,DATEADD(month, 1, @fechaOperacion)
				,C.Saldo
				,C.Saldo
		FROM @TablaFecha.nodes('FechaOperacion/Cuenta') AS xmlData(ref) 
		INNER JOIN CuentaAhorro C ON C.NumeroCuenta = ref.value('@NumeroCuenta', 'int')
		LEFT JOIN EstadoCuenta EC ON EC.FechaInicio = @fechaOperacion
		WHERE EC.FechaInicio IS NULL

--SE PROCESAN LOS MOVIMIENTOS DE LA CUENTA
	INSERT INTO MovimientoCuentaAhorro(
			Fecha
			,Monto
			,NuevoSaldo
			,EstadoCuentaid
			,TipoMovimientoCuentaAhorroid
			,CuentaAhorroid
			,Descripcion
		)
	SELECT	@fechaOperacion
			,ref.value('@Monto','money')
			,EC.SaldoFinal
			,EC.id
			,ref.value('@Tipo','int')
			,CA.id
			,ref.value('@Descripcion','varchar(100)')
	FROM @TablaFecha.nodes('FechaOperacion/Movimientos') AS xmlData(ref) 
	INNER JOIN EstadoCuenta EC ON EC.NumeroCuenta = ref.value('@CodigoCuenta', 'int')
	INNER JOIN CuentaAhorro CA ON CA.NumeroCuenta = ref.value('@CodigoCuenta', 'int')

--INICIO WHILE ESTADO CUENTA
	--SELECT @lo1=min(sec), @hi1=max(sec) FROM @CuentasCierran
	--WHILE @lo1 <= @hi1
	--	BEGIN 
	--		SELECT @CuentaCierra=C.codigocuenta FROM @CuentasCierran C WHERE C.sec=@lo1

		--	SET @LO1 = @LO1 + 1
		--END
--FIN WHILE 

	DELETE @CuentasCierran
	SET @lo = @lo + 1
END;
--SELECT * FROM Persona
--SELECT * FROM CuentaAhorro
--SELECT * FROM Beneficiarios
SELECT * FROM EstadoCuenta
SELECT * FROM MovimientoCuentaAhorro
--Delete FROM Beneficiarios
--DELETE MovimientoCuentaAhorro
--DELETE EstadoCuenta
