
--This rebuilds all indexes associated with the table

USE Azmath_Two ;
GO
ALTER INDEX ALL ON dbo.emp
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON,
              STATISTICS_NORECOMPUTE = ON);
GO


use Azmath_Two 
go 

alter index all on dbo.emp 
reorganize 