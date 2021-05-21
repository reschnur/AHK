#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

SrcFolder = C:\Users\resch\Software Projects\JavaScript\NodeExpress-Anson
DstFolder = E:\Backup Test-%A_Now%

CopyRootFolders(Source, Dest)
{
    ;MsgBox, 0,,Copy 2`n  From: %Source%`n  To:%Dest%
    FileCreateDir, %Dest%

    ; Copy Files
    FileCopy, %Source%\*.*, %Dest%

    ; Copy directories
    Loop Files, % Source "\*", D
    {
        msgbox, 0,,Folder Name: %A_LoopFileName%, 2

        If (A_LoopFileName = "node_modules") {
            MsgBox, 0,,Bypass, 1
            Continue
        }

        SrcFolder2 = %Source%\%A_LoopFileName%
        DstFolder2 = %Dest%\%A_LoopFileName%
        MsgBox, 0,,Directory Copy:`n  From:  %SrcFolder2%`n  To:    %DstFolder2%
        FileCopyDir %SrcFolder2%, %DstFolder2%
    }
}

;MsgBox, 0,,Copy 1`n  From: %SrcFolder%`n  To:%DstFolder%
CopyRootFolders(SrcFolder, DstFolder)

ExitApp, 0