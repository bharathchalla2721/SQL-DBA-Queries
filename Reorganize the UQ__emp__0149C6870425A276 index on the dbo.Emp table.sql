

-- Reorganize the UQ__emp__0149C6870425A276 index on the dbo.Emp table. 

USE Azmath_Two ; 
GO

ALTER INDEX UQ__emp__0149C6870425A276 ON dbo.Emp
REORGANIZE ; 
GO