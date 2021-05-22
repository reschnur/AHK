; Multi-Select Example:

Gui, Add, Checkbox, vOpt1, Google Drive 1.8
Gui, Add, Checkbox, vOpt2, Google Drive 1.8 OCnet
Gui, Add, Checkbox, vOpt3, Hard Drive
Gui, Add, Button, gLabel, Click here to submit
gui, show

return

GuiEscape:
; fall through

GuiClose:
Gui, destroy
ExitApp


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Label:

Gui, Submit, NoHide ;this command submits the guis' datas' state

gui, cancel

If Opt1 = 1
    MsgBox, you checked the first box

; If Opt1 = 0
;     MsgBox, you didnt check the first box

If Opt2 = 1
    MsgBox, you checked the second box

; If Opt2 = 0
;     MsgBox, you didnt check the second box

If Opt3 = 1
    MsgBox, you checked the third box

; If Opt3 = 0
;     MsgBox, you didnt check the third box


FileSelectFolder, OutputVar, , 0

if OutputVar =
{
    MsgBox, You didn't select a folder.
	ExitApp
}
else
    MsgBox, You selected folder "%OutputVar%".

FileSelectFile, files, M3, %outputvar%  ; M3 = Multiselect existing files.

if files =
{
    MsgBox, The user pressed cancel.
    exitapp
}

Loop, parse, files, `n
{
    if a_index = 1
        MsgBox, The selected files are all contained in %A_LoopField%.
    else
    {
        MsgBox, 4, , The next file is %A_LoopField%.  Continue?
        IfMsgBox, No, break
    }
}
return
