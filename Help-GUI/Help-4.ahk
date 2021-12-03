#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

^!+h::
  KeyWait Control
  KeyWait Alt

  tab1active = 1
  tab2active = 1

Start:
  ; ~  Setup tabs
  Gui, Font, Verdana s12 cBlack bold underline

  gui, add, tab3, x6 y6 vtabs -wrap, Trello|VSCode

  ; The loops are strictly for the ability to collapse them in the editor for navigability.
  ;Gosub, BuildTab-1

  ; @@@@@@@@@@@@@ End of Tabs
  Gui, Show, xCenter yCenter AutoSize, Minecraft Help: %versioninfo%
  
  Return

  GuiEscape:
    Gui, Destroy
  return

  GuiClose:
    gui, Destroy
  return

ExitApp

If (tab1active = 1) {
  Gui, Tab, Trello
  Loop, 1 { ; Build a block 
    t1block1title = 1-Function Keys
    t1block1rows =13
    t1block1x = 15
    t1block1y = 40
    t1block1w = 270
    t1block1data= 
    (
      ~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~
      f1|Show/hide HUD

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
    LV_ModifyCol(2, "AutoHdr") Xxxx
  }
}

If (tab2active = 1 ) {
  Gui, Tab, VSCode
  Loop, 1 { ; Build a block 
    t1block1title = 1-Function Keys
    t1block1rows =13
    t1block1x = 15
    t1block1y = 40
    t1block1w = 270
    t1block1data= 
    (
      ~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~
      f1|Show/hide HUD

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
  }

  LV_ModifyCol() ; Auto width columns()
  LV_ModifyCol(1, "AutoHdr") 
  LV_ModifyCol(2, "AutoHdr") Xxxx
}

Return
