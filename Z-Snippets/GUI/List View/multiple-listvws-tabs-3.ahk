;- ListView-Example - 2-TAB / MODIFY / DELETE / ADD-New / RUN> URL,Program,Email 
; https://www.autohotkey.com/boards/viewtopic.php?t=3384
modified = 20181128
created  = 20181128

#NoEnv
#Warn
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode 2
SetBatchLines, -1
FileEncoding, UTF-8

MainWindowTitle=ListView_Test
dlm = `;

gosub,test1    ;-- create 2 text-files for 2 ListViews  ( test )

Gui,2:default
Gui,2: -DPIScale
SS_REALSIZECONTROL := 0x40
Gui,2:Font,s12 cGray, Verdana
Gui,2:Color,Black,

    gui,2:add, Tab2, x10 y10 w850 h470 gtabchange vTabNr AltSubmit, Adress|Regex

        gui,2:tab, Adress
            gui,2:add, listview,x20 y60 w820 h400 grid cWhite backgroundteal hwndLV1 v1 gLVEvents +altsubmit -multi, Name|Surname|Phone
  		    T1=300
            T2=300
            T3=200
		    LV_ModifyCol(1,T1)
            LV_ModifyCol(2,T2)
			LV_ModifyCol(3,T3)
			lv=1
			fx=%f1%
            gosub,fill
            Gui,2:add,button, x400 y510 gAddNew,ADD_NEW-1

        gui,2:tab, Regex
            gui,2:add, listview,x20 y60 w820 h400 grid cWhite backgroundteal hwndLV2 v2 gLVEvents +altsubmit -multi, Name|URL
			T2a:=500
			LV_ModifyCol(1,T1)
            LV_ModifyCol(2,T2a)
			lv=2
            fx=%f2%
            gosub,fill
		
            Gui,2:add,button, x400 y510 gAddNew,ADD_NEW-2

			;--------- rightclick Listview Row ------------
Menu, CMenu, Add, DELETE , menuDo
Menu, CMenu, Add, MODIFY , menuDo

gui,2: show,x10 y1 w1000 h570,%MainWindowTitle%
RETURN
;--------------------------
2Guiclose:
exitapp
;--------------------------

;-------------------------------------------------------------------------------------
tabchange:
GuiControlGet, TabNr
Return
;-------------------------------------------------------------------------------------



;-------------- Fill Listview xy.CSV -----------
Fill:
Gui,2:default
LV_Delete()
FileRead,aac,  *P65001 %fx% ;-read as UTF-8
for each, Line in StrSplit(aac, "`n", "`r")
{
if line=
  continue
Columns := StrSplit(Line,dlm)
LV_Add("",Columns*)
}
return
;------------------------------------------------

LVevents:
Gui,2:default
Gui,2:submit,nohide
gui,2:listview,%TabNr%
;------------
if (TabNr=1)
{
fx=%f1%
total=3
}
if (TabNr=2)
{
fx=%f2%
total=2
}
;------------
  RN:=LV_GetNext("C")
  RF:=LV_GetNext("F")
  GC:=LV_GetCount()
  if (rn=0)
    return

;-----------------  
if A_GuiEvent = Doubleclick
  {
  Row := A_EventInfo
  Col := LV_SubitemHitTest(LV1)
  LV_GetText(result, Row, Col)
  stringmid,urlx ,result,1,4
  stringmid,pathx,result,2,2
  if (urlx="http" || pathx=":\")
     {
     try
	 run,%result%
 	 catch e 
	 {
     xxx:=e.Message
     msgbox, 262208,ERROR,Error=`n%xxx%`n------------------------------------------`n%result%
     }
	 return
	 }
	 
  if result contains @
     {
     try	 
     run, mailto:%result%?subject=Greetings&body=Hello how are you?`%0A`%0ATest1`%0ATest2  
	 return
     }
  }
;--------------
  
  if A_GuiEvent = Rightclick
  {
  Row := A_EventInfo
  Col := LV_SubitemHitTest(LV1)
  LV_GetText(result, Row, Col)
  loop,%total%
     c%a_index%:=""
  all:=""
  loop,%total% 
    {
    LV_GetText(colx,a_eventinfo,a_index)
	all .= colx . dlm
	}
  stringtrimright,cx,all,1	
  goto,menux
  }
return


;------------- MENU when rightclick on row ----------
menux:
if (rn=0)
  return
MouseGetPos, musX, musY
Menu, CMenu, Show, %musX%,%musY%
return

menudo:
Gui,2:submit,nohide
If (A_ThisMenuItem = "DELETE")
   gosub,DELETEx                   ;- <<<
If (A_ThisMenuItem = "MODIFY")
   gosub,MODIFYx                   ;- <<<
return

;======================================================================


;========================== deleteONE ============================
DELETEx:
Gui,2:submit,nohide
   ;MsgBox,You selected column=%col% in row=%row%  =>> %result%`n-------------------`nALL=`n%cx%
   msgbox, 262436,Delete,Want you really delete the row %row%=`n%cx% ?
    IfMsgBox,No
       Return
      FileRead,AA,%Fx%
      Filedelete,%Fx%
      StringReplace,BB,AA,%cx%`r`n,,
      FileAppend,%BB%,%Fx%
aa=
bb=	  
gosub,fill	  
return
;=================================================================


;================ modify ======================================
MODIFYx:
Gui,2:submit,nohide

loop,parse,cx,`n,`r
{
if (a_loopfield="")
  continue
loop,%total%
 {
 C%a_index%:=""
 H%a_index%:=""
 }
stringsplit,c,a_loopfield,%dlm%        ;-- add columns
}

GUI,3:+AlwaysOnTop
Gui,3:Font,  S12 CBlack , Lucida Console

x :=10
y :=20
d :=15
Gui,3:add,text,section x%x% y%y% w0 h0,
I=0
Loop,%total%
    {
    i++
    i:=SubStr(0 i, -1)                         ;- i 01-09
    ch:=h%a_index%
	Gui,3:add,text,xs y+%d% h27,%ch%
    }
	
x :=120
Gui,3:add,text,section x%x% y%y% w0 h0,
I=0
Loop,%total%
    {
    i++
    i:=SubStr(0 i, -1)                         ;- i 01-09
    ch:=h%a_index%
	Gui,3:add,edit,xs y+%d% w700 h27 vE%a_index%,% C%a_index%
   }

   
Gui,3:Add, Button,  x850 y10 w40  h27, OK
Gui,3:show,x500 y10 w900 ,MODIFY	
GuiControl,3:Focus,E1
send,^{end}
return
;--------------
3GuiClose:
3GuiEscape:
Gui, 3:Destroy
return
;--------------
3ButtonOK:
Gui,3:submit
if E1=
   {
   Gui,3: Destroy
   return
   }

cm:=""	   
loop,%total%
    cm .= c%a_index% . dlm
stringtrimright,cm,cm,1
en:=""	   
loop,%total%
    en .= e%a_index% . dlm
stringtrimright,en,en,1

FileRead,Filecontent,  *P65001 %fx% 

FileDelete, %fx%
StringReplace, FileContent, FileContent, %cm%,%en%
FileAppend, %FileContent%, %fx%,UTF-8
Gui,3:destroy
filecontent=
GoSub,fill                  ;- <<<
return
;======================= END MODIFY ==============================



;================== ADD NEW ==================================
;------------- Listbox ADD NEW ----------------------------
addNew:
Gui,2:submit,nohide
SplitPath,Fx, name, dir, ext, name_no_ext, drive
if (ext="")
  return
loop,%total%
   {
   C%a_index%:=""
   H%a_index%:=""
   }
Gui,96:+Owner
GUI,96:+AlwaysOnTop
Gui,96:Font,  S12 CBlack , Lucida Console

x :=10
y :=20
d :=15
Gui,96:add,text,section x%x% y%y% w0 h0,
I=0
Loop,%total%
    {
    i++
    i:=SubStr(0 i, -1)                         ;- i 01-09
    ch:=h%a_index%
	Gui,96:add,text,xs y+%d% h27,%ch%
    }
	
x :=120
Gui,96:add,text,section x%x% y%y% w0 h0,
I=0
Loop,%total%
    {
    i++
    i:=SubStr(0 i, -1)                         ;- i 01-09
    ch:=h%a_index%
	Gui,96:add,edit,xs y+%d% w700 h27 vC%a_index%,
   }
   
Gui,96:Add, Button,  x850 y10 w40  h27, OK
Gui,96:show,x500 y10 w900 ,ADD_NEW
GuiControl,96:Focus,C1
send,^{end}
return
  
   ;-----------
   96GuiClose:
   96GuiEscape:
   Gui,96:Destroy
   return
   ;-----------
   96ButtonOK:
   Gui,96:submit
   ch:=""	   
   loop,%total%
      ch .= c%a_index% . dlm
   stringtrimright,ch,ch,1	  
   if C1<>
   FileAppend,%ch%`r`n,%fx%,UTF-8
   ch=
   loop,%total%
     C%a_index%:=""
   Gui,96:Destroy
   Gosub,fill
return
;====================== END ADD NEW =======================



;================== function from user 'just me' ==============================
; https://autohotkey.com/board/topic/80265-solved-which-column-is-clicked-in-listview/
LV_SubitemHitTest(HLV) {
   ; To run this with AHK_Basic change all DllCall types "Ptr" to "UInt", please.
   ; HLV - ListView's HWND
   Static LVM_SUBITEMHITTEST := 0x1039
   VarSetCapacity(POINT, 8, 0)
   ; Get the current cursor position in screen coordinates
   DllCall("User32.dll\GetCursorPos", "Ptr", &POINT)
   ; Convert them to client coordinates related to the ListView
   DllCall("User32.dll\ScreenToClient", "Ptr", HLV, "Ptr", &POINT)
   ; Create a LVHITTESTINFO structure (see below)
   VarSetCapacity(LVHITTESTINFO, 24, 0)
   ; Store the relative mouse coordinates
   NumPut(NumGet(POINT, 0, "Int"), LVHITTESTINFO, 0, "Int")
   NumPut(NumGet(POINT, 4, "Int"), LVHITTESTINFO, 4, "Int")
   ; Send a LVM_SUBITEMHITTEST to the ListView
   SendMessage, LVM_SUBITEMHITTEST, 0, &LVHITTESTINFO, , ahk_id %HLV%
   ; If no item was found on this position, the return value is -1
   If (ErrorLevel = -1)
      Return 0
   ; Get the corresponding subitem (column)
   Subitem := NumGet(LVHITTESTINFO, 16, "Int") + 1
   Return Subitem
}
;================================================================================

;===============================================
;--- create a testfile ---------------
test1:
;dlm = `,
F1=%A_scriptdir%\test1.txt
ifnotexist,%f1%
{
  e1=
  (Ltrim Join`r`n
  Miller%dlm%Harry%dlm%123
  Garry%dlm%Email%dlm%garry@aol.pt
  Windows%dlm%Program%dlm%C:\windows
  Lilian de Celis%dlm%https://www.youtube.com/watch?v=EFSZnC3-E4A%dlm%
  Li Xiang Lan%dlm%https://www.youtube.com/watch?v=yKbzBGntI8Q%dlm%
  )
Fileappend,%e1%`r`n,%f1%
}

F2=%A_scriptdir%\test2.txt
ifnotexist,%f2%
{
  e2=
  (Ltrim Join`r`n
  2-REGEX ahk%dlm%https://www.autohotkey.com/docs/misc/RegEx-QuickRef.htm
  2-REGEX regular%dlm%https://www.regular-expressions.info/
  2-REGEX regenechsen%dlm%http://www.regenechsen.de/phpwcms/index.php
  2-Regex 101%dlm%https://regex101.com/
  )
Fileappend,%e2%`r`n,%f2%
}
e1=
e2=
return
;--- end create a testfile -----------

;================== END script ==========================================================
