#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
; #Warn  ; Enable warnings to assist with detecting common errors.

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode 2 ;  2 = anywhere

Script_Name = Bulk Folder Creator

FileSelectFile, SourceFile, 3,, Pick a text or HTML file to analyze.
if (SourceFile = "")
{
	MsgBox, 0, %Script_Name%, Cancel, 1
	return  ; This will exit in this case.
}


FileSelectFolder, DstFolder,,,Select Folder
if (DstFolder = "")
{
	MsgBox, 0, %Script_Name%, Cancel, 1
	return  ; This will exit in this case.
}


Loop, read, %SourceFile%
{
	MsgBox, %dstfolder%\%A_LoopReadLine%
	FileCreateDir, %dstfolder%\%A_LoopReadLine%
}

run, explorer, %DstFolder%

return
