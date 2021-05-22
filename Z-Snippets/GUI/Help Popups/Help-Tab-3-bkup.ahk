

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Tab 9 - Cities Skylines Move/Find
; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

Gui, Tab, CS-Move-Find

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Block 1

t9block1title = 1-Function Keys
t9block1rows =13

t9block1x = 15
t9block1y = 40
t9block1w = 270

t9block1data= 
(
~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~
f1|Show/hide HUD
f2|Take screen capture
f3|Show/hide debug info
f4|Light Overlay
f5|Change perspective
f6|
f7|Light Overlay Reloaded
f8|Toggle JEI cheat mode
f9|
f10|
f11|
f12|
)


Gui, Font, Verdana s12 cGreen bold underline
Gui, Add, Text, x%t9block1x% y%t9block1y%, %t9block1Title%
Gui, Font, Verdana s9 cBlack norm

Gui, Add, Listview, x%t9block1x% y+6 w%t9block1w% r%t9block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

Loop, Parse, t9block1data, `n, `r
	{
	 StringSplit, data, A_LoopField, | 
	 LV_Add("", data1, data2)
	}

LV_ModifyCol()                               ; Auto width columns()
LV_ModifyCol(1, "AutoHdr") 
LV_ModifyCol(2, "AutoHdr") 



; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Block 2

t9block2title = 2-F3 Shortcuts
t9block2rows = 17

t9block2x = 295
t9block2y = 40
t9block2w = 270

t9block2data= 
(
~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~
A|Reload Chunks
B|Show Hitboxes
C|Copy XYZ as /TP Command
C-HOLD|Crash the game
D|Clear Chat
F|Cycle render distance
F-SHIFT|Invert render distance
G|Show chunk boundaries
H|Advanced tooltips
I|Entity/block data to clipboard
N|Cycle game mode
P|Pause on lost focus
Q|Show help
T|Reload resource packs
ALT-F3|TPS Graph
SHIFT-F3|Resource Usage Pie Chart
)


Gui, Font, Verdana s12 cBlue bold underline
Gui, Add, Text, x%t9block2x% y%t9block2y%, %t9block2Title%
Gui, Font, Verdana s9 cBlack norm

Gui, Add, Listview, x%t9block2x% y+6 w%t9block2w% r%t9block2rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

Loop, Parse, t9block2data, `n, `r
	{
	 StringSplit, data, A_LoopField, | 
	 LV_Add("", data1, data2)
	}

LV_ModifyCol()                               ; Auto width columns()
LV_ModifyCol(1, "AutoHdr") 
LV_ModifyCol(2, "AutoHdr") 


; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Block 3

t9block3title = 3-Other Keys
t9block3rows = 13

t9block3x = 575
t9block3y = 40
t9block3w = 420

t9block3data= 
(
~~~~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
F|Swap hand contents
H+C|MiniHUD configuration
;|Show advancements GUI
|
Cartography:|Existing map in top slot
|Glass pane bottom slot lock map
)


Gui, Font, Verdana s12 cPurple bold underline
Gui, Add, Text, x%t9block3x% y%t9block3y%, %t9block3Title%
Gui, Font, Verdana s9 cBlack norm

Gui, Add, Listview, x%t9block3x% y+6 w%t9block3w% r%t9block3rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

Loop, Parse, t9block3data, `n, `r
	{
	 StringSplit, data, A_LoopField, | 
	 LV_Add("", data1, data2)
	}

LV_ModifyCol()                               ; Auto width columns()
LV_ModifyCol(1, "AutoHdr") 
LV_ModifyCol(2, "AutoHdr") 


; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Block 4

t9block4title = 4-Commands
t9block4rows = 14

t9block4x = 575
t9block4y = 320
t9block4w = 420

t9block4data= 
(
~~~~~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~
/trigger modularhud|Open Modular HUD options
/function modularhud:admin/configure|Open Modular HUD config
/gamerule randomTickSpeed 200|Set tick speed to speed plant growth
)


Gui, Font, Verdana s12 cRed bold underline
Gui, Add, Text, x%t9block4x% y%t9block4y%, %t9block4Title%
Gui, Font, Verdana s9 cBlack norm

Gui, Add, Listview, x%t9block4x% y+6 w%t9block4w% r%t9block4rows% Hdr Grid NoSortHdr NoSort ReadOnly, Command|Function

Loop, Parse, t9block4data, `n, `r
	{
	 StringSplit, data, A_LoopField, | 
	 LV_Add("", data1, data2)
	}

LV_ModifyCol()                               ; Auto width columns()
LV_ModifyCol(1, "AutoHdr") 
LV_ModifyCol(2, "AutoHdr") 


; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Block 5

t9block5title = 5-Light Overlay
t9block5rows = 10

t9block5x = 15
t9block5y = 320
t9block5w = 270

t9block5data= 
(
~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~
F4|Toggle Light Overlay
F7|Toggle Light Overlay Reloaded
Pad-5|Increase/decrease line
Pad-6|Increase/decrease line
Pad-8|Increase/decrease range
Pad-9|Increase/decrease range
)


Gui, Font, Verdana s12 cNavy bold underline
Gui, Add, Text, x%t9block5x% y%t9block5y%, %t9block5Title%
Gui, Font, Verdana s9 cBlack norm

Gui, Add, Listview, x%t9block5x% y+6 w%t9block5w% r%t9block5rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

Loop, Parse, t9block5data, `n, `r
	{
	 StringSplit, data, A_LoopField, | 
	 LV_Add("", data1, data2)
	}

LV_ModifyCol()                               ; Auto width columns()
LV_ModifyCol(1, "AutoHdr") 
LV_ModifyCol(2, "AutoHdr") 


; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Block 6

t9block6title = 6-Xaero Map
t9block6rows = 8

t9block6x = 295
t9block6y = 390
t9block6w = 270

t9block6data= 
(
~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~
M|Full screen map
N|Create waypoint
,|Open waypoint manager
X|Full screen map
Z|Zoom (mini and full screen map)
N/A|Toggle mobs
N/A|Toggle waypoints
)


Gui, Font, Verdana s12 cTeal bold underline
Gui, Add, Text, x%t9block6x% y%t9block6y%, %t9block6Title%
Gui, Font, Verdana s9 cBlack norm

Gui, Add, Listview, x%t9block6x% y+6 w%t9block6w% r%t9block6rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

Loop, Parse, t9block6data, `n, `r
	{
	 StringSplit, data, A_LoopField, | 
	 LV_Add("", data1, data2)
	}

LV_ModifyCol()                               ; Auto width columns()
LV_ModifyCol(1, "AutoHdr") 
LV_ModifyCol(2, "AutoHdr") 

