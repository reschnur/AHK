/*
HowLongYearsMonthsDays v1.2 by Jack Dunning

Find the current version at:
http://www.computoredge.com/AutoHotkey/Free_AutoHotkey_Scripts_and_Apps_for_Learning_and_Generating_Ideas.html#HowLong

Find discussion at https://jacksautohotkeyblog.wordpress.com/

This HowLongYearsMonthsDays.ahk script uses two DateTime GUI controls to feed
a start date and stop date into a timespan calculator. To use the HowLong() function
copy it into your script (or #Include it), then call the function with the parameters Date1
and Date2. The function loads global variables Years, Months, and Days with the timespan.
August 29, 2018
I made a couple of changes by removing the Leap Year test and replacing the short-month
conditionals with a simple month length calculation. The old code appears in comment sections
for those who want to see the original code which worked, but less efficiently.
October 10, 2018
The input variables now swap if FromDay is greater than ToDay. This allows selecting dates in 
any order.
*/

HowLongAutoExec:



Gui, SpanCalc:Add, Text, , Enter Date One:
Gui, SpanCalc:Add, DateTime, vDate1, LongDate
Gui, SpanCalc:Add, Text, , Enter Date Two:
Gui, SpanCalc:Add, DateTime, vDate2, LongDate
Gui, SpanCalc:Add, Button, , Calculate
Gui,SpanCalc:Show, , Calculate How Long

Return

SpanCalcButtonCalculate:
  Gui +OwnDialogs
  Gui, Submit, NoHide
  HowLong(Date1,Date2)
  MsgBox, , TimeSpan Calculation
       , Years %Years%`rMonths %Months%`rDays %Days%  %Past%
Return

HowLong(FromDay,ToDay)
  {
  Global Years,Months,Days,Past
  Past := ""

; Trim any time component from the input dates
    FromDay := SubStr(FromDay,1,8)
    ToDay := SubStr(ToDay,1,8)

;   For proper date order before calculation
/*
   If (ToDay <= FromDay)
   {
     Years := 0, Months := 0, Days := 0
     MsgBox, Start date after end date!
     Return
   }
*/

   If (ToDay = FromDay)
   {
     Years := 0, Months := 0, Days := 0
     Return
   }

   If (ToDay < FromDay)
   {
     Temp := Today
     ToDay := FromDay
     FromDay := Temp
     Past := "Ago"
   }

/*
The function no longer requires this Leap Year test since when needed
AutoHotkey now calculates the length of the previous month in the target
year. I've left this commented-out code in here for people looking for a different
approach to  identifying a Leap Year but it does not run in this script.

;   Test for Stop date Leap Year. Invalid date calc returns blank.

  Feb29 := SubStr(ToDay,1,4) . "0229"
  Feb29 += 1, days      ; Test for Leap Year

  If (Feb29 != "")
      Feb := 29
  Else
      Feb := 28

*/

;   Calculate years

    Years  := % SubStr(ToDay,5,4) - SubStr(FromDay,5,4) < 0
           ? SubStr(ToDay,1,4)-SubStr(FromDay,1,4)-1 
            : SubStr(ToDay,1,4)-SubStr(FromDay,1,4)

;   Remove years from the calculation

     FromYears := Substr(FromDay,1,4)+years . SubStr(FromDay,5,4)


/*
Calculate the number of months between the Start date (Years removed)
and the Stop date. If the day of the month in the Start date is greater than
the day of the month in the Stop date, then add 11 or 12 months to the 
calculation depending upon the comparison between month days.
*/

    If (Substr(FromYears,5,2) <= Substr(ToDay,5,2))  and (Substr(FromYears,7,2) <= Substr(ToDay,7,2))
       Months := Substr(ToDay,5,2) - Substr(FromYears,5,2)
    Else If (Substr(FromYears,5,2) < Substr(ToDay,5,2)) and (Substr(FromYears,7,2) > Substr(ToDay,7,2))
       Months := Substr(ToDay,5,2) - Substr(FromYears,5,2) - 1
    Else If (Substr(FromYears,5,2) > Substr(ToDay,5,2)) and (Substr(FromYears,7,2) <= Substr(ToDay,7,2))
       Months := Substr(ToDay,5,2) - Substr(FromYears,5,2) +12
    Else If (Substr(FromYears,5,2) >= Substr(ToDay,5,2)) and (Substr(FromYears,7,2) > Substr(ToDay,7,2))
       Months := Substr(ToDay,5,2) - Substr(FromYears,5,2) +11

;   If the start day of the month is less than the stop day of the month use the same month
;   Otherwise use the previous month, (If Jan "01" use Dec "12")
 
     If (Substr(FromYears,7,2) <= Substr(ToDay,7,2))
         FromMonth := Substr(ToDay,1,4) . SubStr(ToDay,5,2) . Substr(FromDay,7,2)
     Else If Substr(ToDay,5,2) = "01"
         FromMonth := Substr(ToDay,1,4)-1 . "12" . Substr(FromDay,7,2)
     Else
        FromMonth := Substr(ToDay,1,4) . Format("{:02}", SubStr(ToDay,5,2)-1) . Substr(FromDay,7,2)

;   FromMonth := Substr(ToDay,1,4) . Substr("0" . SubStr(ToDay,5,2)-1,-1) . Substr(FromDay,7,2)
;   "The Format("{:02}",  SubStr(ToDay,5,2)-1)" function replaces the original "Substr("0" . SubStr(ToDay,5,2)-1,-1)"
;   function found in the line of code above. Both serve the same purpose, although the original function
;   uses sleight of hand to pad single digit months with a zero (0).

;   Adjust for previous months with less days than target day

    Date1 := Substr(FromMonth,1,6) . "01"
    Date2 := Substr(ToDay,1,6) . "01"
    Date2 -= Date1, Days
    If (Date2 < Substr(FromDay,7,2)) and (Date2 != 0)
        FromMonth := Substr(FromMonth,1,6) . Date2

/*
;   Adjust for months with less than 31 days [Removed and replace by code above]

      If (Substr(FromMonth,5,2) = "02") and (Substr(FromDay,7,2) > "28")
              FromMonth := Substr(FromMonth,1,6) . Feb
       If (Substr(FromMonth,5,2) = "04") and (Substr(FromDay,7,2) > "30")
              FromMonth := Substr(FromMonth,1,6) . "30"
       If (Substr(FromMonth,5,2) = "06") and (Substr(FromDay,7,2) > "30")
              FromMonth := Substr(FromMonth,1,6) . "30"
       If (Substr(FromMonth,5,2) = "09") and (Substr(FromDay,7,2) > "30")
              FromMonth := Substr(FromMonth,1,6) . "30"
       If (Substr(FromMonth,5,2) = "11") and (Substr(FromDay,7,2) > "30")
              FromMonth := Substr(FromMonth,1,6) . "30"
 */

; Calculate remaining days. This operation (EnvSub) changes the value of the original 
; ToDay variable, but, since this completes the function, we don't need to save ToDay 
; in its original form. 

     Days := ToDay

     Days -= %FromMonth% , d

/*
       ToDay -= %FromMonth% , d
       Days := ToDay
*/

	
  }

; Enable mousewheel in AutoHotkey GUIs

#If MouseIsOver("ahk_class AutoHotkeyGUI")
   WheelUp::Send {Up}
   WheelDown::Send {Down}
#If

MouseIsOver(WinTitle)
{
   MouseGetPos,,, Win
   Return WinExist(WinTitle . " ahk_id " . Win)
}

^!z::
  GuiControl, SpanCalc: , SysDateTimePick321, 20000101
Return