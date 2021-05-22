; Process BulkMail access request from the IT Connect/Smart IT systems

; Change log is at the end of this file

; ctrl-alt-r for reply with no body. or add it to ctrl-alt-n.
; if ctrl-alt-r, have it invoke ctrl-alt-i automatically.

#SingleInstance force
Menu, Tray, Icon , C:\BulkMail-Paging\Icons\BMU-Red-3.ico
SetTitleMatchMode, 2    ; 1 = start with, 2 = anywhere, 3 = exact match
SetKeyDelay, 20

Set_Variables:

Script_Name = BulkMail Access Request Utility
versioninfo = v2.8.1 (Last updated: 11 December, 2020 by rschnur2)
versioninfoshort = v2.8.1 - 11 Dec, 2020)

; literal variables
comma             := ","
left_parenthesis  := "("
right_parenthesis := ")"
left_bracket      := "<"
right_bracket     := ">"
at_sign           := "@"

true_val := 1
false_val := 0

; Process variables
SIT_WindowCancel = 0
SIT_WindowFound  = 1

SIT_EmailCancel  = 0


; Retrieve INI data and check for required files

if(!FileExist("C:\BulkMail-Paging\BulkMail-Utility.ini"))
{
	MsgBox, 48, %Script_Name% - Error-1, Could not find the required INI file.
	winactivate, Error
}

; Set Email CC value - File name is case sensitive
IniRead, AdminCc, C:\BulkMail-Paging\BulkMail-Utility.ini, EmailAddresses, AdminCC
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

Gosub, ^!h ; Display help window




; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Extract request info
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

^!i::
KeyWait Control
KeyWait Alt

Harvest_Request_Info:

; Find the correct Smart IT window
gosub, FindRequestWindow 

if process = false_val
   {
   msgboxTimeout = 1
   MsgBox, 64, %Script_Name%, Information extraction cancelled., %msgboxTimeout%
   return 
   }

; ------------------------------------------------------------------------------
; Extract the request info for use in other parts of the utility
; ------------------------------------------------------------------------------

BlockInput, MouseMove

Create_working_doc:

; Copy request window contents and paste in Notepad

clipboard := ""

while(clipboard == "")
{
	Send ^a^c           ; Select entire online form and copy into clipboard

    MouseClick, Left, 700, 400          ; So the page highlighting (from the select all) is reset
	Sleep, 100	
}

Run Notepad
WinWaitActive, Notepad
winmove, 0,0

Send ^v        ; Paste
send ^{Home}   ; Go to top

send {ctrl down}{home}{ctrl up} ; Set to start of document

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

Extract_Request_Type:

searchstring = Add elevated access

Send, ^f{backspace}              ; Open find and clear previous string
sleep, 200           
Send, %searchstring%             ; Enter the search string
Send, {Enter}                    ; Start the find
Send, {escape}                   ; Close the dialog

clipboard := ""

Send ^c                         ; clip
clipwait, 1.25                  ; wait time before moving to next command in seconds

;MsgBox, 0, %Script_Name%, Elevated Access clipboard: %clipboard%

if clipboard <>
   {
   ElevatedAccess = y
   ElevatedAccessMsg = YES
   ;MsgBox, 0, %Script_Name%, Elevated access YES: %ElevatedAccess%
   }
else
   {
   ElevatedAccess = n
   ElevatedAccessMsg = NO
   ;MsgBox, 0, %Script_Name%, Elevated access NO: %ElevatedAccess%
   }
   
; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

Extract_WO_Number:

searchstring = WO0000

Send ^f                         ; Open "Find" window
sleep, 200
Send %searchstring%             ; Enter the search string
Send {Enter}                    ; Start the find and positon the cursor at he string
Send {escape}                   ; Close the dialog

clipboard := ""

Send {home}                     ;
Send +{end}                     ; select the rest of the line - + = shift key

Sleep, 200
Send ^c                         ; clip
clipwait, 1.25                     ; 1 is the delay to wait before moving on to the next command.25

StringReplace, clipboard, clipboard, `r`n, , All       ; Remove newline codes
StringReplace, clipboard, clipboard, %A_Tab%,%A_Space% ; Replace tabs with spaces
StringTrimLeft, clipboard, clipboard, 0                ; Remove leading spaces
StringTrimRight, clipboard, clipboard, 0               ; Remove trailing spaces

;MsgBox, 0, %Script_Name%, Clipped: %clipboard%
WorkOrderNumber = %clipboard%                      

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   
Extract_Customer_Name:

; ~~~~~~~~~~~~ Extract customer name

searchstring = Customer

Send ^f{Backspace}              ; Open "Find" window
sleep, 200           
Send %searchstring%             ; Enter the search string
Send {Enter}                    ; Start the find
Send {escape}                   ; Close the dialog

clipboard := ""

Send {right 2} ;3}
Send {shift}+{end}               ; Select the line (the name)
Sleep, 200

Send ^c                         ; copy
clipwait, 1.25                     ; 1 is the delay to wait before moving on to the next command

StringReplace, clipboard, clipboard, `r`n,, A          ; Remove newlines from clipboard
StringReplace, clipboard, clipboard, %A_Tab%,%A_Space% ; Replace tabs with spaces
StringTrimLeft, clipboard, clipboard, 0                ; Remove leading spaces
StringTrimRight, clipboard, clipboard, 0               ; Remove trailing spaces

CustomerName = %clipboard%    

StringGetPos, pos, CustomerName, %A_Space%             ; Get postion of first space
StringLeft, CustomerFirstName, CustomerName, pos       ; Extract customer first name from full name
                     


; ~~~~~~~~~~~~~~~ Extract customer email - search from current position not top of doc

Extract_Customer_Email:

searchstring = @

Send ^f{Backspace}              ; Open "Find" window
sleep, 200           
Send %searchstring%             ; Enter the search string
Send {Enter}                    ; Start the find
Send {escape}                   ; Close the dialog

send {home}
Send {right} ; 3}
send +{end}                     ; Selct the line

Send ^c                         ; Copy

StringReplace, clipboard, clipboard, `r`n,, A          ; Remove newlines from clipboard
StringReplace, clipboard, clipboard, %A_Tab%,%A_Space% ; Replace tabs with spaces
StringTrimLeft, clipboard, clipboard, 0                ; Remove leading spaces
StringTrimRight, clipboard, clipboard, 0               ; Remove trailing spaces

CustomerEmail = %clipboard%

stringlower, CustomerEmail, CustomerEmail


; Reactivate mouse
;BlockInput, MouseMoveOff

; ~~~~~~~~~~~~~~~~ Exit if only sending reply ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;msgbox, 0, %script_name%, Check only_reply: %only_reply%
if only_reply = y
{
msgbox, 0, %script_name%, Only reply selected for customer email: %CustomerEmail%., 2

; Close the file without saving
winactivate, Untitled - Notepad
send {alt down}{f4}{alt up}{right}{enter}

; Reactivate mouse
BlockInput, MouseMoveOff
return
}


; ~~~~~~~~~~~~~~ Extract customer id from email

Extract_Customer_ID:

; Look for @ sign and select everything before it (ID)
StringGetPos, pos, CustomerEmail, @
stringmid, Customer, CustomerEmail, 1, pos

; msgbox, Name:  %CustomerName%`nEmail: %CustomerEmail%`n:   %Customer%

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

Extract_Approver:

searchstring = Approver CDSID:

; Start from last position
Send ^f                         ; Open "Find" window and clear the field
Send {Backspace}                ; Clear the previous fiind string
Send %searchstring%             ; Enter search string
Send {Enter}{escape}            ; Search and close the dialog

Send {right}+{end}              ; Move right 1 pos and select to end of liine 

send ^c                         ; clip

StringReplace, clipboard, clipboard, `r`n,, A          ; Remove newlines from clipboard
StringReplace, clipboard, clipboard, %A_Tab%,%A_Space% ; Replace tabs with spaces
StringTrimLeft, clipboard, clipboard, 0                ; Remove leading spaces
StringTrimRight, clipboard, clipboard, 0               ; Remove trailing spaces

Approver := clipboard
StringTrimLeft, Approver, Approver, 0            ; Remove leading spaces

stringlower, Approver, Approver
StringReplace, Approver, Approver, %A_SPACE%     ; Remove leading spaces

; Extract Approver Name for use if Check Name lookups cause conflicts

Send {right}                                           ; goto next line from Approver 
Send {right}+{end}
Send ^c
StringGetPos, pos1, clipboard, :
stringmid, ApproverName, clipboard, pos1+3

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 
Extract_Comments:

Send ^f{backspace}     ; Open find and clear previous string
Send Comments:         ; Search string
sleep 100
Send {Enter}{escape} ;!{F4}      ; ????? Close?

send {right}           ; Move to next character after the field heading
sleep 100
send +{down 28}        ;Selct the line and the following lines
Sleep 100
send ^c                ; Clip

Comments := clipboard

Comments := RTrim(Comments)  ; strip trailing spaces

; Drop extraneous text
Haystack = %Comments%
Needle := "Show more"
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ if FoundPosMore > 0 or/|| FoundPosLess > 0
FoundPos := InStr(Haystack, Needle)
;MsgBox, 0, %Script_Name%, Comments: %Comments%`nNeedle: %Needle%`nFoundPos: %FoundPos%
If FoundPos > 0
   {
   ;MsgBox, The string was found: position: %FoundPos% .
   CommentsTrimmed := SubStr(Comments, 1, FoundPos)    ; Using % generates bad results
   ;MsgBox, 0, %Script_Name%, Trimmed Comments: %CommentsTrimmed%
   }
Else
   {
   Needle := "Show less"
   ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Also need to check for show less
   FoundPos := InStr(Haystack, Needle)
   ;MsgBox, 0, %Script_Name%, Comments: %Comments%`nNeedle: %Needle%`nFoundPos: %FoundPos%
   If FoundPos > 0
      {
      ;MsgBox, The string was found: position: %FoundPos% .
      CommentsTrimmed := SubStr(Comments, 1, FoundPos)    ; Using % generates bad results
      ;MsgBox, 0, %Script_Name%, Trimmed Comments: %CommentsTrimmed%
      }
   Else
      {
      CommentsTrimmed = %Comments%
      ; MsgBox, The string was not found.
      }
   }   ; Show less
	
CommentsTrimmed := RTrim(CommentsTrimmed)   ; strip trailing spaces


; Close the file without saving
winactivate, Untitled - Notepad
send {alt down}{f4}{alt up}{right}{enter}

; Reactivate mouse
BlockInput, MouseMoveOff

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


Verify_HRLL4:

HRLL4 = N/A

If ElevatedAccess = y
   {
   HRLL4 = %Approver%
   
   ;MsgBox, 0, %Script_Name%, Elevated access requested by %HRLL4%., 1

   ; Opens and positions a new window so - clean slate for better control
   Run, iexplore.exe http://www.sdcds.ford.com/    ; https://www.sd.ford.com/ldap.cgi
   WinActivate, Super Duper                   ; Avoids confusion with data window
   WinWaitActive, Super Duper 

   ;                            x  y                    w                       h 
   WinMove, Super Duper ,  , 0, 0, (A_ScreenWidth * .6), (A_ScreenHeight * .93)

   Send, %HRLL4%
   Send, {enter}
   
   MsgBox, 0, %Script_Name%, Verify that the  has the HR skill team. Click OK to continue., 2
}


; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

Display_Results:

Gosub, ^+i

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Display information about stored IDs and names
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------

^+i::
KeyWait Control
KeyWait Alt

Display_Request_Info:

SetTimer, WinMoveMsgBox, 200

; 262144 is always-on-top
MsgBox, 0, %Script_Name% - Stored IDs,   
(

Work Order:     %WorkOrderNumber%  -  Elevated: %ElevatedAccessMsg%

Customer Name:  %CustomerName%
Customer Email: %CustomerEmail%
Customer :   %Customer%

Approver :   %Approver%
Approver Name:  %ApproverName%
HR LL4 :   %HRLL4%

Comments:`n`n   %CommentsTrimmed%
)


WinMoveMsgBox:

SetTimer, WinMoveMsgBox, OFF
;ifwinexist, Stored ID
;{
;MsgBox, 0, %Script_Name%, Exist
;}
winactivate, Stored ID
WinMove, Stored ID, , 900, 120

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Fill out BulkMail Utility web page to add requested ID as list manager
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------

^!u::
KeyWait Control
KeyWait Alt

Fill_Utility_Form:


; Opens and position a new window so - clean slate for better control
Run, iexplore.exe http://bulkmail.ford.com/~bulkmail/BKUTIL.cgi	
WinActivate, Bulk Mail Utility     ; Avoids confusion with data window
WinWaitActive, Bulk Mail Utility

;                    x  y                     w                       h 
WinMove, Utility,  , 0, 0, (A_ScreenWidth * .6), (A_ScreenHeight * .93)

Sleep, 1000

SetMouseDelay, 80

; Open add managers option
; The following mouse positions assume the menu bar is off and the bookmark bar and the webex bar are on
; mousemove, 46, 196    ; add button
mouseclick, Left, 48, 210       ; 24 inch monitor = 196  21 inch = 182
mouseclick, Left, 229, 252      ; 24 inch monitor = 245 21 inch = 225
mousemove, 300, 310             ; 24 inch monitor = 310 21 inch = 296 ;  NewID field
mouseclick

sleep, 600

gosub, ^+u

return

^+u::

; Enter customer  and then approver  into the form
send %Customer%
send {tab}
send %Approver%

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Process invalid request - email
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------

^!n::
KeyWait Control
KeyWait Alt

Process_Invalid_Request:

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Get rejection reason
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

InvalidHRBasic = 0   
InvalidApprover = 0
InvalidApproverHR = 0
AlreadyAuth = 0
InvalidCustomer = 0
NoApprover = 0

Gui, font, s10, Verdana bold

Gui, Add, GroupBox, w250 r5 border, Select Rejection Action

Gui, font, s10, Verdana

Gui, Add, Radio,  x22 y35   vInvalidApprover checked, Invalid Approver
Gui, Add, Radio,  x22 yp+22 vInvalidApproverHR,       Invalid Approver - HR Access
; Gui, Add, Radio,  x22 yp+22 vNoApprover,              Invalid Approver - None Present
Gui, Add, Radio,  x22 yp+22 vAlreadyAuth,             Already List Manager
Gui, Add, Radio,  x22 yp+22 vInvalidCustomer,         Invalid  ID
Gui, Add, Radio,  x22 yp+22 vInComments,            ID in comments

Gui, font, s10, Verdana bold

Gui, Add, Button, x10   yp+34 w80 h25 default, Ok
Gui, Add, Button, xp+90 yp  w80 h25,         Cancel

Gui, Show, x400 y200 autosize, %Script_Name%

WinActivate, Select Reject Action
Return

GuiEscape:
Gui, Destroy
return

GuiClose:
gui, Destroy
return

ButtonCancel:
gui, Destroy
exit

buttonOk:
Gui, Cancel
Gui, submit, NoHide
Gui, destroy


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build and send the email
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

gosub, Setup_SIT_Email

winactivate, Stored ID

if SIT_EmailStatus = SIT_EmailCancel
   return

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BlockInput, MouseMove
   
WinActivate, Untitled
WinMove, Untitled,, 0, 0, (A_ScreenWidth/2), (A_ScreenHeight * .93)

gosub, set_email_addresses ; Fill out To and Cc fields

Sleep, 200

; Insert subject
If ElevatedAccess = n
   ControlSetText, RichEdit20WPT5, Work Order %WorkOrderNumber% - BulkMail Access Request
else
   ControlSetText, RichEdit20WPT5, Work Order %WorkOrderNumber% - BulkMail Access Request - Elevated Access

gosub, buildemailgreeting

inserttype = email

gosub, InsertRejectionText

send, {delete} ; remove extraneous line after insert


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BlockInput, MouseMoveOff

 
return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Process vaild request - email
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------

^!y::
KeyWait Control
KeyWait Alt

Process_Valid_Request:

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Complete the email notification
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

gosub, Setup_SIT_Email

if SIT_EmailStatus = SIT_EmailCancel
   {
   msgbox, 0, %Script_Name%, Cancel process code returned from email setup routine., %timeout_seconds%
   return
   }


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BlockInput, MouseMove

   
winactivate, Stored ID

WinActivate, Untitled - Message  ; Window titles are case sensitive
WinMove, Untitled, , 0, 0, (A_ScreenWidth/2), (A_ScreenHeight * .93)
   
gosub, set_email_addresses  ; Fill out To and Cc fields

Sleep, 200

; Insert subject
If ElevatedAccess = n
   ControlSetText, RichEdit20WPT5, Work Order %WorkOrderNumber% - BulkMail Access Request
else
   ControlSetText, RichEdit20WPT5, Work Order %WorkOrderNumber% - BulkMail Access Request - Elevated Access
	  
gosub, buildemailgreeting
   
; Insert body text from Word file
EmailBodyDoc       = %UtilityDocFolder%\BulkmailAdd.docx
EmailWordWindow    = BulkmailAdd.docx

gosub, InsertWordDoc
 
; Cleanup after the insert
send, {backspace} {delete}    ; Remove extra blank lines

send, {ctrl down}             ; Position cursor at top of email body
send, {home}
send, {ctrl up}

Sleep, 800

winactivate, Stored ID                        ; Bring info display window to the front

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BlockInput, MouseMoveOff

winactivate, Work Order WO00000                  ; Switch focus to the WO email

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Format an email for Exchange email trace
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------

^!x::
KeyWait Control
KeyWait Alt

Format_Trace_Email:

gosub, FindJobWindow

if process = true_val
  gosub, Extract_Job_Info

  
; Switch to Outlook window
ifwinexist Outlook
   WinActivate, Outlook
else
   {
   timeout_seconds = 4
   msgbox, 0, %Script_Name%, Outlook is not running!, %timeout_seconds%
   return
   }
 
; Get incident number - it is best to copy before starting.

; Check if incident # is already in clipboard   
Incident_Nbr = %clipboard%

Needle = INC
StringGetPos, pos, Incident_Nbr, %Needle%

if pos != 1 ; Not found
   Incident_Nbr = 
 
; Ask for input  
 
InputPrompt1 =
(
`nCopy the incident number to be used in the email subject from the incident form or email and paste it into the field below or leave the field blank to use "No user request/incident". 
`nNote: If the number si copied before starting this process the tool will paste it into the input field.
`nClick OK to create the trace email or Cancel to cancel the process.
)

;                                                           w    h   x  y Font Time  Default
InputBox, Incident_nbr, %Script_Name%, %InputPrompt1%, NOHIDE,  420, 280,  ,  ,    ,    , %Incident_Nbr%

if ErrorLevel
   {
   MsgBox, 0, %Script_Name%, Cancel process., 2
   return
   }

WinActivate, Outlook
   
; Open new email and set focus to it
Send ^+m
WinWaitActive, Untitled - Message

; Position message for better reading
WinMove, Untitled - Message,, 0, 0, (A_ScreenWidth/2), (A_ScreenHeight * .93)
	
; Fill To field
send exchadm@ford.com

sleep, 240

; Fill Subject
if Incident_Nbr =
   ControlSetText, RichEdit20WPT5, BulkMail Email Delivery Trace - No User Request/Incident
else
   ControlSetText, RichEdit20WPT5, BulkMail Email Delivery Trace - Request/Incident %incident_nbr%

; Skip to email body
ControlFocus, _WwG1

; Build email body. If distribution statistics window was used then the timestamp and subjejct will be from that page.
Send, Please trace the specified email for the follwing user(s): `n`nSent by: `n`n`User(s): `nTimestamp: %Job_Timestamp%`nSubject: %Job_Subject%`nFrom: 

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Create email for blocked address
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

^!b::
KeyWait Control
KeyWait Alt

Format_Blocked_Email:

; BulkMail email for xxx - GUI button 1
EmailTo         := "x"
AdminCC         := adminCC                                                   ; variable must not have percent sign for following usage to work
EmailSubject     = List blocked from sending bulkmail emails due to excessive activity
EmailBodyDoc    := "C:\bulkmail-paging\Documents\BulkMailEmailFloodBlock.docx"
EmailWordWindow  = BulkMailEmailFloodBlock.docx

sleep, 1000 ; Prevents "Holding Down Control" Key error when starting word

; Check for Outlook here?
	
gosub Build_New_email

; msgbox, 0, Title, After Create block email

; Insert the word document for the selected reason. Document name is set from the calling routine
gosub, InsertWordDoc
 
; Remove extra blank lines between the end of inserted text and the signature
send, {backspace} {delete}

; Position cursor at top of email body
send, {ctrl down}
send, {home}
send, {ctrl up}

return

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Create email reply using form customer address
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

^!s::
KeyWait Control
KeyWait Alt

Create_Email_Reply:

;msgbox, 0, %script_name%, Enter send reply,1

only_reply = y

; get the form info
Gosub, ^!i

only_reply = n
	
gosub Setup_SIT_Email

winactivate, Untitled
WinWaitActive, Untitled

;msgbox, 0, %script_name%, Before email addresses: %CustomerEmail%, 3

; Build Email "To" Address - was WPT1 before o365
ControlSetText, RichEdit20WPT2, %CustomerEmail%, A

sleep, 300

; Build Email "CC" address
ControlSetText, RichEdit20WPT3, %adminCC%, A

sleep, 200

; Check names - this will check all names
send !K

; Insert subject
ControlSetText, RichEdit20WPT5, Work Order %WorkOrderNumber% - BulkMail Request

; Position cursor at top of email body
ControlFocus, _WwG1

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Display the hotkeys that this script contains. Each row is 20 clicks high.
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------

^!h::
KeyWait Control
KeyWait Alt

Display_Help_Info:

list1= ; Core Tasks
(
~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ctrl-alt-i|Extract info from form
ctrl-alt-u|Open utility page and fill fields
ctrl-alt-y|Process successful completion email
ctrl-alt-n|Process unsuccessful completion
ctrl-alt-s|Build subscribe/un-subscribe email response
ctrl-alt-x|Build email for Exchange trace request
ctrl-alt-b|Build blocked email notification
)

list2= ; Other Tasks
(
~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ctrl-alt-c|Insert cc admin addresses
ctrl-shift-i|Display stored  values
ctrl-alt-h|Display this help window
ctrl-shift-y|Insert valid text to SmartIT WO
ctrl-shift-n|Insert invalid text to SmartIT WO
ctrl-shift-u|Insert  info into utility form
ctrl-shift-b|Insert "Basic Access" message at cursor
ctrl-shift-c|Insert Insert Customer  at cursor
ctrl-alt-m|Insert Comments at cursor
ctrl-shift-w|Insert Work Order # at cursor
)

; Part 1 header - Main Keys
Gui, Font, Arial s12 cBlue bold underline
Gui, Add, Text, x8 y15, Core

; Reset font values to default
Gui, Font, Verdana s10 cBlack norm

; Build part 1 list view field  - each row is 20 clicks high
Gui, Add, Listview, x8 y44 r8 w420 Grid NoSortHdr, Key                         |Function ; Spaces set column widths
Loop, Parse, list1, `n, `r
	{
	 StringSplit, data, A_LoopField, | ; just an example
	 LV_Add("", data1, data2)
	 LV_ModifyCol(1,"AutoHdr")
	 LV_ModifyCol(2,"AutoHdr")
	}

; Part 2 header - Support Keys
Gui, Font, Verdana s12 cGreen bold underline
Gui, Add, Text, x8 y245, Support ; +50 for each row above

; Reset font values to default
Gui, Font, Verdana s10 cBlack w400 norm

; Build part 2 list view field - each row is 20 clicks high - change w & y
Gui, Add, Listview, x8 y275 r11 w420 Grid NoSortHdr, Key                        |Function ; Spaces set column widths + 25 for each row added to sectoin above
Loop, Parse, list2, `n, `r
	{
	 StringSplit, data, A_LoopField, | ; just an example
	 LV_Add("", data1, data2)
	 LV_ModifyCol(1,"AutoHdr")
	 LV_ModifyCol(2,"AutoHdr")
	}

; Footer
; Not specifying a Y value allows AHK to automatically position the text relative to the prior elements..
Gui, Font, Verdana s12 cBlack bold underline
Gui, Add, Text, x8, Press the Escape key to exit this window
Gui, Font, Verdana s8 cBlack norm
gui add, text, x8, Version: %versioninfo%

; Display GUI
Gui, Show, x350 y60 AutoSize, BulkMail Utility Shortcut Keys ; Autosize = variable height and width based on content.
Return

GuiEscape2:
Gui, Destroy
return

GuiClose2:
gui, Destroy

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Insert admin addresses in CC
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
	
^!c::
KeyWait Control
KeyWait Alt

Inset_Admin_Email:Addresses:

; Build Email "CC" address - "'
;MsgBox, 0, %Script_Name%, Insert AdminCC addresses %AdminCC%, 2
ControlSetText, RichEdit20WPT3, %AdminCC%, A      ; A is window title, A means current window

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Process valid request - Work Order web form
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
	
^+y::
KeyWait Control
KeyWait Shift

Insert_Valid_Response_Into_Form:

SetKeyDelay, 6

Send BulkMail found a valid LL4{+} approval manager. This request is valid and was processed.

Sleep, 100

;Send, {tab}{enter}

Send, {tab 5}

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Process invalid request - Work Order web form
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
	
^+n::
KeyWait Control
KeyWait Shift

Insert_Invalid_Response_Into_Form:

inserttype = form
timeout_seconds = 2
msgbox, 0, %Script_Name%, Make sure the cursor is focused in the reason box., %timeout_seconds%

gosub, InsertRejectionText

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Process elevated access granted basic access only
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
	
^+b::
KeyWait Control
KeyWait Shift

Insert_Basic_Access_Only_Into_Form:

inserttype = form
InvalidHRBasic = 1
timeout_seconds = 2
msgbox, 0, %Script_Name%, Make sure the cursor is in the reason box., %timeout_seconds%

gosub, InsertRejectionText

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Insert customer  at cursor
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
	
^+c::
KeyWait Control
KeyWait Shift

Insert_Customer_CDS:

Send, %Customer%

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Insert Work Order #
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
	
^+w::
KeyWait Control
KeyWait Shift

Insert_Work_Order_Number:

Send, %WorkOrderNumber%

return


; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; Insert Comments
; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
	
^!m::
KeyWait Control
KeyWait Shift

Inseet_Comments:

Send, %CommentsTrimmed%

return


   
; \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/   
; \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/   
;                                S u b r o u t i n e s
; \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/   
; \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/      


FindRequestWindow:

msgbox, 0, %Script_Name%, find-request-window, 1

; duplicate tabs are not the same as windows and are unavaialble without extra addons

setkeydelay, 60
process = false_val

loop    ; loop continuously until an action forces an exit from it
{
; Window was opened from the received email
IfWinExist, Smart IT Universal Client
   {
   ; msgbox, Window found, 2

   WinActivate, Smart IT Universal Client
   
   Mouseclick, Left, 500, 500   

   clipboard := ""
   
   ; Determine if it is a request window
   Send, ^f{backspace}   ; Open find
   Sleep, 200
   Send, WO0000          ; Search 
   Sleep, 200
   Send, {Enter}         ; Exec the search  
   Sleep, 200
   Send {escape}         ; close find
   Send ^c               ; Copy found text to clipboard
   
   ; sleep, 600 ; delay while clipboard is populated
   
   clipwait, 3
   
   if clipboard = 
      {
      msgbox, 52, %Script_Name% - Error-3, Open window does not appear to be a Work Order. `nLooking for Workorder in window body. Found: "%clipboard%".`n`nClick Yes to try again or No to cancel this step.
	  
	  ; Check for http?
	  
	  ifmsgbox, no
         {
	     break
	     }
	  else
	     {
	     continue
	     }
	  } ; if clipboard
   else
      {
	  ; msgbox, Right window.
      process = true_val
      break ; exit the loop to continue on to the next process
      }
   }
else
   {
   MsgBox, 51, %Script_Name% - Error-4, No Smart IT window found. `n`nProceed?`n`nSelect a window and click yes to continue, `nClick no to skip this step and go to the email step, `nClick cancel to stop processing this request.
   winactivate, Error
   ifmsgbox, yes
      continue   ; start over
      ifmsgbox, no
	     {
		 process = true_val
		 break ; exit the loop so the process can go on to the email process
		 }
 	  ifmsgbox, cancel
	     exit   ; exit the process for this request
   }
}

return


FindJobWindow:

process = false_val

loop    ; loop continuously until an action forces an exit from it
   {
   IfWinExist, View Distribution Statistics
      {
      WinActivate, View Distribution Statistics
      process = true_val
      break
      }
   else
      {
      MsgBox, 51, %Script_Name% - Error-5, No distribution statistics window found. `n`nOpen a window and click yes to retry.`nClick no to skip this step and go to the email step.`nClick cancel to stop processing this request.
      winactivate, Error

      ifmsgbox, yes
         continue   ; start over
		 
      ifmsgbox, no
         {
		 process = true_false
		 break ; exit the loop so the process can go on to the email process
		 }
		 
 	  ifmsgbox, cancel
	     exit   ; exit the process for this request
      } ; else
} ; loop

; msgbox, ,,Process Value: %process%

return

Extract_Job_Info:

clipboard := ""


; Transfer window info to notepad

while(clipboard == "")
{
	Send ^a^c           ; Select entire online form and copy into clipboard
	MouseMove, 700, 400 ; Out of the way
	Sleep, 100
    MouseClick          ; So the page highlighting (from the select all) is reset
	Sleep, 100	
}

Run Notepad
WinWaitActive, Notepad
winmove, 0,0

Send ^v        ; Paste
send ^{Home}   ; Go to top

send {ctrl down}{home}{ctrl up} ; Set to start of document


; Find and extract subject

searchstring = Subject

Send ^f                         ; Open "Find" window
sleep, 200           
Send %searchstring%             ; Enter the search string
Send {Enter}                    ; Start the find
Send {escape}                   ; Close the dialog

clipboard := ""                 ; Clear clipboard

Send {right}+{end}              ; Move cursor past search string and select the line (the subject)
Send ^c                         ; clip
clipwait, 1

StringReplace, clipboard, clipboard, `r`n,, A      ; Remove newlines from clipboard
Job_Subject = %clipboard%                          ; Remove excess spaces and tabs


; Extract timestamp - search starts at last positon (not the start of the document)

searchstring = Transmission Completed:

Send ^f                         ; Open "Find" window and clear the field
Send {Backspace}                ; Clear the previous fiind string
Send %searchstring%             ; Enter search string
Send {Enter}{escape}            ; Search and close the dialog

Send {right}+{end}              ; Move right 1 pos and select to end of liine 
Send ^c                         ; clip
clipwait, 1

StringReplace, clipboard, clipboard, `r`n,, A      ; Remove newlines from clipboard
Job_Timestamp = %clipboard%                          ; Remove excess spaces and tabs


; msgbox, 0, %Script_Name%, Subject: %Job_Subject%`nTimestamp: %Job_Timestamp%

; Close the notepad window

winactivate, Untitled - Notepad
send {alt down}{f4}{alt up}{right}{enter}

return


; ##############################################################################
; ##############################################################################
; Initiate the response email
; ##############################################################################
; ##############################################################################

Setup_SIT_Email:

; Make sure the inbox is the focus
loop
{
IfWinExist, Inbox ahk_exe outlook.exe
   {
   WinActivate Inbox
   winwaitactive, Inbox, , 2
   WinMove, FW,, 0, 0, (A_ScreenWidth/2), (A_ScreenHeight * .93)
   break
   }
else
   {
   msgbox, 48, %Script_Name%, Outlook is not in the InBox. Switch to the InBox and click OK to proceed., 4
   }
}

; Initiate the email
Send ^+m     ; ^+m = new email

WinWaitActive, Untitled - Message                          ; Window titles are case sensitive
WinMove, Untitled - Message,, 0, 0, (A_ScreenWidth/2), (A_ScreenHeight * .93)

return


; ##############################################################################
; ##############################################################################
; Set up the address fields in the email
; ##############################################################################
; ##############################################################################

set_email_addresses:

; Build Email "To" Address - was WPT1 before o365
ControlSetText, RichEdit20WPT2, %Customer%, A

sleep, 500

; Build Email "CC" address - "';" below between the variable names inserts a literal ; into the string
ControlSetText, RichEdit20WPT3, %Approver%`; %adminCC%, A

; Check names - this will check all names
send !K

;Sleep, 400

; Name check does a wildcard search leading to the possibility of multiple address entries being candidates. 
; The following loop pauses the script so the user can work in Outlook to resolve any issues. 
; The script remains paused the user clicks the yes button in the dialog window to resume the script. 
;loop
;{
;   msgbox, 36, %Script_Name% - Question, Have all of the email addresses been resolved?
;   winactivate, email addresses been resolved
;   ifmsgbox, yes
;      {
	  ; Pass focus to the email body field and return
	  curField = "_WwG1"
	  ControlFocus, curField, A
;	  sleep, 200
;      break
;	  }
;   else
;      continue
;}

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build and insert email greeting
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

buildemailgreeting:

; msgbox,0,,Start buildingemailgreeting

; Advance to message body from cc:
winactivate, Message
WinWaitActive, Message
Send {TAB 3}{Backspace}
Sleep, 400

; Insert the 
Send Hello{space}%CustomerFirstName%{enter 2}

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Insert the rejection text. This routine is used for building the email and completing the request
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

InsertRejectionText:

SetKeyDelay, 6

If (InvalidHRBasic = 1) 
{
   Send A valid LL4+ approver was found. Basic list manager access was granted. `n`n
   Send However, in order to grant BulkMail elevated access authority, the approver must be a LL4+ from the HR skill team.`n`n
   Send The approver id in the request, %Approver%, does not meet this requirement. Therefore, elevated privileges could not be granted to the requested id.`n`n
   Send If this elevated authority is needed, a new Elevated Access request will be needed - with an approver from the HR skill team.
   return
}

; Send selected error text  - 0 = unchecked, 1 = checked
If (InvalidApprover = 1) 
{
   Send BulkMail list manager access requires the approver be LL4 or higher.`n`n
   Send The approver specified in the request, %Approver%, does not meet this requirement. Therefore, list manager access could not be granted to the requested id.
   if inserttype = email ; Using percent signs around variables or quotes around value will break this statement
      {
      Send `n`n
      Send This request will be marked as rejected and a new request will be needed that has a valid LL4+ ID.`n`n
      Send We must do it this way due to audit requirements. We apologize for the inconvenience.
      }
   Return
}

If (InvalidApproverHR = 1) 
{
   Send BulkMail elevated access authority requires the approver be a LL4+ and from the HR skill team (HRS).`n`n
   Send The approver id in the request, %Approver%, does not meet both of these requirements. Therefore, elevated access privleges could not be granted for the requested id.
   if inserttype = email ; Using percent signs around variables or quotes around value will break this statement
      {
      Send `n`n
      Send This request will be marked as rejected and a new request will be needed with a LL4+ id that is in the HR skill team. `n`n
      Send We apologize for the inconvenience, but we must do this due to audit requirements.
      }
   Return
}

/*
If (NoApprover = 1) 
{
   Send The request did not have an approver.`n`n 
   Send This is a known issue with the tool.`n`n
   Send When completing the form please make sure to click the displayed approver name when entering the in the field or the name will not be passed to us.

   if inserttype = email ; Using percent signs around variables or quotes around value will break this statement
      {
      Send `n`n
      Send This request will be marked as rejected and a new request will have to be submitted with a valid approver. `n`n
      Send We apologize for the inconvenience, but we must do this due to audit requirements.
      }
   Return
}
*/

If (AlreadyAuth = 1) 
{
   Send %Customer% is already authorized as a Bulk Mail List manager. No action was necessary.
   Return
}
   
If (InvalidCustomer = 1) 
{
  Send The requested ID is invalid so cannot be added to BulkMail.
  Sleep, 100
  Send {enter 2}
  Sleep, 100
  Send This request will be marked as rejected and a new request will need to be submitted with a valid ID.
  Sleep, 100
  Return
}
   
If (InComments = 1) 
{
  Send We are not allowed to process access requests for ids entered in the comments. All requests must specify the requested ID as the customer.`n`n
  Send The job aid "Submit a BulkMail Access Request" on the help site shows how to submit a request for someone else.
  if inserttype = email ; Using percent signs around variables or quotes around value will break this statement
      {
      Send `n`n
      Send This request will be marked as rejected and a new request will need to be submitted with a valid LL4+ as the approver. `n`n
      Send We apologize for the inconvenience, but we must do this due to audit requirements.

      }
  Return
}

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Build_New_email:

timeout_seconds = 4 ; seconds

; Switch to Outlook Inbox and create a new email. 
ifwinexist Outlook
   {
   WinActivate, Outlook
   WinWaitActive, Outlook, ,%timeout_seconds%
   }
else
   {
   msgbox, 0, %Script_Name%, Outlook is not running! Cancelling the process.
   return
   }

Send ^+m     ; ^+m = new email.
WinWaitActive, Untitled - Message  ; Window titles are case sensitive

; Position message for better reading
WinWaitActive, Untitled - Message
WinMove, Untitled - Message,, 0, 0, (A_ScreenWidth/2), (A_ScreenHeight * .93)

; Build Email "To" Address - x means no value.  Cursor is positioned in the To: field by default when email is initiated.
if EmailTo != x
   ControlSetText, RichEdit20WPT2, %EmailTo%, A

; Build Email "CC" address - x means no value
if AdminCC != x
   ControlSetText, RichEdit20WPT3, %AdminCC%

; Check names - x means no value
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
      msgbox, 36, %Script_Name%, Have all of the email addresses been resolved?
      winactivate, email addresses been resolved
      ifmsgbox, yes
         break
      else
         continue
   } ; loop
   } ; if

; Insert email subject - variable value is provided in the calling routine.
ControlSetText, RichEdit20WPT5, %EmailSubject%

; Set focus for body - if done after the document process, this command does nothing and the insert is in the wrong field.
ControlFocus, _WwG1

return


; ------------------------------------------------------------------------------
; Insert a word document into the body of the focused email
; ------------------------------------------------------------------------------

InsertWordDoc:

; Open Word document
Run, %EmailBodyDoc%
WinActivate, %EmailWordWindow%
WinWaitActive, %EmailWordWindow%

Sleep, 1400 ; Prevents "Holding Down Control Key" error when starting word

; Clear the clipboard
clipboard := ""

; Insert the Word doc into the clipboard
while(clipboard == "")
{
	Send ^a^c
	Sleep, 200
}

; Close the Word file
WinClose, %EmailWordWindow%

; Allow time for window to close
Sleep, 5000

; Return to the email window
winactivate, Work Order
WinWaitActive, Work Order

Sleep, 1000

; Insert the document
 Send ^v 

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Change log
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; v1.0.6  - removed copy to W drive, 
;           fixed mouse positioning error on utility form completion, 
;           fixed timing on email formatting for approved request to eliminate false errors
; v1.0.7  - modified form harvest to click mouse to reset select-all command, 
;           modified rejected request text for better readability
; v1.0.9  - modified Word command to use variable instead of hardcoded file
; v1.0.10 - adjsuting sleep settings on  extract to eliminate timing failures
; v1.0.11 - made several hardcoded elements (files anmes, change level) into parmeters for easier management
; v1.0.12 - additional sleep between Y  process and word doc insertion, commonize dialog titles; fix missing file error
; v1.0.13 - Reworked display of  fields to match order on the RC form; 
;           Added sleep after 'gosub copy' in ^!i loop to eliminate extraction problems; 
;           Documented copy loop code
;           Add statemnt to reinitialize the  field so repeating ^!i works correctly.
; v1.0.14 - Moved initial email building code from the "fvill" routine to the main ctrl-alt routine to better work with prompt 
;           about email addresses being resolved. Fill was mixed purposes. Now it is strictly email address code.
; v1.1.0  - Merged the ctrl-alt-y/n and ctrl-shift-y/n code
; v1.1.1  - Removed obsolete code
; v1.1.2  - Converted greeting to sub routine so it can be used in both yes and no responses
;           removed ctrl-alt-a since it is now in the revised ctrl-alt-y/n
; v1.1.3  - adjsuted code for email address building and renamed a couple of routines to better reflect their purpose
;           added winmove for message positioning for better reading
;           fixed email selecton function. waiting for window that user does not know needs opening. error was after action instead of before
; v1.1.4  - fixed some workflow issues with seelcting the request email and adjusted some code to make it more readable
; v1.1.5  - enhanced ^!r function to fill cc and allow retry within the function rather than exit
; v1.1.6  - add functionality to handle request tickets from the email or opened in the queue
; v1.1.7  - added "additioanl details" to capture and display routine and added winmove to better position notepad window for issue with multiple monitors
; v1.1.8  - fixed error in Request Center form for invalid request (was not selecting "no" and fixed selection for invalid request gui to have a default
; v1.1.9  - fixed email cc build - if ll4 and hr ll4 are the same do not send twice
; v1.1.10 - standardized window titles and added winactivate commands after each msgbox so they don't get buried behind active windows
; v1.1.11 - fixed error where invalid request routine does not select "no" for Is this a vilid request text field
; v1.1.12 - Fixes for Office 2013
; v1.1.13 - Added ctrl-alt-s for subscribe/unsubscribe feature
; v1.1.14 - Converted file locaitons to variable from INI file to help if W: drive is unavailable
; v1.1.15 - Fixed yet another issue with Outlook window selection on y/n process and fixed utility page issue with hr ll4 tabs, 
;           Fixed using wrong command for switching focus to email bodxy on y/n
;           Fixed issue where if the cursor is in the fulfillemnt field the select/copy selects the fulfillemnt text instead of the requests page contnet
; v1.1.16   Reworked the subscription management option
; v1.1.17   Allow skipping of RC record if the request is not opened in IE
; v1.1.18   Fixed a defect in the  extraction process. Basically rewrote the process
;           to simplify it and make it more readable
; v1.1.19   Tweaked the invalid LL4+ rejction email text.
; v1.1.20   Added a sleep after the email resolution to give time to switch to message body. 
;           This attempts to resolve the issue where the focus occasionally stays in the cc field and the guidelines are mistakenly inserted there.
; v1.1.21   Fixed  extract routine to adapt to changes in Request Center form formatting. Also adjsuted the invalid LL4 approve email text for readability.
; v1.1.22   Removed the decision to clear the variables in ctrl-alt-i. It will always be done.
; v1.1.22   Fix error in ctrl-alt-i where requested for extract did not allow for three component names
; v1.1.23   rewote the  extract routines to not count on how the text is formatted but rather using keywords that will not change unless the form is reworked.
;           Modified extracting additional details to grab more lines
;           reworked ctrl-alt-u to process revised  extract processing
;           removed name harvesting and removed code from greeting to insert names.
;           removed all uses of req array
; v1.1.24   Added code to process co-owner 5 (lost in prior changes)
;           Increased some delays to compensate for missing data 
; v1.1.25   Change the file location name. was bulkmail-utility and is not bulkmail-paging to refelct
;           the addition of some paging utility scripts to the folder
; v1.1.26   Updated the message tesxts for some of the declined request options.
; v1.2.0    Major rework of email response processes. Put name extraction back in.
; v1.2.1    Fixed problem with  variables not being cleared when multiple requests processed
;           Fixed issues with not having "and" in the greeting for the last name
; v1.3.0    Added code to look up hr ll4  id to aid in verification
; v1.3.1    Modified To to CC transition for email addresses. Having all list manager fields present causes timing errors.
; v1.3.2    Modified HR LL4 logic to remove find skill team. Can't get the timing right.
; v1.4.0    Modify to use revised RC form texts. Script determines which form was used and adapts to it.
; v1.4.1    Modified the additional details extraction to not collect the trailing comments text.
; v1.4.2    Fix subscribe/unsubscribe process. Window name for subscribe was wrong.
;           Force action window for invalid request to top of windows. was being hidden in some cases.
; v1.4.3    Fix error where  4 names were not being cleared. Cleared names 3 twice.
; v1.5.0    Fixed logic structure in sub/unsub routine. stopped responding with no message.
; v1.6.0    Added function to build email for Exchange email trace.
;           Realigned some code and removed extra code in SvD categorization routine.
;           Updated help window to include ctrl-alt-x
; v1.6.1    Minor changes to the Exchange trace request email.
; v2.0.0    Upgrade all processes to wotk with Smart IT version of form and removed numerous obsolete functions,
; v2.1.0    Improved Exchange trace request process
; v2.1.1    Updated invalid LL4 text to be clearer and more complete
; v2.2.0    Add code to build/send blocked address email
;           Added a separate routine for inserting word documents into the email body that can be used by other functions in the script.
;           Fix customer email extract to allow for content differences between IE and Chrome
;           Modified IE utility function to use mouse clicks rather than tabbing. Tabbing stopped working. It appears to be due
;             to a delay where the WSL screen displays.
; v2.2.1    Modified the insert rejection text function to insert different amounts of text depending on email or form
; v2.3.0    Removed code for Service Desk tool from email form lookup
;           Added code for processing where no SmartIT email was received.
;           Removed extraneous code from blocked address email function 
;           Improvements to "build new email" functions (variable names, code placement)
;           Cleanup of many variable names to help readability
;           increased cliwait delay to 2 seconds. Add delay to copy step in info form extract routine to allow clipboard to be filled with form content.
;           Updated Window Not Found error message be more descriptive and accurate
;           Fixed extract routine to skip extract if no window is found and user cancels the process
; v2.3.1    Cleanup extract routine to be consisitent for all fields for removing extraneous characters
;           Made extensice modification to Valid/Invalid routines to process missing emails inline rather than the ctr-alt-e temporary routine (removed its reference from help menu)
;           The routines now handle all conditions in the respective routine.
;           More variable name cleanup for clarity
;           Updated the ctrl-alt-u mouse clicks to new values
;           Changed name extraction to create first name field and changed greeting function to use first name
; v2.3.2    Increased the delay for pasting the word doc into the email.
;           The form content text changed so name is no longer on the same line as the literal
;           Strip leading spaces from LL4 
;           Changed the default button to No on the message about not finding an email. In most cases there will be no email so
;           "no" makes more sense. You can just hit the enter key rather than having to use the mouse.
; v2.3.3    Addded code to extract approver name to help with address resolution conflicts. The info display can be used rather than go back to the Word
;           Fixed issue with leading space on approver  not being removed.
; v2.3.4    Modified display of msgbox that displays captured info to be moved out of way of email. Both windows are now clearly visible.
;           Fixed error in Exchange trace routine that had wrong window name on winmove command
;           Added winactivate commands to y/n routines for stored info msgbox. It sometimes gets hidden in the copy/paste process.
; v2.3.5    Fixed issue with utility step not clicking in the right place - separated inserting info to separate key sequence so can be done manually if needed
;           Fixed issues with inserting info into email addresses on successfull process. wrong window title was used.
;           Updated help display to include new key sequence
;           Modified the rejection text to state we are updating the form.
;           Made the IE utility window (ctrl-alt-u) narrower so it does not hide the info display window.
;           The Outlook field names for To, From, and Subject (wptx) chaanged with install of O365. They are now one number higher than before.
;           Removed rejection reference to old for in Request Center now that new form is implemented.
;           Added tab-enter to ctrl-shift-y to automatically submit the completion
;           Fixed rejection text
; v2.4.0    Upgrade rejection Gui
;           Remove check for open email. Always build email from scratch.
;           Add functions for elevated authority check for HR LL4
;           Revised email process casuued the email window name to change. Fixed insert word doc routine to use new window name.
;           Added new rejection option for elevated access request 
; v2.5.0    Added ctrl-alt-c code. It was in the help, but had never been added to the script.
;           Added code for elevated access request that only granted basic access due to approver not being HR.
;           Added tray icon command.
;           Changed successful subject to reflect basic versus elevated requests
;           Update help list views using new language ideas (autohdr, ...)
;           Fix errors where rejection switches are not being reset after each use.
; v2.5.1    Add BlockInput commands to prevent exiting the process at critical points where keyboarding is simulated
; v2.6.0    Added command for inserting work order at cursor, inserting comments at cursor, selecting comments better.
;           Changed hotkeys for displaying extracted info and inserting comments. The old settings conflicted with Windows/Outlook standard hot key definitions,
; v2.6.1    Added  in comments rejection reason, added code to check comments for show less (comments were opened)
;           Added rejection reason - no approver.
;           Minor change to SmartIT format (requester  moved 2 positions left); Corrected spelling for rejection message.
; v2.7.1    Various minor fixes to spelling, wording, and form formatting (Smart IT changes). Removed all references to CDS since it will be elimianted.
; v2.8.0    Removed HR LL4 lookup. It no longer works.
; v2.8.1    Disabled "no approver" since that issue was fixed. Updated some wording on rejections.