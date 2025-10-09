

use master 
go 

---- Taking Full Backup 
backup database azmath_standby to disk = 'D:\DB BAKs\Azmath_Standby_FULL.bak' 
with stats = 10, init 

---- Taking Differential Backup 
backup database azmath_standby to disk = 'D:\DB BAKs\Azmath_Standby_diff.bak' 
with differential

---- Taking T.log Backup 
backup log azmath_standby to disk = 'D:\DB BAKs\Azmath_Standby_T.log.trn' 
with stats=10, init

-- Taking Tail log Backup 
backup log azmath_standby to disk = 'D:\DB BAKs\Azmath_Standby_Taillog.trn' 
with no_truncate
