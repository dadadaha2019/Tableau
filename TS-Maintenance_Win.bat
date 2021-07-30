@ECHO off
SET logfilename=%COMPUTERNAME%-logs
SET newlogfilename=%logfilename%_%date:~-4,4%-%date:~-7,2%-%date:~-10,2%
SET backupfilename=%COMPUTERNAME%-backup
SET newbackupfilename=%backupfilename%_%date:~-4,4%-%date:~-7,2%-%date:~-10,2%

ECHO === Starting Ziplog : %date% %time% ===
call tsm maintenance ziplogs -f %logfilename% --overwrite
ECHO === Finished Ziplog task ===

ECHO === Moving ziplog file: %date% %time%===
@ECHO on
move /y "c:\ProgramData\Tableau\Tableau Server\data\tabsvc\files\log-archives\%logfilename%.zip" c:\tsbackup\%newlogfilename%.zip
@ECHO off
ECHO === Finished Moving ziplog task ===

ECHO === Starting Claenup : %date% %time%  ===
call tsm maintenance cleanup
ECHO === Finished Claenup : %date% %time% ===

ECHO == Starting Backup : %date% %time% ===
call tsm maintenance backup -f %backupfilename%.tsbak
ECHO === Finished Backup : %date% %time% ===

ECHO == Moving Backup File : %date% %time% ===
@ECHO on
move /y "c:\ProgramData\Tableau\Tableau Server\data\tabsvc\files\backups\%backupfilename%.tsbak" c:\tsbackup\%newbackupfilename%.tsbak
@ECHO off
ECHO === Finishied Moving Backup file : %date% %time% ===
