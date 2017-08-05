@ECHO OFF

TITLE computername.bat

IF "%1"=="GENRCN" SET SWITCH=GENRCN
IF "%1"=="GENMAC" SET SWITCH=GENMAC
IF "%1"=="GENTAP" SET SWITCH=GENTAP
IF "%1"=="GENDEV" SET SWITCH=GENDEV
IF "%1"=="GENALL" SET SWITCH=GENALL
IF "%1"=="GENRET" SET SWITCH=GENRET

Setlocal EnableDelayedExpansion
Set _RNDLength=8
Set _Alphanumeric=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
Set _Str=%_Alphanumeric%987654321
SET /A HEADER=%RANDOM% %%10 +1
:_LenLoop
IF NOT "%_Str:~18%"=="" SET _Str=%_Str:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%_Str:~9,1%
SET /A _Len=_Len+_tmp
Set _count=0
SET _RndAlphaNum=
:_loop
Set /a _count+=1
SET _RND=%Random%
Set /A _RND=_RND%%%_Len%
SET _RndAlphaNum=!_RndAlphaNum!!_Alphanumeric:~%_RND%,1!
If !_count! lss %_RNDLength% goto _loop
:CHECKCOMLIST
IF "%COMPUTERNAME%" EQU "VMWARE-PC" (
	DIR /B "Z:\" | FIND "COM" >NUL 2>NUL && (
		FOR /F "tokens=*" %%N IN ('DIR /B "Z:\" ^| FIND "COM"') DO SET "COMxX=%%N"
	) || (	
		FOR /F "tokens=1 DELIMS=-" %%N IN ('ECHO %COMPUTERNAME%') DO SET "COMxX=%%N"
	)
	SET SWITCH=GENSET	
)
IF "%COMPUTERNAME%" NEQ "VMWARE-PC" (
	DIR /B "Z:\" | FIND "COM" >NUL 2>NUL && (
		FOR /F "tokens=*" %%N IN ('DIR /B "Z:\" ^| FIND "COM"') DO SET "COMxX=%%N"
	) || (	
		FOR /F "tokens=1 DELIMS=-" %%N IN ('ECHO %COMPUTERNAME%') DO SET "COMxX=%%N"
	)
	SET SWITCH=%SWITCH%
)
GOTO %SWITCH%



:GENRCN
WMIC computersystem where caption='%COMPUTERNAME%' rename "%COMxX%-!_RndAlphaNum!"
cleanmgr /D /sagerun:1
CMD /K SHUTDOWN /R /F -T 10
EXIT
:GENMAC
"..\TMAC\tmac.exe" -n "Vmware" -r -re -s
cleanmgr /D /sagerun:1
CMD /K SHUTDOWN /l /f
EXIT
:GENRET
REM #############
REM |_|REFRESH|_|
REM #############
START /WAIT /MAX "" netsh interface set interface "Vmware" Disabled
TIMEOUT 05 /NOBREAK
START /WAIT /MAX "" netsh interface set interface "Vmware" Enabled
START /WAIT /MAX "" ipconfig /release
START /WAIT /MAX "" ipconfig /flushdns
START /WAIT /MAX "" ipconfig /renew
REM #############
REM |_|REFRESH|_|
REM #############
:: powershell.exe -noprofile -executionpolicy bypass -file Z:\Database\computername.ps1 "%COMxX%-!_RndAlphaNum!"
:: "..\TAP-Windows\bin\devcon.exe" remove tap0901
:: "..\HxVPN\data\driver\hss32\tapinstall.exe" remove taphss
:: "..\TAP-Windows\bin\devcon.exe" install "..\TAP-Windows\driver\OemWin2k.inf" tap0901
:: "..\HxVPN\data\driver\hss32\tapinstall.exe" install "..\HxVPN\data\driver\hss32\OemWin2k.inf" taphss
:: cleanmgr /D /sagerun:1
:: CMD /K SHUTDOWN /l /f
EXIT
:GENTAP
REM #############
REM |_|REFRESH|_|
REM #############
START /WAIT /MAX "" netsh interface set interface "Vmware" Disabled
TIMEOUT 05 /NOBREAK
START /WAIT /MAX "" netsh interface set interface "Vmware" Enabled
START /WAIT /MAX "" ipconfig /release
START /WAIT /MAX "" ipconfig /flushdns
START /WAIT /MAX "" ipconfig /renew
REM #############
REM |_|REFRESH|_|
REM #############
powershell.exe -noprofile -executionpolicy bypass -file Z:\Database\computername.ps1 "%COMxX%-!_RndAlphaNum!"
"..\TMAC\tmac.exe" -n "Vmware" -r -re -s
"..\TAP-Windows\bin\devcon.exe" remove tap0901
"..\HxVPN\data\driver\hss32\tapinstall.exe" remove taphss
"..\TAP-Windows\bin\devcon.exe" install "..\TAP-Windows\driver\OemWin2k.inf" tap0901
"..\HxVPN\data\driver\hss32\tapinstall.exe" install "..\HxVPN\data\driver\hss32\OemWin2k.inf" taphss
:: cleanmgr /D /sagerun:1
:: CMD /K SHUTDOWN /l /f
EXIT
:GENDEV
powershell.exe -noprofile -executionpolicy bypass -file Z:\Database\computername.ps1 "%COMxX%-!_RndAlphaNum!"
:: WMIC computersystem where caption='%COMPUTERNAME%' rename "%COMxX%-!_RndAlphaNum!"
"..\TMAC\tmac.exe" -n "Vmware" -r -re -s
"..\TAP-Windows\bin\devcon.exe" remove tap0901
"..\HxVPN\data\driver\hss32\tapinstall.exe" remove taphss
"..\TAP-Windows\bin\devcon.exe" install "..\TAP-Windows\driver\OemWin2k.inf" tap0901
"..\HxVPN\data\driver\hss32\tapinstall.exe" install "..\HxVPN\data\driver\hss32\OemWin2k.inf" taphss
:: cleanmgr /D /sagerun:1
:: CMD /K SHUTDOWN /l /f
EXIT
:GENALL
:: powershell.exe -noprofile -executionpolicy bypass -file Z:\Database\computername.ps1 "%COMxX%-!_RndAlphaNum!"
:: WMIC computersystem where caption='%COMPUTERNAME%' rename "%COMxX%-!_RndAlphaNum!"
:: "..\TMAC\tmac.exe" -n "Vmware" -r -re -s
:: "..\TAP-Windows\bin\devcon.exe" remove tap0901
:: "..\HxVPN\data\driver\hss32\tapinstall.exe" remove taphss
:: "..\TAP-Windows\bin\devcon.exe" install "..\TAP-Windows\driver\OemWin2k.inf" tap0901
:: "..\HxVPN\data\driver\hss32\tapinstall.exe" install "..\HxVPN\data\driver\hss32\OemWin2k.inf" taphss
:: cleanmgr /D /sagerun:1
CMD /K SHUTDOWN /l /f
EXIT
:GENSET
powershell.exe -noprofile -executionpolicy bypass -file Z:\Database\computername.ps1 "%COMxX%-!_RndAlphaNum!"
:: WMIC computersystem where caption='%COMPUTERNAME%' rename "%COMxX%-!_RndAlphaNum!"
"..\TMAC\tmac.exe" -n "Vmware" -r -re -s
"..\TAP-Windows\bin\devcon.exe" remove tap0901
"..\HxVPN\data\driver\hss32\tapinstall.exe" remove taphss
"..\TAP-Windows\bin\devcon.exe" install "..\TAP-Windows\driver\OemWin2k.inf" tap0901
"..\HxVPN\data\driver\hss32\tapinstall.exe" install "..\HxVPN\data\driver\hss32\OemWin2k.inf" taphss
:: cleanmgr /D /sagerun:1
CMD /K SHUTDOWN /r /f
EXIT


ipconfig /release
ipconfig /flushdns
ipconfig /renew