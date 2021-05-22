SetTitleMatchMode, 2 ; "Window Title Text" can be anywhere in the title

emailaddress:

; Fill reqName array with names of those in reqCDS array foruse in the greeting
; Paste each cdsid into the To field then invoke the check name function to 
; expand it then extract the names into the array
; If there are similar names then the contact selection Outlook box will popup; This 
; potential is why the msgbox asking if the emails are resolved was added.

comma := ","
left_parenthesis := "("
right_parenthesis := ")"
left_bracket := "<"
right_bracket := ">"
at_sign := "@"
true_val := 1
false_val := 0

reqcds0 = 2
reqcds1 = rschnur2
reqcds2 = mconmack
;reqcds3 = pmcgraw
;reqcds4 = jmalaney

msgbox, 0,,Open an email for use and place cursor in To field.

Loop, %reqCDS0%
{
	this_CDS := reqCDS%A_Index%
	; msgbox, 0,,CDS: %this_CDS%
	Send %this_CDS%!k ; !k invokes Outlook's check name places the cdsid's full name in the to field
	Sleep, 100
	WinWaitActive, Message ; In case "Check Name" dialog appears

	clipboard := ""

; Extract the name values
	while(clipboard == "")
	{
		Send ^a^c ; Copies their full name in this form: Last, First (F.L.)
		Sleep, 100	
	}
	
	msgbox, 0,,%clipboard%
;	StringReplace, clipboard, clipboard, %left_bracket%, %left_parent%, All
;	StringReplace, clipboard, clipboard, %right_bracket%, %right_parent%, All
;	StringReplace, clipboard, clipboard, %at_sign%, %comma%, All
;	msgbox, 0,,%clipboard%
	
	; format: last, first (init) <email>  e.g. Schnur, Richard (R.) <rschnur2@ford.com>
	
	; get position of separating comma & left bracket
	StringGetPos, pos_comma, clipboard, %comma%         ; seps firs/last name
;	StringGetPos, pos_leftp, clipboard, %right_parenthesis%
	StringGetPos, pos_leftp, clipboard, %left_parenthesis% ; start of initials
	
	msgbox,0,,Comma: %pos_comma%`nRight Parent: %pos_leftp%
	
	; extract & trim spaces
	remainder := substr(clipboard, pos_comma + 2, pos_leftp - 2)
	remainder := trim(remainder)
	msgbox,0,,Remainder: %remainder%
	
	StringGetPos, pos_leftp, remainder, %left_parenthesis%
	msgbox,0,,Left Parent: %pos_leftp%
	reqnametmp := SubStr(remainder, 1, pos_leftp - 1)
	
    msgbox,0,,Temp Name; %reqnametmp%
	
	reqname%a_index% := trim(reqnametmp)
	
	Send {Delete} ; Delete name from "To" field of email
	
	cdsname := reqName%a_index%
	
	msgbox, 0,,Name: %cdsname%
} ; loop

Sleep, 200
WinWaitActive, Message
Send {TAB 3}{Backspace}
Sleep, 400


; There is an issue with names that have multiple adderss book entries for different people.
; Need to allow time for the search and selection using the address selector popup dialogue
; An alternative less intuitive is keywait left alt
loop
{
   msgbox, 36, %boxtitle% - Question, Have all of the email addresses been resolved?
   winactivate, Question
   ifmsgbox, yes
      {
	  ; Pass focus to the email body field
	  curField = "_WwG1"
	  ControlFocus, curField, A
	  sleep, 200
      break
	  }
   else
      continue
	  
} ; loop - display msgbox waiting for yes response

	  
MsgBox, 0, %boxtitle% - Stored CDSIDs,
(
Requested For CDS:   %reqCDS1% %reqName1%

HR LL4 Appr - CDS:   %LL4CDS2%
LL4 Appr    - CDS:   %LL4CDS1%

Co-owner 1  - CDS 2: %reqCDS2% - %reqName2%
Co-owner 2  - CDS 3: %reqCDS3% - %reqName3%
Co-owner 3  - CDS 4: %reqCDS4% - %reqName4%
Co-owner 4  - CDS 5: %reqCDS5% - %reqName5%
Co-owner 5  - CDS 6: %reqCDS6% - %reqName6%

Co-owner 3-5 do not show on form unless the preceding co-owner field is entered.

Additional Details:`n`n%addl_dtls%

)
winactivate, Stored
