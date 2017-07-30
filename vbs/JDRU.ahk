WinGet,WinState,MinMax, ahk_class SunAwtFrame
If WinState = -1
{
	WinActivate, ahk_class SunAwtFrame
	Sleep 200
}
;	else
;	{
	ControlFocus, , ahk_class SunAwtFrame
	;	Click, 20, 90, 0
	;	ControlClick, , ahk_class SunAwtFrame,, X1, , Down x20 y90 NA
	Click, 490, 140, 1
	ControlClick, , ahk_class SunAwtFrame,, X1, , Down x490 y140 NA
	Sleep 100
	ControlSend, , {Control Down}, ahk_class SunAwtFrame
	ControlSend, , {a}, ahk_class SunAwtFrame
	ControlSend, , {Control Up}, ahk_class SunAwtFrame
	Sleep 200
	ControlSend, , {F11}, ahk_class SunAwtFrame
	Sleep 100
	ControlSend, , {F9}, ahk_class SunAwtFrame
	Sleep 100
	WinGet,WinState,MinMax, ahk_class SunAwtFrame
		If WinState != -1
		{
			WinMinimize, ahk_class SunAwtFrame
		}
;	}