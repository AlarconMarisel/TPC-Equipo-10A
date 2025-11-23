USE E_COMMERCE_DB
GO

-- =============================================
-- ACTUALIZAR STORED PROCEDURE SP_AgregarUsuario
-- =============================================
-- Este script elimina el procedimiento si existe y lo crea de nuevo
-- con el tipo TINYINT en lugar de BIT para TipoUsuario

-- Eliminar el procedimiento si existe
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_AgregarUsuario]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE [dbo].[SP_AgregarUsuario]
    PRINT 'Procedimiento SP_AgregarUsuario eliminado'
END
GO

-- Crear el procedimiento con TINYINT
CREATE PROCEDURE [dbo].[SP_AgregarUsuario](
	@Email NVARCHAR(200),
	@Password VARCHAR(20),
	@DNI VARCHAR(15),
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@Telefono VARCHAR(20),
	@Domicilio VARCHAR(100),
	@TipoUsuario TINYINT
)
AS
BEGIN
	INSERT INTO USUARIOS (Email, Password, DNI, Nombre, Apellido, Telefono, Domicilio, TipoUsuario)
	VALUES (@Email, @Password, @DNI, @Nombre, @Apellido, @Telefono, @Domicilio, @TipoUsuario)
END
GO

PRINT 'Procedimiento SP_AgregarUsuario creado correctamente con TINYINT'
GO

