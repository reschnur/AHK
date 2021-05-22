#SingleInstance,Force
OnMessage(0x201,"Check_Control")
temp_Last_Name_Edit:="Enter Your Last Name:",temp_First_Name_Edit:="Enter Your First Name:",Unchanged_Last:=1,Unchanged_First:=1
Font_Options:="cLime s16 Underline Q5",Font_Type:="Elephant",SetFontOptions:="cTeal s16 Q5",SetFontType:="Segoe UI"
Gui,1:+AlwaysOnTop 
Gui,1:Color,222222,Black
Gui,1:Font,% Font_Options ,% Font_Type
Gui,1:Add,Edit,x10 y10 w400 r1 vFirst_Name_Edit gSubmit_All,% temp_First_Name_Edit
Gui,1:Add,Edit,x10 w400 r1 vLast_Name_Edit gSubmit_All,% temp_Last_Name_Edit
Gui,1:Font,
Gui,1:Font,cWhite ,Segoe UI
Gui,1:Add,Button,x10 w400 h30 gReload,Reload
Gui,1:Add,Edit,x10 w400 r2 ReadOnly vDisplay_Edit,% First_Name_Edit "`n" Last_Name_Edit
GuiControl,1:Focus,Display_Edit
Gui,1:Show,w420 
return
GuiClose:
	ExitApp
Submit_All:
	Gui,1:Submit,NoHide
	GuiControl,1:,Display_Edit,% First_Name_Edit "`n" Last_Name_Edit
	return
Reload:
	Reload
~Tab::
	sleep,50
	ControlGetFocus,temp2,A,
	GuiControlGet,temp3,1:Name,%temp2%
	if(temp3="Last_Name_Edit"&&Unchanged_Last=1)
		PromptFunction("Last_Name_Edit",Unchanged_Last,SetFontOptions,SetFontType,"1")
	else if(Unchanged_Last=0&&Last_Name_Edit=null)
		PromptFunction("Last_Name_Edit",Unchanged_Last,Font_Options,Font_Type,"1",temp_Last_Name_Edit)
	if(temp3="First_Name_Edit"&&Unchanged_First=1)
		PromptFunction("First_Name_Edit",Unchanged_First,SetFontOptions,SetFontType,"1")
	else if(Unchanged_First=0&&First_Name_Edit=null)
		PromptFunction("First_Name_Edit",Unchanged_First,Font_Options,Font_Type,"1",temp_First_Name_Edit)
	return
Check_Control(){
	global
	if(A_GuiControl="Last_Name_Edit"&&Unchanged_Last=1)
		PromptFunction("Last_Name_Edit",Unchanged_Last,SetFontOptions,SetFontType,"1")
	else if(Unchanged_Last=0&&Last_Name_Edit=null)
		PromptFunction("Last_Name_Edit",Unchanged_Last,Font_Options,Font_Type,"1",temp_Last_Name_Edit)
	if(A_GuiControl="First_Name_Edit"&&Unchanged_First=1)
		PromptFunction("First_Name_Edit",Unchanged_First,SetFontOptions,SetFontType,"1")
	else if(Unchanged_First=0&&First_Name_Edit=null)
		PromptFunction("First_Name_Edit",Unchanged_First,Font_Options,Font_Type,"1",temp_First_Name_Edit)
}
PromptFunction(ByRef TargetEdit,ByRef State,FOptions,FType,GuiName,TempText:="" ){
	State:=!State
	GuiControl,%GuiName%:,%TargetEdit%,% TempText
	Gui,%GuiName%:Font,
	Gui,%GuiName%:Font,% FOptions ,% FType
	GuiControl,%GuiName%:Font,%TargetEdit%
}
*Esc::ExitApp