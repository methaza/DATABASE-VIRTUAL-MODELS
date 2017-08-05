@ECHO OFF

TITLE CLEANVPN.BAT


:DOCALL

FOR %%V IN ("D:\Users\Administrator\Downloads\Google Drive\OPENVPN\vpngate.net\*.ovpn") DO (
	CALL :vpngate.net "%%V"
)

GOTO DOCALL
EXIT

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

:: cleanvpn.bat vpngate.net -RELOAD