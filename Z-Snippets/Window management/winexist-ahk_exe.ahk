SetTitleMatchMode, 2 ; Regex

ifwinexist Inbox ahk_exe outlook.exe ; ) - Outlook        ;or ifwinexist .* Notepad or ifwinexist .*Notepad or .*-\sNotepad
	{
	WinActivate
	send ^f
	}
else
	msgbox Did not find window.
return