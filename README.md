# Foldio360-HeliconRemote-automation
Automated control of a Foldio360 turntable combined with control of the Helicon Remote software to capture images

You need Autoit, AnyDesk connected to your smartphone on the PC you are running this script on, a smartphone with the Foldio360 app connected to the turntable and HeliconRemote connected with your camera.

The script uses Anydesk to control the smartphone, and through that the turntable. 

You need to modify these parameters in the script:

Const $ITERATIONS = 23
Const $HELICON_WINDOW = "Helicon Remote (ver. 3.9.11 W)"
Const $ANYDESK_WINDOW = "xxxxx - AnyDesk"
Global $heliconX = 558
Global $heliconY = 109


$ITERATIONS - How many turns are required for a complete turn of the object to be captured. Calculate this based on the turn degrees set in the Foldio360 app
$HELICON_WINDOW - The name (title) of the Helicon Remote window
$ANYDESK_WINDOW - The name (title) of the AnyDesk window when connected to your smartphone
$heliconX and $heliconY - The coordinates of the red dot in the "start shooting" button of Helicon Remote, when that window is active. This is required as the image search for coordinates doesn't currently work for helicon.
