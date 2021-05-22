Process, Exist, Printkey2000.exe ; check to see if Printkey.exe is running
If (ErrorLevel = 0) ; If it is not running
	{
	Run, Printkey2000.exe
	msgbox Program was not running.
	}
Else ; If it is running, ErrorLevel equals the process id for the target program (Printkey). Then close it.
	{
	Process, Close, %ErrorLevel%
	msgbox Closed process %ErrorLevel%
	}