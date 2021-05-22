FileSelectFile, files, M3  ; M3 = Multiselect existing files.
if (files = "")
{
    MsgBox, The user pressed cancel.
    return
}
Loop, parse, files, `n
{
    if (A_Index = 1)
        MsgBox, The selected files are all contained in %A_LoopField%.
    else
    {
        MsgBox, 4, , The next file is %A_LoopField%.  Continue?
        IfMsgBox, No, break
    }
}
return