; This script will build an email in Outlook and insert the contents of a Word document into the body

#SingleInstance force ; Disables pop-up message for re-running this scipt

SetTitleMatchMode, 2 ; "Window Title Text" can be anywhere in the title

versioninfo = v1.0.0 (Last updated: 25 Mar, 2019 by rschnur2)
versioninfoshort = v1.0.0 25 Mar, 2019 rschnur2
wintitle = BulkMail User Emails


comma := ","
parenthesis := "("

; These settings can be used as part of a selection list for different emails. I did this in the BulkMail email builder.

; Assign values to variables for selection 1
s1_email_to   := "x"
s1_email_cc   := "x"  ; <== If a variable then the variable MUST not have the percent-signs
s1_email_doc  := "C:\bulkmail-paging\Documents\BulkMailEmailFloodBlock.docx"
s1_email_sub  := "Your list has been blocked from sending bulkmail emails"
s1_email_word_window  := "BulkMailEmailFloodBlock.docx"

; Assign selection 1 values to subroutine variables
EmailTo = %s1_email_to%
EmailCC = %s1_email_cc%
EmailSubject = %s1_email_sub%
EmailBody = %s1_email_doc%
EmailWindow = %s1_email_word_window%

; If not part of a selection gui, these assignemnts can be the direct text NOT variables using the following method.
EmailTo      := "x"                  ; If no email for this field enter x in the quotes.
EmailCC      := "x"                  ; If no email for this field enter x in the quotes.
EmailSubject := "Your list has been blocked from sending bulkmail emails"
EmailBody    := "C:\bulkmail-paging\Documents\BulkMailEmailFloodBlock.docx"
EmailWindow  := "BulkMailEmailFloodBlock.docx"
	
gosub Build_New_email
   
exitapp


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Build_New_email:

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


; ------------------------------------------------------------------------------
; Initiate new email and setup header info
; ------------------------------------------------------------------------------

Send ^+m     ; ^+m = new email
WinWaitActive, Untitled - Message

; Position message for better reading
WinMove, %WinTitle%,, 0, 0, (A_ScreenWidth/2), (A_ScreenHeight * .93)

; Build Email "To" Address - x means empty, so skip the action
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

   ; Name check does a wildcard search. This leads to the possibility of multiple address entries being candidates. 
   ; The following loop pauses the script so the user can work in Outlook to resolve any issues. 
   ; The script remains paused the user clicks the yes button in the dialog window to resume the script. 
   loop
   {
      msgbox, 36, %wintitle%,Have all of the email addresses been resolved?
      winactivate, email addresses been resolved
      ifmsgbox, yes
         break
      else
         continue
   }
}

; Insert email subject
ControlSetText, RichEdit20WPT4, %EmailSubject%

; exitapp

; Set focus for body - if done after the document process, this command does nothing and the insert is in the wrong field.
ControlFocus, _WwG1


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Insert the Word docuemnt intot he email body
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Open Word document
Run, %EmailBody%
WinWaitActive, %s1_email_word_window%
Sleep, 200

; Clear the clipboard
clipboard := ""

; Copy the document contents into the clipboard
while(clipboard == "")
{
	Send ^a^c
}

; Close the Word file
WinClose, %EmailWindow%

; Allow time for window to close
Sleep, 1000

; Return to the email window
winactivate, Message
WinWaitActive, Message

; Insert the clipboard contents
 Send ^v ; %text% ;^v
 
; Remove extra blank lines
send {backspace}{delete 2}

; Position cursor at top of email body\
send, {home}

return
