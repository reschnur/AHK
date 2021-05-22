; https://www.autohotkey.com/boards/viewtopic.php?t=29336#p137949
Gui,1:default
Gui, 1:Add, Tab, AltSubmit -Wrap , One|Two

Gui, 1:Tab, 1
Gui, 1:Add, ListView, gMyListView vA1 altsubmit,Tab No|Line No
LV_Add("","Tab 1", "Line 1")
LV_Add("","Tab 1", "Line 2")
LV_Add("","Tab 1", "Line 3")
Gui,add,button,x10 y150  gT1,TEST1

Gui, 1:Tab, 2
Gui, 1:Add, ListView, gMyListView vA2 altsubmit,Tab No|Line No
LV_Add("","Tab 2", "Line 1")
LV_Add("","Tab 2", "Line 2")
LV_Add("","Tab 2", "Line 3")
LV_Add("","TEST" , "Line 4")
Gui,add,button,x10 y150  gT2,TEST2
Gui, 1:Show, , Tabs
return

Guiclose:
exitapp

T1:
Gui,1:submit,nohide
Gui,1:Listview,A%whichTab%
msgbox,This is Tab1
return


T2:
Gui,1:submit,nohide
Gui,1:Listview,A%whichTab%
msgbox,This is Tab2
return


MyListView:
ControlGet, whichTab, Tab, , SysTabControl321, Tabs
Gui,1:submit,nohide
Gui,1:Listview,A%whichTab%
GC:=LV_GetCount()
if A_GuiEvent = Normal          ;click once
  {
  LV_Gettext(C1,A_eventinfo,1)
  LV_Gettext(C2,A_eventinfo,2)
  msgbox,Total Rows=%gc%`nC1=%c1%`nC2=%c2%
  }
Return
