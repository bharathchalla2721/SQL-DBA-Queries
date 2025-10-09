
-- Detaching the DB 
use master 
go 
exec sp_detach_db 'azmath_two'

-- Attaching the DB again 
use master 
go 
create database azmath_two
on (Filename = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MOMEN_TWO\MSSQL\DATA\Azmath.mdf'),
(Filename = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MOMEN_TWO\MSSQL\DATA\Azmath_log.ldf')
for attach
go 


