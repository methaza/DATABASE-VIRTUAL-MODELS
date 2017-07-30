

F8::
COUNTROUND := 0
reCaptchaFind:
Loop
	{	
	WinGetTitle, CheckTitleCur, ahk_class MozillaWindowClass ahk_exe firefox.exe		
	If not (instr(CheckTitleCur, "About About - Mozilla Firefox") and instr(CheckTitleCur, "Mozilla Firefox"))
	{
		If instr(CheckTitleCur, CheckTitleNew)
		{
			COUNTROUND := COUNTROUND+1
			MsgBox, The text is:`n%CheckTitleCur%
			MsgBox, COUNTROUND:`n%COUNTROUND%
			MsgBox, 1
			CheckTitleNew := CheckTitleCur
			MsgBox, CheckTitleNew:`n%CheckTitleNew%
			continue reCaptchaFind
		}
		Else
		{
			COUNTROUND := 0
			MsgBox, The text is:`n%CheckTitleCur%
			MsgBox, COUNTROUND:`n%COUNTROUND%
			MsgBox, 2
			CheckTitleNew := CheckTitleCur
			MsgBox, CheckTitleNew:`n%CheckTitleNew%
			continue reCaptchaFind
		}		
	}
	Else
	{
		COUNTROUND := 0	
		MsgBox, The text is:`n%CheckTitleCur%
		MsgBox, COUNTROUND:`n%COUNTROUND%
		MsgBox, 3
		continue reCaptchaFind
	}
}




;	If %CheckTitleCur% is not "About About - Mozilla Firefox" or "Mozilla Firefox"