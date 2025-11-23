USE E_COMMERCE_DB
GO


-- =============================================
-- 1. AGREGAR CAMPO ELIMINADO A USUARIOS (Eliminacion logica)
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[USUARIOS]') AND name = 'Eliminado')
BEGIN
    ALTER TABLE USUARIOS
    ADD Eliminado BIT NOT NULL DEFAULT(0)
    PRINT 'Campo Eliminado agregado a USUARIOS'
END
ELSE
BEGIN
    PRINT 'Campo Eliminado ya existe en USUARIOS'
END
GO

-- =============================================
-- 2. AGREGAR CAMPO NOMBRETIENDA A USUARIOS (URLs Personalizadas)
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[USUARIOS]') AND name = 'NombreTienda')
BEGIN
    ALTER TABLE USUARIOS
    ADD NombreTienda NVARCHAR(50) NULL
    PRINT 'Campo NombreTienda agregado a USUARIOS'
END
ELSE
BEGIN
    PRINT 'Campo NombreTienda ya existe en USUARIOS'
END
GO

-- Crear constraint UNIQUE para NombreTienda (solo valores no nulos)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'UQ_USUARIOS_NombreTienda' AND object_id = OBJECT_ID(N'[dbo].[USUARIOS]'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UQ_USUARIOS_NombreTienda
    ON USUARIOS(NombreTienda)
    WHERE NombreTienda IS NOT NULL
    PRINT 'Constraint UNIQUE creado para NombreTienda'
END
ELSE
BEGIN
    PRINT 'Constraint UNIQUE para NombreTienda ya existe'
END
GO

