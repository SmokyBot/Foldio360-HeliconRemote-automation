#include "_ImageSearch_UDF.au3"
#include "_ImageSearch_Tool.au3"
#RequireAdmin

HotKeySet("{Esc}", "_Exit") ; Press ESC for exit
Func _Exit()
    Exit 0
EndFunc   ;==>_Exit

Global Const $Ask_On_Found = 0
Global Const $Mouse_Move_On_Found = 1
Global Const $Mouse_Click_On_Found = 0

Global Const $iSleep_Time=500

Global $sCount = 0, $_Image_1 = @ScriptDir & "\example.bmp"

; First, use this function to create a file bmp, maybe a desktop icon for example')
MsgBox(64 + 262144, 'ImageSearch', 'At first, create a file bmp,' & @CRLF & 'photos that will search on the screen!')
_ImageSearch_Create_BMP($_Image_1)
