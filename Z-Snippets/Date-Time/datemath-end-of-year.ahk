
; Build the prior month/year from the current date for reporting prior month stuff

curmm = 01 ; A_mm
curyyyy = A_yyyy
primm = 0
priyyyy = 0

; Check for january and force the moth to 12 and the year to prior year
if curmm = 1
{
   primm := 12
   priyyyy := %curyyyy% + -1
}
else
; Calc prior month, but use current year
{
   primm := %curmm% + -1
   priyyyy := %curyyyy%
}

; Check for single digit month and pad it
stringlen primm_length, primm
if primm_length = 1
   primm := 0 primm

; msgbox, Leading zero: %primm%

; msgbox, curmo: %a_mm%`ncuryy: %a_yyyy%`nprimm: %primm%`npriyy: %priyyyy%

; Build date to convert: day of month and all time fields are hard coded since they do not matter
tmpdt := priyyyy primm 01 01 01 01

msgbox, Date: %tmpdt%

; convert to new time format
FormatTime, TimeString, %tmpdt%, MMM dd yyyy
; MsgBox The specified date and time, when formatted, is %TimeString%.

;extract the components
rptmm := SubStr(timestring, 1, 3) 
rptyyyy := SubStr(timestring, 8, 4)

; Set default field for inputbox to its value
default_month := rptmm ", " rptyyyy

msgbox, rptmm: %rptmm%`nrptyy: %rptyyyy%`ndefault_month: %default_month%


exitapp

v := A_Now

v += 2, days

FormatTime, newDate, %v%, dd/MM/yyyy 

msgbox , %newDate%

v := 27/2/2011
v += 2, days
FormatTime, newDate, %v%, dd/MM/yyyy 
msgbox , %newDate%

CurrentDate := A_Now

CurrentDate += -1, D

FormatTime, TimeString, %CurrentDate%, MM/dd/yyyy 07:00

Send, %TimeString%

DayB4(ymd="") { ; date should be in yyyymmdd format

  if !ymd
    ymd:=SubStr(A_Now,1,8)
  if (SubStr(ymd,-1) = "01") { ; credit Laszlo http://www.autohotkey.com/forum/viewtopic.php?p=54502#54502
    ymd += -1,M
    d1 := d2 := SubStr(ymd,1,6)
    d2 += 31,D
    d2 := SubStr(d2,1,6)
    d2 -= %d1%,D
    FormatTime, res, %d1%%d2%, MMddyyyy
  }
  else {
    ymd += -1, D 
    FormatTime, res, %ymd%, MMddyyyy
  }
  return res

}

MsgBox % "Yesterday: " DayB4() "`n"   ; %
  . "Last day of last month: " DayB4("20091001") "`n"
  . "Last day of Feb(leap year): " DayB4("19920301") "`n"