#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

SelectedFolder = C:\Users\resch\Software Projects\Udemy Web Developer Course
BackUpName = Udemy Web Developer Course
copydstfolderbase = E:\Backups\IDE Projects\%BackupName%\As of-%A_yyyy%%A_mm%%A_dd% %A_hour%%A_min%%A_sec%

Loop, %SelectedFolder%\*.*, 2, 0
{
    MsgBox, 4, , Filename = %A_LoopFileName%`n`nContinue?
    IfMsgBox, No
    break

    If (A_LoopFileName = "node_modules" || A_LoopFileName = ".vscode" || A_LoopFileName = ".git") {
       MsgBox, 0,,Bypass %A_LoopFileName%, 1
       Continue
    }

    copysrcfolder = %A_LoopFileFullPath%
    copydstfolder = %copydstfolderbase%\%A_LoopFileName%

    Gosub, CopyFiles
}

MsgBox, 0,,Complete., 2

ExitApp, 0

CopyFiles:

    ;MsgBox, 0,,Copy 2`n  From: %copysrcfolder%`n  To:%copydstfolder%
    FileCreateDir, %copydstfolder%

    ; Copy Files
    FileCopy, %copysrcfolder%\*.*, %copydstfolder%

    ; Copy directories
    Loop Files, % copysrcfolder "\*", D
    {
        ;msgbox, 0,,Folder Name: %A_LoopFileName%
        If (A_LoopFileName = "node_modules" || A_LoopFileName = ".vscode" || A_LoopFileName = ".git") {
            ;MsgBox, 0,,Bypass %A_LoopFileName%, 1
            Continue
        }

        SrcFolder2 = %copysrcfolder%\%A_LoopFileName%
        DstFolder2 = %copydstfolder%\%A_LoopFileName%
        ;MsgBox, 0,,Directory Copy:`n From: %SrcFolder2%`n To: %DstFolder2%, 4
        FileCopyDir %SrcFolder2%, %DstFolder2%
    }

Return