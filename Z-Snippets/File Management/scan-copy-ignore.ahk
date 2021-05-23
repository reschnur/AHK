#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

SrcFolder = C:\Users\resch\Software Projects\JavaScript\NodeExpress-Anson
DstFolder = E:\Backup Test-%now%

CopyRootFolders(Source, Dest, CopyRootFiles:=false)
{
    ; For each direct subfolder of Source...
    Loop Files, % Source "\*", D
    {
        msgbox, 0,,Folder Name: %A_LoopFileName%, 1
        If (A_LoopFileName = "node_modules") 
        {
            MsgBox, 0,,Bypass, 2
            Continue
        }

        ; Create destination subfolder
        MsgBox, 0,,File Copy Dir Directory, 1
        ; FileCreateDir % Dest "\" A_LoopFileName
        MsgBox, 0,,%Source%`n%Dest%, 1
        FileCopyDir % Source, Dest "\" A_LoopFileName
        ; Copy files in subfolder
        MsgBox, 0,,Copy Files Command, 1
        ;FileCopy % A_LoopFilePath "\*", % Dest "\" A_LoopFileName, R
    }

    ;MsgBox, 0,,Copy Root Files, 1
;     if CopyRootFiles
;         FileCopy % Source "\*", % Dest
}

; Example copying direct subfolders and their contents
; MsgBox, 0,,Copy 1, 2
; CopyRootFolders(SrcFolder, DstFolder)

; Example also copying files directly in source
;MsgBox, 0,,Copy 2, 2
CopyRootFolders(SrcFolder, DstFolder, true)

ExitApp, 0