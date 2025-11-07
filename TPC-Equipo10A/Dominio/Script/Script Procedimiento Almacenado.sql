USE E_COMMERCE_DB
GO

CREATE PROCEDURE SP_AgregarUsuario(
	@Email NVARCHAR(200),
	@Password VARCHAR(20),
	@DNI VARCHAR(15),
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@Telefono VARCHAR(20),
	@Domicilio VARCHAR(100),
	@TipoUsuario BIT
)
AS
BEGIN
	INSERT INTO USUARIOS VALUES (@Email,@Password,@DNI,@Nombre,@Apellido,@Telefono,@Domicilio,@TipoUsuario)
END
GO