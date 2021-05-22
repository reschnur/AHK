; Read a file and output selected records.

#SingleInstance force

ScriptName = Extract Records

FileSelectFile, SelectedFile, 3, C:\Users\rschnur2\Documents\LSI\BulkMail\Metrics\Senders - Full SFUL, Select a file to process
if SelectedFile =
   {
   MsgBox, No file selected. 
   ExitApp
   }

SplitPath, SelectedFile, InputFileNameFull, InputFilePath, InputFileExt, InputFileNameNoExt, InputFileDrive	

InputBox, Search_String, %ScriptName%, Please enter a search string:, , 200, 100
If ErrorLevel
   ExitApp

outputfile = %InputFilepath%\%InputFileNameNoExt%-%Search_String%.csv
ifexist, %outputfile%
  FileDelete, %outputfile%


; Count records in file for progress display 
Loop, Read, %SelectedFile%
{
   Total_Records = %A_Index%
}


; Build progress display
Gui, Font, s16, Arial

Gui, Add, Text, x10 y20 w360 vText1
Gui, Add, Text, x10 y50 w360 vText2

Gui, +AlwaysOnTop

Gui, Font, s16, Arial
Gui, Show, x600 y800 w380 h100, %ScriptName%


; Process the file

Iteration = 0
Limit = 10000                                ; 0 means do not limit the iterations
Records_Selected = 0


Loop, read, %SelectedFile%
{
   File_Record = %A_LoopReadLine%
      
   StringGetPos, pos, File_Record, %Search_String%
   if pos >= 0
      {
      fileappend, %A_LoopReadLine%`n, %OutputFile%
	  
	  Records_Selected += 1
	  }
	
	Iteration += 1
	
	; Update the GUI progress text
	Gui_Text1 = Processed: %Iteration% of %Total_Records%.
	Gui_Text2 = Selected:  %Records_Selected%
	
	GuiControl,,Text1,%gui_text1%
	GuiControl,,Text2,%gui_text2%
	
	; Debug limit
    if limit > 0	
	   if Iteration >= %limit%
	      break
}

Gui, Destroy

MsgBox, Extract complete. Records selected: %Records_Selected%

exitapp


