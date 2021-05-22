
Script_Name = File Copy

FileSelectFile, files, M3  ; M3 = Multiselect existing files where the file and path must exist.

if (files = "")
{
    MsgBox, The user pressed cancel.
    return
}

; Process selected files.

; ProfileModsFolder = <path from list view selction>
FileSelectFolder, ProfileModsFolder, C:\Users\rschnur2\Documents\LSI\BulkMail\Sent for Others, 1, Select folder to copy to. ; Testing only

if (ProfileModsFolder = "")
{
    MsgBox, No destination selected.
    return
}

Loop, parse, files, `n
{
    if (A_Index = 1)                      ; Entry 1 is the path of the selected files
	   {
       MsgBox, The selected files are all contained in %A_LoopField%.
	   ModsToInstallPath = %A_LoopField%
	   }
    else
    {
        MsgBox, 4, , The next file is %A_LoopField%.  Continue?
        IfMsgBox, No, break
		
		FileCopy, %ModsToInstallPath%\%A_LoopField%, %ProfileModsFolder%, 1
    }
}

MsgBox, 0, %Script_Name%, Copy complete, 2

run, explorer %ProfileModsFolder%

; loop for next selection

return