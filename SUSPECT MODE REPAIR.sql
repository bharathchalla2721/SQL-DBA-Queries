

exec sp_resetstatus 'Azmath_Standby'

DBCC CHECKDB('Azmath_Standby')

ALTER DATABASE Azmath_Standby SET SINGLE_USER WITH ROLLBACK IMMEDIATE 

DBCC CHECKDB('Azmath_Standby', REPAIR_ALLOW_DATA_LOSS )

ALTER DATABASE Azmath_Standby SET MULTI_USER