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
--DECLARE @DiaCierreEC date
--DECLARE @CuentasCierran TABLE(sec int identity(1,1), codigocuenta varchar (20))

SELECT @hi = max(Sec) from @FechasProcesar

WHILE @lo <= @hi
BEGIN
	SELECT @FechaOperacion=F.Fecha FROM @FechasProcesar F WHERE F.sec=@lo	--Se selecciona la fecha iterando en @FechaOperacion
	SELECT @TablaFecha = xmlData.ref.query('.') FROM @xmlData.nodes('Operaciones/FechaOperacion') AS xmlData(ref) WHERE ref.value('@Fecha','date') = @FechaOperacion

	INSERT INTO Persona(
			Nombre
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



	SET @lo = @lo + 1
END;
SELECT * FROM Persona
--Delete FROM Persona