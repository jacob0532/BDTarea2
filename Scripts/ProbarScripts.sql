DECLARE
 @outCuentaObjetivoId INT
 , @OutResultCode INT
EXEC dbo.CrearCuentaObjetivo
'2020-10-7',
'2020-11-8',
200,
'Mundial',
260,
30,
1,
@outCuentaObjetivoId OUTPUT,
@OutResultCode OUTPUT

SELECT @outCuentaObjetivoId, @OutResultCode
select * from errores 