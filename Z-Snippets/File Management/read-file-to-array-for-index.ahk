; create an object-based array

NameArray := []                                    ; Create the array
YourSavedFile := "G:\Games\Minecraft\Mods & Tools\2-AHK Scripts\Minecraft RES Tool Suite\world-names-desktop" ; quotes are necessary because the file name has speciall characters

; Load the array	
Loop, Read, YourSavedFile
{
	varArray := strSplit(A_LoopReadLine, ~)        ; splits into "keys" and "values", delimiter = ~
	NameArray[varArray[1]] := varArray[2]          ; append line to array
}

;	Scan the array and build a string us ed in the msgbox
;   key,   output,    array name
for index, element in NameArray
{
	NameString .= "index " . index . " is " . element "`n"
}
	
MsgBox % NameString


; call the name you need via: NameArray[accountNumber]
