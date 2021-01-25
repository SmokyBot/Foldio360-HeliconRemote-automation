#include <MsgBoxConstants.au3>
#include "_ImageSearch_UDF.au3"
#include <COLOR.AU3>

DllCall("User32.dll","bool","SetProcessDPIAware")
consolewrite(@DeskTopHeight & @CRLF)
consolewrite(@DesktopWidth & @CRLF)

;Match window names by CONTAINS
Opt("WinTitleMatchMode", 2)

Const $ITERATIONS = 23
Const $HELICON_WINDOW = "Helicon Remote (ver. 3.9.11 W)"
Const $ANYDESK_WINDOW = "444723403 - AnyDesk"
Const $FOLDIO360_MOVE_RIGHT_BTN_IMG = "turn-right-active.bmp"
Const $HELICON_TAKE_PICTURES_BTN_IMG = "helicon-start-active.bmp"


;We remember the coordinates of the FOLDIO360 move button because the detection is slow for some reaseon
;Global $foldioX, $foldioY
Global $foldioX = 1058
Global $foldioY = 364
Global $heliconX = 558
Global $heliconY = 109

For $i = 0 To $ITERATIONS
	ActivateAnyDesk()
	TurnTable()
	ActivateHelicon()
	;TakePictures()
	TakePicturesBasedOnCoords()
Next

Func ActivateAnyDesk()
	; Test if the window is activated and display the results.
	If Not WinActivate($ANYDESK_WINDOW) Then
		MsgBox($MB_SYSTEMMODAL, "", "Could not activate AnyDesk, please connect to your phone :)", 5)
	EndIf
EndFunc   ;==>ActivateAnyDesk

Func ActivateHelicon()
	If Not WinActivate($HELICON_WINDOW) Then
		MsgBox($MB_SYSTEMMODAL, "", "Could not activate Helicon Remote, please start the program and connect camera :)", 5)
	EndIf
EndFunc   ;==>ActivateHelicon


Func TurnTable()
	If ($foldioX And $foldioY) Then
		TurnTableBasedOnCoords()
		Return
	EndIf
	Local $result = _ImageSearch($FOLDIO360_MOVE_RIGHT_BTN_IMG)
	;Local $result = _ImageSearch_Area($FOLDIO360_MOVE_RIGHT_BTN_IMG, 0, 0, 1920, 1080, 0, True)
	If ($result[0]) Then
		$foldioX = $result[1]
		$foldioY = $result[2]
		ConsoleWrite("Initialized foldio with params: X = " & $foldioX & ", Y = " & $foldioY & @CRLF)
		TurnTableBasedOnCoords()
	Else
		MsgBox($MB_SYSTEMMODAL, "", "Could not find Move button in Foldio app, please open the correct interface in foldio", 5)
		Exit
	EndIf
EndFunc   ;==>TurnTable

Func TurnTableBasedOnCoords()
	ConsoleWrite("Turning table.." & @CRLF)
	MouseClick("", $foldioX, $foldioY)
	MouseMove(0, 0)
	$color = 0
	While (Not (isOrange($color)))
		ConsoleWrite("Waiting for table to finish turning, current color = " & $color & " (" & _ColorGetRed($color) & ", " & _ColorGetGreen($color) & ")" & @CRLF)
		Sleep(700)
		$color = PixelGetColor($foldioX, $foldioY)
	WEnd
	ConsoleWrite("Finished turning with color = " & $color & @CRLF)
EndFunc   ;==>TurnTableBasedOnCoords

Func isOrange($color) ;Used for Foldio button detection
	$isOrange = (_ColorGetRed($color) <= 255) And (_ColorGetRed($color) >= 230) And (_ColorGetGreen($color) <= 90) And (_ColorGetGreen($color) >= 80)
	Return $isOrange
EndFunc   ;==>isOrange

Func isRed($color) ;Used for helicon button detection
	$isRed = (_ColorGetRed($color) <= 255) And (_ColorGetRed($color) >= 230) And (_ColorGetGreen($color) <= 170) And (_ColorGetGreen($color) >= 75)
	Return $isRed
 EndFunc   ;==>isRed


;~ Func TakePictures()
;~ 	Local $result = _ImageSearch($HELICON_TAKE_PICTURES_BTN_IMG)
;~ 	If ($result[0]) Then
;~ 		ConsoleWrite("Taking pictures.." & @CRLF)
;~ 		MouseClick("", $result[1], $result[2])
;~ 		MouseMove(0, 0)
;~ 		Sleep(800)
;~ 		$result = _ImageSearch($HELICON_TAKE_PICTURES_BTN_IMG)
;~ 		While (Not $result[0])
;~ 			ConsoleWrite("Waiting for Camera to finish taking pictures.." & @CRLF)
;~ 			Sleep(1000)
;~ 			$result = _ImageSearch($HELICON_TAKE_PICTURES_BTN_IMG)
;~ 		WEnd
;~ 		ConsoleWrite('Found helicon image again on pos ' & $result[1] & ', ' & $result[2] & @CRLF)
;~ 	Else
;~ 		MsgBox($MB_SYSTEMMODAL, "", "Could not find start button in helicon", 5)
;~ 		Exit
;~ 	EndIf
;~ EndFunc   ;==>TakePictures

Func TakePicturesBasedOnCoords()
	ConsoleWrite("Taking pictures.." & @CRLF)
	MouseClick("", $heliconX, $heliconY)
	MouseMove(0, 0)
	$color = 0
	While (Not (isRed($color)))
		ConsoleWrite("Waiting for Camera to finish taking pictures, current color = " & $color & " (" & _ColorGetRed($color) & ", " & _ColorGetGreen($color) & ")" & @CRLF)
		Sleep(700)
		$color = PixelGetColor($heliconX, $heliconY)
	WEnd
	ConsoleWrite("Finished taking pictures color = " & $color & @CRLF)
EndFunc   ;==>TakePicturesBasedOnCoords
