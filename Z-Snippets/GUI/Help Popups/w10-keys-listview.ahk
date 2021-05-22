; ------------------------------------------------------------------------------
; Display the hotkeys that this script contains
; ------------------------------------------------------------------------------

versioninfo |= 1.0.0

^!k::
KeyWait Control
KeyWait Alt

list1= ; test data
(
~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~
d|Show Desktop/Minimize All Windows
e|Open File Explorer
f|Open search (also F3)
i|Open Main Settings
l|Lock Desktop
r|Open Run Dialog
tab|Open task view
)

list2= ; test data
(
~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~
right arrow|Dock window right
left arrow|Dock window left
down arrow|Restore or Minimize active window
up arrow|Maximize window vertically & horizontally
shift-down arrow|Restore or maximize vertically only
shift-up arrow|Restore or maximize vertically only
shift-right arrow|Multiple monitors - move right
shift-left arrow|Multiple monitors - move left
ctrl-print screen|Capture to computer\pictures\screenshots
)

list3= ; test data
(
~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~
ctrl-d|New virtual desktop
ctrl-left arrow|Switch to previous virtual desktop
ctrl-right arrow|Switch to next virtual desktop
ctrl-f4|Close current virtual desktop
)

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Display box each new row = +15 for each y value
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Gui, Font, Arial s12 cBlue bold underline
Gui, Add, Text, x8 y5, Basic

Gui, Font, Verdana s10 cBlack norm
; BackgroundGray Cwhite
Gui, Add, Listview, x8 y30 w480 h190 Grid, Key                         |Function ; Spaces set column widths
Loop, Parse, list1, `n, `r
	{
	 StringSplit, data, A_LoopField, | ; just an example
	 LV_Add("", data1, data2)
	}
	
Gui, Font, Verdana s12 cGreen bold underline
Gui, Add, Text, x8 y235, Window Management

Gui, Font, Verdana s10 cBlack w400 norm
Gui, Add, Listview, x8 y260 w480 h230 Grid, Key                        |Function ; Spaces set column widths
Loop, Parse, list2, `n, `r
	{
	 StringSplit, data, A_LoopField, | ; just an example
	 LV_Add("", data1, data2)
	}
	
Gui, Font, Verdana s12 cPurple bold underline
Gui, Add, Text, x8 y510, Virtual Desktops

Gui, Font, Verdana s10 cBlack w400 norm
Gui, Add, Listview, x8 y535 w480 h130 Grid, Key                        |Function ; Spaces set column widths
Loop, Parse, list3, `n, `r
	{
	 StringSplit, data, A_LoopField, | ; just an example
	 LV_Add("", data1, data2)
	}

Gui, Font, Verdana s12 cBlack bold underline
Gui, Add, Text, x8 y680, Press the Escape key to exit this window

Gui, Show, x800 y100 AutoSize ; w490 h680, Windows 10 Shortcut Keys
Return

GuiEscape:
Gui, Destroy
return

GuiClose:
gui, Destroy
return

Return