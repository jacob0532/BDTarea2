USE [ProyectoBD1]
GO
/****** Object:  Table [dbo].[Beneficiarios]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Beneficiarios](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Personaid] [int] NOT NULL,
	[CuentaAhorroid] [int] NOT NULL,
	[NumeroCuenta] [int] NOT NULL,
	[ValorDocumentoIdentidadBeneficiario] [int] NOT NULL,
	[ParentezcoId] [int] NOT NULL,
	[Porcentaje] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
	[FechaDesactivacion] [date] NULL,
 CONSTRAINT [PK_Beneficiarios] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaAhorro]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaAhorro](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Personaid] [int] NOT NULL,
	[TipoCuentaId] [int] NOT NULL,
	[NumeroCuenta] [int] NOT NULL,
	[FechaCreacion] [date] NOT NULL,
	[Saldo] [money] NOT NULL,
 CONSTRAINT [PK_CuentaAhorro] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaObjetivo]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaObjetivo](
	[id] [int] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[Costo] [money] NOT NULL,
	[Objetivo] [varchar](100) NOT NULL,
	[Saldo] [money] NOT NULL,
	[InteresesAcumulados] [money] NOT NULL,
	[CuentaAhorroid] [int] NOT NULL,
 CONSTRAINT [PK_CuentaObjetivo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiaMesDeposito]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiaMesDeposito](
	[id] [int] NOT NULL,
	[NumDia] [int] NOT NULL,
	[CuentaObjetivoid] [int] NOT NULL,
 CONSTRAINT [PK_DiaMesDeposito] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadoCuenta]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoCuenta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CuentaAhorroid] [int] NOT NULL,
	[NumeroCuenta] [int] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[SaldoInicial] [money] NOT NULL,
	[SaldoFinal] [money] NOT NULL,
 CONSTRAINT [PK_EstadoCuenta] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovCuentaObj]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovCuentaObj](
	[id] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Monto] [money] NOT NULL,
	[TipoMovObjid] [int] NOT NULL,
	[CuentaObjetivoid] [int] NOT NULL,
 CONSTRAINT [PK_MovCuentaObj] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovCuentaObjIntereses]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovCuentaObjIntereses](
	[id] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Monto] [money] NOT NULL,
	[TipoMovObjid] [int] NOT NULL,
	[CuentaObjetivoid] [int] NOT NULL,
 CONSTRAINT [PK_MovCuentaObjIntereses] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientoCuentaAhorro]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoCuentaAhorro](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Monto] [money] NOT NULL,
	[NuevoSaldo] [money] NOT NULL,
	[EstadoCuentaid] [int] NOT NULL,
	[TipoMovimientoCuentaAhorroid] [int] NOT NULL,
	[CuentaAhorroid] [int] NOT NULL,
 CONSTRAINT [PK_MovimientoCuentaAhorro] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parentezco]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parentezco](
	[id] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Parentezco] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Persona]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persona](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[ValorDocIdentidad] [int] NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[Telefono1] [int] NOT NULL,
	[Telefono2] [int] NOT NULL,
	[TipoDocIdentidadid] [int] NOT NULL,
	[Usuarioid] [int] NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoCuentaAhorro]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCuentaAhorro](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[IdTipoMoneda] [int] NOT NULL,
	[SaldoMinimo] [money] NOT NULL,
	[MultaSaldoMin] [float] NOT NULL,
	[CargoAnual] [float] NOT NULL,
	[NumRetirosHumano] [int] NOT NULL,
	[NumRetirosAutomatico] [int] NOT NULL,
	[ComisionHumano] [int] NOT NULL,
	[ComisionAutomatico] [int] NOT NULL,
	[Interes] [int] NOT NULL,
 CONSTRAINT [PK_TipoCuentaAhorro] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDocIdentidad]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDocIdentidad](
	[id] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TipoDocIdentidad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMoneda]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMoneda](
	[id] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Simbolo] [char](10) NOT NULL,
 CONSTRAINT [PK_TipoMoneda] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovimientoCuentaAhorro]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovimientoCuentaAhorro](
	[id] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[TipoOperacion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoMovimientoCuentaAhorro] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TMovCuentaObj]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMovCuentaObj](
	[id] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TMovCuentaObj] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TMovCuentaObjIntereses]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMovCuentaObjIntereses](
	[id] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TMovCuentaObjIntereses] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [varchar](50) NOT NULL,
	[Pass] [varchar](50) NOT NULL,
	[ValorDocIdentidad] [int] NOT NULL,
	[EsAdmi] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioPuedeVer]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioPuedeVer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [varchar](50) NOT NULL,
	[NumeroCuenta] [int] NOT NULL,
	[Usuarioid] [int] NOT NULL,
 CONSTRAINT [PK_UsuarioPuedeVer_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Beneficiarios]  WITH CHECK ADD  CONSTRAINT [FK_Beneficiarios_CuentaAhorro] FOREIGN KEY([CuentaAhorroid])
REFERENCES [dbo].[CuentaAhorro] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Beneficiarios] CHECK CONSTRAINT [FK_Beneficiarios_CuentaAhorro]
GO
ALTER TABLE [dbo].[Beneficiarios]  WITH CHECK ADD  CONSTRAINT [FK_Beneficiarios_Parentezco] FOREIGN KEY([ParentezcoId])
REFERENCES [dbo].[Parentezco] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Beneficiarios] CHECK CONSTRAINT [FK_Beneficiarios_Parentezco]
GO
ALTER TABLE [dbo].[Beneficiarios]  WITH CHECK ADD  CONSTRAINT [FK_Beneficiarios_Persona] FOREIGN KEY([Personaid])
REFERENCES [dbo].[Persona] ([id])
GO
ALTER TABLE [dbo].[Beneficiarios] CHECK CONSTRAINT [FK_Beneficiarios_Persona]
GO
ALTER TABLE [dbo].[CuentaAhorro]  WITH CHECK ADD  CONSTRAINT [FK_CuentaAhorro_Persona] FOREIGN KEY([Personaid])
REFERENCES [dbo].[Persona] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CuentaAhorro] CHECK CONSTRAINT [FK_CuentaAhorro_Persona]
GO
ALTER TABLE [dbo].[CuentaAhorro]  WITH CHECK ADD  CONSTRAINT [FK_CuentaAhorro_TipoCuentaAhorro] FOREIGN KEY([TipoCuentaId])
REFERENCES [dbo].[TipoCuentaAhorro] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CuentaAhorro] CHECK CONSTRAINT [FK_CuentaAhorro_TipoCuentaAhorro]
GO
ALTER TABLE [dbo].[DiaMesDeposito]  WITH CHECK ADD  CONSTRAINT [FK_DiaMesDeposito_CuentaObjetivo] FOREIGN KEY([CuentaObjetivoid])
REFERENCES [dbo].[CuentaObjetivo] ([id])
GO
ALTER TABLE [dbo].[DiaMesDeposito] CHECK CONSTRAINT [FK_DiaMesDeposito_CuentaObjetivo]
GO
ALTER TABLE [dbo].[EstadoCuenta]  WITH CHECK ADD  CONSTRAINT [FK_EstadoCuenta_CuentaAhorro] FOREIGN KEY([CuentaAhorroid])
REFERENCES [dbo].[CuentaAhorro] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EstadoCuenta] CHECK CONSTRAINT [FK_EstadoCuenta_CuentaAhorro]
GO
ALTER TABLE [dbo].[MovCuentaObj]  WITH CHECK ADD  CONSTRAINT [FK_MovCuentaObj_CuentaObjetivo] FOREIGN KEY([CuentaObjetivoid])
REFERENCES [dbo].[CuentaObjetivo] ([id])
GO
ALTER TABLE [dbo].[MovCuentaObj] CHECK CONSTRAINT [FK_MovCuentaObj_CuentaObjetivo]
GO
ALTER TABLE [dbo].[MovCuentaObj]  WITH CHECK ADD  CONSTRAINT [FK_MovCuentaObj_TMovCuentaObj] FOREIGN KEY([TipoMovObjid])
REFERENCES [dbo].[TMovCuentaObj] ([id])
GO
ALTER TABLE [dbo].[MovCuentaObj] CHECK CONSTRAINT [FK_MovCuentaObj_TMovCuentaObj]
GO
ALTER TABLE [dbo].[MovCuentaObjIntereses]  WITH CHECK ADD  CONSTRAINT [FK_MovCuentaObjIntereses_CuentaObjetivo] FOREIGN KEY([CuentaObjetivoid])
REFERENCES [dbo].[CuentaObjetivo] ([id])
GO
ALTER TABLE [dbo].[MovCuentaObjIntereses] CHECK CONSTRAINT [FK_MovCuentaObjIntereses_CuentaObjetivo]
GO
ALTER TABLE [dbo].[MovCuentaObjIntereses]  WITH CHECK ADD  CONSTRAINT [FK_MovCuentaObjIntereses_TMovCuentaObjIntereses] FOREIGN KEY([TipoMovObjid])
REFERENCES [dbo].[TMovCuentaObjIntereses] ([id])
GO
ALTER TABLE [dbo].[MovCuentaObjIntereses] CHECK CONSTRAINT [FK_MovCuentaObjIntereses_TMovCuentaObjIntereses]
GO
ALTER TABLE [dbo].[MovimientoCuentaAhorro]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoCuentaAhorro_CuentaAhorro] FOREIGN KEY([CuentaAhorroid])
REFERENCES [dbo].[CuentaAhorro] ([id])
GO
ALTER TABLE [dbo].[MovimientoCuentaAhorro] CHECK CONSTRAINT [FK_MovimientoCuentaAhorro_CuentaAhorro]
GO
ALTER TABLE [dbo].[MovimientoCuentaAhorro]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoCuentaAhorro_EstadoCuenta] FOREIGN KEY([EstadoCuentaid])
REFERENCES [dbo].[EstadoCuenta] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MovimientoCuentaAhorro] CHECK CONSTRAINT [FK_MovimientoCuentaAhorro_EstadoCuenta]
GO
ALTER TABLE [dbo].[MovimientoCuentaAhorro]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoCuentaAhorro_TipoMovimientoCuentaAhorro] FOREIGN KEY([TipoMovimientoCuentaAhorroid])
REFERENCES [dbo].[TipoMovimientoCuentaAhorro] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MovimientoCuentaAhorro] CHECK CONSTRAINT [FK_MovimientoCuentaAhorro_TipoMovimientoCuentaAhorro]
GO
ALTER TABLE [dbo].[Persona]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_TipoDocIdentidad1] FOREIGN KEY([TipoDocIdentidadid])
REFERENCES [dbo].[TipoDocIdentidad] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Persona] CHECK CONSTRAINT [FK_Cliente_TipoDocIdentidad1]
GO
ALTER TABLE [dbo].[Persona]  WITH CHECK ADD  CONSTRAINT [FK_Persona_Usuario] FOREIGN KEY([Usuarioid])
REFERENCES [dbo].[Usuario] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Persona] CHECK CONSTRAINT [FK_Persona_Usuario]
GO
ALTER TABLE [dbo].[TipoCuentaAhorro]  WITH CHECK ADD  CONSTRAINT [FK_TipoCuentaAhorro_TipoMoneda] FOREIGN KEY([IdTipoMoneda])
REFERENCES [dbo].[TipoMoneda] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TipoCuentaAhorro] CHECK CONSTRAINT [FK_TipoCuentaAhorro_TipoMoneda]
GO
ALTER TABLE [dbo].[UsuarioPuedeVer]  WITH CHECK ADD  CONSTRAINT [FK_UsuarioPuedeVer_Usuario] FOREIGN KEY([Usuarioid])
REFERENCES [dbo].[Usuario] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsuarioPuedeVer] CHECK CONSTRAINT [FK_UsuarioPuedeVer_Usuario]
GO
/****** Object:  StoredProcedure [dbo].[ConsultaEstadoCuenta]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultaEstadoCuenta] @inNumeroCuenta INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT TOP (8) id
		,NumeroCuenta
		,FechaInicio
		,FechaFin
		,SaldoInicial
		,SaldoFinal
	FROM EstadoCuenta
	WHERE NumeroCuenta = @inNumeroCuenta
	ORDER BY FechaInicio ASC

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[EditarBeneficiarios]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Procedimiento que edita los beneficiarios*/
CREATE PROCEDURE [dbo].[EditarBeneficiarios]
	@inNumeroCuenta INT
	,@inValorDocIdentidadBeneficiario INT
	,@inParentezcoId INT
	,@inPorcentaje INT
	,@inAccion VARCHAR(10)

AS
DECLARE @outErrorCode int = 0
BEGIN
	SET NOCOUNT ON
	/*Agrega un nuevo beneficiario*/
	IF @inAccion = 'AGREGAR'
	BEGIN
		IF NOT EXISTS (SELECT NumeroCuenta FROM CuentaAhorro WHERE NumeroCuenta = @inNumeroCuenta)
			SET @outErrorCode = 5001	--El numero de cuenta no existe
	
		IF NOT EXISTS (SELECT ValorDocIdentidad FROM Cliente WHERE ValorDocIdentidad = @inValorDocIdentidadBeneficiario )
			SET @outErrorCode = 5002	--El beneficiario no existe

		IF (SELECT COUNT(*) FROM Beneficiarios where NumeroCuenta = @inNumeroCuenta) > 3
			Set @outErrorCode = 5005	--Posee más de 3 beneficiarios

		IF @inPorcentaje < 0 OR @inPorcentaje > 100
			SET @outErrorCode = 5004	--El porcentaje es mayor o igual 100 o negativo

		IF EXISTS(SELECT ValorDocumentoIdentidadBeneficiario from Beneficiarios where @inValorDocIdentidadBeneficiario = ValorDocumentoIdentidadBeneficiario)
			Set @outErrorCode = 5006	--El Beneficiario ya existe

		ELSE
				INSERT INTO Beneficiarios (
					NumeroCuenta
					,ValorDocumentoIdentidadBeneficiario
					,ParentezcoId
					,Porcentaje
					)
				VALUES (
					@inNumeroCuenta
					,@inValorDocIdentidadBeneficiario
					,@inParentezcoId
					,@inPorcentaje
					)
	END	

	/*Editar beneficiario*/
	IF @inAccion = 'EDITAR'
	BEGIN
		IF NOT EXISTS (SELECT ValorDocIdentidad FROM Cliente WHERE ValorDocIdentidad = @inValorDocIdentidadBeneficiario )
			SET @outErrorCode = 5002 --El beneficiario no existe

		IF NOT EXISTS(SELECT id FROM Parentezco WHERE id = @inParentezcoId)
			SET @outErrorCode = 5003	--El parentezco no existe

		IF @inPorcentaje < 0 OR @inPorcentaje > 100
			SET @outErrorCode = 5004	--El porcentaje es mayor o igual 100 o negativo

		IF  EXISTS(SELECT ValorDocumentoIdentidadBeneficiario from Beneficiarios where ValorDocumentoIdentidadBeneficiario = @inValorDocIdentidadBeneficiario)
			Set @outErrorCode = 5006	--El Beneficiario ya existe
		ELSE
			UPDATE Beneficiarios
			SET ValorDocumentoIdentidadBeneficiario = @inValorDocIdentidadBeneficiario
				,ParentezcoId = @inParentezcoId
				,Porcentaje = @inPorcentaje
			WHERE NumeroCuenta = @inNumeroCuenta
	END

	/*Eliminar beneficiario*/
	IF @inAccion = 'ELIMINAR'
		BEGIN
			UPDATE Beneficiarios
			SET Activo = 0
				,FechaDesactivacion = GETDATE()
			WHERE NumeroCuenta = @inNumeroCuenta
		END
	SET NOCOUNT OFF
	RETURN @outErrorCode
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarRecords]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarRecords]
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM Cliente
	DELETE FROM Usuario
	DELETE FROM UsuarioPuedeVer
	DELETE FROM CuentaObjetivo
	DELETE FROM TipoMoneda
	DELETE FROM TipoCuentaAhorro
	DELETE FROM TipoDocIdentidad
	DELETE FROM MovimientoCuentaAhorro
	DELETE FROM Parentezco

	SELECT * FROM Cliente
	SELECT * FROM Usuario
	SELECT * FROM UsuarioPuedeVer
	SELECT * FROM CuentaObjetivo
	SELECT * FROM TipoMoneda
	SELECT * FROM TipoCuentaAhorro
	SELECT * FROM TipoDocIdentidad
	SELECT * FROM MovimientoCuentaAhorro
	SELECT * FROM Parentezco

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[InsertarUsuarioJacob]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[InsertarUsuarioJacob]
AS
BEGIN 

--faltan los usuarios y usuarios ver
	INSERT INTO Usuarios(Usuario, Contrasena, EsAdministrador)
	SELECT 
		MY_XML.Datos.value('@Usuario', 'VARCHAR(100)'),
		MY_XML.Datos.value('@Contrasena', 'VARCHAR(100)'),
		MY_XML.Datos.value('@EsAdministrador', 'bit')

	FROM (SELECT CAST(MY_XML AS xml)
			FROM OPENROWSET(BULK 'C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\no-catalogos.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
			CROSS APPLY MY_XML.nodes('Usuarios/Usuario') AS MY_XML (Datos);

END;
GO
/****** Object:  StoredProcedure [dbo].[ObtenerUsuario]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerUsuario]	@inUser varchar(50),
								@inPass varchar(50)
AS
BEGIN 
	SELECT * 
	FROM [dbo].[Usuario]
	WHERE [user] = @inUser and pass = @inPass
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_ActualizarBeneficiario]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActualizarBeneficiario]
(
	-- Add the parameters for the stored procedure here
	@inNumeroCuenta int = 0,
	@inValorDocumentoIdentidadBeneficiario int = 0,
	@inNuevoDocumentoIdentidad int = 0,
	@inParentezcoId int = 0,
	@inPorcentaje int = 0,
	@inActivo bit = 1,
	@inFechaDesactivacion date = null
)
AS
DECLARE @outErrorCode int = 0
BEGIN
	IF NOT EXISTS (SELECT ValorDocIdentidad FROM Cliente WHERE ValorDocIdentidad = @inNuevoDocumentoIdentidad )
		SET @outErrorCode = 5002	--El beneficiario no existe

	ELSE IF NOT EXISTS(SELECT id FROM Parentezco WHERE id = @inParentezcoId)
		SET @outErrorCode = 5003	--El parentezco no existe

	ELSE IF (CONVERT(INT,(SELECT SUM(Porcentaje) FROM Beneficiarios where NumeroCuenta = @inNumeroCuenta AND Activo = 1 AND ValorDocumentoIdentidadBeneficiario != @inValorDocumentoIdentidadBeneficiario ))+@inPorcentaje)>100
		SET @outErrorCode = 5007	--La suma es mayor al 100	

	ELSE
		UPDATE Beneficiarios
		SET ValorDocumentoIdentidadBeneficiario = @inNuevoDocumentoIdentidad 
			,ParentezcoId = @inParentezcoId
			,Porcentaje = @inPorcentaje
			,Activo = 1
			,FechaDesactivacion = null
		WHERE NumeroCuenta = @inNumeroCuenta and ValorDocumentoIdentidadBeneficiario = @inValorDocumentoIdentidadBeneficiario
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AgregarBeneficiario]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AgregarBeneficiario]
(
	-- Add the parameters for the stored procedure here
	 @inNumeroCuenta INT
	,@inValorDocIdentidadBeneficiario INT
	,@inParentezcoId INT
	,@inPorcentaje INT
)
AS
DECLARE @outErrorCode int = 0
BEGIN
	IF NOT EXISTS (SELECT NumeroCuenta FROM CuentaAhorro WHERE NumeroCuenta = @inNumeroCuenta)
		SET @outErrorCode = 5001	--El numero de cuenta no existe
	
	ELSE IF NOT EXISTS (SELECT ValorDocIdentidad FROM Cliente WHERE ValorDocIdentidad = @inValorDocIdentidadBeneficiario )
		SET @outErrorCode = 5002	--El beneficiario no existe

	ELSE IF (SELECT COUNT(*) FROM Beneficiarios where NumeroCuenta = @inNumeroCuenta AND Activo = 1) >= 3
		Set @outErrorCode = 5005	--Posee más de 3 beneficiarios

	ELSE IF EXISTS(SELECT ValorDocumentoIdentidadBeneficiario from Beneficiarios WHERE NumeroCuenta = @inNumeroCuenta and  ValorDocumentoIdentidadBeneficiario = @inValorDocIdentidadBeneficiario AND Activo = 1)
		SET @outErrorCode = 5006	--El Beneficiario ya existe

	ELSE IF (CONVERT(INT,(SELECT SUM(Porcentaje) FROM Beneficiarios where NumeroCuenta = @inNumeroCuenta AND Activo = 1))+@inPorcentaje)>100
		SET @outErrorCode = 5007	--La suma es mayor al 100	

	ELSE
			INSERT INTO Beneficiarios (
				NumeroCuenta
				,ValorDocumentoIdentidadBeneficiario
				,ParentezcoId
				,Porcentaje
				,Activo
				,FechaDesactivacion
				)
			VALUES (
				@inNumeroCuenta
				,@inValorDocIdentidadBeneficiario
				,@inParentezcoId
				,@inPorcentaje
				,1
				,NULL
				)
	RETURN @outErrorCode;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_BeneficiarioPorID]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BeneficiarioPorID]
(
	-- Add the parameters for the stored procedure here
	@ValorDocumentoIdentidadBeneficiario int = 0
)
AS
BEGIN
	SELECT * FROM Beneficiarios 
	WHERE ValorDocumentoIdentidadBeneficiario = @ValorDocumentoIdentidadBeneficiario
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CompararUsuario]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CompararUsuario]
(
	-- Add the parameters for the stored procedure here
	@Usuario VARCHAR(50) = '',
	@Pass VARCHAR(50) = ''
)
AS
BEGIN
	SELECT * FROM Usuario 
	WHERE [User] = @Usuario and Pass = @Pass
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarBeneficiario]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_EliminarBeneficiario]
(
	-- Add the parameters for the stored procedure here
	@ValorDocumentoIdentidadBeneficiario int = 0
)
AS
BEGIN
	UPDATE Beneficiarios SET Activo = 0,FechaDesactivacion = GETDATE()
	WHERE ValorDocumentoIdentidadBeneficiario = @ValorDocumentoIdentidadBeneficiario
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertarCliente]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_InsertarCliente]
(
	@inNombre varchar(100)
	,@inValorDocIdentidad int
	,@inEmail varchar(100)
	,@inFechaNacimiento date
	,@inTelefono1 int
	,@inTelefono2 int
	,@inTipoDocIdentidadid int
)

AS
BEGIN 
	SET NOCOUNT ON
	INSERT INTO Cliente(
		Nombre
		,ValorDocIdentidad
		,Email
		,FechaNacimiento
		,Telefono1
		,Telefono2
		,TipoDocIdentidadid
	)
	VALUES(
		@inNombre
		,@inValorDocIdentidad
		,@inEmail
		,@inFechaNacimiento
		,@inTelefono1
		,@inTelefono2
		,@inTipoDocIdentidadid
	)
	SET NOCOUNT OFF

END;
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtenerBeneficiarios]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ObtenerBeneficiarios]
(
	-- Add the parameters for the stored procedure here
	@NumeroCuenta int = 0
)
AS
BEGIN
	SELECT * FROM Beneficiarios 
	WHERE NumeroCuenta = @NumeroCuenta and Activo = 1
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtenerParentezco]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ObtenerParentezco]
(
	-- Add the parameters for the stored procedure here
	@ParentezcoId int = 0
)
AS
BEGIN
	SELECT Nombre FROM Parentezco 
	WHERE id = @ParentezcoId
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SeleccionarClientePorCedula]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jacob
-- Create date: 6/11/2020
-- Description:	Seleccionar Cliente por Cedula
-- =============================================
CREATE PROCEDURE [dbo].[SP_SeleccionarClientePorCedula]
(
	-- Add the parameters for the stored procedure here
	@Cedula int = 0
)
AS
BEGIN
	SELECT * FROM Cliente 
	WHERE ValorDocIdentidad = @Cedula
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SeleccionarClientes]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jacob
-- Create date: 6/11/2020
-- Description:	Get all customers
-- =============================================
CREATE PROCEDURE [dbo].[SP_SeleccionarClientes]

AS
BEGIN
	SELECT * FROM Cliente 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SeleccionarCuentaAhorro]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SeleccionarCuentaAhorro]
(
	-- Add the parameters for the stored procedure here
	@Clienteid int = 0
)
AS
BEGIN
	SELECT * FROM CuentaAhorro 
	WHERE Clienteid = @Clienteid
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SeleccionarCuentasAhorroUsuarioPuedeVer]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Darío Vargas>
-- Create date: <Create Date,15/11/2020>
-- Description:	<Description, Procedimiento que obtiene las cuentas de un UsuarioPuedeVer>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SeleccionarCuentasAhorroUsuarioPuedeVer]
(
	@inUser varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * 
	FROM CuentaAhorro
	INNER JOIN UsuarioPuedeVer 
	ON CuentaAhorro.NumeroCuenta = UsuarioPuedeVer.NumeroCuenta
	--WHERE @inUser = UsuarioPuedeVer.[User]
	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_TipoCuentaAhorro]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TipoCuentaAhorro] (@inTipoCuentaAhorroId INT)
AS
BEGIN
	SELECT *
	FROM TipoCuentaAhorro
	WHERE id = @inTipoCuentaAhorroId
END
GO
/****** Object:  StoredProcedure [dbo].[SP_TipoMoneda]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TipoMoneda] (@inTipoMonedaId INT)
AS
BEGIN
	SELECT	Nombre
			,Simbolo
	FROM TipoMoneda
	WHERE id = @inTipoMonedaId
END
GO
/****** Object:  StoredProcedure [dbo].[SP_TodoCuentaAhorro]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TodoCuentaAhorro]
AS
BEGIN
	SELECT *
	FROM CuentaAhorro
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UsuarioPuedeVer]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UsuarioPuedeVer] 
(
	@inUsuario varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT cuentaAhorro.*
	FROM CuentaAhorro AS cuentaAhorro
	INNER JOIN UsuarioPuedeVer AS usuarioVer ON usuarioVer.NumeroCuenta =  cuentaAhorro.NumeroCuenta
	WHERE usuarioVer.[User] = @inUsuario

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_VerificarPorcentajeBeneficiarios]    Script Date: 28/11/2020 23:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VerificarPorcentajeBeneficiarios] (@inNumeroCuenta INT)
AS
DECLARE @outErrorCode INT;
DECLARE @porcentajeBeneficiarios INT = convert(INT, (
			SELECT SUM(Porcentaje)
			FROM Beneficiarios
			WHERE NumeroCuenta = @inNumeroCuenta
				AND Activo = 1
			))
BEGIN
	IF @porcentajeBeneficiarios < 100
		SET @outErrorCode = 5007;--El porcentaje es menor a 100
	ELSE IF @porcentajeBeneficiarios > 100
		SET @outErrorCode = 5008;--El porcentaje es MAYOR a 100
	ELSE
		SET @outErrorCode = 0;

	RETURN @outErrorCode
END
GO
