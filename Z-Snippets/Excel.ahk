#SingleInstance, Force 

; Browswer command triggers
;Browser_Forward::Reload 
;Browser_Back:: 

try XL := ComObjActive("Excel.Application") ;handle to running application 
Catch { 
MsgBox % "no existing Excel ojbect: Need to create one" 
XL := ComObjCreate("Excel.Application") 
XL.Visible := 1 ;1=Visible/Default 0=hidden 
exitapp
} 

XL.Visible := 1 ;1=Visible/Default 0=hidden 
MsgBox % "is an object? " IsObject(XL)
exitapp

XL:=XL_Handle(1) ; 1=pointer to Application 2= Pointer to Workbook 
MsgBox % XL.range("A1").Text 
MsgBox % SubStr(XL.range("A1").Text,6) 
MsgBox % InStr(XL.range("A1").Text,"and") 
MsgBox % StrSplit(XL.range("A1").Text," ").3 RegExMatch(XL.range("A1").Text,".*?(\d+)",Numb) 
MsgBox % Numb1 XL.range("A1").Value:="This didn't work" ;*********Connect to current Excel Worksheet***************** XL_Handle(Sel){ ControlGet, hwnd, hwnd, , Excel71, ahk_class XLMAIN ;identify the hwnd for Excel Obj:=ObjectFromWindow(hwnd,-16) 
return (Sel=1?Obj.Application:Sel=2?Obj.Parent:Sel=3?Obj.ActiveSheet:"") } ;***borrowd & tweaked from Acc.ahk Standard Library*** by Sean Updated by jethrow***************** ObjectFromWindow(hWnd, idObject = -4){ if(h:=DllCall("LoadLibrary","Str","oleacc","Ptr")) If DllCall("oleacc\AccessibleObjectFromWindow","Ptr",hWnd,"UInt",idObject&=0xFFFFFFFF,"Ptr",-VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0 Return ComObjEnwrap(9,pacc,1) }