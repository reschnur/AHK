; ------------------------------------------------------------------------------
; Display the hotkeys that this script contains
; ------------------------------------------------------------------------------

versioninfo |= 1.0.0

^!k::
KeyWait Control
KeyWait Alt

list= ; test data
(
~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~
d|Minimize all windows
e|Open File Explorer
i|Open Main Settings
l|Lock Desktop
r|Open Run Dialog
tab|Enter task view
-|
Windows|
~~~~~~~~~~~|
Key|Function
~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~
right arrow|Dock window right
left arrow|Dock window left
down arrow|Restore or Minimize active window
up arrow|Maximize window vertically & Horizontally
shift-down arrow|Restore or Maximize vertically only
shift-up arrow|Restore or Maximize vertically only
shift-right arrow|Multiple monitors - move right
shift-left arrow|Multiple monitors = move left
ctrl-print screen|Capture to computer\pictures\screenshots
-|
Virtual Desktops|
~~~~~~~~~~~|
Key|Function
~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~
ctrl-d|New virtual desktop
ctrl-left arrow|Switch to previous virtual desktop
ctrl-right arrow|Switch to next virtual desktop
ctrl-f4|Close current virtual desktop
)

Gui, font, s10, Verdana
Gui, Add, Listview, x4 y5 w500 h690[/color], Key                    |Function ; Spaces set column widths
Loop, Parse, list, `n, `r
	{
	 StringSplit, data, A_LoopField, | ; just an example
	 LV_Add("", data1, data2)
	}
Gui, Show, x400 y200 w495 h700, W10 Keys-%versioninfo%
Return

GuiEscape:
Gui, Destroy
return

GuiClose:
gui, Destroy
return

Return