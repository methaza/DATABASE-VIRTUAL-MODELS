
CheckTitleChk := "[RC] DETECTED [1]"
F8::	
	NewVar := RegExReplace(CheckTitleChk, "\D")
	MsgBox, The text is : %NewVar%