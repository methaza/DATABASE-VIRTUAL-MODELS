F6::
KeysDelay := 60
PresDelay := 60
If clipboard =
{
	SetKeyDelay %KeysDelay%,%PresDelay%
	return
}
Else
{
	MsgBox Clipboard is : %clipboard%
	SetKeyDelay %KeysDelay%,%PresDelay%
	Send %clipboard%
	Sleep 2000
	Clipboard :=
	return
}