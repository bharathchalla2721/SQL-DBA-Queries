--- SQL Server – Find sql text in active query with a sql derived table

select * from 
 
(
 select OBJECT_NAME(ObjectID) as ObjectName,
  (SELECT TOP 1    SUBSTRING(s2.text,statement_start_offset / 2+1 ,
       ( (CASE WHEN statement_end_offset = -1 THEN (LEN(CONVERT(nvarchar(max),s2.text)) * 2)
        ELSE statement_end_offset END)  - statement_start_offset) / 2+1))  AS sql_statement ,
DB_NAME(er.database_ID) as dbname,er.open_transaction_count ,
 es.nt_user_name,es.nt_domain
FROM sys.dm_exec_sessions as es
INNER JOIN sys.dm_exec_requests as er ON er.session_id = es.session_id CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2 
) derived_table

--where sql_statement LIKE '%my_search_term%'