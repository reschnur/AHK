; ------------------------------------------------------------------------------
; Display the hotkeys that this script contains
; ------------------------------------------------------------------------------

versioninfo := 1.0.0

^!k::
KeyWait Control
KeyWait Alt

MsgBox, 0, W10 Hotkeys, 8
(
Key	         Function
d:	         Minimize all windows (show desktop)
e:           Open explorer
i:           Open settings
l:           Lock screen
r:           Open run prompt
tab:         Open task view

Windows
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Key	               Function
right arrow:       Dock window right
left arrow:        Dock window left
down arrow:        Restore or Minimize active window
up arrow:          Maximize window vertically & Horizontally
shift-down arrow:  Restore or Maximize vertically only
shift-up arrow:    Restore or Maximize vertically only
shift-right arrow: Multiple monitors - move right
shift-left arrow:  Multiple monitors = move left
ctrl-print screen: Capture to computer\pictures\screenshots

Virtual Desktops
~~~~~~~~~~~~~~~~~
Key	               Function
ctrl-d:            new virtual desktop
ctrl-left arrow:   switch to previous virtual desktop
ctrl-right arrow:  switch to next virtual desktop
ctrl-f4:           close current virtual desktop

%versioninfo%
)

return
