USE [ProyectoBD1]
GO
/****** Object:  StoredProcedure [dbo].[SeleccionarTipoMovimiento]    Script Date: 9/12/2020 11:34:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SeleccionarTipoMovimiento]
(
	@id INT = 0 

)

AS
BEGIN
	SELECT * FROM dbo.TipoMovimientoCuentaAhorro 
	WHERE id = @id
END
