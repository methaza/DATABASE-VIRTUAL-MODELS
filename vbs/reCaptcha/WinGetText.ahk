
;	F8::	
;	WinGetTitle, ErrorTitle, ahk_class MozillaWindowClass ahk_exe firefox.exe
;	If InStr(ErrorTitle, "Problem loading page")
;		{
;			MsgBox, The text is:`n%ErrorTitle%
;		}

ControlFocus, , ahk_class MozillaWindowClass ahk_exe firefox.exe
F8::
ImageSearch, GoogleConnectionAlertX, GoogleConnectionAlertY, 0, 0, 800, 600, %A_ScriptDir%\Screenshots\Continue.png
If ErrorLevel = 0
{
	MsgBox, The text is:`n1
}
Else
{
	MsgBox, The text is:`n2
}