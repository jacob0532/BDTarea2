USE ProyectoBD1
--Se lee el archivo xml
DECLARE @xmlData XML
-- Nota: cambiar el path del from C:\Users\yeico\Desktop\BDTarea2\XML\catalogos.xml
SET @xmlData = (
		SELECT *
		FROM OPENROWSET(BULK 'C:\Users\dvarg\Desktop\TEC\2020\Segundo Semestre\Bases de datos\Proyectos\Proyecto 2\BDTarea2\XML\Datos_Tarea_2.xml', SINGLE_BLOB) 
		AS xmlData
		)

--Declaracion de variables
DECLARE @FechasProcesar TABLE (Sec int identity (1,1), Fecha date)		--Tabla de las fechas a procesar
DECLARE @lo int = 1, @hi int, @fechaOperacion date						--Variable lo, hi y fecha operacion
DECLARE @TablaFecha XML
DECLARE @CuentaCierra int
DECLARE @DiaCierreEC date

--Asignacion de valores a las variables
INSERT @FechasProcesar(Fecha)											--Tabla con las fechas de operacion del xml
SELECT ref.value('@Fecha', 'date')										
FROM @xmlData.nodes('Operaciones/FechaOperacion') AS xmlData(ref)			
SELECT @hi = max(Sec) from @FechasProcesar
SET NOCOUNT ON
WHILE @lo <= @hi
BEGIN
	SELECT @FechaOperacion=F.Fecha FROM @FechasProcesar F WHERE F.sec=@lo	--Fecha de operacion actual

	--SE GUARDA EN @TablaFecha LA TABLA ACTUAL A PROCESAR.
	SELECT @TablaFecha = xmlData.ref.query('.') 
	FROM @xmlData.nodes('Operaciones/FechaOperacion') AS xmlData(ref) 
	WHERE ref.value('@Fecha','date') = @FechaOperacion 

--SE PROCESA LA  INSERCION DE USUARIOS
	INSERT INTO Usuario(
		NombreUsuario
		,Pass
		,ValorDocIdentidad
		,EsAdmi
	)
	SELECT	ref.value('@User', 'varchar(50)')
			,ref.value('@Pass', 'varchar(50)')
			,ref.value('@ValorDocumentoIdentidad', 'int')
			,ref.value('@EsAdministrador', 'bit')	
	FROM @TablaFecha.nodes('FechaOperacion/Usuario') AS xmlData(ref) 

--SE PROCESA LA  INSERCION DE USUARIOS PUEDE VER
	INSERT INTO UsuarioPuedeVer(
		NombreUsuario
		,NumeroCuenta
		,Usuarioid
	)
	SELECT	ref.value('@User', 'varchar(100)')
			,ref.value('@NumeroCuenta', 'varchar(100)')
			,U.id
	FROM @TablaFecha.nodes('FechaOperacion/UsuarioPuedeVer') AS xmlData(ref) 
	INNER JOIN Usuario U ON U.NombreUsuario = ref.value('@User', 'varchar(100)')

--SE PROCESA LA  INSERCION DE CLIENTES EN LA FECHA DE OPERACION IGUAL A @FechaOperacion
	INSERT INTO Persona(
		Nombre
		,ValorDocIdentidad
		,Email
		,FechaNacimiento
		,Telefono1
		,Telefono2
		,TipoDocIdentidadid
		,Usuarioid
	)
	SELECT	ref.value('@Nombre', 'varchar(100)')
			,ref.value('@ValorDocumentoIdentidad', 'int')
			,ref.value('@Email', 'varchar(100)')
			,ref.value('@FechaNacimiento', 'date')
			,ref.value('@Telefono1', 'int')
			,ref.value('@Telefono2', 'int')
			,ref.value('@TipoDocuIdentidad', 'int')
			,U.id
	FROM @TablaFecha.nodes('FechaOperacion/Persona') AS xmlData(ref) 
	LEFT JOIN Usuario U ON U.ValorDocIdentidad = ref.value('@ValorDocumentoIdentidad', 'int')

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
			,0
			,E.id
			,ref.value('@Tipo','int')
			,E.CuentaAhorroid
			,ref.value('@Descripcion','varchar(100)')
	FROM @TablaFecha.nodes('FechaOperacion/Movimientos') xmlData(ref)
	JOIN EstadoCuenta E ON E.FechaInicio = @fechaOperacion AND E.NumeroCuenta =  ref.value('@CodigoCuenta', 'int')

--Tablas con cierre de las cuentas.
	--Se declaran las variables
	DECLARE @CuentasCierran TABLE(sec int identity(1,1), codigocuenta varchar (20))	--Tabla con las cuentas que se cierran
	DECLARE @lo1 int, @hi1 int														--Contadores

	--Se insertan valores en la tabla de @CuentasCierran
	INSERT @CuentasCierran(codigocuenta) SELECT ref.value('@NumeroCuenta','int') FROM @TablaFecha.nodes('FechaOperacion/Cuenta') AS xmlData(ref)
	--Se ingresan los valores de los contadores
	SELECT @lo1=min(sec), @hi1=max(sec) FROM @CuentasCierran

--INICIO WHILE CIERRE ESTADO CUENTA
	WHILE @lo1 <= @hi1
		BEGIN 
			SELECT @CuentaCierra  = C.codigocuenta FROM @CuentasCierran C WHERE C.sec = @lo1
			
			DECLARE	@OutMovimientoId INT
					,@OutResultCode INT
					,@FechaFin DATE
			SELECT @FechaFin = DATEADD(DAY, -1, DATEADD(month, 1, @fechaOperacion))
			--Stored procedure para cerrar el estado de cuenta.
			EXEC [dbo].[CerrarEstadoCuenta] 
				@CuentaCierra
				,@fechaOperacion
				,@FechaFin
				,@OutMovimientoId OUTPUT
				,@OutResultCode OUTPUT

			--Se inserta estado de cuenta para el nuevo mes
			INSERT INTO EstadoCuenta(
				CuentaAhorroid
				,NumeroCuenta
				,FechaInicio
				,FechaFin
				,SaldoInicial
				,SaldoFinal
			)
			SELECT	CA.id
					,Ca.NumeroCuenta
					,DATEADD(DAY, 1, @FechaFin)
					,DATEADD(DAY,-1, DATEADD(MONTH, 1, @FechaFin))--Solucion Provisional
					,CA.Saldo
					,0
			FROM CuentaAhorro CA
			WHERE CA.NumeroCuenta = @CuentaCierra

			SET @LO1 = @LO1 + 1
		END;
--FIN WHILE 

	DELETE @CuentasCierran	
	SET @lo = @lo + 1
END;

SELECT * FROM Usuario
SELECT * FROM UsuarioPuedeVer
SELECT * FROM Persona
SELECT * FROM Beneficiarios
SELECT * FROM CuentaAhorro
SELECT * FROM EstadoCuenta
SELECT * FROM MovimientoCuentaAhorro

--DELETE Usuario
--DELETE UsuarioPuedeVer
--DELETE EstadoCuenta
--DELETE MovimientoCuentaAhorro
--DELETE CuentaAhorro
--DELETE Persona
--DELETE Beneficiarios

