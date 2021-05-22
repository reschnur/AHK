; 

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

FileCreateDir, %A_ScriptDir%\Assets
SetWorkingDir, %A_ScriptDir%\Assets

;                                            source,                         dest, overwrite
FileInstall, C:\BulkMail-Paging\Icons\BMU-Red-3.ico, %A_WorkingDir%\BMU-Red-3.ico, 1

GUI, Add, Picture, , BMU-Red-3.ico

GUI, Show, , Tut 26

Return

GUIClose:
ExitApp

esc::ExitApp