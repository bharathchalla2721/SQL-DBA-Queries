/*
Question: How can I find the largest sql table or sql  index in a database? I also want to report on the size of indexes and tables?

Answer:  Here are two different ways . Method 1 is more flexible – and you can build into reporting and capacity planning.
Method 2 utilises the SQL Server Standard Report
*/

use azmath_two 
GO
CREATE TABLE #TableSpaceUsed

(
           
           Table_name NVARCHAR(255),
           Table_rows INT,
           Reserved_KB VARCHAR(20),
           Data_KB VARCHAR(20),
           Index_Size_KB VARCHAR(20),
           Unused_KB VARCHAR(20)

)

INSERT INTO #TableSpaceUsed

EXEC sp_msforeachtable 'sp_spaceused ''?'''

SELECT Table_name,Table_Rows,
CONVERT(INT,SUBSTRING(Index_Size_KB,1,LEN(Index_Size_KB) -2)) as indexSizeKB, 
CONVERT(INT,SUBSTRING(Data_KB,1,LEN(Data_KB) -2)) as dataKB, 
CONVERT(INT,SUBSTRING(Reserved_KB,1,LEN(Reserved_KB) -2)) as reservedKB, 
CONVERT(INT,SUBSTRING(Unused_KB,1,LEN(Unused_KB) -2)) as unusedKB
FROM #TableSpaceUsed
ORDER BY dataKB DESC
DROP TABLE #TableSpaceUsed

 

/* 
Method 2: Use the Disk Usage by Tables Report  .
To use: Right Click on Database on SSMS > Reports > Standard Reports > Disk Usage by Table
*/ 