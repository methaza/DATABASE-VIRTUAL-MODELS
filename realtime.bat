@ECHO OFF

IF "%1" EQU "CLEANOVPN" (
	FORFILES -p Z:\Sync\IPLOGS -m *.LOG -d -1 -c "cmd /c DEL /Q @file"
	FORFILES -p Z:\Sync\IPLOGS\HISTORY -m *.LOG -d -2 -c "cmd /c DEL @file"
	FORFILES -p Z:\OPENVPN\vpngate.net -m *.ovpn -d -1 -c "cmd /c del /q @file"
	FOR %%V IN (Z:\OPENVPN\vpngate.net\*.ovpn) DO (
		CALL :vpngate.net "%%V"
	)
	EXIT
)

TITLE REALTIME.BAT

:CONFIG
CLS
DEL /Q "%SYSTEMDRIVE%\Download\Jdownloader\*.*"
DEL /Q "%HOMEPATH%\My Documents\Downloads\*.*"
DEL /Q ".\jd\cfg\*.zip"
DEL /Q ".\jd\cfg\*.broken"
DEL /Q ".\STATIC.LOG"
DEL /Q ".\PIRACY.LOG"
DEL /Q ".\SHABBY.LOG"
DEL /Q ".\ACTION.LOG"
DEL /Q ".\GitHub\reCaptcha\*.his"
DEL /Q ".\GitHub\reCaptcha\*.log"
DEL /Q ".\GitHub\reCaptcha\*.mp3"
DEL /Q ".\GitHub\reCaptcha\*.wav"
DEL /Q ".\GitHub\reCaptcha\splitAudio\*.mp3"
DEL /Q ".\GitHub\reCaptcha\splitAudio\*.wav"
DEL /Q "Z:\GitHub\reCaptcha\*.mp3"
DEL /Q "Z:\GitHub\reCaptcha\*.wav"
DEL /Q "Z:\GitHub\reCaptcha\splitAudio\*.mp3"
DEL /Q "Z:\GitHub\reCaptcha\splitAudio\*.wav"
RMDIR ".\jd\logs" /s /q
RMDIR ".\jd\tmp\logs" /s /q
RMDIR ".\jd" /s /q
RMDIR ".\ff\App\" /s /q
RMDIR ".\ff\Data\profile\" /s /q
RMDIR ".\ff\Data\profile_normal\" /s /q
RMDIR ".\ff\Data\profile_piracy\" /s /q
REM ##############
REM |_| SERVER |_|
REM ##############
FOR /F "tokens=1 DELIMS=-" %%N IN ('ECHO %COMPUTERNAME%') DO SET "COMxX=%%N"
IF "%SERVERNAME%" EQU "" FOR /F "tokens=5 DELIMS=:. " %%S IN ('ipconfig ^| find "Default Gateway" ^| find "192.168."') DO SET "VMDGATEWAY=%%S"
IF "%SERVERNAME%" EQU "" FOR /F "tokens=1 DELIMS=< " %%S IN ('nbtstat -a 192.168.%VMDGATEWAY%.1 ^| find "<00>  UNIQUE"') DO SET "SERVERNAME=%%S"
IF "%SERVERNAME%" EQU "" FOR /F "tokens=1 DELIMS=< " %%S IN ('nbtstat -a 192.168.%VMDGATEWAY%.1 ^| find "<00>  UNIQUE"') DO SET "SERVERNAME=%%S"
IF "%SERVERNAME%" EQU "" FOR /F "tokens=1 DELIMS=< " %%S IN ('nbtstat -a 192.168.%VMDGATEWAY%.1 ^| find "<20>  UNIQUE"') DO SET "SERVERNAME=%%S"
IF "%SERVERNAME%" NEQ "" ECHO %SERVERNAME% | findrepl " " "" > SERVERNAME.LOG
IF "%SERVERNAME%" EQU "" FOR /F "tokens=1 DELIMS= " %%S IN (SERVERNAME.LOG) DO SET "SERVERNAME=%%S"
TIMEOUT 2 /NOBREAK
REM ##############
REM |_| SERVER |_|
REM ##############
REM |_|FFJD ZIP|_|
REM ##############
CMD /C ECHO a| START /MAX "UNZIP" /D "%CD%" "..\7-Zip\7z.exe" x "Z:\Database\ff\ff.7z" -o"." -aoa
:: ECHO -p%ZIPPASSWORD%
:: ECHO a| "..\7-Zip\7z.exe" x "Z:\Database\jd\jd.7z" -o"."
:: ECHO -p%ZIPPASSWORD%
REM ##############
REM |_|FFJD ZIP|_|
REM ##############
REM ##############
REM |_|vpngate.|_|
REM ##############
IF "%SERVERNAME%" EQU "CNR-BATCHER-PC" (
	IF "%COMxX%" EQU "COMx01" (
		CMD /C START /MAX "CLEAN OVPN vpngate.net" /D "%PROGRAMFILES%\JDownloader Secondary" "Z:\Database\realtime.bat" CLEANOVPN
	)
	IF "%COMxX%" EQU "COMX01"  (
		CMD /C START /MAX "CLEAN OVPN vpngate.net" /D "%PROGRAMFILES%\JDownloader Secondary" "Z:\Database\realtime.bat" CLEANOVPN
	)
)
MOVE ".\OPENVPN\vpngate.net\*.ovpn" "Z:\OPENVPN\vpngate.net"
DEL /Q ".\OPENVPN\vpngate.net\*.*"
REM ##############
REM |_|vpngate.|_|
REM ##############
REM ##############
REM |_| TAPCON |_|
REM ##############
CMD /C START /WAIT /MAX "GENERATE COMPUTER NAME" /D "%CD%" /I ".\computername.exe" GENTAP
IF "%COMPUTERNAME%" EQU "VMWARE-PC" PAUSE
REM ##############
REM |_| TAPCON |_|
REM ##############
DEL /Q ".\*.7z"
:: START "" /MAX "..\JDownloader Secondary"
:: START "" /MAX "%SYSTEMDRIVE%\Download\Jdownloader"
:: START "" /MAX "Z:\Desktop"
:: START "" /MAX "Z:\Sync"
COPY /Y "Z:\Database\lst\*.lst" ".\lst\"
COPY /Y "Z:\Database\vbs\*.exe" ".\vbs"
COPY /Y "Z:\Database\vbs\*.ahk" ".\vbs"
:: COPY /Y "Z:\Database\vbs\*.vbs" ".\"
:: COPY /Y "Z:\Database\lnk\*.lnk" "%USERPROFILE%\Start Menu\Programs\Startup\"
:: COPY /Y "Z:\Database\dlc\*.dlc" "%SYSTEMDRIVE%\Download\dlc\"
COPY /Y "Z:\Database\prefs\mms.cfg" "%SYSTEMROOT%\SYSTEM32\Macromed\Flash\mms.cfg"
COPY /Y "Z:\Database\cfg\*.*" ".\jd\cfg\"
COPY /Y "Z:\Database\cfg\FileChooser\*.*" ".\jd\cfg\FileChooser"
COPY /Y "Z:\Database\cfg\laf\*.*" ".\jd\cfg\laf\"
COPY /Y "Z:\Database\cfg\menus\*.*" ".\jd\cfg\menus\"
COPY /Y "Z:\Database\cfg\menus_v2\*.*" ".\jd\cfg\menus_v2\"
IF /I NOT EXIST "..\TMAC\" MKDIR "..\TMAC\"
IF /I EXIST "..\TMAC" COPY "Z:\Sync\PROGRAMS\TMAC\*.*" "..\TMAC\"
IF /I NOT EXIST %systemroot%\SysWOW64 COPY /Y "Z:\GitHub\reCaptcha\application\ffmpeg-20170308-3016e91-win32-static.bin\*.exe" ".\GitHub\reCaptcha\"
IF /I EXIST %systemroot%\SysWOW64 COPY /Y "Z:\GitHub\reCaptcha\application\ffmpeg-20170308-3016e91-win64-static.bin\*.exe" ".\GitHub\reCaptcha\"
IF /I NOT EXIST ".\psping.exe" COPY /Y "Z:\Database\psping.exe" ".\"
REM ##############
REM |_|  MYJD  |_|
REM ##############
type "Z:\Database\My.JDownloader\org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json" |findrepl "COMxX" "%COMxX%" > ".\jd\cfg\org.jdownloader.api.myjdownloader.MyJDownloaderSettings.jsonrename"
DEL /Q ".\jd\cfg\org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json"
REN ".\jd\cfg\org.jdownloader.api.myjdownloader.MyJDownloaderSettings.jsonrename" org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json
type ".\jd\cfg\org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json" |findrepl "SERVERNAME" "%SERVERNAME%" > ".\jd\cfg\org.jdownloader.api.myjdownloader.MyJDownloaderSettings.jsonrename"
DEL /Q ".\jd\cfg\org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json"
REN ".\jd\cfg\org.jdownloader.api.myjdownloader.MyJDownloaderSettings.jsonrename" org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json
REM ##############
REM |_|  MYJD  |_|
REM ##############
REM ##############
REM |_| CONFIG |_|
REM ##############
SET MISCARRYLOOT=0
SET COMPLETELOOT=0
SET /A RETRAY=0
SET LOCATE=%CD%
REGEDIT.EXE /S "Z:\Database\reg\!Safe_W7_Ultimate_32_SP1_Start_v100.reg"
REGEDIT.EXE /S "Z:\Database\reg\Set_Unidentified_Networks_Public"
REGEDIT.EXE /S "Z:\Database\reg\windowsLogin.reg"
REM	IF NOT "%COMxX%" EQU "COMx01" REGEDIT.EXE /S "Z:\Database\reg\autoHideTaskbar.reg"
tzutil /s "Pacific Standard Time"
REM ##############
REM |_| CONFIG |_|
REM ##############
REM ##############
REM |_|  TASK  |_|
REM ##############
REM	SC STOP "VSS"
REM	SC STOP "sppsv"
REM	SC STOP "MSDTC"
REM	SC STOP "iphlpsvc"
REM	SC STOP "Winmgmt"
REM	SC START "iphlpsvc"
REM ##############
REM |_|  TASK  |_|
REM ##############
REM #############
REM |_| ROUTE |_|
REM #############
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 bit.ly') DO (IF "%%p" NEQ "" set BIT=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 bitly.com') DO (IF "%%p" NEQ "" set BITLY=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 is.gd') DO (IF "%%p" NEQ "" set IS=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 houndify.com') DO (IF "%%p" NEQ "" set HOUNDIFY=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.houndify.com') DO (IF "%%p" NEQ "" set WWWHOUNDIFY=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 api.houndify.com') DO (IF "%%p" NEQ "" set APIHOUNDIFY=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 microsoft.com') DO (IF "%%p" NEQ "" set MICROSOFT=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.microsoft.com') DO (IF "%%p" NEQ "" set MICROSOFT=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 api.cognitive.microsoft.com') DO (IF "%%p" NEQ "" set APICOGNITIVEMICROSOFT=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 microsoftstore.com') DO (IF "%%p" NEQ "" set MICROSOFTSTORE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.microsoftstore.com') DO (IF "%%p" NEQ "" set WWWMICROSOFTSTORE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 live.com') DO (IF "%%p" NEQ "" set LIVE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.live.com') DO (IF "%%p" NEQ "" set WWWLIVE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 login.live.com') DO (IF "%%p" NEQ "" set LOGINLIVE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 account.live.com') DO (IF "%%p" NEQ "" set ACCOUNTLIVE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 outlook.live.com') DO (IF "%%p" NEQ "" set OUTLOOKLIVE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 messenger.live.com') DO (IF "%%p" NEQ "" set MESSENGERLIVE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 office365.com') DO (IF "%%p" NEQ "" set OFFICE365=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 gfx.ms') DO (IF "%%p" NEQ "" set GFX=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.gfx.ms') DO (IF "%%p" NEQ "" set WWWGFX=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 mem.gfx.ms') DO (IF "%%p" NEQ "" set MEMGFX=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 auth.gfx.ms') DO (IF "%%p" NEQ "" set AUTHGFX=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 onestore.ms') DO (IF "%%p" NEQ "" set ONESTORE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.onestore.ms') DO (IF "%%p" NEQ "" set WWWONESTORE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 assets.onestore.ms') DO (IF "%%p" NEQ "" set ASSETSONESTORE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 bing.com') DO (IF "%%p" NEQ "" set BING=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.bing.com') DO (IF "%%p" NEQ "" set BING=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 platform.bing.com') DO (IF "%%p" NEQ "" set PLATFORMBING=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 speech.platform.bing.com') DO (IF "%%p" NEQ "" set SPEECHPLATFORMBING=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 wit.ai') DO (IF "%%p" NEQ "" set WIT=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.wit.ai') DO (IF "%%p" NEQ "" set WWWWIT=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 api.wit.ai') DO (IF "%%p" NEQ "" set APIWIT=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 facebook.com') DO (IF "%%p" NEQ "" set FACEBOOK=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 google.com') DO (IF "%%p" NEQ "" set GOOGLE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.google.com') DO (IF "%%p" NEQ "" set WWWGOOGLE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 gstatic.com') DO (IF "%%p" NEQ "" set GSTATIC=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.gstatic.com') DO (IF "%%p" NEQ "" set WWWGSTATIC=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 googleapis.com') DO (IF "%%p" NEQ "" set GOOGLEAPIS=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.googleapis.com') DO (IF "%%p" NEQ "" set WWWGOOGLEAPIS=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 emailfake.com') DO (IF "%%p" NEQ "" set EMAILFAKE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.emailfake.com') DO (IF "%%p" NEQ "" set WWWEMAILFAKE=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 fakenamegenerator.com') DO (IF "%%p" NEQ "" set FAKENAMEGENERATOR=%%p)
REM FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.fakenamegenerator.com') DO (IF "%%p" NEQ "" set WWWFAKENAMEGENERATOR=%%p)
REM #############
REM |_| ROUTE |_|
REM #############
REM #############
REM |_| CHECK |_|
REM #############
IF /I NOT EXIST ".\findrepl.bat" TIMEOUT 02 /NOBREAK && CMD /K SHUTDOWN /l /f && PAUSE
netsh interface show interface | find "Local"
IF %ERRORLEVEL% EQU 1 GOTO CLOSE
REM #############
REM |_| CHECK |_|
REM #############
GOTO STATIC

:STATIC
CLS
IF %RETRAY% GEQ 20 CMD /K SHUTDOWN /l /f
IF %RETRAY% GEQ 10 (
	CMD /C START /WAIT /MAX "GENERATE COMPUTER NAME" /D "%CD%" /I ".\computername.exe" GENRET
	SET /A RETRAY=0
) ELSE (
	SET /A RETRAY+=1
)
ECHO IP : %STATIC%
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO ENTER 1 = STARTUP
ECHO ENTER 2 = RECHECK IP
ECHO AUTO MODE [COM : %COMxX%] [SV : %SERVERNAME%] [IPCheck : %HOSTCHECKIP%]
CALL :GETHOSCHKIP
ECHO CHECKING IP SERVER : %HOSTCHECKIP%
TIMEOUT 02 /NOBREAK
CURL.EXE -s -m 15 %HOSTCHECKIP% > STATIC.LOG
FINDSTR /R /N "^" ".\STATIC.LOG" | FIND /C ":"
IF %ERRORLEVEL% EQU 1 SET /A HOSTCHECKIPLOOP=%HOSTCHECKIPLOOP% + 1 && GOTO STATIC
FOR /F "tokens=1 DELIMS=" %%A IN (STATIC.LOG) DO SET STATIC=%%A
IF "%STATIC%" EQU "" SET /A HOSTCHECKIPLOOP=%HOSTCHECKIPLOOP% + 1 && GOTO STATIC
IF "%STATIC%" EQU " " SET /A HOSTCHECKIPLOOP=%HOSTCHECKIPLOOP% + 1 && GOTO STATIC
IF "%STATIC%" EQU "ECHO is off." SET /A HOSTCHECKIPLOOP=%HOSTCHECKIPLOOP% + 1 && GOTO STATIC
IF "%STATIC%" EQU "ECHO is off. " SET /A HOSTCHECKIPLOOP=%HOSTCHECKIPLOOP% + 1 && GOTO STATIC
TIMEOUT 10 /NOBREAK
.\wget\wget -q -O VPN.CSV http://www.vpngate.net/api/iphone/ --user-agent="Mozilla/5.0 (Mozilla/5.0 (iPhone; CPU iPhone OS 9_2 like Mac OS X) AppleWebKit/601.1 (KHTML, like Gecko) CriOS/47.0.2526.70 Mobile/13C71 Safari/601.1.46" --tries=2 --connect-timeout=15
CMD /C START /MAX C:\Windows\explorer.exe shell:::{3080F90D-D7AD-11D9-BD98-0000947B0257}
GOTO RELOAD

:RELOAD
REM ##############
REM |_|  MODE  |_|
REM ##############
CALL :MODELOG
TASKKILL /F /IM "WmiPrvSE.exe"
TASKKILL /F /IM "jp2launcher.exe"
TASKKILL /F /IM "javaw.exe"
REM ##############
REM |_|  MODE  |_|
REM ##############
CLS
DEL /Q ".\jd\tmp\myjd.session"
DEL /Q "%SYSTEMDRIVE%\Download\Jdownloader\*.*"
DEL /Q "%HOMEPATH%\My Documents\Downloads\*.*"
DEL /Q ".\ff\Data\profile_normal\iMacros\Downloads\*.*"
DEL /Q ".\ff\Data\profile_piracy\iMacros\Downloads\*.*"
RMDIR ".\jd\logs" /s /q
RMDIR ".\jd\tmp\logs" /s /q
REM	TASKLIST /FI "IMAGENAME eq Jdownloader2.exe" | find /i "Jdownloader2.exe"
REM	IF %ERRORLEVEL% EQU 0 GOTO LOAD
REM	CMD /C START /MAX .\jd\JDownloader2.exe
TIMEOUT 10 /NOBREAK
GOTO LOAD

:LOAD
CLS
SET "KEYUSE="
SET "KEYPAS="
IF NOT EXIST ".\OPENVPN" MKDIR ".\OPENVPN"
SET /A VPNRANDOM=%RANDOM% %%70 +1
IF %VPNRANDOM% GEQ 1 (
	IF NOT %VPNRANDOM% GEQ 10 (
		SET VPNON=hotspotshield.com.get
		SET VPNEXTEN=ovpn
		IF NOT EXIST ".\OPENVPN\hotspotshield.com.get" MKDIR ".\OPENVPN\hotspotshield.com.get" && MKDIR ".\OPENVPN\hotspotshield.com.get\out" && MKDIR ".\OPENVPN\hotspotshield.com.get\limite"
		FORFILES -p .\OPENVPN\hotspotshield.com.get\out -m *.txt -d -1 -c "cmd /c del /q @file"
		FORFILES -p .\OPENVPN\hotspotshield.com.get\limite -m *.txt -d -1 -c "cmd /c  del /q @file"
		SET /A VPNRSPAM=0
		SET /A VPNMSPAM=2
		SET /A ACTRSPAM=0
		SET /A ACTMSPAM=4
		SET VPNRETRY=LOADLST
		SET VPNLOCAL=HxVPN
		SET VPNUSAGE=LOADHSS && GOTO LOADLST
	)
)
IF %VPNRANDOM% GEQ 11 (
	IF NOT %VPNRANDOM% GEQ 16 (
		SET VPNON=purevpn.com.get
		SET KEYON=purevpn.com
		SET VPNEXTEN=ovpn
		IF NOT EXIST ".\OPENVPN\purevpn.com.get" MKDIR ".\OPENVPN\purevpn.com.get" && MKDIR ".\OPENVPN\purevpn.com.get\out" && MKDIR ".\OPENVPN\purevpn.com.get\limite"
		FORFILES -p .\OPENVPN\purevpn.com.get\out -m *.txt -d -1 -c "cmd /c del /q @file"
		FORFILES -p .\OPENVPN\purevpn.com.get\limite -m *.txt -d -1 -c "cmd /c  del /q @file"
		CALL :purevpn.com
		SET /A VPNRSPAM=0
		SET /A VPNMSPAM=2
		SET /A ACTRSPAM=0
		SET /A ACTMSPAM=4
		SET VPNRETRY=LOADLST
		SET VPNLOCAL=OpenVPN
		SET VPNUSAGE=LOADGUI && GOTO LOADLST
	)
)
IF %VPNRANDOM% GEQ 17 (
	IF NOT %VPNRANDOM% GEQ 21 (
		SET VPNON=windscribe.com.get
		SET VPNEXTEN=ovpn
		IF NOT EXIST ".\OPENVPN\windscribe.com.get" MKDIR ".\OPENVPN\windscribe.com.get" && MKDIR ".\OPENVPN\windscribe.com.get\out" && MKDIR ".\OPENVPN\windscribe.com.get\limite"
		FORFILES -p .\OPENVPN\windscribe.com.get\out -m *.txt -d -1 -c "cmd /c del /q @file"
		FORFILES -p .\OPENVPN\windscribe.com.get\limite -m *.txt -d -1 -c "cmd /c  del /q @file"
		SET /A VPNRSPAM=0
		SET /A VPNMSPAM=2
		SET /A ACTRSPAM=0
		SET /A ACTMSPAM=4
		SET VPNRETRY=LOADLST
		SET VPNLOCAL=OpenVPN
		SET VPNUSAGE=LOADGUI && GOTO LOADLST
	)
)
IF %VPNRANDOM% GEQ 22 (
	IF NOT %VPNRANDOM% GEQ 24 (
		SET VPNON=windscribe.com.get
		SET VPNEXTEN=pbk
		IF NOT EXIST ".\OPENVPN\windscribe.com.get" MKDIR ".\OPENVPN\windscribe.com.get" && MKDIR ".\OPENVPN\windscribe.com.get\out" && MKDIR ".\OPENVPN\windscribe.com.get\limite"
		FORFILES -p .\OPENVPN\windscribe.com.get\out -m *.txt -d -1 -c "cmd /c del /q @file"
		FORFILES -p .\OPENVPN\windscribe.com.get\limite -m *.txt -d -1 -c "cmd /c  del /q @file"
		SET USERNAME=akgift02_x4cs95g
		SET PASSWORD=ub6mdf4ezw
		SET /A VPNRSPAM=0
		SET /A VPNMSPAM=2
		SET /A ACTRSPAM=0
		SET /A ACTMSPAM=4
		SET VPNRETRY=LOADLST
		SET VPNLOCAL=OpenVPN
		SET VPNUSAGE=LOADRAS && GOTO LOADLST
	)
)
IF %VPNRANDOM% GEQ 25 (
	IF NOT %VPNRANDOM% GEQ 50 (
		SET VPNON=vpngate.net
		SET VPNEXTEN=ovpn
		IF NOT EXIST ".\OPENVPN\vpngate.net" MKDIR ".\OPENVPN\vpngate.net" && MKDIR ".\OPENVPN\vpngate.net\out" && MKDIR ".\OPENVPN\vpngate.net\limite"
		:: MOVE ".\OPENVPN\vpngate.net\*.ovpn" "Z:\OPENVPN\vpngate.net"
		:: DEL /Q ".\OPENVPN\vpngate.net\*.*"
		DEL /Q "Z:\OPENVPN\vpngate.net\out\*.*"
		DEL /Q "Z:\OPENVPN\vpngate.net\limite\*.*"
		SET /A IPCONFIG=61
		SET /A PORTOVPN=61
		SET /A PROTOCOL=40
		SET /A VPNRSPAM=0
		SET /A VPNMSPAM=6
		SET /A ACTRSPAM=0
		SET /A ACTMSPAM=12
		SET VPNRETRY=LOADLST
		SET VPNLOCAL=OpenVPN
		SET VPNUSAGE=LOADCON && GOTO LOADLST
	)
)
IF %VPNRANDOM% GEQ 51 (
	IF NOT %VPNRANDOM% GEQ 56 (
		SET VPNON=ipvanish.com.get
		SET VPNEXTEN=ovpn
		IF NOT EXIST ".\OPENVPN\ipvanish.com.get" MKDIR ".\OPENVPN\ipvanish.com.get" && MKDIR ".\OPENVPN\ipvanish.com.get\out" && MKDIR ".\OPENVPN\ipvanish.com.get\limite"
		FORFILES -p .\OPENVPN\ipvanish.com.get\out -m *.txt -d -1 -c "cmd /c del /q @file"
		FORFILES -p .\OPENVPN\ipvanish.com.get\limite -m *.txt -d -1 -c "cmd /c  del /q @file"
		SET /A VPNRSPAM=0
		SET /A VPNMSPAM=2
		SET /A ACTRSPAM=0
		SET /A ACTMSPAM=4
		SET VPNRETRY=LOADLST
		SET VPNLOCAL=OpenVPN
		SET VPNUSAGE=LOADGUI && GOTO LOADLST
	)
)
IF %VPNRANDOM% GEQ 57 (
	IF NOT %VPNRANDOM% GEQ 63 (
		SET VPNON=nordvpn.com.get
		SET KEYON=nordvpn.com
		SET VPNEXTEN=ovpn
		IF NOT EXIST ".\OPENVPN\nordvpn.com.get" MKDIR ".\OPENVPN\nordvpn.com.get" && MKDIR ".\OPENVPN\nordvpn.com.get\out" && MKDIR ".\OPENVPN\nordvpn.com.get\limite"
		FORFILES -p .\OPENVPN\nordvpn.com.get\out -m *.txt -d -1 -c "cmd /c del /q @file"
		FORFILES -p .\OPENVPN\nordvpn.com.get\limite -m *.txt -d -1 -c "cmd /c  del /q @file"
		CALL :nordvpn.com
		SET /A VPNRSPAM=0
		SET /A VPNMSPAM=2
		SET /A ACTRSPAM=0
		SET /A ACTMSPAM=4
		SET VPNRETRY=LOADLST
		SET VPNLOCAL=OpenVPN
		SET VPNUSAGE=LOADGUI && GOTO LOADLST
	)
)
IF %VPNRANDOM% GEQ 64 (
	IF NOT %VPNRANDOM% GEQ 70 (
		SET VPNON=safervpn.com
		SET KEYON=safervpn.com
		SET VPNEXTEN=ovpn
		IF NOT EXIST ".\OPENVPN\safervpn.com" MKDIR ".\OPENVPN\safervpn.com" && MKDIR ".\OPENVPN\safervpn.com\out" && MKDIR ".\OPENVPN\safervpn.com\limite"
		FORFILES -p .\OPENVPN\safervpn.com\out -m *.txt -d -1 -c "cmd /c del /q @file"
		FORFILES -p .\OPENVPN\safervpn.com\limite -m *.txt -d -1 -c "cmd /c  del /q @file"
		CALL :safervpn.com
		SET /A VPNRSPAM=0
		SET /A VPNMSPAM=2
		SET /A ACTRSPAM=0
		SET /A ACTMSPAM=4
		SET VPNRETRY=LOADLST
		SET VPNLOCAL=OpenVPN
		SET VPNUSAGE=LOADGUI && GOTO LOADLST
	)
)
GOTO LOAD
:LOADLST
TASKKILL /F /IM "hxvpn.exe"
TASKKILL /F /IM "openvpn-gui.exe"
TASKKILL /F /IM "openvpn.exe"
TASKKILL /F /IM "rasdial.exe"
TASKKILL /F /IM "rasautou.exe"
RASDIAL /DISCONNECT
DEL /Q "..\%VPNLOCAL%\config\*.*"
DEL /Q "..\%VPNLOCAL%\config\out\*.*"
DEL /Q "..\%VPNLOCAL%\config\key\*.*"
DEL /Q "..\%VPNLOCAL%\config\proxies\*.*"
DEL /Q "..\%VPNLOCAL%\log\*.*"
DEL /Q "..\%VPNLOCAL%\config\*.*"
DEL /Q "..\%VPNLOCAL%\config\out\*.*"
DEL /Q "..\%VPNLOCAL%\config\key\*.*"
DEL /Q "..\%VPNLOCAL%\config\proxies\*.*"
DEL /Q ".\ACTION.LOG"
IF %ACTRSPAM% GEQ %ACTMSPAM% (
	SET /A ACTRSPAM=0
	SET VPNRETRY=LOAD
) ELSE (
	SET /A ACTRSPAM+=1
	TIMEOUT 01 /NOBREAK
)
:LOADGEN
FOR /F %%F IN ('DIR /A-D-S-H /B "Z:\OPENVPN\%VPNON%" ^| FIND /C ".%VPNEXTEN%"') DO SET /A VPNCN=%%F
IF %VPNCN% EQU 1 GOTO LOAD
SET /A VPNOF=(%RANDOM%*%VPNCN%/32768)+1
FOR /F %%F IN ('DIR /A-D-S-H /B ".\OPENVPN\%VPNON%\out" ^| FIND /C ".%VPNEXTEN%" 2^>NUL') DO SET /A OUTER=%%F
FOR /F %%F IN ('DIR /A-D-S-H /B ".\OPENVPN\%VPNON%\limite" ^| FIND /C ".%VPNEXTEN%" 2^>NUL') DO SET /A LIMIT=%%F
SET /A TOTAL=%OUTER%+%LIMIT%+8
IF %TOTAL% GEQ %VPNCN% GOTO LOAD
FOR /F "delims= skip=%VPNOF%" %%F in ('DIR /A-D-S-H /B "Z:\OPENVPN\%VPNON%\*.%VPNEXTEN%"') DO (
	SET "VPNNAMEONTYPE=%%F"
	SET "VPNNAMENOTYPE=%%~nF"
	GOTO LOADOUT
)
:LOADOUT
DIR /A-D-S-H /B ".\OPENVPN\%VPNON%\out" | FIND "%VPNNAMEONTYPE%"
IF %ERRORLEVEL% EQU 0 GOTO LOADGEN
DIR /A-D-S-H /B ".\OPENVPN\%VPNON%\limite" | FIND "%VPNNAMEONTYPE%"
IF %ERRORLEVEL% EQU 0 GOTO LOADGEN
GOTO %VPNUSAGE%
:LOADHSS
COPY /Y "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.key" "..\%VPNLOCAL%\config\key\"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.ca" "..\%VPNLOCAL%\config\key\"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.crt" "..\%VPNLOCAL%\config\key\"
REM #############
REM |_| ROUTE |_|
REM #############
ECHO. >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO # redirect a host using a domainname to NOT go via the VPN >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route bit.ly 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route bitly.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route is.gd 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route houndify.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.houndify.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route api.houndify.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route 8.25.217.0 255.255.255.0 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route microsoft.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route api.cognitive.microsoft.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route microsoftstore.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.microsoftstore.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route login.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route account.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route outlook.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route messenger.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route office365.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route mem.gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route auth.gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route onestore.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.onestore.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route assets.onestore.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route bing.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route platform.bing.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route speech.platform.bing.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route wit.ai 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.wit.ai 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route api.wit.ai 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route 66.220.159.0 255.255.255.0 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route facebook.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route google.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.google.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route gstatic.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.gstatic.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route googleapis.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.googleapis.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route emailfake.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.emailfake.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route fakenamegenerator.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.fakenamegenerator.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM #############
REM |_| ROUTE |_|
REM #############
TIMEOUT 01 /NOBREAK
REM	CMD /C START ..\%VPNLOCAL%\data\bin\hx-vpn.exe --connect %VPNNAMEONTYPE%
START /MAX CMD /C ..\%VPNLOCAL%\data\bin\hxvpn.exe "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%" ^> ACTION.LOG
TIMEOUT 20 /NOBREAK
FOR /F %%F IN ('TYPE ".\ACTION.LOG" ^| FIND /C /I "Connection timed out"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 (
	:: IF /I EXIST "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" (
		ECHO %VPNNAMEONTYPE% > ".\OPENVPN\%VPNON%\out\%VPNNAMEONTYPE%.txt"  
		:: DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	:: )
	GOTO %VPNRETRY%
)
GOTO PING
:LOADGUI
COPY /Y "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.key" "..\%VPNLOCAL%\config\key\"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.ca" "..\%VPNLOCAL%\config\key\"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.crt" "..\%VPNLOCAL%\config\key\"
IF "%KEYUSE%" NEQ "" ECHO %KEYUSE% > "..\%VPNLOCAL%\config\key\%KEYON%.key"
IF "%KEYPAS%" NEQ "" ECHO %KEYPAS% >> "..\%VPNLOCAL%\config\key\%KEYON%.key"
REM #############
REM |_| ROUTE |_|
REM #############
ECHO. >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO # redirect a host using a domainname to NOT go via the VPN >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route bit.ly 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route bitly.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route is.gd 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route houndify.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.houndify.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route api.houndify.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route 8.25.217.0 255.255.255.0 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route microsoft.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route api.cognitive.microsoft.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route microsoftstore.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.microsoftstore.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route login.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route account.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route outlook.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route messenger.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route office365.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route mem.gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route auth.gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route onestore.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.onestore.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route assets.onestore.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route bing.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route platform.bing.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route speech.platform.bing.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route wit.ai 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.wit.ai 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route api.wit.ai 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route 66.220.159.0 255.255.255.0 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route facebook.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route google.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.google.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route gstatic.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.gstatic.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route googleapis.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.googleapis.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route emailfake.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.emailfake.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route fakenamegenerator.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.fakenamegenerator.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM #############
REM |_| ROUTE |_|
REM #############
TIMEOUT 01 /NOBREAK
CMD /C START ..\%VPNLOCAL%\bin\openvpn-gui.exe --connect %VPNNAMEONTYPE%
TIMEOUT 30 /NOBREAK
FOR /F %%F IN ('TYPE "..\%VPNLOCAL%\log\%VPNNAMENOTYPE%.LOG" ^| FIND /C /I "try again in 2 seconds"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 (
	IF /I EXIST "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" (
		ECHO %VPNNAMEONTYPE% > ".\OPENVPN\%VPNON%\out\%VPNNAMEONTYPE%.txt"  
		:: DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	)
	GOTO %VPNRETRY%
)
FOR /F %%F IN ('TYPE "..\%VPNLOCAL%\log\%VPNNAMENOTYPE%.LOG" ^| FIND /C /I "try again in 5 seconds"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 (
	IF /I EXIST "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" (
		ECHO %VPNNAMEONTYPE% > ".\OPENVPN\%VPNON%\out\%VPNNAMEONTYPE%.txt"  
		:: DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	)
	GOTO %VPNRETRY%
)
FOR /F %%F IN ('TYPE "..\%VPNLOCAL%\log\%VPNNAMENOTYPE%.LOG" ^| FIND /C /I "Restart pause, 5 second"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 (
	IF /I EXIST "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" (
		ECHO %VPNNAMEONTYPE% > ".\OPENVPN\%VPNON%\out\%VPNNAMEONTYPE%.txt"  
		DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	)
	GOTO %VPNRETRY%
)
FOR /F %%F IN ('TYPE "..\%VPNLOCAL%\log\%VPNNAMENOTYPE%.LOG" ^| FIND /C /I "Restart pause, 2 second"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 (
	IF /I EXIST "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" (
		ECHO %VPNNAMEONTYPE% > ".\OPENVPN\%VPNON%\out\%VPNNAMEONTYPE%.txt"  
		:: DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	)
	GOTO %VPNRETRY%
)
GOTO PING
:LOADCON
COPY /Y "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.key" "..\%VPNLOCAL%\config\key\"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.ca" "..\%VPNLOCAL%\config\key\"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.crt" "..\%VPNLOCAL%\config\key\"
REM #############
REM |_| ROUTE |_|
REM #############
ECHO. >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO # redirect a host using a domainname to NOT go via the VPN >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route bit.ly 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route bitly.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route is.gd 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route houndify.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.houndify.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route api.houndify.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route 8.25.217.0 255.255.255.0 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route microsoft.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route api.cognitive.microsoft.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route microsoftstore.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.microsoftstore.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route login.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route account.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route outlook.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route messenger.live.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route office365.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route mem.gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route auth.gfx.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route onestore.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.onestore.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route assets.onestore.ms 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route bing.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route platform.bing.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route speech.platform.bing.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route wit.ai 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.wit.ai 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route api.wit.ai 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route 66.220.159.0 255.255.255.0 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route facebook.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route google.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.google.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route gstatic.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.gstatic.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route googleapis.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM	ECHO route www.googleapis.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route emailfake.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.emailfake.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route fakenamegenerator.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
ECHO route www.fakenamegenerator.com 255.255.255.255 net_gateway >> "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
REM #############
REM |_| ROUTE |_|
REM #############
COPY /Y "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.key" "..\%VPNLOCAL%\config\key\"
COPY /Y "Z:\OPENVPN\%VPNON%\key\*.ca" "..\%VPNLOCAL%\config\key\"
REM #############
REM |_| IPCHK |_|
REM #############
SET PINGICPM=0
SET PINGTCIP=0
SET TIMEICPM=0
SET TIMETCIP=0
SET PROTOCAL=0
SET PINGICPMRESULT=0
SET PINGTCIPRESULT=0
SET TIMEICPMRESULT=0
SET TIMETCIPRESULT=0
CALL :GETIPCONFIG "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
CALL :GETPORTOVPN "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
CALL :GETPROTOCAL "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%"
CLS
ECHO %VPNNAMEONTYPE% [%VPNOF%/%VPNCN%] : %GETPROTOCAL% %GETIPCONFIG%:%GETPORTOVPN%
IF "%GETPROTOCAL%" EQU "udp" SET PROTOCAL=1
IF "%GETPROTOCAL%" NEQ "udp" FOR /F %%F in ('psping.exe -n 1 -i 0 %GETIPCONFIG% ^| find /c "Lost = 0"') DO SET PINGICPMRESULT=%%F
IF "%GETPROTOCAL%" NEQ "udp" IF %PINGICPMRESULT% GEQ 1 SET PINGICPM=1
IF "%GETPROTOCAL%" NEQ "udp" FOR /F %%F in ('psping.exe %GETIPCONFIG%:%GETPORTOVPN% -u -n 1 -i 0 ^| find /c "Lost = 0"') DO SET PINGTCIPRESULT=%%F
IF "%GETPROTOCAL%" NEQ "udp" IF %PINGTCIPRESULT% GEQ 1 SET PINGTCIP=1
IF "%GETPROTOCAL%" NEQ "udp" IF "%PINGICPM%%PINGTCIP%%PROTOCAL%" EQU "000" DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" && GOTO %VPNRETRY%
IF "%GETPROTOCAL%" NEQ "udp" FOR /F "tokens=3 delims==.m " %%F in ('psping.exe -n 2 -i 0 %GETIPCONFIG%') DO SET TIMEICPMRESULT=%%F
IF "%GETPROTOCAL%" NEQ "udp" IF "%TIMEICPMRESULT%" NEQ "" IF "%TIMEICPMRESULT%" NEQ "ECHO is off." IF %TIMEICPMRESULT% LEQ 800 SET TIMEICPM=1
IF "%GETPROTOCAL%" NEQ "udp" FOR /F "tokens=3 delims==.m " %%F in ('psping.exe %GETIPCONFIG%:%GETPORTOVPN% -u -n 2 -i 0') DO SET TIMETCIPRESULT=%%F
IF "%GETPROTOCAL%" NEQ "udp" IF "%TIMETCIPRESULT%" NEQ "" IF "%TIMETCIPRESULT%" NEQ "ECHO is off." IF %TIMETCIPRESULT% LEQ 800 SET TIMETCIP=1
IF "%PINGICPM%%PINGTCIP%%TIMEICPM%%TIMETCIP%%PROTOCAL%" EQU "00000" DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" && GOTO %VPNRETRY%
REM #############
REM |_| IPCHK |_|
REM #############
TIMEOUT 01 /NOBREAK
START /MAX CMD /C ..\%VPNLOCAL%\bin\openvpn.exe "..\%VPNLOCAL%\config\%VPNNAMEONTYPE%" ^> ACTION.LOG
TIMEOUT 20 /NOBREAK
FOR /F %%F IN ('TYPE ".\ACTION.LOG" ^| FIND /C /I "Connection timed out"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" && GOTO %VPNRETRY%
FOR /F %%F IN ('TYPE ".\ACTION.LOG" ^| FIND /C /I "UDPv4 link remote: [AF_INET]"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" && GOTO %VPNRETRY%
FOR /F %%F IN ('TYPE ".\ACTION.LOG" ^| FIND /C /I "TCPv4_CLIENT link remote: [AF_INET]"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" && GOTO %VPNRETRY%
FOR /F %%F IN ('TYPE ".\ACTION.LOG" ^| FIND /C /I "try again in 5 seconds"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" && GOTO %VPNRETRY%
FOR /F %%F IN ('TYPE ".\ACTION.LOG" ^| FIND /C /I "try again in 2 seconds"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" && GOTO %VPNRETRY%
FOR /F %%F IN ('TYPE ".\ACTION.LOG" ^| FIND /C /I "Restart pause, 5 second"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" && GOTO %VPNRETRY%
FOR /F %%F IN ('TYPE ".\ACTION.LOG" ^| FIND /C /I "Restart pause, 2 second"') DO SET /A ACTION=%%F
IF %ACTION% GEQ 2 DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" && GOTO %VPNRETRY%
GOTO PING
:LOADRAS
COPY /Y "Z:\OPENVPN\%VPNON%\pbk\rasphone.pbk" "%PROGRAMDATA%\Microsoft\Network\Connections\pbk\rasphone.pbk"
TIMEOUT 05 /NOBREAK
START /MAX /WAIT CMD /C RASDIAL "%VPNNAMENOTYPE%" %USERNAME% %PASSWORD% ^> ACTION.LOG
TIMEOUT 02 /NOBREAK
FOR /F %%F IN ('TYPE ".\ACTION.LOG" ^| FIND /C /I "completed successfully"') DO SET /A ACTION=%%F
IF %ACTION% EQU 0 (
	IF /I EXIST "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" (
		ECHO %VPNNAMEONTYPE% > ".\OPENVPN\%VPNON%\out\%VPNNAMEONTYPE%.txt"  
		DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	)
	GOTO %VPNRETRY%
)
REM #############
REM |_| ROUTE |_|
REM #############
ROUTE DELETE %BIT% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %BITLY% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %IS% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %HOUNDIFY% mask 255.255.255.255 192.168.126.2
ROUTE DELETE 198.49.100.0/24 192.168.126.2
ROUTE DELETE %WWWHOUNDIFY% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %APIHOUNDIFY% mask 255.255.255.255 192.168.126.2
ROUTE DELETE 8.25.217.0/24 192.168.126.2
ROUTE DELETE %MICROSOFT% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %APICOGNITIVEMICROSOFT% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %MICROSOFTSTORE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WWWMICROSOFTSTORE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %LIVE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WWWLIVE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %LOGINLIVE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %ACCOUNTLIVE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %OUTLOOKLIVE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %MESSENGERLIVE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %OFFICE365% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %GFX% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WWWGFX% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %MEMGFX% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %AUTHGFX% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %ONESTORE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WWWONESTORE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %ASSETSONESTORE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %BING% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %PLATFORMBING% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %SPEECHPLATFORMBING% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WIT% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WWWWIT% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %APIWIT% mask 255.255.255.255 192.168.126.2
ROUTE DELETE 66.220.159.0/24 192.168.126.2
ROUTE DELETE %FACEBOOK% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %GOOGLE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WWWGOOGLE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %GSTATIC% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WWWGSTATIC% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %GOOGLEAPIS% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WWWGOOGLEAPIS% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %EMAILFAKE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WWWEMAILFAKE% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %FAKENAMEGENERATOR% mask 255.255.255.255 192.168.126.2
ROUTE DELETE %WWWFAKENAMEGENERATOR% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 bit.ly') DO (IF "%%p" NEQ "" set BIT=%%p)
ROUTE ADD %BIT% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 bitly.com') DO (IF "%%p" NEQ "" set BITLY=%%p)
ROUTE ADD %BITLY% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 is.gd') DO (IF "%%p" NEQ "" set IS=%%p)
ROUTE ADD %IS% mask 255.255.255.255 192.168.126.2
REM	FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 houndify.com') DO (IF "%%p" NEQ "" set HOUNDIFY=%%p)
REM	ROUTE ADD %HOUNDIFY% mask 255.255.255.255 192.168.126.2
REM	ROUTE ADD 198.49.100.0/24 192.168.126.2
REM	FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.houndify.com') DO (IF "%%p" NEQ "" set WWWHOUNDIFY=%%p)
REM	ROUTE ADD %WWWHOUNDIFY% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 api.houndify.com') DO (IF "%%p" NEQ "" set APIHOUNDIFY=%%p)
ROUTE ADD %APIHOUNDIFY% mask 255.255.255.255 192.168.126.2
ROUTE ADD 8.25.217.0/24 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 microsoft.com') DO (IF "%%p" NEQ "" set MICROSOFT=%%p)
ROUTE ADD %MICROSOFT% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 api.cognitive.microsoft.com') DO (IF "%%p" NEQ "" set APICOGNITIVEMICROSOFT=%%p)
ROUTE ADD %APICOGNITIVEMICROSOFT% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 microsoftstore.com') DO (IF "%%p" NEQ "" set MICROSOFTSTORE=%%p)
ROUTE ADD %MICROSOFTSTORE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.microsoftstore.com') DO (IF "%%p" NEQ "" set WWWMICROSOFTSTORE=%%p)
ROUTE ADD %WWWMICROSOFTSTORE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 live.com') DO (IF "%%p" NEQ "" set LIVE=%%p)
ROUTE ADD %LIVE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.live.com') DO (IF "%%p" NEQ "" set WWWLIVE=%%p)
ROUTE ADD %WWWLIVE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 login.live.com') DO (IF "%%p" NEQ "" set LOGINLIVE=%%p)
ROUTE ADD %LOGINLIVE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 account.live.com') DO (IF "%%p" NEQ "" set ACCOUNTLIVE=%%p)
ROUTE ADD %ACCOUNTLIVE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 outlook.live.com') DO (IF "%%p" NEQ "" set OUTLOOKLIVE=%%p)
ROUTE ADD %OUTLOOKLIVE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 messenger.live.com') DO (IF "%%p" NEQ "" set MESSENGERLIVE=%%p)
ROUTE ADD %MESSENGERLIVE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 office365.com') DO (IF "%%p" NEQ "" set OFFICE365=%%p)
ROUTE ADD %OFFICE365% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 gfx.ms') DO (IF "%%p" NEQ "" set GFX=%%p)
ROUTE ADD %GFX% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.gfx.ms') DO (IF "%%p" NEQ "" set WWWGFX=%%p)
ROUTE ADD %WWWGFX% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 mem.gfx.ms') DO (IF "%%p" NEQ "" set MEMGFX=%%p)
ROUTE ADD %MEMGFX% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 auth.gfx.ms') DO (IF "%%p" NEQ "" set AUTHGFX=%%p)
ROUTE ADD %AUTHGFX% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 onestore.ms') DO (IF "%%p" NEQ "" set ONESTORE=%%p)
ROUTE ADD %ONESTORE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.onestore.ms') DO (IF "%%p" NEQ "" set WWWONESTORE=%%p)
ROUTE ADD %WWWONESTORE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 assets.onestore.ms') DO (IF "%%p" NEQ "" set ASSETSONESTORE=%%p)
ROUTE ADD %ASSETSONESTORE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 bing.com') DO (IF "%%p" NEQ "" set BING=%%p)
ROUTE ADD %BING% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 platform.bing.com') DO (IF "%%p" NEQ "" set PLATFORMBING=%%p)
ROUTE ADD %PLATFORMBING% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 speech.platform.bing.com') DO (IF "%%p" NEQ "" set SPEECHPLATFORMBING=%%p)
ROUTE ADD %SPEECHPLATFORMBING% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 wit.ai') DO (IF "%%p" NEQ "" set WIT=%%p)
ROUTE ADD %WIT% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.wit.ai') DO (IF "%%p" NEQ "" set WWWWIT=%%p)
ROUTE ADD %WWWWIT% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 api.wit.ai') DO (IF "%%p" NEQ "" set APIWIT=%%p)
ROUTE ADD %APIWIT% mask 255.255.255.255 192.168.126.2
ROUTE ADD 66.220.159.0/24 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 facebook.com') DO (IF "%%p" NEQ "" set FACEBOOK=%%p)
ROUTE ADD %FACEBOOK% mask 255.255.255.255 192.168.126.2
REM	FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 google.com') DO (IF "%%p" NEQ "" set GOOGLE=%%p)
REM	ROUTE ADD %GOOGLE% mask 255.255.255.255 192.168.126.2
REM	FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.google.com') DO (IF "%%p" NEQ "" set WWWGOOGLE=%%p)
REM	ROUTE ADD %WWWGOOGLE% mask 255.255.255.255 192.168.126.2
REM	FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 gstatic.com') DO (IF "%%p" NEQ "" set GSTATIC=%%p)
REM	ROUTE ADD %GSTATIC% mask 255.255.255.255 192.168.126.2
REM	FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.gstatic.com') DO (IF "%%p" NEQ "" set WWWGSTATIC=%%p)
REM	ROUTE ADD %WWWGSTATIC% mask 255.255.255.255 192.168.126.2
REM	FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.googleapis.com') DO (IF "%%p" NEQ "" set WWWGOOGLEAPIS=%%p)
REM	ROUTE ADD %WWWGOOGLEAPIS% mask 255.255.255.255 192.168.126.2
REM	FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 googleapis.com') DO (IF "%%p" NEQ "" set GOOGLEAPIS=%%p)
REM	ROUTE ADD %GOOGLEAPIS% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 emailfake.com') DO (IF "%%p" NEQ "" set EMAILFAKE=%%p)
ROUTE ADD %EMAILFAKE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.emailfake.com') DO (IF "%%p" NEQ "" set WWWEMAILFAKE=%%p)
ROUTE ADD %EMAILFAKE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 fakenamegenerator.com') DO (IF "%%p" NEQ "" set FAKENAMEGENERATOR=%%p)
ROUTE ADD %EMAILFAKE% mask 255.255.255.255 192.168.126.2
FOR /F "tokens=1,2 delims=[]" %%o IN ('ping -n 1 www.fakenamegenerator.com') DO (IF "%%p" NEQ "" set WWWFAKENAMEGENERATOR=%%p)
ROUTE ADD %EMAILFAKE% mask 255.255.255.255 192.168.126.2
REM #############
REM |_| ROUTE |_|
REM #############
GOTO PING


:PING
SET /A COUNT=0
SET /A COUNTLIMIT=5
IF %VPNRSPAM% GEQ %VPNMSPAM% (
	:: SET /A ACTRSPAM=0
	SET /A VPNRSPAM=0
	SET VPNRETRY=LOAD
) ELSE (
	:: SET /A ACTRSPAM=0
	SET /A VPNRSPAM+=1
	TIMEOUT 01 /NOBREAK
)
:PINGCOUNTING
CLS
SET /A COUNT+=1
IF %COUNT% GEQ %COUNTLIMIT% (
	IF "%VPNON%" EQU "vpngate.net" (
		DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	) ELSE (
		:: IF /I EXIST "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" (
			ECHO %VPNNAMEONTYPE% > ".\OPENVPN\%VPNON%\out\%VPNNAMEONTYPE%.txt"  
			:: DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
			GOTO %VPNRETRY%
		:: )
		GOTO %VPNRETRY%
	)
)
GOTO PINGCHECKIP
:PINGCHECKIP
CLS
ECHO CHECKING IP :    [%COUNT%/%COUNTLIMIT%] [C:%COMPLETELOOT% M:%MISCARRYLOOT%]
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO STATIC   IP : %STATIC%
ECHO PIRACY   IP : %PIRACY%  [%IPLOGS%] 
ECHO SERVER   SV : %VPNON% [%VPNRSPAM%:%ACTRSPAM%]
IF "%VPNON%" EQU "vpngate.net" ECHO NAME   OVPN : %VPNNAMEONTYPE% : %GETPROTOCAL% %GETIPCONFIG%:%GETPORTOVPN% [%PINGICPM%%PINGTCIP%%TIMEICPM%%TIMETCIP%%PROTOCAL% - %PINGICPMRESULT% %PINGTCIPRESULT% %TIMEICPMRESULT% %TIMETCIPRESULT%]
IF "%VPNON%" NEQ "vpngate.net" ECHO NAME   OVPN : %VPNNAMEONTYPE%
CALL :GETHOSCHKIP && ECHO CHECK    SV : %HOSTCHECKIP%
ECHO SHABBY   IP : %SHABBY%
TIMEOUT 04 /NOBREAK
CURL.EXE -s -m 15 %HOSTCHECKIP% > PIRACY.LOG
FOR /F "tokens=1" %%B IN ('type .\PIRACY.LOG ^| findrepl ":" "."') DO SET PIRACY=%%B
FOR /F "tokens=1 DELIMS=" %%C IN (SHABBY.LOG) DO SET SHABBY=%%C
FOR %%B in (PIRACY.LOG) DO IF %%~zB==0 GOTO PINGCOUNTING
IF "%PIRACY%" EQU "" GOTO PINGCOUNTING
IF "%PIRACY%" EQU " " GOTO PINGCOUNTING
IF "%PIRACY%" EQU "ECHO is off." GOTO PINGCOUNTING
IF "%PIRACY%" EQU "ECHO is off. " GOTO PINGCOUNTING
IF "%PIRACY%" EQU "%STATIC%" GOTO PINGCOUNTING
IF "%PIRACY%" EQU "%STATIC% " GOTO PINGCOUNTING
IF "%PIRACY%" EQU "%SHABBY%" PING -n 5 localhost && GOTO %VPNRETRY%
IF "%PIRACY%" EQU "%SHABBY% " PING -n 5 localhost && GOTO %VPNRETRY%
DIR /A-D-S-H /B "Z:\Sync\IPLOGS" > IPLOGS.LOG
FOR /F "tokens=1" %%B IN ('Type IPLOGS.LOG ^| Find /C "%PIRACY%"') DO SET /A IPLOGS=%%B
IF %IPLOGS% GEQ 2 (
	IF "%VPNON%" EQU "vpngate.net" (
		DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	) ELSE (
		:: IF /I EXIST "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" (
			ECHO %VPNNAMEONTYPE% > ".\OPENVPN\%VPNON%\out\%VPNNAMEONTYPE%.txt"  
			:: DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
			GOTO %VPNRETRY%
		:: )
		GOTO %VPNRETRY%
	)
)
SET /A AVGOUTDNS=0 && FOR /F "tokens=10 delims==m " %%F in ('ping -n 5 8.8.8.8 ^| find "Average ="') DO SET /A AVGOUTDNS=%%F
:: SET /A AVGOUTBITLY=0 && FOR /F "tokens=10 delims==m " %%F in ('ping -n 5 bit.ly ^| find "Average ="') DO SET /A AVGOUTBITLY=%%F
SET "AVGOUT=%AVGOUTDNS%"
IF "%VPNON%" EQU "vpngate.net" (
	IF %AVGOUTDNS% EQU 0 (
		DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	)
	IF %AVGOUTDNS% GEQ 800 (
		DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	)
	:: IF %AVGOUTBITLY% EQU 0 (
	:: 	DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
	:: 	GOTO %VPNRETRY%
	:: )
	:: IF %AVGOUTBITLY% GEQ 800 (
	:: 	DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
	:: 	GOTO %VPNRETRY%
	:: )
)
.\wget\wget -q -O PROXY.LOG http://whatismyipaddress.com --user-agent="Mozilla/5.0 (Mozilla/5.0 (iPhone; CPU iPhone OS 9_2 like Mac OS X) AppleWebKit/601.1 (KHTML, like Gecko) CriOS/47.0.2526.70 Mobile/13C71 Safari/601.1.46" --tries=2 --connect-timeout=15
TIMEOUT 2 /NOBREAK && FIND /C /I "Confirmed Proxy Server" ".\PROXY.LOG"
IF %ERRORLEVEL% EQU 0 (
	IF "%VPNON%" EQU "vpngate.net" (
		DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
		GOTO %VPNRETRY%
	) ELSE (
		:: IF /I EXIST "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%" (
			ECHO %VPNNAMEONTYPE% > ".\OPENVPN\%VPNON%\out\%VPNNAMEONTYPE%.txt"  
			:: DEL /Q "Z:\OPENVPN\%VPNON%\%VPNNAMEONTYPE%"
			GOTO %VPNRETRY%
		:: )
		GOTO %VPNRETRY%
	)
)
GOTO PINGSETLOOT
:PINGSETLOOT
ECHO.
SET /A ADDEDURLFIR=0
SET /A RESTARTLOOT=0
SET /A RESULTELOOT=0
SET /A RESULTELOOTCHECK=0
GOTO ADDEDJDOWNLOAD

:ADDEDJDOWNLOAD
CLS
ECHO ADD JDOWNLOADER
ECHO.
REM	CMD /C START /MAX "UNLOCK" /D "%CD%" /I "Z:\Database\unlock.exe" //
REM	CMD /C START /MAX "ADD JDOWNLOAD" /D "%CD%" /I "Z:\Database\addjdownload.exe" %MODELOG%
CMD /C START /WAIT /MAX "GENERATE REFERER" /D "%CD%" /I ".\generate.exe" %MODELOG%
TIMEOUT 5 /NOBREAK
COPY /Y "Z:\GitHub\reCaptcha\audiowit.his" ".\GitHub\reCaptcha\audiowit.ser"
COPY /Y "Z:\GitHub\reCaptcha\audiobing.his" ".\GitHub\reCaptcha\audiobing.ser"
COPY /Y "Z:\GitHub\reCaptcha\audiohoundify.his" ".\GitHub\reCaptcha\audiohoundify.ser"
ECHO. > ".\GitHub\reCaptcha\apikey.key"
COPY /Y "Z:\GitHub\reCaptcha\*.py" ".\GitHub\reCaptcha\"
IF %MODELOG% EQU 1 CMD /C START /MAX "reCaptcha Python" /D ".\GitHub\reCaptcha\" reCaptcha.py
COPY /Y "Z:\Database\vbs\reCaptcha\*.exe" ".\vbs\reCaptcha\"
COPY /Y "Z:\Database\vbs\reCaptcha\*.ahk" ".\vbs\reCaptcha\"
COPY /Y "Z:\Database\vbs\reCaptcha\Screenshots\*.*" ".\vbs\reCaptcha\Screenshots\"
IF %MODELOG% EQU 1 CMD /C START /D ".\vbs\reCaptcha\" .\vbs\reCaptcha\reCaptcha.exe
GOTO ADDEDURLFIREFOX
:ADDEDURLFIREFOX
CLS
ECHO RUNNING FIREFOX
ECHO.
IF %MODELOG% GEQ 1 DEL /Q ".\ff\Data\profile_piracy\iMacros\Downloads\CLOSED.LOG"
IF %MODELOG% GEQ 1 DEL /Q ".\ff\Data\profile_piracy\iMacros\Downloads\OPENED.LOG"
IF %MODELOG% GEQ 1 DEL /Q ".\ff\Data\profile_piracy\iMacros\Downloads\URLCURRENT.LOG"
IF %MODELOG% GEQ 1 DEL /Q ".\ff\Data\profile_piracy\iMacros\Downloads\SESSIONS.LOG"
IF %MODELOG% GEQ 1 DEL /Q ".\ff\Data\profile_normal\iMacros\Downloads\CLOSED.LOG"
IF %MODELOG% GEQ 1 DEL /Q ".\ff\Data\profile_normal\iMacros\Downloads\OPENED.LOG"
IF %MODELOG% GEQ 1 DEL /Q ".\ff\Data\profile_normal\iMacros\Downloads\URLCURRENT.LOG"
IF %MODELOG% GEQ 1 DEL /Q ".\ff\Data\profile_normal\iMacros\Downloads\SESSIONS.LOG"
IF %MODELOG% EQU 0 DEL /Q ".\ff\Data\profile__piracy\iMacros\Downloads\CLOSED.LOG"
IF %MODELOG% EQU 0 DEL /Q ".\ff\Data\profile__piracy\iMacros\Downloads\OPENED.LOG"
IF %MODELOG% EQU 0 DEL /Q ".\ff\Data\profile__piracy\iMacros\Downloads\URLCURRENT.LOG"
IF %MODELOG% EQU 0 DEL /Q ".\ff\Data\profile__piracy\iMacros\Downloads\SESSIONS.LOG"
IF %MODELOG% EQU 0 ECHO 0 > ".\ff\Data\profile_normal\iMacros\Downloads\CLOSED.LOG"
IF %MODELOG% EQU 0 ECHO 0 > ".\ff\Data\profile_normal\iMacros\Downloads\OPENED.LOG"
IF %MODELOG% EQU 0 ECHO 0 > ".\ff\Data\profile_normal\iMacros\Downloads\URLCURRENT.LOG"
IF %MODELOG% EQU 0 ECHO 0 > ".\ff\Data\profile_normal\iMacros\Downloads\SESSIONS.LOG"
TASKKILL /F /IM "firefox.exe"
TASKKILL /F /IM "firefix.exe"
TASKKILL /F /IM "crashreporter.exe"
:: START /MAX .\ff\App\firefox\firefox.exe -profile ".\ff\Data\profile_piracy" /Perfect:1 -new-window imacros://run/?m=Ads_Skip_Bot_-_NoReCaptcha.iim
IF %MODELOG% GEQ 0 START /MIN .\ff\App\firefox\firefix.exe -profile ".\ff\Data\profile_piracy" -no-remote /Perfect:1 && TIMEOUT 30 /NOBREAK
IF /I NOT EXIST ".\ff\Data\profile_piracy\iMacros\Downloads\OPENED.LOG" (
	TASKKILL /F /IM "firefox.exe"
	TASKKILL /F /IM "firefix.exe"
	TASKKILL /F /IM "crashreporter.exe"
	IF %ADDEDURLFIR% GEQ 3 (
		GOTO CLOSE
	) ELSE (
		SET /A ADDEDURLFIR+=1
		GOTO ADDEDJDOWNLOAD
	)
)
:: START /MAX .\ff\App\firefox\firefox.exe -profile ".\ff\Data\profile_normal" /Perfect:1 -new-window imacros://run/?m=Ads_Skip_Bot_-_NoReCapView.iim 
IF %MODELOG% GEQ 1 START /MAX .\ff\App\firefox\firefox.exe -profile ".\ff\Data\profile_normal" -no-remote /Perfect:1 && TIMEOUT 30 /NOBREAK
IF /I NOT EXIST ".\ff\Data\profile_normal\iMacros\Downloads\OPENED.LOG" (
	TASKKILL /F /IM "firefox.exe"
	TASKKILL /F /IM "firefix.exe"
	TASKKILL /F /IM "crashreporter.exe"
	IF %ADDEDURLFIR% GEQ 3 (
		GOTO CLOSE
	) ELSE (
		SET /A ADDEDURLFIR+=1
		GOTO ADDEDJDOWNLOAD
	)
)
CMD /C START /MAX C:\Windows\explorer.exe shell:::{3080F90D-D7AD-11D9-BD98-0000947B0257}
TIMEOUT 4 /NOBREAK
CALL ".\nircmdc.exe" win hide process "JDownloader2.exe"
CALL ".\nircmdc.exe" win max process "firefox.exe"
CALL ".\nircmdc.exe" win max process "firefix.exe"
GOTO CHECKINGFILES

:CHECKINGFILES
SET /A RESTARTLOOT=0
SET /A RESULTELOOT=0
SET /A RESULTELOOTCHECK=0
SET /A CNTMIN=10
GOTO CHECKINGFILESSTART
:CHECKINGFILESSTART
CLS
ECHO CHECKINGFILES %RESULTELOOT% [%RESTARTLOOT%] [C:%COMPLETELOOT% M:%MISCARRYLOOT%]
ECHO NORMAL SESSIONS : %NRSS%
ECHO [%NRUC%]
ECHO PIRACY SESSIONS : %STSS%
ECHO [%STUC%]
ECHO FILE COUNT = %CNT%
ECHO STATIC   IP : %STATIC%
ECHO PIRACY   IP : %PIRACY%  [%IPLOGS% %AVGOUT%]
ECHO SERVER   SV : %VPNON%
IF "%VPNON%" EQU "vpngate.net" ECHO NAME   OVPN : %VPNNAMEONTYPE% : %GETPROTOCAL% %GETIPCONFIG%:%GETPORTOVPN% [%PINGICPM%%PINGTCIP%%TIMEICPM%%TIMETCIP%%PROTOCAL% - %PINGICPMRESULT% %PINGTCIPRESULT% %TIMEICPMRESULT% %TIMETCIPRESULT%]
IF "%VPNON%" NEQ "vpngate.net" ECHO NAME   OVPN : %VPNNAMEONTYPE%
ECHO CHECK    SV : %HOSTCHECKIP%
ECHO SHABBY   IP : %SHABBY%
TIMEOUT 8 /NOBREAK
ECHO.
SET "NRUC=" && FOR /F "usebackq delims=" %%G IN (".\ff\Data\profile_normal\iMacros\Downloads\URLCURRENT.LOG") DO SET NRUC=%%G
SET "STUC=" && FOR /F "usebackq delims=" %%G IN (".\ff\Data\profile_piracy\iMacros\Downloads\URLCURRENT.LOG") DO SET STUC=%%G
SET "NRSS=" && FOR /F "usebackq delims=" %%H IN (".\ff\Data\profile_normal\iMacros\Downloads\SESSIONS.LOG") DO SET NRSS=%%H
SET "STSS=" && FOR /F "usebackq delims=" %%H IN (".\ff\Data\profile_piracy\iMacros\Downloads\SESSIONS.LOG") DO SET STSS=%%H
ECHO.
SET /A RESULTELOOT=%RESULTELOOT% + 1
ECHO.
IF %RESULTELOOT% EQU 10 GOTO CHECKINGFILESCHECKIP
IF %RESULTELOOT% EQU 20 GOTO CHECKINGFILESCHECKIP
IF %RESULTELOOT% EQU 30 GOTO CHECKINGFILESCHECKIP
IF %RESULTELOOT% EQU 40 GOTO CHECKINGFILESCHECKIP
IF %RESULTELOOT% EQU 50 GOTO CHECKINGFILESCHECKIP
IF %RESULTELOOT% EQU 60 GOTO CHECKINGFILESCHECKIP
IF %RESULTELOOT% EQU 70 GOTO CHECKINGFILESCHECKIP
IF %RESULTELOOT% EQU 80 GOTO CHECKINGFILESCHECKIP
IF %RESULTELOOT% EQU 90 GOTO CHECKINGFILESCHECKIP
FOR /F %%A IN ('DIR /A-D-S-H /B "%SYSTEMDRIVE%\Download\Jdownload" ^| FIND /V /C ""') DO SET CNT=%%A
IF %NRSS% NEQ "" (
	IF %NRSS% EQU "SESSIONS CLOSED" (
		CALL ".\nircmdc.exe" win min process "firefox.exe"
	)
)
IF %STSS% NEQ "" (
	IF %STSS% EQU "SESSIONS CLOSED" (
		REM CALL ".\nircmdc.exe" win min process "firefix.exe"
	)
)
IF /I NOT EXIST ".\ff\Data\profile_normal\iMacros\Downloads\CLOSED.LOG" GOTO CHECKINGFILESSTART
IF /I NOT EXIST ".\ff\Data\profile_piracy\iMacros\Downloads\CLOSED.LOG" GOTO CHECKINGFILESSTART
TIMEOUT 5 /NOBREAK
FOR %%A IN (%SYSTEMDRIVE%\Download\Jdownloader\*.zip) DO CALL :CHECKREAD "%%A"
GOTO %DISTANCE%
:CHECKINGFILESCHECKIP
CLS
ECHO CHECKING IP : %RESULTELOOT% [%RESTARTLOOT% - %RESULTELOOTCHECK%] [C:%COMPLETELOOT% M:%MISCARRYLOOT%]
ECHO NORMAL SESSIONS : %NRSS%
ECHO [%NRUC%]
ECHO PIRACY SESSIONS : %STSS%
ECHO [%STUC%]
ECHO FILE COUNT = %CNT%
ECHO STATIC   IP : %STATIC%
ECHO PIRACY   IP : %PIRACY%  [%IPLOGS%] 
ECHO SERVER   SV : %VPNON%
IF "%VPNON%" EQU "vpngate.net" ECHO NAME   OVPN : %VPNNAMEONTYPE% : %GETPROTOCAL% %GETIPCONFIG%:%GETPORTOVPN% [%PINGICPM%%PINGTCIP%%TIMEICPM%%TIMETCIP%%PROTOCAL% - %PINGICPMRESULT% %PINGTCIPRESULT% %TIMEICPMRESULT% %TIMETCIPRESULT%]
IF "%VPNON%" NEQ "vpngate.net" ECHO NAME   OVPN : %VPNNAMEONTYPE%
CALL :GETHOSCHKIP && ECHO CHECK    SV : %HOSTCHECKIP%
ECHO SHABBY   IP : %SHABBY%
TIMEOUT 04 /NOBREAK
IF %RESTARTLOOT% GEQ 3 GOTO MISCARRY
IF %RESULTELOOTCHECK% GEQ 6 SET /A RESULTELOOTCHECK=0 && GOTO MISCARRY
CURL.EXE -s -m 15 %HOSTCHECKIP% > PIRACY.LOG
FOR /F "tokens=1" %%B IN ('type .\PIRACY.LOG ^| findrepl ":" "."') DO SET PIRACY=%%B
FOR /F "tokens=1 DELIMS=" %%C IN (SHABBY.LOG) DO SET SHABBY=%%C
FOR %%B in (PIRACY.LOG) DO IF %%~zB==0 SET /A RESULTELOOTCHECK=%RESULTELOOTCHECK% + 1 && GOTO CHECKINGFILESCHECKIP
IF "%PIRACY%" EQU "" SET /A RESULTELOOTCHECK=%RESULTELOOTCHECK% + 1 && GOTO CHECKINGFILESCHECKIP
IF "%PIRACY%" EQU " " SET /A RESULTELOOTCHECK=%RESULTELOOTCHECK% + 1 && GOTO CHECKINGFILESCHECKIP
IF "%PIRACY%" EQU "ECHO is off." SET /A RESULTELOOTCHECK=%RESULTELOOTCHECK% + 1 && GOTO CHECKINGFILESCHECKIP
IF "%PIRACY%" EQU "ECHO is off. " SET /A RESULTELOOTCHECK=%RESULTELOOTCHECK% + 1 && GOTO CHECKINGFILESCHECKIP
IF "%PIRACY%" EQU "%STATIC%" PING -n 2 localhost && GOTO MISCARRY
IF "%PIRACY%" EQU "%STATIC% " PING -n 2 localhost && GOTO MISCARRY
IF "%PIRACY%" EQU "%SHABBY%" PING -n 2 localhost && GOTO MISCARRY
IF "%PIRACY%" EQU "%SHABBY% " PING -n 2 localhost && GOTO MISCARRY
SET /A RESULTELOOTCHECK=0
IF %RESULTELOOT% EQU 10 GOTO CHECKINGFILESRESUMED
IF %RESULTELOOT% EQU 20 GOTO CHECKINGFILESRESUMED
IF %RESULTELOOT% EQU 30 GOTO CHECKINGFILESRESETED
IF %RESULTELOOT% EQU 40 GOTO CHECKINGFILESRESUMED
IF %RESULTELOOT% EQU 50 GOTO CHECKINGFILESRESUMED
IF %RESULTELOOT% EQU 60 GOTO CHECKINGFILESRESETED
IF %RESULTELOOT% EQU 70 GOTO CHECKINGFILESRESUMED
IF %RESULTELOOT% EQU 80 GOTO CHECKINGFILESRESUMED
IF %RESULTELOOT% EQU 90 SET /A RESTARTLOOT=%RESTARTLOOT% + 1
IF %RESULTELOOT% EQU 90 SET /A RESULTELOOT=1 && GOTO CHECKINGFILESSTART
GOTO CHECKINGFILESCHECKIP
:CHECKINGFILESRESUMED
ECHO.
TASKLIST /v | findstr "JDownloader2.exe"
IF %ERRORLEVEL% EQU 1 GOTO CHECKINGFILESSTART
REM	CMD /C START .\vbs\JDRU.EXE
ECHO.
GOTO CHECKINGFILESSTART
:CHECKINGFILESRESETED
ECHO.
TASKLIST /v | findstr "JDownloader2.exe"
IF %ERRORLEVEL% EQU 1 GOTO CHECKINGFILESSTART
REM	CMD /C START .\vbs\JDRT.EXE
ECHO.
GOTO CHECKINGFILESSTART
:CHECKINGFILESREADDED
ECHO.
TASKLIST /v | findstr "JDownloader2.exe"
IF %ERRORLEVEL% EQU 1 GOTO CHECKINGFILESSTART
REM	java -jar ".\jd\JDownloader.jar" -H -co "%SYSTEMDRIVE%\Download\DLC\Tusfiles.net-%COMxX%.dlc"
ECHO.
GOTO CHECKINGFILESSTART
:CHECKINGFILESRESTART
ECHO.
TASKLIST /v | findstr "JDownloader2.exe"
IF %ERRORLEVEL% EQU 1 GOTO CHECKINGFILESSTART
REM	CMD /C START .\vbs\JDRT.EXE
ECHO.
GOTO CHECKINGFILESSTART

:COMPLETE
CLS
ECHO COMPLETE
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO STATIC   IP : %STATIC%
ECHO PIRACY   IP : %PIRACY%  [%IPLOGS%] 
ECHO SERVER   SV : %VPNON%
IF "%VPNON%" EQU "vpngate.net" ECHO NAME   OVPN : %VPNNAMEONTYPE% : %GETPROTOCAL% %GETIPCONFIG%:%GETPORTOVPN% [%PINGICPM%%PINGTCIP%%TIMEICPM%%TIMETCIP%%PROTOCAL% - %PINGICPMRESULT% %PINGTCIPRESULT% %TIMEICPMRESULT% %TIMETCIPRESULT%]
IF "%VPNON%" NEQ "vpngate.net" ECHO NAME   OVPN : %VPNNAMEONTYPE%
ECHO CHECK    SV : %HOSTCHECKIP%
ECHO SHABBY   IP : %SHABBY%
ECHO %PIRACY% >> SHABBY.LOG
SET hr=%time:~0,2%
IF "%hr:~0,1%" equ " " set hr=0%hr:~1,1%
SET FILELOGNAME=%date:~-2,2%%date:~-10,2%%date:~-7,2%_%hr%%time:~3,2%%time:~6,2%_%SERVERNAME%_%COMPUTERNAME%_[COMPLETE]_[%VPNON%-%PIRACY%]
ECHO CHECKINGFILES %RESULTELOOT% [%RESTARTLOOT%] [C:%COMPLETELOOT% M:%MISCARRYLOOT%] > "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO [%COMPUTERNAME%] [COMPLETE] %DATE% : %TIME% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO IP     : %PIRACY% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO SERVER : %VPNON% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO NAME   : %VPNNAMEONTYPE% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO NORMAL SESSIONS : %NRSS% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO PIRACY SESSIONS : %STSS% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO FILE COUNT = %CNT% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
type ".\jd\cfg\org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json" >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
type ".\addjdownload.log" >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ATTRIB "Z:\DATABASE\imacros\Datasources\*.csv" >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
nbtstat -a 192.168.%VMDGATEWAY%.1 >>  "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
type ".\GitHub\reCaptcha\audiowit.his" >> "Z:\GitHub\reCaptcha\audiowit.his" 
type ".\GitHub\reCaptcha\audiohoundify.his" >> "Z:\GitHub\reCaptcha\audiohoundify.his" 
FOR /F "usebackq" %%U IN ('".\ff\Data\profile_normal\adblockplus\elemhide.css"') DO SET ELEMHIDESIZECLIENTNR=%%~zU
FOR /F "usebackq" %%U IN ('".\ff\Data\profile_normal\adblockplus\patterns.ini"') DO SET PATTERNSSIZECLIENTNR=%%~zU
FOR /F "usebackq" %%U IN ('".\ff\Data\profile_piracy\adblockplus\elemhide.css"') DO SET ELEMHIDESIZECLIENTST=%%~zU
FOR /F "usebackq" %%U IN ('".\ff\Data\profile_piracy\adblockplus\patterns.ini"') DO SET PATTERNSSIZECLIENTST=%%~zU
FOR /F "usebackq" %%U IN ('"Z:\Database\ff\adblockplus\elemhide.css"') DO SET ELEMHIDESIZESERVER=%%~zU
FOR /F "usebackq" %%U IN ('"Z:\Database\ff\adblockplus\patterns.ini"') DO SET PATTERNSSIZESERVER=%%~zU
IF %ELEMHIDESIZESERVER% NEQ %ELEMHIDESIZECLIENTNR% COPY ".\ff\Data\profile_normal\adblockplus\elemhide.css" "Z:\Database\ff\adblockedge\%FILELOGNAME%_[profile_normal]_elemhide.css"
IF %PATTERNSSIZESERVER% NEQ %PATTERNSSIZECLIENTNR% COPY ".\ff\Data\profile_normal\adblockplus\patterns.ini" "Z:\Database\ff\adblockedge\%FILELOGNAME%_[profile_normal]_patterns.ini"
IF %ELEMHIDESIZESERVER% NEQ %ELEMHIDESIZECLIENTST% COPY ".\ff\Data\profile_piracy\adblockplus\elemhide.css" "Z:\Database\ff\adblockedge\%FILELOGNAME%_[profile_piracy]_elemhide.css"
IF %PATTERNSSIZESERVER% NEQ %PATTERNSSIZECLIENTST% COPY ".\ff\Data\profile_piracy\adblockplus\patterns.ini" "Z:\Database\ff\adblockedge\%FILELOGNAME%_[profile_piracy]_patterns.ini"
CMD /C START .\vbs\JDEX.EXE
:COMPLETETASKKILL
TASKKILL /F /IM "HSSCP.exe"
TASKKILL /F /IM "openvpntray.exe"
TASKKILL /F /IM "firefox.exe"
TASKKILL /F /IM "firefix.exe"
TASKKILL /F /IM "crashreporter.exe"
TASKKILL /F /IM "Jdownloader2.exe"
TASKKILL /F /IM "reCaptcha.exe"
TASKKILL /F /IM "AutoHotkey.exe"
TASKKILL /F /IM "py.exe"
TASKKILL /F /IM "python.exe"
SC STOP "hsswd"
SC STOP "hshld"
SC STOP "hsstrayservice"
DEL /Q ".\MODE.TXT"
DEL /Q ".\jd\cfg\*.zip"
DEL /Q ".\jd\cfg\*.broken"
COPY /Y ".\GitHub\reCaptcha\*.mp3" "Z:\GitHub\reCaptcha\History\"
DEL /Q ".\GitHub\reCaptcha\*.his"
DEL /Q ".\GitHub\reCaptcha\*.log"
DEL /Q ".\GitHub\reCaptcha\*.mp3"
DEL /Q ".\GitHub\reCaptcha\*.wav"
DEL /Q ".\GitHub\reCaptcha\splitAudio\*.mp3"
DEL /Q ".\GitHub\reCaptcha\splitAudio\*.wav"
DEL /Q "Z:\GitHub\reCaptcha\*.mp3"
DEL /Q "Z:\GitHub\reCaptcha\*.wav"
DEL /Q "Z:\GitHub\reCaptcha\splitAudio\*.mp3"
DEL /Q "Z:\GitHub\reCaptcha\splitAudio\*.wav"
REM	CHECK "piracy.exe" PROCESS TASKLIST /v | findstr "piracy.exe"
REM	CHECK "piracy.exe" PROCESS IF %ERRORLEVEL% EQU 0 TASKKILL /FI "WINDOWTITLE eq piracy.exe"
TASKLIST /v | findstr "addjdownload.exe"
IF %ERRORLEVEL% EQU 0 TASKKILL /FI "WINDOWTITLE eq addjdownload.exe"
TIMEOUT 2 /NOBREAK > NUL
GOTO COMPLETESTANBY
:COMPLETESTANBY
SET SHABBY=%PIRACY%
SET /A COMPLETELOOT=%COMPLETELOOT% + 1
IF %COMPLETELOOT% GEQ 6 GOTO CLOSE
CMD /C START /WAIT /MAX "GENERATE COMPUTER NAME" /D "%CD%" /I ".\computername.exe" GENDEV
TIMEOUT 5 /NOBREAK
GOTO RELOAD

:MISCARRY
CLS
ECHO MISCARRY
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO STATIC   IP : %STATIC%
ECHO PIRACY   IP : %PIRACY%  [%IPLOGS%] 
ECHO SERVER   SV : %VPNON%
IF "%VPNON%" EQU "vpngate.net" ECHO NAME   OVPN : %VPNNAMEONTYPE% : %GETPROTOCAL% %GETIPCONFIG%:%GETPORTOVPN% [%PINGICPM%%PINGTCIP%%TIMEICPM%%TIMETCIP%%PROTOCAL% - %PINGICPMRESULT% %PINGTCIPRESULT% %TIMEICPMRESULT% %TIMETCIPRESULT%]
IF "%VPNON%" NEQ "vpngate.net" ECHO NAME   OVPN : %VPNNAMEONTYPE%
ECHO CHECK    SV : %HOSTCHECKIP%
ECHO SHABBY   IP : %SHABBY%
ECHO %PIRACY% >> SHABBY.LOG
SET hr=%time:~0,2%
IF "%hr:~0,1%" equ " " set hr=0%hr:~1,1%
SET FILELOGNAME=%date:~-2,2%%date:~-10,2%%date:~-7,2%_%hr%%time:~3,2%%time:~6,2%_%SERVERNAME%_%COMPUTERNAME%_[MISCARRY]_[%VPNON%-%PIRACY%]
ECHO CHECKINGFILES %RESULTELOOT% [%RESTARTLOOT%] [C:%COMPLETELOOT% M:%MISCARRYLOOT%] > "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO [%COMPUTERNAME%] [MISCARRY] %DATE% : %TIME% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO IP     : %PIRACY% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO SERVER : %VPNON% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO NAME   : %VPNNAMEONTYPE% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO NORMAL SESSIONS : %NRSS% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO PIRACY SESSIONS : %STSS% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ECHO FILE COUNT = %CNT% >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
type ".\jd\cfg\org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json" >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
type ".\addjdownload.log" >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
ATTRIB "Z:\DATABASE\imacros\Datasources\*.csv" >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
nbtstat -a 192.168.%VMDGATEWAY%.1 >>  "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
type ".\GitHub\reCaptcha\audiowit.his" >> "Z:\GitHub\reCaptcha\audiowit.his" 
type ".\GitHub\reCaptcha\audiohoundify.his" >> "Z:\GitHub\reCaptcha\audiohoundify.his" 
FOR /F "usebackq" %%U IN ('".\ff\Data\profile_normal\adblockplus\elemhide.css"') DO SET ELEMHIDESIZECLIENTNR=%%~zU
FOR /F "usebackq" %%U IN ('".\ff\Data\profile_normal\adblockplus\patterns.ini"') DO SET PATTERNSSIZECLIENTNR=%%~zU
FOR /F "usebackq" %%U IN ('".\ff\Data\profile_piracy\adblockplus\elemhide.css"') DO SET ELEMHIDESIZECLIENTST=%%~zU
FOR /F "usebackq" %%U IN ('".\ff\Data\profile_piracy\adblockplus\patterns.ini"') DO SET PATTERNSSIZECLIENTST=%%~zU
FOR /F "usebackq" %%U IN ('"Z:\Database\ff\adblockplus\elemhide.css"') DO SET ELEMHIDESIZESERVER=%%~zU
FOR /F "usebackq" %%U IN ('"Z:\Database\ff\adblockplus\patterns.ini"') DO SET PATTERNSSIZESERVER=%%~zU
IF %ELEMHIDESIZESERVER% NEQ %ELEMHIDESIZECLIENTNR% COPY ".\ff\Data\profile_normal\adblockplus\elemhide.css" "Z:\Database\ff\adblockedge\%FILELOGNAME%_[profile_normal]_elemhide.css"
IF %PATTERNSSIZESERVER% NEQ %PATTERNSSIZECLIENTNR% COPY ".\ff\Data\profile_normal\adblockplus\patterns.ini" "Z:\Database\ff\adblockedge\%FILELOGNAME%_[profile_normal]_patterns.ini"
IF %ELEMHIDESIZESERVER% NEQ %ELEMHIDESIZECLIENTST% COPY ".\ff\Data\profile_piracy\adblockplus\elemhide.css" "Z:\Database\ff\adblockedge\%FILELOGNAME%_[profile_piracy]_elemhide.css"
IF %PATTERNSSIZESERVER% NEQ %PATTERNSSIZECLIENTST% COPY ".\ff\Data\profile_piracy\adblockplus\patterns.ini" "Z:\Database\ff\adblockedge\%FILELOGNAME%_[profile_piracy]_patterns.ini"
CMD /C START .\vbs\JDEX.EXE
:MISCARRYTASKKILL
TASKKILL /F /IM "HSSCP.exe"
TASKKILL /F /IM "openvpntray.exe"
TASKKILL /F /IM "firefox.exe"
TASKKILL /F /IM "firefix.exe"
TASKKILL /F /IM "crashreporter.exe"
TASKKILL /F /IM "Jdownloader2.exe"
TASKKILL /F /IM "reCaptcha.exe"
TASKKILL /F /IM "AutoHotkey.exe"
TASKKILL /F /IM "py.exe"
TASKKILL /F /IM "python.exe"
SC STOP "hsswd"
SC STOP "hshld"
SC STOP "hsstrayservice"
DEL /Q ".\MODE.TXT"
DEL /Q ".\jd\cfg\*.zip"
DEL /Q ".\jd\cfg\*.broken"
COPY /Y ".\GitHub\reCaptcha\*.mp3" "Z:\GitHub\reCaptcha\History\"
DEL /Q ".\GitHub\reCaptcha\*.his"
DEL /Q ".\GitHub\reCaptcha\*.log"
DEL /Q ".\GitHub\reCaptcha\*.mp3"
DEL /Q ".\GitHub\reCaptcha\*.wav"
DEL /Q ".\GitHub\reCaptcha\splitAudio\*.mp3"
DEL /Q ".\GitHub\reCaptcha\splitAudio\*.wav"
DEL /Q "Z:\GitHub\reCaptcha\*.mp3"
DEL /Q "Z:\GitHub\reCaptcha\*.wav"
DEL /Q "Z:\GitHub\reCaptcha\splitAudio\*.mp3"
DEL /Q "Z:\GitHub\reCaptcha\splitAudio\*.wav"
REM	CHECK "piracy.exe" PROCESS TASKLIST /v | findstr "piracy.exe"
REM	CHECK "piracy.exe" PROCESS IF %ERRORLEVEL% EQU 0 TASKKILL /FI "WINDOWTITLE eq piracy.exe"
TASKLIST /v | findstr "addjdownload.exe"
IF %ERRORLEVEL% EQU 0 TASKKILL /FI "WINDOWTITLE eq addjdownload.exe"
TIMEOUT 2 /NOBREAK > NUL
GOTO MISCARRYSTANBY
:MISCARRYSTANBY
SET SHABBY=%PIRACY%
SET /A MISCARRYLOOT=%MISCARRYLOOT% + 1
IF %MISCARRYLOOT% GEQ 2 GOTO CLOSE
CMD /C START /WAIT /MAX "GENERATE COMPUTER NAME" /D "%CD%" /I ".\computername.exe" GENDEV
TIMEOUT 5 /NOBREAK
GOTO RELOAD


:CLOSE
CMD /C START /WAIT /MAX "GENERATE COMPUTER NAME" /D "%CD%" /I ".\computername.exe" GENALL
IF "%SERVERNAME%" EQU "BOYSKYLAKE-PC" type "Z:\DATABASE\imacros\Datasources\*.csv" >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
REM IF "%SERVERNAME%" EQU "DESKTOP-P4OPQ2L" type "Z:\DATABASE\imacros\Datasources\*.csv" >> "Z:\Sync\IPLOGS\%FILELOGNAME%.LOG"
EXIT

















:CHECKREAD
SET /A LOOPCOU=0
SET /A MAXLOOP=300
SET "FILENAME=%~1"
:CHECKLOOP
2>NUL (CALL;>>"%FILENAME%") && (
	ECHO "%FILENAME%" IS FREE!
	GOTO :LAMESTROK
) || (
	ECHO "%FILENAME%" IS USING
	SET /A LOOPCOU=%LOOPCOU%+1
	IF %LOOPCOU% GEQ %MAXLOOP% GOTO LAMECLEAR
)
TIMEOUT 1 /NOBREAK > NUL
GOTO :CHECKLOOP
:LAMESTROK
	DEL "%~1" > NUL
	SET "DISTANCE=COMPLETE" && GOTO:EOF
:LAMECLEAR
	DEL /Q "%SYSTEMDRIVE%\Download\Jdownloader\*.zip" > NUL
	SET "DISTANCE=MISCARRY" && GOTO:EOF

:GETIPCONFIG
SET "FILENAME=%~1"
FOR /F "tokens=2 skip=%IPCONFIG% delims= " %%F in ('type "%FILENAME%"') DO (
	SET GETIPCONFIG=%%F
	GOTO:EOF
)
:GETPORTOVPN
SET "FILENAME=%~1"
FOR /F "tokens=3 skip=%PORTOVPN% delims= " %%F in ('type "%FILENAME%"') DO (
	SET GETPORTOVPN=%%F
	GOTO:EOF
)
:GETPROTOCAL
SET "FILENAME=%~1"
FOR /F "tokens=2 skip=%PROTOCOL% delims= " %%F in ('type "%FILENAME%"') DO (
	SET GETPROTOCAL=%%F
	GOTO:EOF
)
:GETHOSCHKIP
SET /A HOSTCHECKIPLOOP=%RANDOM% %%7 +1
IF "%HOSTCHECKIPLOOP%" EQU "1" SET "HOSTCHECKIP=ident.me"
IF "%HOSTCHECKIPLOOP%" EQU "2" SET "HOSTCHECKIP=myip.dnsomatic.com"
IF "%HOSTCHECKIPLOOP%" EQU "3" SET "HOSTCHECKIP=icanhazip.com"
IF "%HOSTCHECKIPLOOP%" EQU "4" SET "HOSTCHECKIP=myexternalip.com/raw"
IF "%HOSTCHECKIPLOOP%" EQU "5" SET "HOSTCHECKIP=ifconfig.co/ip"
IF "%HOSTCHECKIPLOOP%" EQU "6" SET "HOSTCHECKIP=bot.whatismyipaddress.com"
IF "%HOSTCHECKIPLOOP%" EQU "7" SET "HOSTCHECKIP=myip.dnsomatic.com"
GOTO:EOF
:vpngate.net
SET "UNWANT=%~1"
ECHO %UNWANT% | FIND "\.ovpn" && (
	ECHO NO && DEL /Q "%~1"
)
ECHO %UNWANT% | FIND "(1).ovpn" && (
	ECHO NO && DEL /Q "%~1"
)
ECHO %UNWANT% | FIND "(2).ovpn" && (
	ECHO NO && DEL /Q "%~1"
)
ECHO %UNWANT% | FIND "(3).ovpn" && (
	ECHO NO && DEL /Q "%~1"
)
ECHO %UNWANT% | FIND "[Conflict].ovpn" && (
	ECHO NO && DEL /Q "%~1"
)
GOTO:EOF
:purevpn.com
FOR /F %%H IN ('type "Z:\OPENVPN\purevpn.com.get\key\purevpn.com.hex" ^| FIND /C "/"') DO SET /A HEXGEN=(%RANDOM%*%%H/32768) + 1
FOR /F "tokens=1-2 skip=%HEXGEN% delims=/" %%A in ('type "Z:\OPENVPN\purevpn.com.get\key\purevpn.com.hex"') DO (
	SET KEYUSE=%%A
	SET KEYPAS=%%B
	GOTO:EOF
)
:nordvpn.com
FOR /F %%H IN ('type "Z:\OPENVPN\nordvpn.com.get\key\nordvpn.com.hex" ^| FIND /C "/"') DO SET /A HEXGEN=(%RANDOM%*%%H/32768) + 1
FOR /F "tokens=1-2 skip=%HEXGEN% delims=/" %%A in ('type "Z:\OPENVPN\nordvpn.com.get\key\nordvpn.com.hex"') DO (
	SET KEYUSE=%%A
	SET KEYPAS=%%B
	GOTO:EOF
)
:safervpn.com
FOR /F %%H IN ('type "Z:\OPENVPN\safervpn.com\key\safervpn.com.hex" ^| FIND /C "/"') DO SET /A HEXGEN=(%RANDOM%*%%H/32768) + 1
FOR /F "tokens=1-2 skip=%HEXGEN% delims=/" %%A in ('type "Z:\OPENVPN\safervpn.com\key\safervpn.com.hex"') DO (
	SET KEYUSE=%%A
	SET KEYPAS=%%B
	GOTO:EOF
)
:MODELOG
IF "%SERVERNAME%" EQU "CNR-BATCHER-PC" (
	IF "%COMxX%" EQU "COMx01" SET /A MODELOG=2 && REM TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx02" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx03" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx04" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx05" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx06" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx07" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx08" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX01" SET /A MODELOG=2 && REM TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX02" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX03" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX04" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX05" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX06" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX07" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX08" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
)
IF "%SERVERNAME%" NEQ "CNR-BATCHER-PC" (
	IF "%COMxX%" EQU "COMx01" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx02" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx03" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx04" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx05" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx06" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx07" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMx08" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX01" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX02" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX03" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX04" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX05" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX06" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX07" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
	IF "%COMxX%" EQU "COMX08" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
)
IF "%MODELOG%" EQU "" SET /A MODELOG=2 && TASKKILL /F /IM "explorer.exe"
GOTO:EOF
:IPLOGSCHECK
SET /A IPLOGSCHECK+=1
IF %IPLOGSCHECK% LEQ 500 (
	CLS
	ECHO %~1
	GOTO:EOF
) ELSE (
	ECHO "Z:\Sync\IPLOGS\%~1"
	ECHO a| move "Z:\Sync\IPLOGS\%~1" "Z:\Sync\IPLOGS\HISTORY"
	GOTO:EOF
)

:: @       echo off
:: 
:: 
:: rem     +====================================================================
:: rem     | This package needs the new CMD.EXE extensions to be loaded and
:: rem     | will refuse to run, if they can not be enabled.
:: rem     +====================================================================
:: 
::         verify other 2>NUL
::         setLocal enableExtensions
::         if errorLevel 1 (
::             echo.
::             echo *ERROR*
::             echo.
::             echo Sorry - this program requires that extensions to CMD.EXE are
::             echo enabled.  Please consult your manual for instruction on how
::             echo to proceed.
:: 
::             goto :EOF
::         )
:: 
::         set delcount=0
:: 
:: rem     Use the DIR command to get a simple listing of file names sorted by date.
:: rem     The file Timestamp.log marks the time when this script was last run.
:: rem     Assuming that this was at least 24 hours ago, any files that is sorted
:: rem     *before* the timestamp is safe to delete.  When the timestamp file is
:: rem     encountered, we are done.
:: 
::         for /f "delims=" %%f in ('dir /b /o:d') do (
:: 
::             if /i "%%f" == "Timestamp.log" goto :done
::             if /i "%%~xf" == ".PDF" call :delete "%%f"
::         )
:: :done
:: 
:: rem     Update the Timestamp.log file.  The update 'moves' the log file
:: rem     ahead in the list of files sorted by date.  Any PDF file modified
:: rem     after the new timestamp will thus not be deleted the next the
:: rem     del_marked script is run.
:: 
::         echo %date% %time% - deleted %delcount% files >> "Timestamp.log"
::         echo %date% %time% - deleted %delcount% files
::         goto :EOF
:: 
:: :delete
::         set /a delcount=delcount + 1
::         del "%~1"
::         goto :EOF
:: 
:: --

REM DEL /Q "%USERPROFILE%\Start Menu\Programs\Startup\*.lnk"
REM FOR /F "delims= skip=%VPNOF%" %%F in (VPN.LST) DO (

:: IF "%SERVERNAME%" EQU "CNR-BATCHER-PC" (
:: 	SET /A IPLOGSCHECK=0
:: 	FOR /F "DELIMS=" %%F IN ('DIR /A-D-S-H /B "Z:\Sync\IPLOGS"') DO (
:: 		FORFILES -p Z:\Sync\IPLOGS -m *.LOG -d -1 -c "cmd /c ECHO a| move @file "Z:\Sync\IPLOGS\HISTORY"
:: 		IF /I "%%~xF" == ".LOG" CALL :IPLOGSCHECK "%%F"
:: 	)
:: 	SET /A IPLOGSCHECK=0
:: )
:: IF "%SERVERNAME%" EQU "CNR-BATCHER-PC" FORFILES -p Z:\Sync\IPLOGS -m *.LOG -d -1 -c "cmd /c ECHO a| move @file "Z:\Sync\IPLOGS\HISTORY"