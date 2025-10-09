
use master 
go 

--- Restore a Full Backup :: Step 1 
Restore database azmath_standby from disk = 'D:\DB BAKs\Azmath_Standby_FULL.bak' with replace, norecovery

-- Restore a Differential Backup :: Step 2
Restore database azmath_standby from disk = 'D:\DB BAKs\Azmath_Standby_diff.bak' 
with norecovery

-- Restore a TLOG Backup :: Step 3
Restore log azmath_standby from disk = 'D:\DB BAKs\Azmath_Standby_T.log.trn' with norecovery


-- Restore a Tail Log :: Step 4
Restore log azmath_standby from disk = 'D:\DB BAKs\Azmath_Standby_Taillog.trn' with recovery

