; Multi-Select Example:

; c:\... google drive ...\game\Minecraft 1.8
; c:\... google drive ...\game\Minecraft 1.8\OCnet
; c:\... users\appdata\roaming\.minecraft\mods\1.8 


; Select source folder

sourcefolder := "g:\Pictures"

; Build & disply destination selection dialog box

Gui, Add, Checkbox, vOpt1, Google Drive 1.8
Gui, Add, Checkbox, vOpt2, Google Drive 1.8 OCnet
Gui, Add, Checkbox, vOpt3, Hard Drive
Gui, Add, Button, gLabel, Click here to submit
gui, show
return

; Process destination selections

Label:

Gui, Submit, NoHide ;this command submits the guis' datas' state

; Close the window
gui, cancel

; Process checkboxes

If Opt1 = 1 ; 0 = unchecked, 1 = checked
    destfolder1 := "g:\offload\personal"

If Opt2 = 1
    destfolder2 := "g:\offload\work"

If Opt3 = 1
    destfolder3 := "g:\offload\software"

MsgBox, 1, Destination Select, You selected folder 1- "%destfolder1%" 2- "%destfolder2%" 3- "%destfolder3%".

; Select files to copy

FileSelectFile, files, M3, %sourcefolder%  ; M3 = Multiselect existing files.

if files =
{
    MsgBox, 1, Cancel Process, The user pressed cancel.
    exitapp
}

if destfolder1 != 

Loop, parse, files, `n
{
    if a_index = 1 ; entry 1 contains the path
        msgbox, 1, ,Copy from %sourcefolder% to %destfolder1%
    else
    {
        MsgBox, 4, , Copy file: %A_LoopField%.  Continue?
		FileCopy, %A_LoopField%, %destfolder1%, 1
        IfMsgBox, No, continue
    }
}


if destfolder2 != 

Loop, parse, files, `n
{
    if a_index = 1
        msgbox, 1, ,Copy from %sourcefolder% to %destfolder2%
    else
    {
        MsgBox, 4, , Copy file: %A_LoopField%.  Continue?
		IfMsgBox, No, continue
		FileCopy, %A_LoopField%, %destfolder2%, 1
    }
}


if destfolder3 != 

Loop, parse, files, `n
{
    if a_index = 1
        msgbox, 1, ,Copy from %sourcefolder% to %destfolder3%
    else
    {
        MsgBox, 4, , Copy file: %A_LoopField%.  Continue?
        IfMsgBox, No, continue
		FileCopy, %A_LoopField%, %destfolder3%, 1
    }
}

exitapp
