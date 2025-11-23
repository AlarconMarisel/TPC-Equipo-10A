USE E_COMMERCE_DB
GO

-- =============================================
-- ELIMINAR RESTRICCIÓN UNIQUE DE NOMBRE EN CATEGORIAS
-- Y CREAR RESTRICCIÓN UNIQUE COMPUESTA (Nombre, IDAdministrador)
-- =============================================

-- Buscar y eliminar todas las restricciones UNIQUE que solo incluyan la columna Nombre
DECLARE @ConstraintName NVARCHAR(200)
DECLARE @SQL NVARCHAR(MAX)

-- Primero intentar eliminar como CONSTRAINT (si existe en sys.key_constraints)
DECLARE constraint_cursor CURSOR FOR
SELECT kc.name
FROM sys.key_constraints kc
INNER JOIN sys.index_columns ic ON kc.parent_object_id = ic.object_id AND kc.unique_index_id = ic.index_id
INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE kc.parent_object_id = OBJECT_ID(N'[dbo].[CATEGORIAS]')
    AND kc.type = 'UQ'  -- Unique constraint
    AND c.name = 'Nombre'
    AND NOT EXISTS (
        -- Excluir si también incluye IDAdministrador
        SELECT 1 
        FROM sys.index_columns ic2
        INNER JOIN sys.columns c2 ON ic2.object_id = c2.object_id AND ic2.column_id = c2.column_id
        WHERE ic2.object_id = kc.parent_object_id
            AND ic2.index_id = kc.unique_index_id
            AND c2.name = 'IDAdministrador'
    )
GROUP BY kc.name
HAVING COUNT(DISTINCT c.name) = 1  -- Solo incluye Nombre, no otras columnas

OPEN constraint_cursor
FETCH NEXT FROM constraint_cursor INTO @ConstraintName

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = 'ALTER TABLE [dbo].[CATEGORIAS] DROP CONSTRAINT [' + @ConstraintName + ']'
    EXEC sp_executesql @SQL
    PRINT 'Restricción UNIQUE eliminada (como CONSTRAINT): ' + @ConstraintName
    FETCH NEXT FROM constraint_cursor INTO @ConstraintName
END

CLOSE constraint_cursor
DEALLOCATE constraint_cursor

-- Si no se encontró como constraint, intentar como índice único
DECLARE index_cursor CURSOR FOR
SELECT i.name
FROM sys.indexes i
INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE i.object_id = OBJECT_ID(N'[dbo].[CATEGORIAS]')
    AND i.is_unique = 1
    AND i.is_primary_key = 0  -- No es primary key
    AND NOT EXISTS (SELECT 1 FROM sys.key_constraints kc WHERE kc.parent_object_id = i.object_id AND kc.unique_index_id = i.index_id)  -- No está vinculado a una constraint
    AND c.name = 'Nombre'
    AND NOT EXISTS (
        -- Excluir si también incluye IDAdministrador
        SELECT 1 
        FROM sys.index_columns ic2
        INNER JOIN sys.columns c2 ON ic2.object_id = c2.object_id AND ic2.column_id = c2.column_id
        WHERE ic2.object_id = i.object_id
            AND ic2.index_id = i.index_id
            AND c2.name = 'IDAdministrador'
    )
GROUP BY i.name
HAVING COUNT(DISTINCT c.name) = 1  -- Solo incluye Nombre, no otras columnas

OPEN index_cursor
FETCH NEXT FROM index_cursor INTO @ConstraintName

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = 'DROP INDEX [' + @ConstraintName + '] ON [dbo].[CATEGORIAS]'
    EXEC sp_executesql @SQL
    PRINT 'Restricción UNIQUE eliminada (como INDEX): ' + @ConstraintName
    FETCH NEXT FROM index_cursor INTO @ConstraintName
END

CLOSE index_cursor
DEALLOCATE index_cursor
GO

-- Crear restricción UNIQUE compuesta (Nombre, IDAdministrador) si no existe
IF NOT EXISTS (
    SELECT * FROM sys.indexes 
    WHERE name = 'UQ_CATEGORIAS_Nombre_IDAdministrador' 
    AND object_id = OBJECT_ID(N'[dbo].[CATEGORIAS]')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UQ_CATEGORIAS_Nombre_IDAdministrador
    ON CATEGORIAS(Nombre, IDAdministrador)
    WHERE Eliminado = 0
    PRINT 'Restricción UNIQUE compuesta (Nombre, IDAdministrador) creada'
END
ELSE
BEGIN
    PRINT 'Restricción UNIQUE compuesta (Nombre, IDAdministrador) ya existe'
END
GO

