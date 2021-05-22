; Display the GUI with a countdown timer and when it times out move to next process - Foo.

;                   Title,            Message, Seconds, where to go next
MsgBoxTimed("Timed GUI 2", "GUI Message Text", 6, "Foo")

return ; must be return or the process terminates without displaying the GUI


Foo:

;OtherCode
msgbox, 0, Title, Other processing., 2

exitapp ; if you are done
return ; instead of exitapp if there is other stuff to do


MsgBoxTimed(title, msg, seconds, complete="") 
{
    static init = false, _seconds, _complete ; sttic = remeber variables between iterations
    global Msg92, Seconds92

    if (!init)  ; create the GUI; 92: is the unique qualifier for the GUI incase there are multiple
    {
        init := true
        Gui, 92:Font, s24
        Gui, 92:Add, Text, vMsg92 Center w360, %msg%
        Gui, 92:Font, s30 cRed
        Gui, 92:Add, Text, vSeconds92 Center w360, %seconds%
    }

    _seconds := seconds
    _complete := complete

    GuiControl, 92:, Msg92, %msg%
    Gui, 92:Show, w400 h150, %title%

    Update92:
	
    GuiControl, 92:, Seconds92, %_seconds%
    
	_seconds -= 1
    
	if (_seconds > 0) {
        SetTimer, Update92, -1000 ; loop back to "update92" to display the latest timer value one second from now
    }
    else {
        Gui, 92:Hide
        if (_complete)
            SetTimer, %_complete%, -1 ; launch "complete" routine; -1 means run it only once, but reun it immediately immediately
    }
	
    return
} 