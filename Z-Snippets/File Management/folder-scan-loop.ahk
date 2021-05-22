;

msgbox, Start

; 0 = no options, 1 = allow new folders, +2 = Edit field to type name
FileSelectFolder, SelectedFolder, C:\Users\resch, Select Folder to Scan, 0
if SelectedFolder =
   {                             ; User canceled
   MsgBox, The user didn't select anything.
   ExitApp
   }
else
    MsgBox, The user selected the following:`n%SelectedFile%


;Loop, %A_ProgramFiles%\*.txt, , 1  ; Recurse into subfolders.
; first option  = 0=only files, 1=files & folders, 2=only folders
; second option = 0=no recurse, 1=recurse
Loop, %SeelctedFolder%\*.*, 2, 0
{
   MsgBox, 4, , Filename = %A_LoopFileFullPath%`n`nContinue?
   IfMsgBox, No
      break
}