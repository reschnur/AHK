#SingleInstance force ; Disables pop-up message for re-running this scipt
SetTitleMatchMode, 2  ; "Window Title Text" can be anywhere in the title

comma := ","
parenthesis := "("
dialogtitle := "SCCM Request Filler - 1.0.4"
needle := "  "


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Get the package info from eAssets
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Force a new window
run, iexplore.exe https://www.eassets.ford.com/eassetsWeb/sms/reports/smspackage/openSmsPackageRpt.do

winactivate, eAssets PROD

; Get the package info
msgbox, 4097, %dialogtitle%, Copy the package name to the clipboard.

ifmsgbox, cancel 
   exitapp

winclose, eAssets

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Process the package info from eAssets
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Sample package name from eAssets;
; package := A00017AF  WSUS_MSPATCH_2012_STN_SUSTAINED  2012 and before 

package := clipboard

StringGetPos, pos, package, %Needle%

stringleft, packageid, package, 8
stringmid, packagename, package, 11, 99

StringGetPos, pos, packagename, %Needle%

pd1 := pos+2
pd2 := pos+1
	
stringmid, packagedesc, packagename, %pd1%, 99	
stringmid, packagename, packagename, 1, %pd2%

;msgbox, 65, package Info:`n`n%dialogtitle%, PackageID: %packageid%`nPackageNM: %packagename%`nPackageDesc: %packagedesc%
;ifmsgbox, cancel  
;   exitapp

; ~~~~~~~~~~~~~~~~
; Setup the window
; ~~~~~~~~~~~~~~~~~~~
   
loop 
{
 ifwinnotexist, STC Request - New Item
 {
	MsgBox, 49, %dialogtitle%, There is no new SCCM request form open. Open a form to proceed.
	ifmsgbox, cancel
	{
	   exitapp
	}
 } ; if
 else
 {
   msgbox, 65, %dialoguetitle%, Select Scenario 1 in deplyment Type and then press "Left-Alt"
   WinActivate, STC Request - New
   break
 }
} ; loop


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Fill the form
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Secnario Type is manually selected so that the cursor is int he correct locaiton 
; for the remainder of the macro. The macro is all send and tab

; Select "Scenario 1"
;Send s

KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Enter requestor cdsid
Send {Tab}
Send rschnur2
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Skip verify names and browse buttons
Send {Tab 2}
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Skip date
Send {tab}

; Skip to hour field
Send {tab 2}
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Force to 9am
Send 9

; Skip Minutes, Proejcted delivery and Weekend Support fields
Send {tab 5}
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.


; Ask for exception group

; Build & disply destination selection dialog box

Gui, Margin, 10, 10
Gui, Font, s9, ARIEL
Gui, Add, Radio, checked vOpt1, SCCM Group 5051-datacenter-pcs
Gui, Add, Radio, vOpt2, SCCM Group 5091-datacenter-pcs
Gui, Add, Button, gLabel, Click here to submit
gui, show
return

; Process dialog

Label:

Gui, Submit, NoHide ;this command submits the guis' datas' state

; Close the window
gui, cancel

; Process checkboxes

If Opt1 = 1 ; 0 = unchecked, 1 = checked
    scroll = 9

If Opt2 = 1
    scroll = 17

Send {down %scroll%} ; 9 5051 17 for 5091	
Send {tab}
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Target Region
Send a

; Skip reboot field
Send {tab 2}
 ; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Instructions field
Send Install the package.`n`n
Send If there is a way to do this sooner then we are open to that option as long as we know the day the install will occur so we can monitor.`n`n
Send Also, we may need to enter change control records for this deployment so we need  to know the confirmed deployment date at least 7 business days in advance so we can enter  the records as standard changes and not emergency changes.
Send {tab}
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Business case field
Send Remain compliant and install the software within the implementation window specified by the announcement.
Send {tab}

; Application name and version
Send %packagedesc%
Send {tab}
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Certification link
Send {tab} ; skip the "Click here to test" link
Send https://www.eassets.ford.com/eassetsWeb/certLabs/getCertLabsRequestMenu.do?top=	
Send {tab}

; Certification link name
Send Certification Link
Send {tab 2} ; Skip eAssets link
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Certification stsatus
Send c
Send {tab}
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Package name 
Send %packagename%
Send {tab}
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

; Package ID
Send %packageid%
Send {tab 2} ; Skip the eAssets link under the field
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

;
Send Installer
Send {tab}
; KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.

Send rschnur2

msgbox, 65,%dialogtitle%,Verify Requested Deployment Date and Exception Group then save the record.

exitapp
