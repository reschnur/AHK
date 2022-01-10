; ------------------------------------------------------------------------------
; Display the hotkeys that this script contains
; ------------------------------------------------------------------------------

#SingleInstance, Force
SetTitleMatchMode, 2 ; 1 = Starts with, 2 = Anywhere, 3 = Exact

Script_Name = ScriptName
versioninfo = 2.4.0

tab1Active = 1
tab2Active = 1
tab3Active = 1
tab4Active = 1
tab5Active = 1
tab6Active = 1
tab7Active = 1
tab8Active = 1
tab9Active = 1
tab10Active = 1

; MsgBox, 0, %Script_Name%, Start MC Help, 2

^!h::
  KeyWait Control
  KeyWait Alt

RunIt:
  ; ~  Setup tabs
  Gui, Font, Verdana s12 cBlack bold underline
  Gui, add, tab3, x6 y6 -wrap, Minecraft Common|Minecraft Fabric|Java|VSCode|Trello|Cities Common|Cities Roads|Cities Move/Find|Mars

  gosub BuildTabs

  ; Footer
  Gui, tab, 
  Gui, Font, Verdana s10 cBlack bold underline
  Gui, color, c9c9c9
  ; Gui, Color, WindowColor884488, ControlColorFFFF99
  Gui, Add, Text, x10 y+4, Press the Escape key to exit this window 
  Gui, Add, Text, yp x900, Version: %versioninfo% ; yp mean previous lines y coordinate (these 2 controls will be on the same line

  Gui, Show, xCenter yCenter AutoSize, Minecraft Help: %versioninfo%

  Return

  GuiEscape:
  Gui, Destroy
  return

  GuiClose:
  gui, Destroy
  return

ExitApp

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

BuildTabs:

  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ; Tab 1 - Minecraft Common
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  if (tab1Active = 1) {

    Gui, Tab, Minecraft Common

    Tab_1_Block_1:

      t1block1title = 1-Function Keys
      t1block1rows =13

      t1block1x = 15
      t1block1y = 40
      t1block1w = 270

      t1block1data= 
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
      Gui, Add, Text, x%t1block1x% y%t1block1y%, %t1block1Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t1block1x% y+6 w%t1block1w% r%t1block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t1block1data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 2

    Tab_1_Block_2:

      t1block2title = 2-F3 Shortcuts
      t1block2rows = 17

      t1block2x = 295
      t1block2y = 40
      t1block2w = 270

      t1block2data= 
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
      Gui, Add, Text, x%t1block2x% y%t1block2y%, %t1block2Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t1block2x% y+6 w%t1block2w% r%t1block2rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t1block2data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 3

    Tab_1_Block_3:

      t1block3title = 3-Other Keys
      t1block3rows = 13

      t1block3x = 575
      t1block3y = 40
      t1block3w = 400

      t1block3data= 
      (
        ~~~~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        F|Swap hand contents
        H+C|MiniHUD configuration
        ;|Show advancements GUI
        |
        Cartography:|Existing map in top slot
        |Glass pane bottom slot lock map
        |
        Cycle Painting|Click paintingon wall with another painting
        |
        Edit Sign|Right-click
      )

      Gui, Font, Verdana s12 cPurple bold underline
      Gui, Add, Text, x%t1block3x% y%t1block3y%, %t1block3Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t1block3x% y+6 w%t1block3w% r%t1block3rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t1block3data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 4

    Tab_1_Block_4:

      t1block4title = 4-Commands
      t1block4rows = 12

      t1block4x = 575
      t1block4y = 320
      t1block4w = 400

      t1block4data= 
      (
        ~~~~~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~
        /trigger modularhud|Open Modular HUD options
        /function modularhud:admin/configure|Open Modular HUD config
        /gamerule randomTickSpeed 200|Set tick speed to speed plant growth
      )

      Gui, Font, Verdana s12 cRed bold underline
      Gui, Add, Text, x%t1block4x% y%t1block4y%, %t1block4Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t1block4x% y+6 w%t1block4w% r%t1block4rows% Hdr Grid NoSortHdr NoSort ReadOnly, Command|Function

      Loop, Parse, t1block4data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 5

    Tab_1_Block_5:

      t1block5title = 5-Light Overlay
      t1block5rows = 10

      t1block5x = 15
      t1block5y = 320
      t1block5w = 270

      t1block5data= 
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
      Gui, Add, Text, x%t1block5x% y%t1block5y%, %t1block5Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t1block5x% y+6 w%t1block5w% r%t1block5rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t1block5data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 6

    Tab_1_Block_6:

      t1block6title = 6-Xaero Map
      t1block6rows = 8

      t1block6x = 295
      t1block6y = 390
      t1block6w = 270

      t1block6data= 
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
      Gui, Add, Text, x%t1block6x% y%t1block6y%, %t1block6Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t1block6x% y+6 w%t1block6w% r%t1block6rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t1block6data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 
    }

  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ; Tab 2 - Minecraft Fabric Specific Mods
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  If (tab2Active = 1) {

      gui, tab, Minecraft Fabric	

    Tab_2_Block_1:

      t2block1title = 1-Roughly Enough Items
      t2block1rows =10

      t2block1x = 15
      t2block1y = 40
      t2block1w = 270

      t2block1data= 
      (
        ~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~
        O|Show/hide right panel
        R|Show recipe for item at cursor
          U|Show used in for item at cursor
          N/A|Next page of recipes
        N/A|Previos page of recipes
        Right-click|Clear search when pointing there
        In cheat mode:|
        - Left-click|Give one item when cheat on
        - Right-click|Give item stack when cheat on
      )

      Gui, Font, Verdana s12 cBlue bold underline
      Gui, Add, Text, x%t2block1x% y%t2block1y%, %t2block1Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t2block1x% y+6 w%t2block1w% r%t2block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t2block1data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 2

    Tab_2_Block_2:

      t2block2title = 2-Enhanced Book Redisgn
      t2block2rows = 10

      t2block2x = 300
      t2block2y = 40
      t2block2w = 270

      t2block2data= 
      (
        ~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~
        Green|Armor
        Red|Swords
        Purple|Tridents
        Orange|Bow
        Teal|Crossbow
        Blue|Fishing Rods
        Brown|Tools
        Black|Cursed (Stay away)
      )

      Gui, Font, Verdana s12 cGreen bold underline
      Gui, Add, Text, x%t2block2x% y%t2block2y%, %t2block2Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t2block2x% y+6 w%t2block2w% r%t2block2rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t2block2data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 
    }

  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ; Tab 4 - Java
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  If (tab4Active = 1) {

      gui, tab, Java			

    Tab_4_Block_1:

      t4block1title = 1-Lambda Expressions
      t4block1rows = 7

      t4block1x = 15
      t4block1y = 40
      t4block1w = 425

      t4block1data= 
      (
        ~~~~~~~~~~~~~~~~~~|~~~~~~|~~~~~~|~~~~~~~~~~|~~~~~~~
        Consumer|accept()|1|no|yes
        Supplier|get()|0|yes|no
        Predicate|test()|1|yes-boolean|yes
        Function|apply()|1|yes|yes
        UnaryOperator|depends|1|yes-same type|yes
        Note: most have bi version||||
      )

      ; BUILD
      Gui, Font, Verdana s12 cPurple bold underline
      Gui, Add, Text, x%t4block1x% y%t4block1y%, %t4block1Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t4block1x% y+6 w%t4block1w% r%t4block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Interface|method|# inputs|outputs|chainable

      Loop, Parse, t4block1data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2, data3, data4, data5)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 
      LV_ModifyCol(3, "AutoHdr") 
      LV_ModifyCol(4, "AutoHdr") 
      LV_ModifyCol(5, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 2

    Tab_4_Block_2:

      t4block2title = 2-Stream Collection Interface
      t4block2rows =16

      t4block2x = 15
      t4block2y = 220
      t4block2w = 425

      t4block2data= 
      (
        ~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~
        toList()|List<T>|Unmodifiable version better
        toSet()|Set<T>|Unmodifiable version better
        toMap()|Set<T>|Unmodifiable version better
        toCollection()|Collection<T>|
        counting()|Long|
        summingint()|Long|
        averagingInt()|Double|
        joining()|String|
        maxBy()|Optional<T>|
        minBy()|Optional<T>|
        reducing()|N/A|
        groupingBy()|Map<K,List<T>>|
        partitioningBy()|Map<Boolean, List<T>>|
        collectingAndThen()|Collector<T>, Function<T>|
        comparing()|?|
      )

      Gui, Font, Verdana s12 cBlue bold underline
      Gui, Add, Text, x%t4block2x% y%t4block2y%, %t4block2Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t4block2x% y+6 w%t4block2w% r%t4block2rows% Hdr Grid NoSortHdr NoSort ReadOnly, Method|Return Type|Comments

      Loop, Parse, t4block2data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2, data3)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 
      LV_ModifyCol(3, "AutoHdr") 
      LV_ModifyCol(4, "AutoHdr") 
      LV_ModifyCol(5, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 3

    Tab_4_Block_3:

      t4block3title = 3-Stream Commands
      t4block3rows = 20

      t4block3x = 450
      t4block3y = 180
      t4block3w = 425

      t4block3data = 
      (
        ~~~~~~~~~~|~~~~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~
        allMatch|Terminal|N/A|
        anyMatch|Terminal|N/A|
        collect|Terminal|See Collection Section|
        count|Terminal|N/A|
        distinct|Intermediate|N/A|
        filter|Intermediate|N/A|
        findAny|Terminal|N/A|
        findFirst|Terminal|N/A|
        flatMap|Intermediate|N/A|
        forEach|Terminal|N/A|
        limit|Intermediate|N/A|
        map|Intermediate|N/A|
        min, max|Terminal|N/A|
        noneMatch|Terminal|N/A|
        peek|Intermediate|N/A|
        reduce|Terminal|N/A|
        skip|Intermediate|N/A|
        sorted|Intermediate|N/A|
        toArray|Terminal|N/A|
      )

      Gui, Font, Verdana s12 cRed bold underline
      Gui, Add, Text, x%t4block3x% y%t4block3y%, %t4block3Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t4block3x% y+6 w%t4block3w% r%t4block3rows% Hdr Grid NoSortHdr NoSort ReadOnly, Operation|Type|Output|Purpose

      Loop, Parse, t4block3data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2, data3, data4)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 
      LV_ModifyCol(3, "AutoHdr") 
      LV_ModifyCol(4, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 4

    Tab_4_Block_4:

      t4block1title = 4-Lambda Method References
      t4block1rows = 5

      t4block1x = 450
      t4block1y = 40
      t4block1w = 425

      t4block1data= 
      (
        ~~~~~~~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        Class::staticMethod||||
        object::instanceMethod||||
        Class:: new|Constructor|||
      )

      ; BUILD
      Gui, Font, Verdana s12 cPurple bold underline
      Gui, Add, Text, x%t4block1x% y%t4block1y%, %t4block1Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t4block1x% y+6 w%t4block1w% r%t4block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Interface|method

      Loop, Parse, t4block1data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 
    }
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ; Tab 5 - VSCode
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  if (tab5Active = 1) {

      gui, tab, VSCode

    Tab_5_Block_1:

      t5block1title = Shortcut Keys
      t5block1rows = 20

      t5block1x = 15
      t5block1y = 40
      t5block1w = 350

      t5block1data= 
      (
        ~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~
        alt-f7|Find references
        ctrl-b|Toggle Side Bar
        f1|Command Pallet
        Win-Alt-P|Peacock Border Color
      )

      Gui, Font, Verdana s12 cPurple bold underline
      Gui, Add, Text, x%t5block1x% y%t5block1y%, %t5block1Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t5block1x% y+6 w%t5block1w% r%t5block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t5block1data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 	

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 2

    Tab_5_Block_2:

      t5block2title = JShell
      t5block2rows = 20

      t5block2x = 380
      t5block2y = 40
      t5block2w = 350

      t5block2data= 
      (
        ~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~
        alt-f7|Find references
        alt-1|open/close project sidebar
        CTRL-F1|Open AHK help (only for AHK)
        )

      Gui, Font, Verdana s12 cPurple bold underline
      Gui, Add, Text, x%t5block2x% y%t5block2y%, %t5block2Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t5block2x% y+6 w%t5block2w% r%t5block2rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t5block2data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 	
    }
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ; Tab 6 - Trello
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  if (tab6Active = 1) {

      gui, tab, Trello

    Tab_6_Block_1:

      t6block1title = 1-Shortcut Keys
      t6block1rows = 22

      t6block1x = 15
      t6block1y = 40
      t6block1w = 400

      t6block1data= 
      (
        ~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~
        B|Open header boards menu
        C|Archive
        D|Due date
        E|Quick edit
        F|
        L|Open color code selector
        V|Vote
        M|Add/remove members
        N|Create new card
        Q|My cards filtersS|Subscribe (to card)
        T|Edit title
        X|Clear all filters
        |
        /J|Label (THEN USE 0-9 FOR COLOR)
          0-9|Labels
        Enter|Open card
        ESC|Close menu or cancel editing
        |
        < or >|Move card
        Arrows|Navigate cards
      )

      Gui, Font, Verdana s12 cPurple bold underline
      Gui, Add, Text, x%t6block1x% y%t6block1y%, %t6block1Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t6block1x% y+6 w%t6block1w% r%t6block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t6block1data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 	
    }
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ; Tab 7 - Cities-Skylines
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  if (tab7Active = 1) {

      gui, tab, Cities Common

    Tab_7_Block_1:

      t7block1title = 1-Function Keys
      t7block1rows = 13

      t7block1x = 15
      t7block1y = 35
      t7block1w = 300

      t7block1data= 
      (
        ~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~
        F1|Quick save
        F2|Traffic Manager
        F3|
        F4|
        F5|
        F6|
        F7|
        F8|
        F9|
        F10|
        F11|Screenshot (Shift = HiRes)
        F12|Steam screenshot
      )

      Gui, Font, Verdana s12 cPurple bold underline
      Gui, Add, Text, x%t7block1x% y%t7block1y%, %t7block1Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t7block1x% y+6 w%t7block1w% r%t7block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t7block1data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 	

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 2

    Tab_7_Block_2:

      t7block2title = 2-Key Shortcuts
      t7block2rows = 27

      t7block2x = 325
      t7block2y = 35
      t7block2w = 295

      t7block2data= 
      (
        ~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~
        I|Info views
        Space|Pause
        Esc|Exit tool, Show Main Menu
        P|Picker
        Ctrl-Shift-P|Problem reporting tool
        Ctrl-M|Show mesh info
        Home/End|Tilt camera
        B/V|Toggle bulldozer (V = underground)
        W/A/S/D|Scroll up, left, down, right
        Z/X|Zoom in/out
        E/Q|Rotate clockwise, counter-clockwise
        R/F|Pan camera up/down
        1/2/3|Speed
        4/5|Low/High residential zoning
        6/7|Low/High commercial zoning
        8/9|Industrial/Office zoning
        0|De-zoning
        Keypad-4|Electricity
        Keypad-5|Water and Sewage
        Keypad-6|Garbage
        Keypad-7|Roads
        Keypad-8|Zoning
        Keypad-9|Districts
      )

      ; BUILD
      Gui, Font, Verdana s12 cPurple bold underline
      Gui, Add, Text, x%t7block2x% y%t7block2y%, %t7block2Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t7block2x% y+6 w%t7block2w% r%t7block2rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t7block2data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 3

    Tab_7_Block_3:

      t7block3title = 3-Camera Utilities
      t7block3rows =10
      t7block3x = 15
      t7block3y = 320
      t7block3w = 300

      t7block3data = 
      (
        ~~~~~~~~~~|~~~~~~~~~~
        Alt-R|Rotate to North
        Ctrl X/Y|Rotate X/Y Axis right 15 deg (alt=45 deg)
        Ctrl-Shift X/Y|Rotate X/Y Axis left 15 deg (alt=45 deg)
        Ctrl-Shift 1-9|Save camera position
        Ctrl 1-9|Load saved camera positon
        Ctrl-Shift C|Center camera
        Ctrl-Shift Up/Dn| Change FOV (Left arrow resets)
      )

      Gui, Font, Verdana s12 cRed bold underline
      Gui, Add, Text, x%t7block3x% y%t7block3y%, %t7block3Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t7block3x% y+6 w%t7block3w% r%t7block3rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t7block3data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 4

    Tab_7_Block_4:

      t7block4title = 4-Landscaping
      t7block4rows = 12

      t7block4x = 635
      t7block4y = 40
      t7block4w = 300

      t7block4data = 
      (
        Keypad +/-| Increase/Decrease brush size
        Shift-Keypad +/-| Increase/decrease brush strength
        Y|Select game areas
        U|Unlock panel
        Shift-P|Prop & Tree Anarchy
      )

      Gui, Font, Verdana s12 cRed bold underline
      Gui, Add, Text, x%t7block4x% y%t7block4y%, %t7block4Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t7block4x% y+6 w%t7block4w% r%t7block4rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t7block4data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 5

    Tab_7_Block_5:

      t7block5title = 5-Xxxx

      t7block5rows = 11

      t7block5x = 635
      t7block5y = 310
      t7block5w = 300

      t7block5data= 
      (
      )

      Gui, Font, Verdana s12 cNavy bold underline
      Gui, Add, Text, x%t7block5x% y%t7block5y%, %t7block5Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t7block5x% y+6 w%t7block5w% r%t7block5rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t7block5data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 6

    
    }
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ; Tab 8 - Cities Skylines - Roads
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  if (tab8Active = 1) {

      Gui, Tab, Cities Roads

    Tab_8_Block_1:

      t8block1title = 1-Traffic Manager
      t8block1rows =17

      t8block1x = 15
      t8block1y = 40
      t8block1w = 270

      t8block1data= 
      (
        ~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~
        Esc|Exit tool
        F2|Open menu
        Shift-CLick|Select/apply to entire route
        Right-click|Deselect route/action
        Pg-Dn/Up|Underground/Overground view
        Ctrl-click junction|Give all roads a turn lane
        Del/Bkspc|Remove all lane connectors
        Ctrl-T|Traffic Lights
        Ctrl-A|Arrows
        Ctrl-C|Lane Connections
        Ctrl-S|Priorities
        Ctrl-J|Junctions
        Ctrl-L|Speed limits
        Ctrl-T|Traffic Lights
      )

      Gui, Font, Verdana s12 cGreen bold underline
      Gui, Add, Text, x%t8block1x% y%t8block1y%, %t8block1Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t8block1x% y+6 w%t8block1w% r%t8block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t8block1data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 2

    Tab_8_Block_2:

      t8block2title = 2-Roundabout/Pedestrian Builder
      t8block2rows = 8

      t8block2x = 295
      t8block2y = 40
      t8block2w = 270

      t8block2data= 
      (
        ~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~
        Roundabouts:|
        Ctrl-O|Open/close
        =/-|Adjust roundabout radius
        |
        Pedestrian Bridge:|
        Ctrl-B|Open/close
      )

      Gui, Font, Verdana s12 cBlue bold underline
      Gui, Add, Text, x%t8block2x% y%t8block2y%, %t8block2Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t8block2x% y+6 w%t8block2w% r%t8block2rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t8block2data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 3

    Tab_8_Block_3:

      t8block3title = 3-Parallel Road Tool
      t8block3rows = 10

      t8block3x = 575
      t8block3y = 40
      t8block3w = 380

      t8block3data= 
      (
        ~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        Ctrl-P|Toggle (anarchy button does not always work)
        Ctrl-=/-|Increase/decrease horizontal spacing
        Ctrl-Shift-=/-|Increase/decrease vertical spacing
      )

      Gui, Font, Verdana s12 cPurple bold underline
      Gui, Add, Text, x%t8block3x% y%t8block3y%, %t8block3Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t8block3x% y+6 w%t8block3w% r%t8block3rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

      Loop, Parse, t8block3data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 4

    Tab_8_Block_4:

      t8block4title = 4-Fine Road/Anarchy Tool
      t8block4rows = 12

      t8block4x = 575
      t8block4y = 270
      t8block4w = 380

      t8block4data= 
      (
        ~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~
        Ctrl-A|Toggle Anarchy
        Pg Up/Dn|Elevation
        Ctrl-Up/Dn|Elevation Step Up/Down
        Home|Reset Elevation
        Ctrl-Right/Left|Cycle Modes Left/Right
        Shift-S|Toggle Straight Slope
        Ctrl-B|Toggle Bending
        Ctrl-S|Toggle Snapping
        Alt-C|Toggle Collision
        Alt-G|Toggle Editor Grid
      )

      Gui, Font, Verdana s12 cRed bold underline
      Gui, Add, Text, x%t8block4x% y%t8block4y%, %t8block4Title%
      Gui, Font, Verdana s9 cBlack norm

      Gui, Add, Listview, x%t8block4x% y+6 w%t8block4w% r%t8block4rows% Hdr Grid NoSortHdr NoSort ReadOnly, Command|Function

      Loop, Parse, t8block4data, `n, `r
      {
        StringSplit, data, A_LoopField, | 
        LV_Add("", data1, data2)
      }

      LV_ModifyCol() ; Auto width columns()
      LV_ModifyCol(1, "AutoHdr") 
      LV_ModifyCol(2, "AutoHdr") 

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 5

    Tab_8_Block_5:

      t8block5title = 5-Other Keys
      t8block5rows = 8

      t8block5x = 15
      t8block5y = 390
      t8block5w = 270

      t8block5data= 
      (
        ~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~
        Ctrl-0 (zero)|Broken Nodes Detector
        Precision|Engineering:
          Ctrl|Snapping is in 5 degreesteps
          Shift|Show additional info
          Alt|Snap to guidelines
          Elektrix Road Tools|
          Shift-C|De-select nodes
        )

        Gui, Font, Verdana s12 cNavy bold underline
        Gui, Add, Text, x%t8block5x% y%t8block5y%, %t8block5Title%
        Gui, Font, Verdana s9 cBlack norm

        Gui, Add, Listview, x%t8block5x% y+6 w%t8block5w% r%t8block5rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

        Loop, Parse, t8block5data, `n, `r
        {
          StringSplit, data, A_LoopField, | 
          LV_Add("", data1, data2)
        }

        LV_ModifyCol() ; Auto width columns()
        LV_ModifyCol(1, "AutoHdr") 
        LV_ModifyCol(2, "AutoHdr") 

        ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        ; Block 6

    Tab_8_Block_6:

          t8block6title = 6-Intersection Tool
          t8block6rows = 14

          t8block6x = 295
          t8block6y = 235
          t8block6w = 270

          t8block6data= 
          (
            ~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~
            Ctrl-L|Activate
            Ctrl-Shift D|Delete all node lines
            Ctrl-Shift R|Reset all points offset
            Ctrl-Shift A|Add new line rule
            Ctrl-Shift F|Add new filler
            Ctrl-Shift C|Copy marking
            Ctrl-Shift V|Paste marking
            Ctrl-Shift E|Change marking color

          )

          Gui, Font, Verdana s12 cTeal bold underline
          Gui, Add, Text, x%t8block6x% y%t8block6y%, %t8block6Title%
          Gui, Font, Verdana s9 cBlack norm

          Gui, Add, Listview, x%t8block6x% y+6 w%t8block6w% r%t8block6rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

          Loop, Parse, t8block6data, `n, `r
          {
            StringSplit, data, A_LoopField, | 
            LV_Add("", data1, data2)
          }

          LV_ModifyCol() ; Auto width columns()
          LV_ModifyCol(1, "AutoHdr") 
          LV_ModifyCol(2, "AutoHdr") 
        }

  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ; Tab 9 - Cities Skylines Move/Find
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  if (tab9Active = 1) {
       Gui, Tab, Cities Move/Find

      ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ; Block 1

      Tab_9_Block_1:

          t9block1title = 1-Find It!
          t9block1rows =13

          t9block1x = 15
          t9block1y = 40
          t9block1w = 270

          t9block1data= 
          (
            ~~~~~~~~~~|~~~~~~~~~~
            Ctrl-F|Open/close
            Alt-1|All
            Alt-2|Network
            Alt-3|Ploppable
            Alt-4|Growable
            Alt-5|RICO
            Alt-6|Grwb/RICO
            Alt-7|Prop
            Alt-8|Decal
            Alt-9|Tree
            Alt-v|Random Selection
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

          LV_ModifyCol() ; Auto width columns()
          LV_ModifyCol(1, "AutoHdr") 
          LV_ModifyCol(2, "AutoHdr") 

          ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          ; Block 2

      Tab_9_Block_2:

          t9block2title = 2-Move It!
          t9block2rows = 22

          t9block2x = 295
          t9block2y = 40
          t9block2w = 300

          t9block2data= 
          (
            ~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~
            M|Open tool
            Shift-left-click|Select multiple elements
            Move (Left-click):|
            Alt|Enables Snapping
            Shift|Low detail
            Ctrl|Precision mode
            Rotate (Right-click):|
            Alt|Rotate 45 degree increments
            Shift|Low detail
            Ctrl|Precsion mode
            Keyboard:| 
            Left/Right|Move Left/Right 2 meters 
            Pg Up/Dn|Move Up/Down .125 meters
            Shift|Increases distance 8 times
            Alt|Decrease distance 1/8th
            Toolbox-Height:|
            Ctrl-H|Move to object Height
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

          LV_ModifyCol() ; Auto width columns()
          LV_ModifyCol(1, "AutoHdr") 
          LV_ModifyCol(2, "AutoHdr") 

          ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          ; Block 3

      Tab_9_Block_3:

          t9block3title = 3-Other Keys
          t9block3rows = 13

          t9block3x = 605
          t9block3y = 40
          t9block3w = 320

          t9block3data= 
          (
            ~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            P|Picker Tool
            Shift-C|Elektrix De-select
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

          LV_ModifyCol() ; Auto width columns()
          LV_ModifyCol(1, "AutoHdr") 
          LV_ModifyCol(2, "AutoHdr") 

        }
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ; Tab 10 - Surviving Mars
  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  if (tab10Active) {
          gui, tab, Mars

          ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          ; Block 1

        Tab_10_Block_1:

          t10block1title = Shortcut Keys
          t10block1rows = 28

          t10block1x = 15
          t10block1y = 40
          t10block1w = 350

          t10block1data= 
          (
            ~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~
            W|Pan Up
            S|Pan Down
            A|Pan Left
            D|Pan Right
            Q|Rotate Camera Left
            E|Rotate Camera Right
            Home|Reset Camera
            -|
            Space|Pause
            +|Speed Up
            -|Slow Down
            Numpad *|Toggle High Speed
            -|
            R|Rotate Building Left
            T|Rotate Building Right
            -|
            X|Deploy Orbital Probe
            Y|Radio
            Pg-Up|Next Dome
            Pg-Dn|Prev Dome
            Delete|Salvage
            Backspace|Last Notification
            End|Last Constructed Building
          )

          Gui, Font, Verdana s12 cPurple bold underline
          Gui, Add, Text, x%t10block1x% y%t10block1y%, %t10block1Title%
          Gui, Font, Verdana s9 cBlack norm

          Gui, Add, Listview, x%t10block1x% y+6 w%t10block1w% r%t10block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

          Loop, Parse, t10block1data, `n, `r
          {
            StringSplit, data, A_LoopField, | 
            LV_Add("", data1, data2)
          }

          LV_ModifyCol() ; Auto width columns()
          LV_ModifyCol(1, "AutoHdr") 
          LV_ModifyCol(2, "AutoHdr") 	

          ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          ; Block 2

        Tab_10_Block_2:

          t10block2title = More Keys
          t10block2rows = 20

          t10block2x = 380
          t10block2y = 40
          t10block2w = 350

          t10block2data= 
          (
            ~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~
            B|Build Menu
            M|Map Menu
            P|Resupply Screen
            H|Research Screen
            O|Colony Overview
            L|Milestones
            -|
            C|Power Cables
            V|Pipes
            J|Large Solar
            K|Power Accumulator
            N|Solar Panel
            U|Universal Depot
          )

          Gui, Font, Verdana s12 cPurple bold underline
          Gui, Add, Text, x%t10block2x% y%t10block2y%, %t10block2Title%
          Gui, Font, Verdana s9 cBlack norm

          Gui, Add, Listview, x%t10block2x% y+6 w%t10block2w% r%t10block2rows% Hdr Grid NoSortHdr NoSort ReadOnly, Key|Function

          Loop, Parse, t10block2data, `n, `r
          {
            StringSplit, data, A_LoopField, | 
            LV_Add("", data1, data2)
          }

          LV_ModifyCol() ; Auto width columns()
          LV_ModifyCol(1, "AutoHdr") 
          LV_ModifyCol(2, "AutoHdr") 	
        }
        Return