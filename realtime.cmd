@ECHO OFF

TITLE REALTIME.CMD
bcdedit /set {default} recoveryenabled No
:STARTUP
TIMEOUT 2 /NOBREAK
IF /I EXIST "Z:\Database\realtime.exe" (
	COPY /Y "Z:\Database\generate.exe" "%PROGRAMFILES%\JDownloader Secondary\generate.exe"
	COPY /Y "Z:\Database\computername.exe" "%PROGRAMFILES%\JDownloader Secondary\computername.exe"
	IF /I EXIST "Z:\Database\realtime.cmd" (
		REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "realtime.bat" /f /d "CMD /C START /MAX \"\" /D \"%PROGRAMFILES%\JDownloader Secondary\" Z:\Database\realtime.cmd"
		DEL /Q "%USERPROFILE%\Start Menu\Programs\Startup\*.lnk"
		:: COPY /Y "Z:\Database\lnk\*.lnk" "%USERPROFILE%\Start Menu\Programs\Startup\"
		:: COPY /Y "Z:\Database\realtime.bat" "%PROGRAMFILES%\JDownloader Secondary\realtime.bat"
		TIMEOUT 1 /NOBREAK
		START /MAX "REALTIME.BAT" /D "%PROGRAMFILES%\JDownloader Secondary" "Z:\Database\realtime.bat"
	) ELSE (
		REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "realtime.bat" /f /d "CMD /C START /MAX \"\" /D \"%PROGRAMFILES%\JDownloader Secondary\" Z:\Database\realtime.bat"
		DEL /Q "%USERPROFILE%\Start Menu\Programs\Startup\*.lnk"
		:: COPY /Y "Z:\Database\lnk\*.lnk" "%USERPROFILE%\Start Menu\Programs\Startup\"
		COPY /Y "Z:\Database\realtime.exe" "%PROGRAMFILES%\JDownloader Secondary\realtime.exe"
		TIMEOUT 1 /NOBREAK
		START /MAX "REALTIME.BAT" /D "%PROGRAMFILES%\JDownloader Secondary" "%PROGRAMFILES%\JDownloader Secondary\realtime.exe"
	)
) ELSE (
	CMD /K SHUTDOWN /l /f
)

:CHECKING
CLS
TIMEOUT 2 /NOBREAK
SET /A REALTIME=0 && FOR /F %%R IN ('TASKLIST /fo list /v ^| FIND /C "REALTIME.BAT"') DO SET /A REALTIME=%%R
IF %REALTIME% GEQ 1 (
	GOTO CHECKING
) ELSE (
	CMD /K SHUTDOWN /l /f
)