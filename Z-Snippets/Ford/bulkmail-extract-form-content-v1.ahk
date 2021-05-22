; ------------------------------------------------------------------------------
; Extract needed CDS values from the form page

; Search string CDS ID is for the requester, initiator, and the supervisor
;    Iteration 1 starts at the docuemnt top and finds the requester CDS (CDS ID search string)
;    Iteration 2 thru 8 search for CDSID. Iteration 2 skips the other 2 CDS ID values - initiator and supervisor
; Search string CDSID is for the LL4's and the co-owners
;    note: While only 2 co-owners appear on the form there are 5 in the extracted form in notepad. 
;          As co-owner 2 is entered then co-owner 3 displays, etc.
 
; Each iteration opens the find dialog, inserts the appropriate search text, does the search {enter} and 
; closes the find dialog {escape} and moves the cursor right. 
;   This process positions the cursor at the CDS value and the process then selects it and sends it to the clipboard.
; The loop then cleans the value (spaces, extra characters, etc. and stores it in the array

; Since the docuemnt is never closed and the cursor is not moved from the prior iteration 
; it is placed after the previous iteration's search string so the searches march through the docuemnt to the end
; ------------------------------------------------------------------------------

; 1 = start with, 2 = anywhere, 3 = exact match
SetTitleMatchMode, 2 

IfWinExist, txt - Notepad
   {
   Winactivate
   WinRestore
   send ^{Home}   ; Go to top   
   }
else
   {
   msgbox, No window
   exitapp
   }

; ------------------------------------------------------------------------------
; Extract "Requested For" info before looping to get remaining CDS info
; ------------------------------------------------------------------------------
   
; Search for Requester line
searchstring = Requested for

Send ^f ; Open "Find" window
Send %searchstring%
Send {Enter}{escape}

clipboard := ""

; move 3 right to get to first of next line then skip three words to get to 
; start of email address then select email address then copy to clipboard
; This version allows for three part names
Send {Right 3}+{end} ; Move cursor past "CDSID" and select next word, the CDSID
Send ^C

clipwait

StringReplace, clipboard, clipboard, `r`n,, A  ; Remove newlines from clipboard
reqline = %clipboard%                         ; Remove excess spaces and tabs

msgbox, %reqline%

; Look for ( and select everything after it email address and rest of line
StringGetPos, pos, reqline, (
if pos >= 0
   MsgBox, The string was found at position %pos%.

; Extract everything after the name field   
stringmid, reqemail, reqline, pos + 2, 99

msgbox, %reqemail%

; Look for @ sign and select everything before it (CDSID)
StringGetPos, pos, reqemail, @
; if pos >= 0
;    MsgBox, The string was found at position %pos%.
	
stringmid, reqcds1, reqemail, 1, pos

msgbox, ReqCDS1: %reqcds1%

Send {down}


; ------------------------------------------------------------------------------
; Loop through the remainder of the record looking for CSDIDS (2-6)
; ------------------------------------------------------------------------------
	
searchstring = CDSID 

Outer:
	
loop, 7
{
   msgbox, Loop %a_index%
   
   Send ^f ; Open "Find" window

   Send %searchstring%
   Send {Enter}{escape}

   Send {Right}^+{Right} ; Move cursor past "CDSID" and select next word, the CDSID
    
   sleep, 100
	
   clipboard := ""
   Send ^C
   sleep, 100
   clipwait

   StringReplace, clipboard, clipboard, `r`n,, A ; Remove newlines from clipboard
   clipboard = %clipboard% ; Remove excess spaces and tabs

   sleep 100
   
   msgbox, Clipboard: %clipboard%
   
   if clipboard = 
      {
	  msgbox, Clipboard empty
      continue
	  }
   
   if clipboard = BY
      break outer
   
   in%A_Index% := clipboard
}


; ------------------------------------------------------------------------------
; Store CDSID from loop into variables used in the remaining workflow - LL4, HR LL4, and co-owners
; ------------------------------------------------------------------------------

;reqCDS1 := in1
reqCDS0 := 1

LL4CDS1 := in2
LL4CDS0 := 1

if(in1 != "") ; An HR LL4 CDSID was given
{
	LL4CDS2 := in1
	LL4CDS0 := 2
}

inIndex := 3
offset := 2
while(in%inIndex% != "") ; Captures all co-owner CDSIDs
{
	repeatedCDS := 0
	loop, %reqCDS0% ; For all requested CDSIDs in the array
	{
		if(in%inIndex% == reqCDS%A_Index%)
		{
			repeatedCDS := 1
		}
	}

	if(repeatedCDS != 1) ; Unique CDSID, add it to the array
	{
		reqCDS0 := reqCDS0 + 1
		reqCDS%reqCDS0% := in%inIndex%
	}
	inIndex := inIndex + 1
}

;\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
; Extract "Additional Details" field
;\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

Send ^{Home}
Sleep 100
Send ^f ; Paste in Notepad, go to top, and open "Find" window
Send Additional Details
sleep 100
Send {Enter}!{F4}
Sleep 100
send {right}
sleep 100
send +{end}
Sleep 100
send ^c

addl_dtls := clipboard
; msgbox, ,,Additional Details: %addl_dtls%

; WinClose, Notepad
Send n ; Answer the "Would you like to save?" prompt with No

; Display the request info for verification
Gosub, ^!m
MouseClick

exitapp

; ------------------------------------------------------------------------------
; Display information about stored CDSIDs and names
; ------------------------------------------------------------------------------

^!m::
KeyWait Control
KeyWait Alt

MsgBox, 0, %boxtitle% - Stored CDSIDs,
(
Requested CDSIDs:   %reqCDS0%
LL4 CDSIDs:         %LL4CDS0%

Requested For CDS:  %reqCDS1% (%reqName1%)

HR LL4 Appr - CDS:   %LL4CDS2%
LL4 Appr    - CDS:   %LL4CDS1%

Co-owner 1  - CDS 2: %reqCDS2% (%reqName2%)
Co-owner 2  - CDS 3: %reqCDS3% (%reqName3%)
Co-owner 3  - CDS 4: %reqCDS4% (%reqName4%)
Co-owner 4  - CDS 5: %reqCDS5% (%reqName5%)

Co-owner 3-5 do not show on form unless the preceding co-owner field is entered.

Additional Details:`n`n%addl_dtls%
)

winactivate, Stored

return
