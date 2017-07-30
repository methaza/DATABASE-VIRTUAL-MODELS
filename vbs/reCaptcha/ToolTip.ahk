f9::
font := CreateFont("bold s10", "Matisse ITC")
Tooltip, Wow! A monster tooltip!
WinWait ahk_class tooltips_class32
SetFont("", WinExist(), font)
return

f8::
Tooltip, Wow! A monster tooltip!

CreateFont(options="", font="") {
Loop 99 {
    g = %a_index%
    Gui %g%: +LastfoundExist
    If ! WinExist()
      break
  }
Gui, %g%: +Lastfound
Gui, %g%: Font, %options%, %font%
Gui, Add, Button
SendMessage, 0x31, 0, 0, Button1  ;WM_GETFONT
Gui, %g%: Destroy
return errorLevel
}

SetFont(ctrl, win, font=0) {
SendMessage, 0x30, %font%, 1, %ctrl%, ahk_id%win% 
return errorLevel
}
