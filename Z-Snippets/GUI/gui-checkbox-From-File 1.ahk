;  This script reads a file and build a string used in a series of checkboxes
; This method is overly complicated. It could be simpler by reading the file ad adding the checkbox without using the string (loop, parse command)

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

Script_Name = Checkbox from File

CommandsFile = C:\BulkMail-Paging\vm-commands.txt ; G:\Games\Minecraft\Worlds\world-names-desktop.txt

vCount=
vOutput=
Clipboard =

; Read the file and build the checkbox list
vList := ""

loop, read, %CommandsFile%
{
   StringLeft, pos, A_LoopReadLine, 1    ; Extract the character in postion 1

   if pos <> #                           ; # = comment. skip the record.
	  vList = %vlist%@%A_LoopReadLine%   ; concatenate new string onto current string
}

StringTrimLeft, vList, vList, 1  ; Remove leading @

; Display final list string  
msgbox, 0,,%vList%


; Build the GUI
Gui, Add, Text,, Select one or more options:

Loop, parse, vList, @ ; `n
	{
		Gui, Add, Checkbox, vCheckbox%a_index%, %a_loopfield%
		vCount = %a_index%
	}

Gui, Add, Button, default xm, OK 

Gui, Show,, Pick List

Return


ButtonOK:

Gui, Submit

Loop, parse, vList, @  ; <= This character must match the separator from the GUI build step
{
	;msgbox, 0, title, Checkbox-%A_Index%: Checkbox%A_Index%
	If Checkbox%a_index% <> 0
	   {
	   ; msgbox, 0, %script_name%, Selected: Checkbox%A_Index%
	   Clipboard = %Clipboard%`n%a_loopfield%
	   }
}

Msgbox, These checkboxes were checked:`n%Clipboard%

; Copy

Return


GuiClose:

GuiEscape:

ExitApp