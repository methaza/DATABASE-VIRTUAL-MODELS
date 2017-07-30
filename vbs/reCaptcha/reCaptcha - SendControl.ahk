F6::
KeysDelay := 100
PresDelay := 100
SetKeyDelay %KeysDelay%,%PresDelay%

;ControlSend,, {LControl Down}{+}{LControl Up}, ahk_class MozillaWindowClass ahk_exe firefox.exe


ControlSend,, %CLIPBOARD%, ahk_class MozillaWindowClass ahk_exe firefox.exe