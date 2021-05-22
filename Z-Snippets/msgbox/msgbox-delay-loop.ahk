
; This code displays a message box and will only move to the next command 
; (outside the loop) when the"yes" button is clicked.
Menu, Tray, Icon, Shell32.dll, 174
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

