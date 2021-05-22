; Retrieve INI data and check for required files

if(!FileExist("C:\BulkMail-Paging\BulkMail-Utility.ini"))
{
	MsgBox, 48, %Script_Name% - Error-1, Could not find the required INI file.
	winactivate, Error
}

; Set Email CC value - File name is case sensitive
IniRead, AdminCc, C:\BulkMail-Paging\BulkMail-Utility.ini, DocumentLocation, EmailCC
;MsgBox, 48, %Script_Name% - Debug, INI File Cc: %AdminCc%

; Set Email Document Locations - File name is case sensitive
IniRead, UtilityDocFolder, C:\BulkMail-Paging\BulkMail-Utility.ini, DocumentLocation, Key
; MsgBox, 48, %Script_Name% - Debug, INI File UtilityDocFolder: %UtilityDocFolder%

EmailBodyDocName_Add = %UtilityDocFolder%\BulkmailAdd.docx
EmailBodyDocName_Req = %UtilityDocFolder%\BulkmailRequest.docx

bulkmailutilurl = ""

if(!FileExist(EmailBodyDocName_Add))
{
	MsgBox, 48, %Script_Name% - Error-2, Could not find the required file:`n`n%EmailBodyDocName_Add%
	winactivate, Error
	Return
}
