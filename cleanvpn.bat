@ECHO OFF

TITLE CLEANVPN.BAT

IF "%1" EQU "vpngate.net" (
	FORFILES -p Z:\Sync\IPLOGS -m *.LOG -d -1 -c "cmd /c DEL /Q @file"
	FORFILES -p Z:\Sync\IPLOGS\HISTORY -m *.LOG -d -2 -c "cmd /c DEL @file"
	FORFILES -p Z:\OPENVPN\vpngate.net -m *.ovpn -d -1 -c "cmd /c del /q @file"
	FOR %%V IN (Z:\OPENVPN\vpngate.net\*.ovpn) DO (
		CALL :vpngate.net "%%V"
	)
	EXIT
) ELSE (
	FORFILES -p Z:\Sync\IPLOGS -m *.LOG -d -1 -c "cmd /c DEL /Q @file"
	FORFILES -p Z:\Sync\IPLOGS\HISTORY -m *.LOG -d -2 -c "cmd /c DEL @file"
	FORFILES -p Z:\OPENVPN\vpngate.net -m *.ovpn -d -1 -c "cmd /c del /q @file"
	REM FOR %%V IN (Z:\OPENVPN\vpngate.net\*.ovpn) DO (
	REM 	CALL :vpngate.net "%%V"
	REM )
	EXIT
)

:vpngate.net
SET "UNWANT=%~1"
ECHO %UNWANT% | FIND "\.ovpn" && (
	ECHO NO && DEL /Q "%~1" && GOTO:EOF
)
ECHO %UNWANT% | FIND ").ovpn" && (
	ECHO NO && DEL /Q "%~1" && GOTO:EOF
)
ECHO %UNWANT% | FIND "].ovpn" && (
	ECHO NO && DEL /Q "%~1" && GOTO:EOF
)
GOTO:EOF