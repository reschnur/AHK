; 

scriptname = Copy Files Using Explorer


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Open source folder and copy files
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   

run, explorer C:\Program Files (x86)\IBM\SAIOM\logs
winwaitactive, C:\Program Files (x86)\IBM\SAIOM\logs
send, {tab}
sleep, 1000
Send, ^a
sleep, 1000
send, ^c
sleep, 1000


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Get backup folder suffix
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

loop {
;         outvar,    title,        Prompt,                   Hide, W,     H, X, Y, Font, Timeout, Default
InputBox, UserInput, %scriptname%, Please enter suffix:,    , 180, 126,  ,  ,     ,        , ; Default
if ErrorLevel
   {
   MsgBox, 0, %scriptname%, Process cancelled., 2
   Exitapp
   }
;else
;    MsgBox, You entered "%UserInput%"

suffix = %UserInput% ; Do not enter : for =

if suffix =    ; Blank
   {
   msgbox, 0, %scriptname%, Must enter a value or cancel.
   continue
   }
else
   {
   stringupper, suffix, suffix  ; Do not use %
   ; msgbox, 0, %scriptname%, Server: %suffix%
   break
   }
}


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Check if destination exists and create it if necessary
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
dstfolder = W:\GNCO\SA-IOM\Backups\%a_yyyy%\Logs\%suffix%\%a_mm%	

; msgbox, 0, %scriptname%, Backup log files to:`n%dstfolder%, 2
	
ifnotexist, %dstfolder%
   {
   msgbox, 0, %scriptname%, Log backup destination folder not found. Trying to create., 2
   filecreatedir, %dstfolder%
   if errorlevel
      {
      msgbox, 0, %scriptname%, Cannot create Log destination folder. Cancel process., 4 
	  exitapp
	  }
   }


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Paste Files to Destination
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
; msgbox, 0, %scriptname%, Start Log backup., 2 

run, explorer %dstfolder%
winwaitactive, %dstfolder%
; msgbox, 0, %scriptname%, Start Log backup 2., 1
sleep, 2000
; send, {LWin Down}{left}{LWin Up}
send {tab}
sleep, 1000
send, ^v
; sleep, 2000

; msgbox, 0, %scriptname%, Process Completed., 2