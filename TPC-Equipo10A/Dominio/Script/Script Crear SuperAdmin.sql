USE E_COMMERCE_DB
GO

-- =============================================
-- SCRIPT PARA CREAR USUARIO SUPERADMIN
-- =============================================
-- Este script crea un usuario SuperAdmin para que todos los miembros del equipo
-- puedan acceder al panel de SuperAdmin con las mismas credenciales.
--
-- IMPORTANTE: 
-- - Ejecuta este script en tu base de datos local
-- - Las credenciales por defecto son:
--   Email: superadmin@test.com
--   Password: 123456
-- =============================================

-- Verificar si el SuperAdmin ya existe
IF NOT EXISTS (SELECT 1 FROM USUARIOS WHERE Email = 'superadmin@test.com' AND TipoUsuario = 2)
BEGIN
    -- Crear el SuperAdmin
    INSERT INTO USUARIOS 
    (
        Email, 
        Password, 
        DNI, 
        Nombre, 
        Apellido, 
        Telefono, 
        Domicilio, 
        TipoUsuario, 
        IDAdministrador, 
        NombreTienda, 
        FechaAlta, 
        FechaVencimiento, 
        Activo, 
        Eliminado
    )
    VALUES 
    (
        'superadmin@test.com',  -- Email (cambiar si lo deseas)
        '123456',              -- Password (cambiar si lo deseas)
        NULL,                         -- DNI (opcional)
        'Super',                      -- Nombre
        'Admin',              -- Apellido
        NULL,                         -- Telefono (opcional)
        NULL,                         -- Domicilio (opcional)
        2,                            -- TipoUsuario: 2 = SUPERADMIN
        NULL,                         -- IDAdministrador: NULL (SuperAdmin no tiene administrador padre)
        NULL,                         -- NombreTienda: NULL (SuperAdmin no tiene tienda)
        GETDATE(),                    -- FechaAlta: Fecha actual
        NULL,                         -- FechaVencimiento: NULL (SuperAdmin no vence)
        1,                            -- Activo: 1 (activo)
        0                             -- Eliminado: 0 (no eliminado)
    )
    
    PRINT 'SuperAdmin creado exitosamente.'
    PRINT 'Credenciales:'
    PRINT '  Email: superadmin@test.com'
    PRINT '  Password: 123456'
END
ELSE
BEGIN
    PRINT 'El SuperAdmin ya existe en la base de datos.'
    PRINT 'Si deseas actualizar las credenciales, primero elimina el usuario existente.'
END
GO

-- Verificar que se creó correctamente
SELECT 
    IdUsuario,
    Email,
    Nombre,
    Apellido,
    TipoUsuario,
    Activo,
    Eliminado,
    FechaAlta
FROM USUARIOS
WHERE TipoUsuario = 2
GO

