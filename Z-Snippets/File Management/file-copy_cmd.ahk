
srcfolder = C:\Program Files (x86)\IBM\SAIOM\logs
dstfolder = W:\GNCO\SA-IOM\Backups\%a_yyyy%\Logs\%servername%\%a_mm%
servername = Test02

s_cmd := `"""xcopy`"" " `"""/H`"" " `""C:\Program Files (x86)\IBM\SAIOM\logs`" " `""W:\GNCO\SA-IOM\Backups\%a_yyyy%\Logs\%servername%\%a_mm%`""
RunWait , %ComSpec% /k "%s_cmd%" , , UseErrorLevel