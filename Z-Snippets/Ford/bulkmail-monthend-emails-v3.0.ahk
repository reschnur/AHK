#SingleInstance force ; Disables pop-up message for re-running this scipt

SetTitleMatchMode, 2    ; 1 = start with, 2 = anywhere, 3 = exact match

Script_Name = BulkMail Monthly Emails
versioninfo = v2.0 (Last updated: 6 Jul, 2020 by rschnur2)
versioninfoshort = v3.1 11 Mar, 2020

comma := ","
parenthesis := "("

INIFile = C:\BulkMail-Paging\BulkMail-Utility.ini

; Add other emails? Two different metrics emails - vanessa and simone?


; Retrieve INI data and check for required files

if(!FileExist(INIFile))
{
	MsgBox, 48, %Script_Name% - Error-1, Could not find the required INI file. Process cancelled.`nFile Name: %INIFile%
	winactivate, Error
	ExitApp
}

; Set Email CC value - File name is case sensitive
IniRead, AdminCc, C:\BulkMail-Paging\BulkMail-Utility.ini, EmailAddresses, AdminCC
IniRead, SubjectAudit_To, C:\BulkMail-Paging\BulkMail-Utility.ini, EmailAddresses, SubjectAuditTo
IniRead, SubjectAudit_CC, C:\BulkMail-Paging\BulkMail-Utility.ini, EmailAddresses, SubjectAuditCC
IniRead, SubjectAudit_Doc, C:\BulkMail-Paging\BulkMail-Utility.ini, DocumentLocation, SubjectAuditDoc
IniRead, MetricsPPT_To, C:\BulkMail-Paging\BulkMail-Utility.ini, EmailAddresses, MetricsPPTTo
IniRead, MetricsPPT_CC, C:\BulkMail-Paging\BulkMail-Utility.ini, EmailAddresses, MetricsPPTCC
IniRead, MetricsPPT_Doc, C:\BulkMail-Paging\BulkMail-Utility.ini, DocumentLocation, MetricsPPTDoc
IniRead, MetricsXLS_To, C:\BulkMail-Paging\BulkMail-Utility.ini, EmailAddresses, MetricsXLSTo
IniRead, MetricsXLS_CC, C:\BulkMail-Paging\BulkMail-Utility.ini, EmailAddresses, MetricsXLSCC
IniRead, MetricsXLS_Doc, C:\BulkMail-Paging\BulkMail-Utility.ini, DocumentLocation, MetricsXLSDoc

SplitPath, SubjectAudit_Doc, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
SubjectAudit_Win = %OutNameNoExt%

SplitPath, MetricsPPT_Doc, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
MetricsPPT_Win = %OutNameNoExt%

SplitPath, MetricsXLS_Doc, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
MetricsXLS_Win = %OutNameNoExt%

/*
MsgBox, 262192, INI Values, 
(
AdminCC: %AdminCC%`n`n
SubjectAudit_To: %SubjectAudit_To%`n
SubjectAudit_CC: %SubjectAudit_CC%`n
SubjectAudit_Doc: %SubjectAudit_Doc%`n
SubjectAudit_Win: %SubjectAudit_Win%`n`n
MetricsPPT_To: %MetricsPPT_To%`n
MetricsPPT_CC: %MetricsPPT_CC%`n
MetricsPPT_Doc: %MetricsPPT_Doc%`n
MetricsPPT_Win: %MetricsPPT_Win%`n
MetricsXLS_To: %MetricsXLS_To%`n
MetricsXLS_CC: %MetricsXLS_CC%`n
MetricsXLS_Doc: %MetricsXLS_Doc%`n
MetricsXLS_Win: %MetricsXLS_Win%`n
)
*/


;SubjectAudit_Doc = %SubjectAuditDoc%
;Metrics_Doc = %MetricsDoc%

if(!FileExist(SubjectAudit_Doc))
{
	MsgBox, 48, %Script_Name% - Error-2, Could not find the required file:`n`nFile Name: %SubjectAudit_Doc%
	winactivate, Error
	ExitApp
}

if(!FileExist(MetricsPPT_Doc))
{
	MsgBox, 48, %Script_Name% - Error-3, Could not find the required file:`n`nFile Name: %MetricsPPT_Doc%
	winactivate, Error
	ExitApp
}

if(!FileExist(MetricsXLS_Doc))
{
	MsgBox, 48, %Script_Name% - Error-4, Could not find the required file:`n`nFile Name: %MetricsXLS_Doc%
	winactivate, Error
	ExitApp
}


; Build default month from current date
gosub, default_mmmyyyy

; Ask which email is being sent
Gui, font, s10, Arial

Gui, Add, Radio,  x10  y10   vRadioFP, BulkMail Subject Audit
Gui, Add, Radio,  x10  yp+19 vRadioSP, BulkMail Usage Metrics (PPT)
Gui, Add, Radio,  x10  yp+19 vRadioXP, BulkMail Usage Metrics (XLS)
Gui, Add, Text,   x10  yp+26, Reporting Month
Gui, Add, Edit,   x110 yp-2  w100 r1 h16 vrptmo, %rptmmmyyyy%

Gui, Add, Button, x10  yp+40 w70 h22 default, &Ok
Gui, Add, Button, x90  yp    w70 h22 , &Cancel
GUI, Add, Text,   x180 yp+2    w120 h22, %versioninfoshort%

guicontrol, , BulkMail Subject Audit, 1

Gui, Show, x400 y200, BulkMail Reports Emails

Return

GuiEscape:
Gui, Destroy
exitapp

GuiClose:
gui, Destroy
exitapp

ButtonCancel:
gui, Destroy
exitapp

buttonOk:
Gui, Cancel
Gui, submit, NoHide
Gui, destroy

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

reportmonth = %rptmo%

StringLen, length, reportmonth
if length = 0
{
	msgbox, No reporting month entered. Exit App.
	exitapp
}

; ------------------------------------------------------------------------------
; Switch to Outlook Inbox and create a new email. Cursor is positioned in the To: field by default.
; ------------------------------------------------------------------------------
if winexist Microsoft Outlook
{
WinActivate, Microsoft Outlook
WinWaitActive, Microsoft Outlook, ,6 ; Timeout = 6 seconds
}
else
{
ifwinexist Outlook
{
WinActivate, Outlook
WinWaitActive, Outlook, ,6 ; Timeout = 6 seconds
}
else
{
msgbox, 0, %wintitle%, Outlook is not running!
}
}

; Setup new email
Send ^+m     ; ^+m = new email
WinWaitActive, Untitled - Message

; Position message for better reading
WinMove, %WinTitle%,, 0, 0, (A_ScreenWidth/2), (A_ScreenHeight * .93)


; Process selected option
If (RadioFP=1)
	{
    subto = %SubjectAudit_to%
	subcc = %SubjectAudit_cc%
	subsubj = BulkMail Subject Line Audit Report - %reportmonth%
	subdoc = %SubjectAudit_doc%
	subwin = %SubjectAudit_win%
	
	gosub emailbuild
}
Else If (RadioSP=1) 
 {
    subto = %MetricsPPT_to%
	subcc = %MetricsPPT_cc%
	subsubj = BulkMail Usage Stats for %reportmonth%
	subdoc = %MetricsPPT_doc%
	subwin = %MetricsPPT_win%
	
	gosub emailbuild
}
Else If (RadioXP=1) 
 {
    subto = %MetricsXLS_to%
	subcc = %MetricsXLS_cc%
	subsubj = BulkMail Usage Stats for %reportmonth%
	subdoc = %MetricsXLS_doc%
	subwin = %MetricsXLS_win%
	
	gosub emailbuild
}
else
   exitapp

If (RadioFP=1)
   msgbox, 0, Email Builder, Before sending the message`, make sure the hyperlink points to the correct year., 4 

else
   msgbox, 0, Email Builder, 
   (
   Before sending the message`, make sure that any:`n    
   File names are correct`n    Month references are correct`n    
   Files are attached`n    Record counts are updated`n    Links work correctly, 6
   )
   
exitapp


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

emailbuild:

BlockInput, MouseMove

; Build Email "To" Address - was 1 before o365
ControlSetText, RichEdit20WPT2, %SubTo%, A

sleep, 400

; Build Email "CC" address - "';" below between the variable names inserts a literal ; into the string
ControlSetText, RichEdit20WPT3, %SubCC%`

; Check names - this will check all names
send !K

;Sleep, 400

; Insert subject
ControlSetText, RichEdit20WPT5, %SubSubj%

; Sleep, 200
	  

; Open Word document, copy all contents, close document
; msgbox, Page doc %pg_rpt1_doc%`n Window %pg_rpt1_win%
Run, %subdoc%
WinWaitActive, %subwin%
Sleep, 200

; Clear the clipboard
clipboard := ""

; Insert the Word doc into the clipboard
while(clipboard == "")
{
	Send ^a^c
	Sleep, 200	
}

; Close the Word file - wrong place?????????????
WinClose, %subwin%

; Allow Word to close
Sleep, 1000

; Switch to message
WinActivate, Untitled
WinWaitActive, Untitled

; Does not work, don't know why
; Pass focus to the email body field and return
;curField = "_WwG1"
;ControlFocus, curField, Untitled ;A

BlockInput, Off

; Position cursor in body
MouseClick, left, 40, 340
Sleep, 500
; Insert text and remove extraneous trailing spaces
Send ^v
Sleep 500
Send {Backspace 2}
Send {Delete}

return


; ------------------------------------------------------------------------------
; Setup default entry for month/year to process
; ------------------------------------------------------------------------------

default_mmmyyyy:

today = %a_now%
curmm = %A_mm%
; curmm = 02

dateoffset := -10

; msgbox, 0, Initial values, MM: %a_mm% / %curmm%`nNow: %a_now%`nToday: %today%

; Check for january
if curmm = 01
;  force today var back into december of prior year
{
   EnvAdd, today, %dateoffset%, days
  ;  MsgBox, 0, After Envadd, Today: %today%
}
else
{
   EnvAdd, today, %dateoffset%, days
}

formattime, rptmmmyyyy, %today%, MMM, yyyyy ; parms are case sensitive

; msgbox, 0,Formattime,Report: %rptmmmyyyy%


return


; v1.0.0 - build monthly emails for subject audit and Metrics spreadsheets to ensure 
;          that all emails are covered
; v1.1.0 - Added new email for paging Metrics metrics
; v1.1.1 - Corrected for Office 2013
; v1.1.2 - Corrected docuemnt location
; v1.1.3 - Corrected prompt spelling error
; v1.1.4 - changed document locations to be same as other utility programs
; v1.1.5 - fixed reporting date not working for january reporting for december
;          was not calculating reporting date.
; v1.1.6 - more fixes to reporting date logic
; v1.1.7 - remove jmalaney, fixed send timings to compensate for new delays, modified 
;          post build message to differentiate between subject audit and other emails.
; v1.1.8 - updated cds ids to reflect current organization
; v2.0   - droped to 2 digit versioninfo
;          split paging funcitons to separate script
; v3.0   - Converted to use INI for values
; v3.1   - Fixed inseet into email body. Direct reference no longer works.
