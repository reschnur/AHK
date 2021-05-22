;- LV_TV_READ-CSV_BANK with search
;- read postfinance with 6-columns / delimiter=";"
;- creates a folder with a testfile ..\M_Postfinance\Test.csv
;- save csv-file with notepad under UTF8-BOM
; https://www.autohotkey.com/boards/viewtopic.php?t=3384
;------------------------
;modified = 20181219
;created  = 20181219
;------------------------

#NoEnv
#Warn
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode 2
SetBatchLines, -1
MainWindowTitle=LV_TV_Postfinance
FileEncoding, UTF-8
;---------------
dlm = `;    ;- predefined delimiter
total:=6    ;- predefined columns
;---------------
wa:=A_screenwidth
ha:=A_screenHeight
;---------------
Gui,2:default
Gui,2: -DPIScale
SS_REALSIZECONTROL := 0x40
Gui,2:Font,s13 cBlack,Lucida Console
Gui,2:Color,Black,Black
;---------------
TreeRoot       = %a_scriptdir%\M_Postfinance
ifnotexist,%treeroot%
  filecreatedir,%treeroot%
ftest=%treeroot%\Test.csv
ifnotexist,%ftest%
 gosub,createtest
;---------------
xx:=101
LBW:=(wa*10)/xx
LBH:=(ha*83)/xx
x  :=(wa*.2)/xx
y  :=(ha*.3)/xx
Gui,2: Add, TreeView, backgroundGray vTV1 x%x% y%y% w%lbw% h%lbh% altsubmit gTreeEvent
AddSubFolderToTree(TreeRoot)
;----------------
		sect1=Date,Avisierungstext,IN,OUT,Valuta,SALDO
        stringsplit,h,sect1,`,
        ch1:=""	   
        loop,%total%
            ch1 .= h%a_index% . "|"

        T1:=(wa*5  )/xx
        T2:=(wa*65 )/xx
        T3:=(wa*5  )/xx
        T4:=(wa*5  )/xx
        T5:=0
        T6:=(wa*5  )/xx

        x :=(wa*11 )/xx
        w :=(wa*87 )/xx
        h :=(ha*80 )/xx
        y :=(ha*1  )/xx
        gui,2:add, listview,x%x% y%y% w%w% h%h% grid cWhite backgroundteal hwndLV1 vLVC1 gLVEvents +altsubmit -multi, %ch1%
        LV_ModifyCol(1,T1)
        LV_ModifyCol(2,T2)
	    LV_ModifyCol(3,T3)
	    LV_ModifyCol(4,T4)
	    LV_ModifyCol(5,T5)
	    LV_ModifyCol(6,T6)
        LV_ModifyCol(1, "Integer")
        LV_ModifyCol(3, "Integer")
        LV_ModifyCol(4, "Integer") 
        LV_ModifyCol(6, "Integer")
;----------------------

x3 :=x+t1+t2
w3 :=T3
y :=(ha*82.5  )/xx
h :=(ha*2.2 )/xx
Gui,2: Add,Edit,cWhite x%x3%  y%y%  w%w3%  h%h% readonly vIN1 right
x4 :=x+t1+t2+t3
w4 :=T4
Gui,2: Add,Edit,cWhite x%x4%  y%y%  w%w4%  h%h% readonly vOUT1 right
x6 :=x+t1+t2+t3+t4+t5
w6 :=T6
Gui,2: Add,Edit,cWhite x%x6%  y%y%  w%w6%  h%h% readonly vSaldo right
y :=(ha*85  )/xx
Gui,2: Add,Edit,cWhite x%x6%  y%y%  w%w6%  h%h% readonly vDifference right
Gui,2: Add,Text,cGray  x%x4%  y%y%  w%w6%   ,Difference
;----------------
x :=(wa*10  )/xx
y :=(ha*85  )/xx
w :=(wa*5   )/xx
h :=(ha*2.5 )/xx
Gui,2: Add,Edit,cWhite x%x%  y%y%  w%w%  h%h% gSearchA vsearchx
x :=(wa*16  )/xx
Gui,2: add,button,     x%x%  y%y%  w%w%  h%h% gClearsearch ,<Clear
x :=(wa*22  )/xx
Gui,2: Add,Edit,cWhite x%x%  y%y%  w%w%  h%h%  readonly vCountFile1   right,
x :=(wa*28  )/xx
Gui,2: Add,Edit,cWhite x%x%  y%y%  w%w%  h%h%  readonly vSearchYN     center
;----------------------
w :=(wa*99 )/xx
h :=(ha*90 )/xx
gui,2: show,x1 y1 w%w% h%h%,%MainWindowTitle%
Guicontrol,2:,searchYN,Search-NO
RETURN
;--------------------------
2Guiclose:
exitapp
;--------------------------
;esc::exitapp
;--------------------------

;--------------------- TV1 ---------------------------------
AddSubFolderToTree(Folder, ParentItemID = 0)
{
  Loop %Folder%\*.*, 2
    {
    ID := TV_Add(A_LoopFileName, ParentItemID)
    AddSubFolderToTree(A_LoopFileFullPath, ID)
    }
  Loop %Folder%\*.csv
    ID := TV_Add(A_LoopFileName, ParentItemID)
}
return
;------------------------------------------------------------

;------------------- TV-1 EVENT -----------------------------
TreeEvent:
Gui, 2:TreeView, TV1
if A_GuiEvent <> S
    return
parenttext:=""
selecteditemtext:=""
selectedfullpath:=""
f1:=""
TV_GetText(SelectedItemText, A_EventInfo)
ParentID := A_EventInfo
Loop
    {
    ParentID := TV_GetParent(ParentID)
    if not ParentID
        break
    TV_GetText(ParentText, ParentID)
    SelectedItemText = %ParentText%\%SelectedItemText%
    }
SelectedFullPath = %TreeRoot%\%SelectedItemText%
GuiControl,2:,Pathx,%SelectedFullPath%
F1=%SelectedFullPath%
SplitPath,SelectedFullPath, name, dir, ext, name_no_ext, drive
LB1name=%name%
LB1nameNoExt=%name_no_ext%
;msgbox,PARENT=%parenttext%`nDIR=%dir%`nSELITEM=%selecteditemtext%`nFULL=%f1%
gosub,fill
return
;====================================================================

;-------------- Fill Listview read CSV -----------
Fill:
Gui,2:submit,nohide
Gui,2:default
setformat,float,0.2

LV_Delete()
e:=""
i:=0
Fileread,e,%f1%
u3t:=0
u3 :=0
u4t:=0
u4 :=0
for each, Line in StrSplit(e, "`n", "`r")
{
if line=
  continue
Columns := StrSplit(Line,dlm)
ct:=strsplit(Line,dlm).Count()
if (ct!=total)                    ;- if columns <> predefined total 
  continue
stringsplit,u,line,%dlm%
u3  +=0.00
u3t +=0.00
u4  +=0.00
u4t +=0.00
u3t := (u3t+(u3))
u4t := (u4t+(u4))
i++
LV_Add("",Columns*)
}
Guicontrol,2:,CountFile1,%I%
GuiControl,2:Focus,searchx
Guicontrol,2:,in1,%u3t%
Guicontrol,2:,out1,%u4t%
outx:=(ABS(u4t))
diff:=(u3t-outx)
Guicontrol,2:,difference,%diff%
return
;------------------------------------------------

;------------------------------------------------
LVevents:
Gui,2:submit,nohide
rcon:=a_guicontrol
Gui,2:ListView,%rcon%
  RN:=LV_GetNext("C")
  RF:=LV_GetNext("F")
  GC:=LV_GetCount()
  if (rn=0)
    return
;-----------------  
if A_GuiEvent = Normal
  {
  LV_GetText(C2,a_eventinfo,2)
  msgbox,%C2%
  return	 
  }
return
;--------------

;================== SEARCH ====================
SearchA:
Gui,2:default
Gui,2:submit,nohide
Gui,2:ListView, LVC1
if (searchx="")
   return
settimer,checkempty,1000
LV_Delete()
Guicontrol,2:,searchYN,Search-YES
I2=0
GuiControl,2: -Redraw,LVC1
Loop,parse,e,`n,`r
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
GuiControl,2: +Redraw,LVC1
Guicontrol,2:,CountFile1,%I2%
return
;--------------
checkempty:
Gui,2:submit,nohide
if (searchx="")
   {
   settimer,checkempty,off
   gosub,fill                      ;- <<< 
   Guicontrol,2:,searchYN,Search-NO
   return
   }
return
;--------------------------
clearsearch:
guicontrol,2:,searchx
return
;------------------ END SEARCH --------------------

;------------ testfile -------------

createtest:
e4=
(Ltrim join`r`n
2018-10-31;Price monthly;;-5.00;2018-10-31;
2018-10-27;Gift from X;100.00;;2018-10-27;
2018-10-25;Tool XY;;-50.00;2018-10-25;
)
fileappend,%e4%,%ftest%
e4=
return
;================== END script ==========================================================
