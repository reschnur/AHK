; Count files

#SingleInstance, Force


Script_Name = File Counter

; msgbox, 0, %Script_Name%, Start process.

; Display folder selection dialog for user
;                 Result,       start path,  0 = no "new folder" button, no text for typing pattern (option 1)
FileSelectFolder, SourceFolder, G:\Pictures, 0, Select the folder to count

if ErrorLevel = 0 ; User selected a folder
{
   msgbox, 0, %Script_Name%, Source: %sourcefolder%
   count1 = 0
   
   loop, %sourcefolder%\*.png, 1, 1
     { 
	 ; msgbox, 0, %Script_Name%, %a_loopfilename%
	 count1 += 1
	 }

   if count1 > 0 
      MsgBox, 0, %Script_Name%, File count: %count1%
   else
      MsgBox, 0, %Script_Name%, No matching files.
} ; file select error level

return