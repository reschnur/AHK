;- https://autohotkey.com/boards/viewtopic.php?f=28&t=3384&p=245251#p245251  
;
;- modified= 20181102
;- created = 20181020

;- ListView example depending screensize %  ( e.g. FHD-1920*1080 or 4K-3840*2160 ) 
;- defined to read max 26 columns with different delimiters like = `,`;`|   ( delimiters not allowed inside columns )

;- DELETE (multiple) row's  (rightclick-ROW)         ;- if search is used you can't DELETE row's
;- MODIFY ( EDIT ) columns  (rightclick-ROW)         ;-
;- ADD new                                           ;-
;- Click column to start program/url/email           ;-
;- SEARCH                                            ;-
;- PRINT formatted                                   ;-
;- PRINT what you see formatted                      ;-
;- Drag&Drop CSV-File                                ;-
;- Drag-GUI                                          ;-
;- Open different folders/files (rightclick-Listbox) ;-
;- Add textfile / picture etc to defined folder      ;-
;- Change LV-Header depending Listbox-name.csv       ;- 
;------------------------------------------------------

#warn
#NoEnv
#SingleInstance Force
SetBatchLines -1
setworkingdir,%a_scriptdir%
MainWindowTitle=ListView_Test1 
;MsgBox % A_IsUnicode
FileEncoding, UTF-8
Gui,1:default
Gui,1: -DPIScale
SS_REALSIZECONTROL := 0x40
LVM_GETCOLUMNWIDTH=0x101D     ;- get ListViewColumnWidth with loop to modify columns-width
Gui,1: +LastFound

  
M_LBfolders =%a_scriptdir%\M_LB-FOLDERS
ifnotexist,%m_lbfolders%
  filecreatedir,%m_lbfolders%


columntot:=26                 ;- total max columns ( can be changed ) shows only existing columns

setformat,float,0.0
wa:=A_screenwidth
ha:=A_screenHeight


;--- ( for print use non proportional script like Lucida console etc ... )
if (wa=3840)
  Gui,1:Font,s12 cBlack,Lucida Console
if (wa=1920)
  Gui,1:Font,s10 cBlack,Lucida Console

xx:=101
LBW  :=(wa*10)   /xx
LVW  :=(wa*89)   /xx       ;- LV  width    at 4K UHD (3840/89)/100 = 3417.6   FHD/FullHD=(1920*1080)   4K-UHD=(3840*2160)
LVH  :=(ha*83)   /xx       ;- LV  height
GUW  :=(wa*99.8) /xx       ;- GUI width
GUH  :=(ha*94)   /xx       ;- GUI height


Gui,1:Color,Black
Gui,1:Color,ControlColor, Black
Gui,1:Font,s12 cBlack,Lucida Console

gosub,testfile                                                          ;-<<<< create testfile F1

x  :=(wa*.2)/xx
y  :=(ha*.3)/xx
Gui,1:add,Listbox, cWhite  x%x%  y%y% w%lbw% h%lvh% Sort vLB1 gLB


x :=(wa*.2)/xx
y :=(ha*84)/xx
h :=(ha*10)/xx
Gui,1:add,Listbox   , cGray  x%x%  y%y% w%lbw% h%h% vDrag  -vscroll,  ;- drag & drop a csv-file here


;--------- column names columntot=26 --------------------------------------------------------------
sect=A1,B2,C3,D4,E5,F6,G7,H8,I9,J10,K11,L12,M13,N14,O15,P16,Q17,R18,S19,T20,U21,V22,W23,X24,Y25,Z26	
stringsplit,h,sect,`,
ch:=""	   
loop,%columntot%
    ch .= h%a_index% . "|"
	
x :=(wa*10.6 )/xx
y :=(ha*.3)/xx
Gui, Add, ListView, x%x% y%y% h%lvh% w%lvw% Grid +altsubmit backgroundGray gLvHandler vLV1 +HWNDLV1,%ch%
loop,%columntot%
  LV_ModifyCol(a_index,0)


x:=(wa*11)/xx
y:=(ha*86)/xx
Gui,1: Add,Text, x%x%  y%y%  cYellow, Search:

x:=(wa*15 )/xx
w:=(wa*10 )/xx
h:=(ha*2.6)/xx
Gui,1: Add,Edit,cWhite x%x%  y%y%  w%w%  h%h% gSearchA vsearchx

x:=(wa*25.5)/xx
w:=(wa*5 )/xx
Gui,1:add,button,      x%x%  y%y% w%w%   h%h% gClearsearch ,<Clear

x:=(wa*31)/xx
w:=(wa*5 )/xx
Gui,1: Add,Edit,cWhite x%x%  y%y%  w%w%  h%h%  readonly vCountFile1   right,
  
x:=(wa*37)/xx
w:=(wa*7 )/xx
Gui,1: Add,Edit,cWhite x%x%  y%y%  w%w%  h%h%  readonly vSearchYN     center

x:=(wa*45)/xx
w:=(wa*4 )/xx
Gui,1:add,button,      x%x%  y%y% w%w%   h%h% gPrint ,Print

x:=(wa*50)/xx
w:=(wa*5 )/xx
Gui,1:add,button,      x%x%  y%y% w%w%   h%h% gPrint2 ,Print_WYS


x:=(wa*58)/xx
w:=(wa*5 )/xx
Gui,1:add,button,      x%x%  y%y% w%w%   h%h% gAdd1 ,ADD_NEW

/*
x:=(wa*64)/xx
w:=(wa*8 )/xx
Gui,1:add,button,      x%x%  y%y% w%w%   h%h% gFolder1 ,FOLDER-CSV
*/

  
  
Gui,1: Show, x0 y0 h%guh% w%guw%,%MainWindowTitle%

;--------- rightclick Listview Row ------------
Menu, CMenu, Add, DELETE , menuDo
Menu, CMenu, Add, MODIFY , menuDo

;-------- rightclick listbox ------------------
Menu, CMenuLB, Add, Edit CSV-file            , menuDoLB
Menu, CMenuLB, Add, Open LB-EndlessTextfile  , menuDoLB
Menu, CMenuLB, Add, Open LB-Folder           , menuDoLB
Menu, CMenuLB, Add, Open CSV-Folder          , menuDoLB



Gosub,listboxfill                       ;- << fill listbox

Guicontrol,1:,searchYN,Search-NO
GuiControl,1:,Drag,Drag&Drop CSV-file|here

   
sleep,100
ControlClick, , %MainWindowTitle%            ;- click on marked file in listbox
GuiControl,1:Focus,searchx
OnMessage(0x201, "WM_LBUTTONDOWN")           ;- DragGui
Return
;========================================================
GuiClose:
ExitApp
esc::exitapp
;================== END GUI =============================

;-------------------- Fill Listbox ----------------------
Listboxfill:
GuiControl,1:,LB1,|
R3C =%a_scriptdir%\M_CSV
ifnotexist,%r3c%
  filecreatedir,%r3c%
Loop,%R3C%\*.csv
    {
   FX=%A_LoopFileName%
   stringlen,L1,FX
   stringmid,FA,FX,1,L1-4
   GuiControl,1:,LB1,%FA%                    ;-display the files in listbox
    }

;GuiControl,1:ChooseString, LB1,PT1_adress   ;- mark defined file
GuiControl,1:ChooseString, LB1,%fa%          ;- mark last listbox file
return
;--------------------------------------------------------


;--------------- Drag & Drop a csv-file -----------------
GuiDropFiles:
Extensions := "xls,csv"
GuiControl,1:,Drag,|
Loop, parse, A_GuiEvent, `n
   {
   lr:=a_loopfield
   ;GuiControl,1:,Drag,%A_LoopField%
   SplitPath,lr, name, dir, ext, name_no_ext, drive
   if Ext in %Extensions%
      {
      filecopy,%lr%,%r3c%\%name%
      if errorlevel<>0
         msgbox, 262208,FILECOPY ,The file=`n%name%`nalready exist
      }
   else
      msgbox, 262208,NOT CSV-File ,File=`n%name%`n... is not a CSV-File
   }
GuiControl,1:,Drag,Drag&Drop CSV-file|here
lr= 
gosub,listboxfill
GuiControl,1:ChooseString, LB1,%name_no_ext%   ;- mark this file
sleep,100
ControlClick, , %MainWindowTitle%              ;- click on marked file in listbox
return



;===================== PRINT formatted rows ===================
print:
Gui,1:submit,nohide
tx:=""
e :=""
aab=
;FilePrint=%a_desktop%\%a_now%_%mainwindowtitle%.txt
FilePrint=%a_desktop%\%mainwindowtitle%.txt
ifexist,%fileprint%
   filedelete,%fileprint%
FileRead,aab,  *P65001 %f1% ;-read as UTF-8
tx:=""
loop,%total%
  T%a_index%:=0
loop,%total%
  L%a_index%:=0
loop,%total%
  A%a_index%:=""
  
	Loop,parse,aab,`n,`r
     {
	 lr=%a_loopfield%
     if lr=
       continue
	 i=0
	 loop,%total%                           ;- get max lenght from x columns
	    {
		i++
        StringSplit,A,lr,%dlm%
        stringlen,L%i%,A%i%
        if (T%i%<L%i%)
           T%i%:=(L%i%+1)                   ;-maximal lenght columnX+1
		}
	 }

;- x columns
tx:=""
loop,%total%	 
 Tx .= "{:" . T%a_index% . "}" . dlm
stringtrimright,tx,tx,1
loop,%total%
  a%a_index%:=""

lr=
e:=""
a:=""
Loop, parse,aab, `n,`r
 {
 lr=%a_loopfield%
 if lr=
    continue
 a :=StrSplit(lr,dlm )
 e .= Format(tx . "`r`n",a*)
 }
fileappend,%e%,%fileprint%
run,%fileprint% 
e=
a=
aab=
return
;=============================================





;============ case-1 PRINT_WYS ====================
print2:
;-- check maximal lenght from each column ---

FilePrint=%a_desktop%\%mainwindowtitle%_WYS.txt
ifexist,%fileprint%
   filedelete,%fileprint%
ControlGet, Listx, List, , SysListView321,%mainwindowtitle%
stringreplace,listx,listx,`t,%dlm%,all
tx:=""
loop,%total%
  T%a_index%:=0
loop,%total%
  L%a_index%:=0
	Loop,parse,listx,`n,`r
     {
	 lr=%a_loopfield%
     if lr=
       continue
	 i=0
	 loop,%total%                           ;- get max lenght from x columns
	    {
		i++
        StringSplit,A,lr,%dlm%
        stringlen,L%i%,A%i%
        if (T%i%<L%i%)
           T%i%:=(L%i%+1)                   ;-maximal lenght columnX+1
		}
	 }

;- x columns
loop,%total%	 
 Tx .= "{:" . T%a_index% . "}" . dlm

stringtrimright,tx,tx,1
loop,%total%
  a%a_index%:=""

lr=
e:=""
Loop, parse,listx, `n,`r
 {
 lr=%a_loopfield%
 if lr=
    continue
 xv:=((columntot-total)-0)
 stringtrimright,lr,lr,xv                    ;- line without rest delimiter ;;;;;
 a :=StrSplit(lr,dlm )
 e .= Format(tx . "`r`n",a*)
 }
fileappend,%e%,%fileprint%
run,%fileprint% 
e=
a=
listx=
return
;=============================================








;================== SEARCH ====================
SearchA:
Gui,1:default
Gui,1:submit,nohide
Gui,1:ListView, LV1
if (searchx="")
   return
settimer,checkempty,1000
LV_Delete()
Guicontrol,1:,searchYN,Search-YES
I2=0
GuiControl,1: -Redraw,LV1

FileRead,text1,  *P65001 %f1% ;-read as UTF-8

Loop,parse,text1,`n,`r
{
loop,%total%
  z%a_index%:=""
zx= 
stringsplit,z,a_loopfield,%dlm%
loop,%total%
    zx .= z%a_index% . dlm
stringtrimright,zx,zx,1

ifinstring,zX,%searchx%
  {
    i2++
	Cns := StrSplit(zx,dlm)
	LV_Add("", cns*)
  }
}
	
GuiControl,1: +Redraw,LV1
Guicontrol,1:,CountFile1,%I2%
return

checkempty:
Gui,1:submit,nohide
if (searchx="")
   {
   settimer,checkempty,off
   gosub,fill                      ;- <<< 
   text1=
   Guicontrol,1:,searchYN,Search-NO
   return
   }
return

;--------------------------
clearsearch:
guicontrol,1:,searchx
return

;================ END SEARCH ======================




;======== FILL Listbox read selected file and SHOW in Listview ===============================
LB:
Gui,1:default
Gui,1:submit,nohide
Gui,1: Listview, LV1
Guicontrol,1:,CountFile1,
GuiControlGet,LB1
F1=%R3C%\%LB1%.csv
;--------------------
delim:=",;|"        ;- search for these delimiters ( shouldn't be in rows/text )
F=0
b=
Loop,read,%f1%
 {
   loop,parse,a_loopreadline,         ;- search last delimiter (DLM) from first column
     {
     if InStr(Delim,A_LoopField)
        {
        F++
        dlm:=A_LoopField
        }
     }
   if dlm<>	 
   break                             ;- after first line readed , break
 }
total:=(f+1)                         ;- total columns (f+1) ,

gosub,fill                           ;- <<<

return
;=================================================================

LvHandler:
Gui,1:default
Gui,1:Submit,nohide
gui,1:listview,LV1
  RN:=LV_GetNext("C")
  RF:=LV_GetNext("F")
  GC:=LV_GetCount()

if A_GuiEvent = Normal
  {
  if (rn=0)
    {
	tooltip
     return
	} 
  Row := A_EventInfo
  Col := LV_SubitemHitTest(LV1)
  LV_GetText(result, Row, Col)
  allcx:=""
  loop,%total%
    c%a_index%:=""
  i=0	
  if (col=1)
    {
  Loop,%total%
    {
    i++
    i:=SubStr(0 i, -1)                         ;- i 01-09
    LV_GetText(colx,a_eventinfo,a_index)
	c%a_index%:=colx
	allcx .= i . "- " . colx . "`n"
	}
  tooltip,column=%col%`n%result%`n-------- ROW= %row% ---------------------`n%allcx%
  sleep,8000
  tooltip
    }
  }  
 
 
  
if (A_GuiEvent == "DoubleClick")
  {
  if (rn=0)
    return
  Row := A_EventInfo
  Col := LV_SubitemHitTest(LV1)
  LV_GetText(result, Row, Col)
  all:=""
  loop,%total%
    c%a_index%:=""
  Loop,%total%
    {
    LV_GetText(colx,a_eventinfo,a_index)
	c%a_index%:=colx
	all .= colx . dlm
	}
  stringtrimright,all,all,1	
  ;MsgBox,You clicked column=%col% in row=%row%  =>> %result%`n-------------------`nALL=`n%all%
  all=
  stringmid,urlx ,result,1,4
  stringmid,pathx,result,2,2
  if (urlx="http" || pathx=":\")
     {
     try
	 run,%result%
	 }
  if result contains @
     {
     try	 
     run, mailto:%result%?subject=Greetings&body=Hello how are you?`%0A`%0ATest1`%0ATest2  
     }
  if (result="TEXT")
     {
	 ;msgbox,C1=%c1%`nC2=%c2%`nC3=%c3%`nC4=%c4%`nC5=%c5%`n
     aaff=%m_LBfolders%\%lb1%
     ifnotexist,%aaff%
        filecreatedir,%aaff%
	 Filex=%aaff%\%c1%.txt
     ifnotexist,%filex%
       Fileappend,%c1%`r`n,%filex%	 
	 try
	   {
	   Run,"%filex%"
	   sleep,2200
	   send,^{end}
	   }
	 }
  loop,%total%
    c%a_index%:=""
  result=	 
  }
  

  
  if A_GuiEvent = Rightclick
  {
  all:=""
  Loop, % LV_GetCount("Col")
    {
    LV_GetText(colx,a_eventinfo,a_index)
	all .= colx . dlm
	}
  stringtrimright,cx,all,1	
  goto,menux
  }
return  
;====================================================




;------------- when rightclick on LISTBOX open file xy.csv ----------

GuiContextMenu:
r:=a_guicontrol
GuiControlGet,%r%
;msgbox,%lb1%
if (R="LB1" and LB1!="")
  {
  sleep,200
  F1x=%R3C%\%LB1%.csv
  if LB1<>
    gosub,menulb
  }
return

;------------- MENU when rightclick on LISTBOX ----------
menuLB:
MouseGetPos, musX2, musY2
Menu, CMenuLB, Show, %musX2%,%musY2%
lb1=
r=
return


menudoLB:
Gui,submit,nohide
If (A_ThisMenuItem = "Edit CSV-file")               ;- open Listbox CSV-File
    Run, %f1x%                   
If (A_ThisMenuItem = "Open LB-EndlessTextfile")     ;- open textfile in XY-Listbox
    gosub, LBTextFile
If (A_ThisMenuItem = "Open LB-Folder")              ;- open folder   in XY-Listbox
    gosub,foldertextfiles
If (A_ThisMenuItem = "Open CSV-Folder")
    run,%r3c%	
return



;-- Open a textfile to each Listbox -----
LBTextFile:
aaff=%m_LBfolders%\%lb1%
ifnotexist,%aaff%
  filecreatedir,%aaff%
aacc=%aaff%\_%lb1%_Endless_LB.txt
ifnotexist,%aacc%
  fileappend,%aaff%`r`n,%aacc%
try
  {
  run,%aacc%  
  sleep,2200
  send,^{end}
  }
return


;--- Open folder from listbox ----
FolderTextFiles:
aaff=%m_LBfolders%\%lb1%
ifnotexist,%aaff%
  filecreatedir,%aaff%
try
  run,%aaff%
return



;------------- MENU when rightclick on row ----------
menux:
if (rn=0)
  return
MouseGetPos, musX, musY
Menu, CMenu, Show, %musX%,%musY%
return

menudo:
Gui,submit,nohide
If (A_ThisMenuItem = "DELETE")
   gosub,Recyclex                  ;- <<<
If (A_ThisMenuItem = "MODIFY")
   gosub,MODIFYx                   ;- <<<
return





;-------------- Fill Listview -----------
Fill:
Gui,1:default
Gui,1:submit,nohide
gui,1:listview,LV1
LV_Delete()
GuiControl, -Redraw, LV1
loop,%columntot%
  LV_ModifyCol(a_index,0)

i=0
FileRead,aac,  *P65001 %f1% ;-read as UTF-8

for each, Line in StrSplit(aac, "`n", "`r")
{
if line=
  continue
  I++
	Columns := StrSplit(Line,dlm)
	LV_Add("",Columns*)
}
aac=
Guicontrol,1:,CountFile1,%I%


Lvw:=0
columnwidthx:=""
diff:=(wa*.8)/xx
errorlevel:=0
wdthfix:=(wa*16)/xx
xxc:=""
Loop, %total%
{
   LV_ModifyCol(A_Index, "AutoHdr")
   SendMessage, LVM_GETCOLUMNWIDTH, A_Index - 1, 0, SysListView321
   xcc:=(errorlevel+diff)                ;- column width
   if (xcc>wdthfix)
      t%a_index%:=(wdthfix+diff)         ;- columnwidth maximal FIX 
   else
      t%a_index%:=xcc                    ;- column width
   ;t%a_index%:= wdthfix                 ;- columnwidth FIX 
   lvw += T%a_index%                     ;- each column addition
   LV_ModifyCol(a_index,T%a_index%)      ;- fit each column
   columnwidthx .= t%a_index% . "`n"
}

;---- Modify Header 
if (LB1="pearl")
{
cff=Product|Number|Price|Date|URL|Info
loop,parse,cff,`|
  {
  LV_ModifyCol(a_index,"left",a_loopfield)
  }
LV_ModifyCol(3, "Integer")
LV_ModifyCol(4, "Integer")
}

;-------- Modify Header to default A1 B2 C3 ....
else
{
i=0
Loop, 26
  {
  i++
  Char := Chr(64+A_Index) . I
  LV_ModifyCol(a_index,"left",char)
  }
i=0
}

LV_ModifyCol(1, "Sort CaseLocale")   ;-
LV_Modify(LV_GetCount(), "Vis")      ;- scrolls down
GuiControl, +Redraw, LV1
ControlClick, , %MainWindowTitle%    ;- click on marked file in listbox

;--------------- keep for test ---------------
stringtrimright,columnwidthx,columnwidthx,1
GuiControlGet, P, Pos, %LV1%
;msgbox,%columnwidthx%`n-----------------`n%lvw%    << Columns total width`nLV-width  =%PW% 
;---------------------------------------------
GuiControl,1:Focus,searchx
return
;================ END FILL ====================================





;================== ADD NEW ==================================
;------------- Listbox ADD NEW ----------------------------
add1:
Gui,1:submit,nohide
loop,%columntot%
   C%a_index%:=""
;Gui, 1:+Disabled
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
   ;Gui,1:-Disabled
   ;Gui,1:Default
   return
   ;-----------
   96ButtonOK:
   Gui,96:submit

   ch:=""	   
   loop,%total%
      ch .= c%a_index% . dlm
   stringtrimright,ch,ch,1	  
   if C1<>
   FileAppend,%ch%`r`n,%f1%,UTF-8
   ch=
   loop,%total%
     C%a_index%:=""
   Gui,96:Destroy
   ;Gui,1:-Disabled
   ;Gui,1:Default
   Gosub,fill
return
;====================== END ADD NEW =======================






;================ modify ======================================
MODIFYx:
Gui,1:submit,nohide

loop,parse,cx,`n,`r
{
if (a_loopfield="")
  continue
loop,%columntot%
 C%a_index%:=""
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

FileRead,Filecontent,  *P65001 %f1% ;-read as UTF-8

FileDelete, %f1%
StringReplace, FileContent, FileContent, %cm%,%en%
FileAppend, %FileContent%, %f1%,UTF-8
Gui,3:destroy
filecontent=
GoSub,fill                  ;- <<<
return
;======================= END MODIFY ==============================



;===================== DELETE multiple selected rows =============
Recyclex:
if (searchYN="Search-YES")
  {
  msgbox,Can't DELETE while Search 
  return
  }

C1 =
RF = 0
RFL =
Loop
   {
   RF:=LV_GetNext(RF)
   if RF=0
      break
   RFL = %RF%|%RFL%
   LV_GetText(C1_Temp, RF, 1)
   C1 = %C1%`n%C1_Temp%
  }
if C1 !=
 {
   msgbox, 262180,DELETE ,Want you really delete ? =`n------------`n%C1%
   IfMsgBox,No
      Return
   Else
   {
   Loop, parse, RFL, |
       LV_Delete(A_LoopField)
   filedelete,%F1%
   allx:=""
   k=0
   Loop % LV_GetCount()
   {
   k++
   j=0
   all:=""
   Loop,%total%
      {
	  j++
      LV_GetText(colx,k,j)
	  if colx=
	     continue
	  all .= colx . dlm
	  }
    stringtrimright,all,all,1	
    allx .= all . "`r`n" 
   }
   if allx<>   
   fileappend,%allx%,%f1%,UTF-8
  }	
 allx=
 all= 
 }
gosub,listboxfill                              ;- if all rows deleted maybe also the CSV-File is deleted
SplitPath,F1, name, dir, ext, name_no_ext, drive
GuiControl,1:ChooseString, LB1,%name_no_ext%   ;- mark this file
sleep,100
ControlClick, , %MainWindowTitle%              ;- click on marked file in listbox
return
;===================== END DELETE =================================




;================== function just me ==============================
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

;------ move GUI -------------
WM_LBUTTONDOWN(wParam, lParam, msg, hwnd)
{
Gui, +LastFound
Checkhwnd := WinExist()
if hwnd = %Checkhwnd%
   PostMessage, 0xA1, 2
;- 0x201 is the number for Windows Message WM_LBUTTONDOWN, which is the message Windows sends when the mouse clicks on our window.
;- 0xA1 is WM_NCLBUTTONDOWN, to make Windows think we clicked on the non-client area of the window (the border).
;- The "2" tells windows we clicked on caption at the top of the window, as if to drag it.
}

;================================================================
;--------------- create testfile --------------------------
testfile:
R3C =%a_scriptdir%\M_CSV
ifnotexist,%r3c%
  filecreatedir,%r3c%
Ftest1=%R3C%\PT1_Adress.csv
ifnotexist,%ftest1%
{
  e1=
  (Ltrim Join`r`n
  Maria Dolores;0211914498;Lisboa;cc
  Miguel Vaquinhas;0218868209;Porto;hhhhh
  Rodrigues Fernanda;0218234567;Setubal;kkkkkk
  Jim Reeves;0341234567;Atlanta;nnnnn
  )
Fileappend,%e1%`r`n,%ftest1%,UTF-8
e1=
}

Ftest2=%R3C%\PT2_Adress.csv
ifnotexist,%ftest2%
{
  e2=
  (Ltrim Join`r`n
  Test Maria Dolores,+34-211914498,Lisboa
  Test Miguel Vaquinhas,+33-218868209,Porto
  Test Rodrigues Fernanda,+31-218234567,Setubal
  Test Jim Reeves2,+1-341234567,Atlanta
  Test Li xiang lan / Ye lai xiang,https://www.youtube.com/watch?v=yKbzBGntI8Q,李香蘭 夜來香
  Test Windows,C:\windows,Test
  Email,garry.hughes@aol.no,Test
  )
Fileappend,%e2%`r`n,%ftest2%,UTF-8
e2=
}

Ftest3=%R3C%\PEARL.csv
ifnotexist,%ftest3%
{
  e3=
  (Ltrim Join`r`n
  PrinterCopyScanFax_PANTUM-M6600NW;PV-8850;169.95;20181031;https://www.pearl.ch/ch-a-PV8850-1121.shtml;TEXT
  Videorecorder;NX-4445;269.95;;https://www.pearl.ch/ch-a-NX4445-1241.shtml;TEXT
  )
Fileappend,%e3%`r`n,%ftest3%,UTF-8
e3=
}
 
Ftest4=%R3C%\AHK-HELP.csv
ifnotexist,%ftest4%
{
  e4=
  (Ltrim Join`r`n
  Tutorial;https://autohotkey.com/docs/Tutorial.htm;http://www.daviddeley.com/autohotkey/xprxmp/autohotkey_expression_examples.htm;https://riptutorial.com/Download/autohotkey.pdf;https://maul-esel.github.io/ahkbook/en/Introduction
  )
Fileappend,%e4%`r`n,%ftest4%,UTF-8
e4=
}

return
;============ END script ====================================
;============================================================

