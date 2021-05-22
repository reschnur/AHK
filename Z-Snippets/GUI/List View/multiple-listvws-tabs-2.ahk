; https://www.autohotkey.com/boards/viewtopic.php?t=3384
MODIFIED=20140605
;- Listview   >>>   ADD_NEW  / MODIFY / DELETE / SEARCH

MainWindowTitle=ListView_Test1
transform,T,chr,09
delim = `,
first1:=0

gosub,test1    ;-- create 2 text-files for 2 ListViews  ( test )

Gui,2:default
Gui,2: Font,CDefault,Fixedsys
Gui,2: Margin, 10, 10

Tabnumber:=1
    gui,2:add, Tab2, x10 y10 w540 h250 gtabchange vTabnumber AltSubmit, Links|Regex

        gui,2:tab, Links
            gui,2:add, listview,x10 y40 w520 h400 grid cWhite backgroundteal hwndLV1 vLV1 gListViewEvents +altsubmit -multi, A|B
            gosub,fill1
            gosub,width1
            Gui,2:add,button, x10  y450 gPrintLV1,Print
            Gui,2:Add, Edit,  x100 y450 w250 gFind vSrch1,
            Gui,2:add,button, x400 y450 gAddNew1,ADD_NEW


        gui,2:tab, Regex
            gui,2:add, listview,x10 y40 w520 h400 grid cWhite backgroundteal hwndLV2 vLV2 gListViewEvents +altsubmit -multi, A|B
            gosub,fill2
            gosub,width1
            Gui,2:add,button, x10 y450 gPrintLV1,Print
            Gui,2:Add, Edit,  x100 y450 w250 gFind vSrch2,
            Gui,2:add,button, x400 y450 gAddNew1,ADD_NEW


gui,2: show,x10 y1 w600 h500,%MainWindowTitle%
gosub,tabchange
RETURN

2Guiclose:
exitapp

width1:
   T1=300
   T2=200
   LV_ModifyCol(1,T1)
   LV_ModifyCol(2,T2)
   ;LV_ModifyCol(2,"Integer")
return

;-------------------------------------------------------------------------------------
tabchange:
 GuiControlGet, Tabnumber
GuiControl,2:Focus,srch%tabnumber%
Return
;-------------------------------------------------------------------------------------





;---------------- SEARCH -------------------
Find:
Gui,2: Submit, Nohide
Gui,2:listview, LV%Tabnumber%
Fx=%A_scriptdir%\test%tabnumber%.txt
src:= % srch%Tabnumber%
if (SRC="")
   {
   goto,Fill%Tabnumber%
   return
   }
LV_Delete()
  loop,read,%fx%
  {
  LR=%A_loopReadLine%
  if SRC<>
     {
     if LR contains %src%
       {
       stringsplit,C,A_LoopReadLine,%delim%
       LV_Add("",C1,C2)
       }
     }
  else
   continue
   }
LV_Modify(LV_GetCount(), "Vis")
if (SRC="")
  goto,Fill%Tabnumber%
return




;------------------- LISTVIEW --------------
ListViewEvents:
Gui,2:default
Gui,2:listview, LV%Tabnumber%

    if(A_GuiEvent == "Normal")
         {
         LV_GetText(C1, A_EventInfo, 1)
         LV_GetText(C2, A_EventInfo, 2)
         }

    if(A_GuiEvent == "DoubleClick")
        {
        LV_GetText(C2, A_EventInfo, 2)
        stringmid,url1,c2,1,7
        stringmid,pth1,c2,2,2
        if ((url1="http://") or (pth1=":\"))
          run,%c2%
        return
        }


    if(A_GuiEvent == "RightClick")
        {
        LV_GetText(C1, A_EventInfo, 1)
        LV_GetText(C2, A_EventInfo, 2)
        gosub,Modify1
        return
        }

    if A_GuiEvent=K
       {
       GetKeyState,state,DEL        ;- << DELETE
       if state=D
         {
         RowNumber:=LV_GetNext()
         LV_Delete(RowNumber)
         gosub,Modify2
         return
        }
      return
      }
RETURN
;--------------------------------------------------------------



;----------------   MODIFY  ----------------
Modify1:
Gui,3: +AlwaysonTop
Gui,3: Font, s10, Verdana
gui, 3:listview, LV%Tabnumber%
    Gui,3:add, edit, w300 h30 vC1, %C1%
    Gui,3:add, edit, w300 h30 vC2, %C2%

    Gui,3: Add,Button,   x12 gACCEPT1 default, Accept
    Gui,3: Add,Button,   x+4 gCANCEL1, Cancel
Gui,3:show,center, LV_Modify
return

accept1:
Gui,2:default
Gui,3:submit,nohide
gui 3:listview, LV%Tabnumber%
RowNumber := LV_GetNext()
c1:= % c1
c2:= % c2
lv_modify(rownumber, "col1" , C1 )
lv_modify(rownumber, "col2" , C2 )
gosub,modify2
Gui,3:destroy
return

cancel1:
3Guiclose:
Gui,3:destroy
return
;-----------------------------------------------------------------


;----------------   ADD NEW  ----------------
ADDNEW1:
Gui,4: +AlwaysonTop
Gui,4: Font, s10, Verdana
Gui,4:listview, LV%Tabnumber%
    Gui,4:add, edit, w300 h30 vC1,
    Gui,4:add, edit, w300 h30 vC2,

    Gui,4: Add,Button,   x12 gACCEPT4 default, Accept
    Gui,4: Add,Button,   x+4 gCANCEL4, Cancel
Gui,4:show,center,Add_NEW
return

accept4:
Gui,2:default
Gui,4:submit,nohide
Gui,4:listview, LV%Tabnumber%
Fx=%A_scriptdir%\test%tabnumber%.txt
Fileappend,%c1%%delim%%c2%`r`n,%fx%
gosub,fill%tabnumber%
Gui,4:destroy
return

cancel4:
4Guiclose:
Gui,4:destroy
return
;-----------------------------------------------------------------



;------------------ FILL ----------------------------
Fill1:
gui,2:listview, listview%Tabnumber%
LV_Delete()
loop,read,%F1%
  {
  LR=%A_loopReadLine%
  if LR=
     continue
          C1 =
          C2 =
         stringsplit,C,LR,%delim%,
   LV_Add("", c1,c2)
  }
LV_ModifyCol(1, "Sort CaseLocale")   ; or "Sort CaseLocale"
LV_Modify(LV_GetCount(), "Vis")      ;scrolls down
return


Fill2:
gui, 2:listview, listview%Tabnumber%
LV_Delete()
loop,read,%F2%
  {
  LR=%A_loopReadLine%
  if LR=
     continue
          C1 =
          C2 =
         stringsplit,C,LR,%delim%,
   LV_Add("", c1,c2)
  }
LV_ModifyCol(1, "Sort CaseLocale")   ; or "Sort CaseLocale"
LV_Modify(LV_GetCount(), "Vis")      ;scrolls down
return


;---------------------------------------------------





;------------------- Modify Text -------------------------
Modify2:
Fx=%A_scriptdir%\test%tabnumber%.txt
ifexist,%fx%
   filedelete,%fx%
ControlGet,AA,List,,SysListView32%tabnumber%,%MainWindowTitle%        ;<< the correct name of listview
if aa<>
 {
 stringreplace,AA,AA,%t%,%delim%,all                                   ;<< replaces TAB with Delimiter
 stringreplace,AA,AA,`n,`r`n,all
 ;msgbox, 262208, ,%aa%
 fileappend,%AA%,%fx%
 aa=
 return
 }
return
;------------------------------------------------------------------





;------------------- PRINT-Listview -------------------------
PrintLv1:
FileTest=%a_scriptdir%\PrintListview55.txt
ifexist,%filetest%
   filedelete,%filetest%
ControlGet,AA,List,,SysListView32%tabnumber%,%MainWindowTitle%        ;<< the correct name of listview
if aa<>
 {
 stringreplace,AA,AA,%t%,%delim%,all                                   ;<< replaces TAB with Delimiter
 stringreplace,AA,AA,`n,`r`n,all
 ;msgbox, 262208, ,%aa%
 fileappend,%AA%,%filetest%
 aa=
 run,%filetest%
 return
 }
return
;------------------------------------------------------------------




;--- create a testfile ---------------
test1:
;delim = `,
F1=%A_scriptdir%\test1.txt
ifnotexist,%f1%
{
  e1=
  (Ltrim Join`r`n
  1-Youtube Monty Python%delim%http://www.youtube.com/MontyPython
  1-Li Xianglan wikipedia%delim%http://en.wikipedia.org/wiki/Li_Xianglan
  )
Fileappend,%e1%`r`n,%f1%
}

F2=%A_scriptdir%\test2.txt
ifnotexist,%f2%
{
  e2=
  (Ltrim Join`r`n
  2-REGEX ahk%delim%http://www.autohotkey.com/docs/misc/RegEx-QuickRef.htm
  2-REGEX regular%delim%http://www.regular-expressions.info/
  2-REGEX regenechsen%delim%http://www.regenechsen.de/phpwcms/index.php
  2-Regex 101%delim%http://regex101.com/
  )
Fileappend,%e2%`r`n,%f2%
}
e1=
e2=
return
;--- end create a testfile -----------

;================== END script ==========================================================
