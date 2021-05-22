;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

; One of each control - "count" is the gui name in case there were multiples

Gui, Count:Add, Button, x5 y7 w74 h380, Button
Gui, Count:Add, Text, x87 y15 w368 h59, Text
Gui, Count:Add, DropDownList, x91 y92 w358 h19 R5, DropDownList
Gui, Count:Add, ComboBox, x91 y126 w363 h8 R5, ComboBox
Gui, Count:Add, ListView, x92 y163 w358 h101 -0x4000000, ListView
Gui, Count:Add, Slider, x95 y278 w352 h27, 25
Gui, Count:Add, Tab2, x96 y317 w349 h322 +0x4000000 +0x2000000, Tab1|Tab2
Gui, Count:Tab
Gui, Count:Add, StatusBar, -Theme +Background0xFFFFFF, Status bar
Gui, Count:Add, Button, x102 y352 w96 h28, Button
Gui, Count:Add, Checkbox, x109 y386 w98 h39, Checkbox
Gui, Count:Add, Radio, x109 y433 w60 h18, Radio
Gui, Count:Add, Edit, x99 y651 w346 h50 -Multi, Edit
Gui, Count:Add, Picture, x470 y17 w387 h253, Picture
Gui, Count:Add, GroupBox, x477 y289 w375 h244, GroupBox
Gui, Count:Add, Button, x107 y490 w87 h31, Button
Gui, Count:Add, ListBox, x872 y22 w320 h683, ListBox
Gui, Count:Add, ListView, x482 y543 w109 h163 -0x4000000, ListView
Gui, Count:Add, DateTime, x602 y547 w253 h28, 
Gui, Count:Add, MonthCal, x609 y586 w190 h165, 
Gui, Count:Add, Button, x5 y391 w74 h380, Button
Gui, Count:Default

; Generated using SmartGuiXP Creator mod 4.3.29.7
Gui, Count:Show, x145 y94 w1207 h836, Sample GUI

Return

CountGuiClose:
ExitApp

testlabel:
; Automatic label for Menu commands

Return
