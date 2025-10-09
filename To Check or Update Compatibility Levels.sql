


-- To find the Compatibility Level in SQL Server 

USE azmath;
GO
SELECT compatibility_level
FROM sys.databases WHERE name = 'azmath';
GO


-- To Edit/Change the compatibility Level of DB 

use azmath_two 
go 
ALTER DATABASE Azmath_two 
SET COMPATIBILITY_LEVEL = 110;
GO



