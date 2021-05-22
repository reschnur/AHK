; Write to the array:

ArrayCount = 0
recno = 0

ScanFile = G:\Games\Minecraft\Mods & Tools\2-AHK Scripts\Minecraft RES Tool Suite\world-names-desktop.txt

; Read the file and load the array
Loop, Read, %ScanFile%                      ; This loop retrieves each line from the file, one at a time.
{
    recno += 1
	
    if recno = 1                            ; Skip first line
	   continue
	   
    ArrayCount	+= 1                        ; Keep track of how many items are in the array.
    Array%ArrayCount% := A_LoopReadLine     ; Store this line in the next array element.
}

; Read from and display the array:
Loop %ArrayCount%
{
    element := Array%A_Index%              ; A_Index is a built-in variable.

    ; Split the array line into its parts	
	StringSplit, var_,Array%A_Index%, ~
	
    MsgBox, 0, %Script_Name%, 
    (
    1: %var_1%
    2: %var_2%
    3: %var_3%
    )

    ; Alternatively, you could use the "% " prefix to make MsgBox or some other command expression-capable:
    MsgBox % "Element number " . A_Index . " is " . Array%A_Index%   ; %
}