;	F8::
;	ControlSend,, {LControl Down}{+ Down}, ahk_class MozillaWindowClass ahk_exe firefox.exe
;	Sleep 400
;	ControlSend,, {LControl Up}{+ Up}, ahk_class MozillaWindowClass ahk_exe firefox.exe

WinActivate, ahk_class MozillaWindowClass ahk_exe firefox.exe
ControlFocus, , ahk_class MozillaWindowClass ahk_exe firefox.exe
CoordMode, Pixel, Relative
TABNUMLOCK := 0
TABNUMLOCK := %TABNUMLOCK%+1

F8::
;	ControlSend,, {ENTER}, ahk_class MozillaDialogClass ahk_exe firefox.exe

ControlSend,, {LControl Down}{%TABNUMLOCK%}{LControl Up}, ahk_class MozillaWindowClass ahk_exe firefox.exe