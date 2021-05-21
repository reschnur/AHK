;

#SingleInstance, Force
SetTitleMatchMode, 2                ; 1 = Starts with, 2 = Anywhere, 3 = Exact

Script_Name = ScriptName

FileCreateDir, %a_ProgramFiles%\CC-iConnect
FileInstall, FTPS.exe, %a_ProgramFiles%\CC-iConnect\FTPS.exe , 1
FileInstall, icon_arrow_down.ico, %a_ProgramFiles%\CC-iConnect\icon_arrow_down.ico , 1
FileInstall, icon_arrow_up.ico, %a_ProgramFiles%\CC-iConnect\icon_arrow_up.ico , 1
FileInstall, icon_biggrin.ico, %a_ProgramFiles%\CC-iConnect\icon_biggrin.ico , 1
FileInstall, icon_cool.ico, %a_ProgramFiles%\CC-iConnect\icon_cool.ico , 1
FileInstall, icon_eek.ico, %a_ProgramFiles%\CC-iConnect\icon_eek.ico , 1
FileInstall, icon_question.ico, %a_ProgramFiles%\CC-iConnect\icon_question.ico , 1
FileInstall, icon_sad.ico, %a_ProgramFiles%\CC-iConnect\icon_sad.ico , 1
FileInstall, icon_wink.ico, %a_ProgramFiles%\CC-iConnect\icon_wink.ico , 1
FileInstall, icon_mad.ico, %a_ProgramFiles%\CC-iConnect\icon_mad.ico , 1
FileInstall, icon_exclaim.ico, %a_ProgramFiles%\CC-iConnect\icon_exclaim.ico , 1
FileInstall, Detect Internet Connection.exe, %a_ProgramFiles%\CC-iConnect\Detect Internet Connection.exe , 1

FileCreateShortcut, "%a_ProgramFiles%\CC-iConnect\Detect Internet Connection.exe", %A_StartupCommon%\CC iConnect.lnk, "%a_ProgramFiles%\CC-iConnect\", , Completely Computing IP monitor software.  Used for Remote Support., "%a_ProgramFiles%\CC-iConnect\icon_cool.ico"

ExitApp
