; This script will build the emails for various functions that do not require paramters from Smart IT forms.
; It is meant as an alternative if the admin does not want to use Outlook's Quick Parts feature.
; It is not persistent. Once executed, it ends.

#SingleInstance force ; Disables pop-up message for re-running this scipt

SetTitleMatchMode, 2 ; 1=Starts with, 2=anywhere in the title, 3=exact match - window commands - titles are case sensitive

versioninfo = v1.0.0 (Last updated: 25 Mar, 2019 by rschnur2)
versioninfoshort = v1.0.0 25 Mar, 2019 rschnur2

Script_Name = BulkMail User Emails


comma := ","
parenthesis := "("


; Default variable values

AdminCC := "mconmack;jpoma10"

; BulkMail email values for - GUI button 1
s1_email_to   := "x"
s1_email_cc   := AdminCC
s1_email_doc  := "C:\bulkmail-paging\Documents\BulkMailEmailFloodBlock.docx"
s1_email_subject  := "Your list has been blocked from sending BulkMail emails"
s1_email_word_window  := "BulkMailEmailFloodBlock.docx"

; BulkMail email values for - GUI button 2
s2_email_to   := "x"
s2_email_cc   := "x"
s2_email_doc  := "C:\bulkmail-paging\Documents\BulkMailRequestEmail"
s2_email_subject  := "How to request BulkMail List Manager access"
s2_email_word_window  := "BulkMailAccessRequestITConnect.docx"

; BulkMail email values for - GUI button 3
s3_email_to   := "x"
s3_email_cc   := "x"
s3_email_doc  := "C:\bulkmail-paging\Documents\BulkMailAcessRequestITConnect.docx"
s3_email_subject  := "How to submit a BulkMail incident"
s3_email_word_window  := "BulkMailAccessRequestITConnect.docx"

; BulkMail email values for - GUI button 4
s4_email_to   := "x"
s4_email_cc   := "x"
s4_email_doc  := "C:\bulkmail-paging\Documents\BulkMailIncidentRequestCenter.docx"
s4_email_subject  := "How to request BulkMail List Manager access"
s4_email_word_window  := "BulkMailAccessRequestITConnect.docx"



; Ask which email is being sent
Gui, font, s10, Arial
Gui, Add, Radio, x10 vRadio01 checked, Add Blocked Address
Gui, Add, Radio, x10 vRadio02 , Request Email for Research
Gui, Add, Radio, x10 vRadio03 , Submit Access Request ; 
Gui, Add, Radio, x10 vRadio04 , Submit Incident ; 
Gui, Add, Radio, x10 vRadio05 , Subscriber Management
;Gui, Add, Radio, x10 vRadio06 , EAMS List Management
;Gui, Add, Radio, x10 vRadio08 , Not Receiving - List Known
;Gui, Add, Radio, x10 vRadio09 , Not Receiving - List Unknown
Gui, Add, Button, x10 w70 h24 default, &Ok
Gui, Add, Button, x+5 w70 h24 , &Cancel  ; position relative to last control on the line
GUI, Add, Text, x+40 w170 h20, %versioninfoshort%
guicontrol, , BulkMail Subject Audit, 1
Gui, Show, x400 y200 w380, BulkMail/Paging Reports Email Builder
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


; ------------------------------------------------------------------------------
; Process email selection
; ------------------------------------------------------------------------------

; Switch to Outlook Inbox
ifwinexist Outlook
   {
   WinActivate, Outlook
   WinWaitActive, Outlook, ,4 ; Timeout = 4 seconds
   }
else
   {
   msgbox, 0, %Script_Name%, Outlook is not running! Cancellin gprocess.
   return
   } 
   
 
; Setup new email.  Cursor is positioned in the To: field by default.
Send ^+m     ; ^+m = new email
WinWaitActive, Untitled - Message

; Position message for better reading
WinMove, %Script_Name%,, 0, 0, (A_ScreenWidth/2), (A_ScreenHeight * .93)


; Process selected option
If (Radio01=1)
	{
    EmailTo = %s1_email_to%
	EmailCC = %s1_email_cc%
	EmailSubject = %s1_email_subject%
	EmailBodyDoc = %s1_email_doc%
	EmailWordWindow = %s1_email_word_window%
	
	gosub Build_Email
}
Else If (Radio02=1) 
 {
    EmailTo = %s2_email_to%
	EmailCC = %s2_email_cc%
	EmailSubject = %s2_email_subject%
	EmailBodyDoc = %s2_email_doc%
	EmailWordWindow = %s2_email_word_window%
	
	gosub Build_Email
}
Else If (Radio03=1) 
{
    EmailTo = %s3_email_to%
	EmailCC = %s3_email_cc%
	EmailSubject = %s3_email_subject%
	EmailBodyDoc = %s3_email_doc%
	EmailWordWindow = %s3_email_word_window%
	
	gosub Build_Email
}
Else If (Radio04=1) 
{
    EmailTo = %s4_email_to%
	EmailCC = %s4_email_cc%
	EmailSubject = %s4_email_subject%
	EmailBodyDoc = %s4_email_doc%
	EmailWordWindow = %s4_email_word_window%
	
	gosub Build_Email
}
Else ; Radio05=1
{
    EmailTo = %s5_email_to%
	EmailCC = %s5_email_cc%
	EmailSubject = %s5_email_subject%
	EmailBodyDoc = %s5_email_doc%
	EmailWordWindow = %s5_email_word_window%
	
	gosub Build_Email
}

timeout_seconds = 4
msgbox, 0, %Script_Name%, Before sending the message`, make sure that any variables in the text are updated and all links work correctly, %timeout_seconds%
   
exitapp


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Build_Email:

; Build Email "To" Address - x means empty, so skip the action. Cursor will be here by default when message is created.
if EmailTo != x
   ControlSetText, RichEdit20WPT1, %EmailTo%, A

; Build Email "CC" address - x means empty, so skip the action
if emailCC != x
   ControlSetText, RichEdit20WPT2, %EmailCC%

; Check names - this will check all names - x means empty, so skip the action
if EmailTo != x  
   {
   send !K

   ; Allow name check to process
   Sleep, 400

   ; Name check does a wildcard search leading to the possibility of multiple address entries being candidates. 
   ; The following loop pauses the script so the user can work in Outlook to resolve any issues. 
   ; The script remains paused until the user clicks the yes button in the dialog window to resume the script. 
   loop
   {
      msgbox, 36, %Script_Name%,Have all of the email addresses been resolved?
      winactivate, email addresses been resolved
      ifmsgbox, yes
         break
      else
         continue
   }
}

; Insert email subject
ControlSetText, RichEdit20WPT4, %EmailSubject%

; Set focus on email body
ControlFocus, _WwG1

gosub Insert_Word_Doc

; Delete blank lines inserted after the text insert
send, {backspace}{delete 2}

; Position cursor at top of body
Send ^{Home}

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Insert the Word docuemnt into the email body
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Insert_Word_Doc:

; Open Word document
Run, %EmailBodyDoc%

Sleep, 2000 ; wait for it to open

WinGetTitle, WindowTitle, A
; msgbox, 0, %Script_Name%,Window title: %WindowTitle%
WinWaitActive, %WindowTitle%

Sleep, 1200 ; Prevents "Hold down control keey" error

; Clear the clipboard
clipboard := ""

; Copy the document into the clipboard
while(clipboard == "")
{
	Send ^a^c
}

; Close the Word file
WinClose, %EmailWordWindow%

; Allow for the Word window to close
Sleep, 1200

; Switch to message
WinActivate, Message   ; Window titles are case sensitive

; Insert the clipboard text
Send ^v

return



; Change log:

; v1.0.0 - Initial build
