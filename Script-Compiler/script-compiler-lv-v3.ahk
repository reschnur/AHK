; Compile common AHK scripts

; This script must be compiled manually from ahk2exe.exe, not the compiled
; version else an error is generated. IOW it cannot be self compiled from the exe version.

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact
DetectHiddenWindows, On


Script_Name   = Script Compiler
ScriptVersion = v1.0
IconFolder    = D:\OneDrive\Graphics\Icons
InputFile     = C:\Program Files (Z)\AHK-Script-Compiler\script-compiler.txt

Rows = 0       ; minimum rows


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Count records to know the number of rows to show in the list view so no scrolling
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Loop,Read, C:\Program Files (Z)\AHK-Script-Compiler\script-compiler.txt
{
	stringleft, pos1, A_LoopReadLine, 1

	if pos1 <> #                               ; # = comment line. Skip the record.
	   rows ++
}


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build GUI - Load file to list view
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GUI, Font, s10 bold

Gui, Add, ListView, r%rows% backgroundteal cwhite grid NoSortHdr gGUIProcess, Script Name (double click to compile)|Icon Name|Source Path|Destination File

Loop,Read, C:\Program Files (Z)\AHK-Script-Compiler\script-compiler.txt
{
	stringleft, pos1, A_LoopReadLine, 1

	if pos1 <> #                               ; # = comment line. Skip the record.
       {
	   StringSplit, var_, A_LoopReadLine, ~
	   
	   ;MsgBox, 0, %Script_Name%, Var_1: %var_1%`nVar_2: %var_2%`nVar_3: %var_3%`nVar_4: %var_4%
       
       ; var_1 = Friendly name, var_2 = icon name in C:\Users\rschnur2\Pictures\Icons, var_3 = input base path, var_4 = outputpath & program name
	   LV_Add("", var_1, var_2, var_3, var_4) ; each var is a column - max 256
       
       LV_ModifyCol(1, "AutoHdr Sort") ; Autohdr sets the width based on header or content whichever is wider  
       LV_ModifyCol(2, "0")            ; 0 causes the width = 0 (hidden), but still available for processing.
       LV_ModifyCol(3, "0")            ; 0 causes the width = 0 (hidden), but still available for processing.
       LV_ModifyCol(4, "0")            ; 0 causes the width = 0 (hidden), but still available for processing.
	   }
}

Gui, Add, Button, w180 h20 gOpenEntries, Open Compiler Entries
Gui, Add, Button, w180 h20 gOpenSource, Open Last Source
Gui, Add, Button, w180 h20 gOpenDest, Open Last Destination

Gui, Add, Text, x280 yp, %ScriptVersion%

Gui, Show, autosize, %Script_Name%

Return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Process GUI Actions
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GuiClose:
GUI, Destroy
ExitApp


GuiEscape:
GUI, Destroy
ExitApp


GUIProcess:

if A_GuiEvent = DoubleClick
	{
		LV_GetText(ScriptDesc, A_EventInfo, 1)               ; Get the text from the row's first field.
		LV_GetText(IconName, A_EventInfo, 2)                 ; Get the text from the row's second field.
		LV_GetText(SrcFolder, A_EventInfo, 3)                ; Get the text from the row's third field.
		LV_GetText(DstFileName, A_EventInfo, 4)              ; Get the text from the row's fourth field.
		
		ToolTip, You double-clicked row %A_EventInfo%: Script: "%ScriptDesc%"`nIcon: %IconName%
		
		SetTimer, removetooltip, 2000                  ; turn off the tool tip after 2 seconds (2000 milliseconds)
		
		;msgbox, 0, %script_name%, Compile:`n`nName: %ScriptDesc%`nIcon: %IconName%,`nSrcFolder: %SrcFolder%`nDest File: %DstFileName%, 2
		
          ; Get input file
		FileSelectFile, SrcFileName, 1, %SrcFolder%, Select the %ScriptDesc% source file to compile.
		
		if SrcFileName = 
		{
			MsgBox, 0, %Script_Name%, No source file selected., 1
			return
		}
		
		IconFileName = %IconFolder%\%IconName%
		
		if (FileExist (IconFileName))
		{
			run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "%SrcFileName%" /out "%DstFileName%" /icon "%IconFileName%"
			MsgBox, 0, %Script_Name%, Compile complete., 2
			return
		}
		
		MsgBox, 0, %Script_Name%, Icon file missing. Compile failed., 2
	} 

return


RemoveToolTip:

SetTimer, RemoveToolTip, Off

ToolTip                           ; command with no text turns off the tip window

return

exitapp


OpenEntries:

run, C:\Program Files (Z)\AHK-Script-Compiler\script-compiler.txt

return


OpenSource:

if SrcFolder <>
	run, explorer.exe %Srcfolder%
else
	MsgBox, 0, %Script_Name%, No source folder., 1

return


OpenDest:

;             input, file name, path, ext, name no ext, drive  
SplitPath, DstFileName, , DstFolder
;MsgBox, 0, %Script_Name%, Destination: %DstFolder%

if DstFolder <>
	run explorer.exe %DstFolder%
else
	MsgBox, 0, %Script_Name%, No destination folder., 1

return