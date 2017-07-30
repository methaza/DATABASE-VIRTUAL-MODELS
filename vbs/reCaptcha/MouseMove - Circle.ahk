#Include MouseMove_Ellipse.ahk

F8::
	random, circle, 50, 100
	MouseMove_Ellipse( -50 , +50 , "S0.25 I1 R" )
	random, circle, 50, 100
	MouseMove_Ellipse( +50 , +50 , "S0.25 I1 R" )
	random, circle, 50, 100
	MouseMove_Ellipse( +50 , -50 , "S0.25 I1 R" )
	random, circle, 50, 100
	MouseMove_Ellipse( -50 , -50 , "S0.25 I1 R" )