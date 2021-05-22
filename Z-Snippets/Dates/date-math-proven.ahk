;

EventDate = 20200503

; Days from now past
today = %a_now%
today_bk = %A_Now%
dateoffset := -15
EnvAdd, today, %dateoffset%, days
MsgBox, 0, After EnvAdd-1, %today% is %DateOffset% days from %Today_Bk%

; Days from now future
today = %A_Now%
today_bk = %A_Now%
dateoffset = 15
EnvAdd, today, %dateoffset%, days
MsgBox, 0, After EnvAdd-2, %today% is %DateOffset% days from %Today_Bk%

; Days from specific date future
today = %EventDate%
today_bk = %Today%
dateoffset = 15
EnvAdd, today, %dateoffset%, days
MsgBox, 0, After EnvAdd-3, %today% is %DateOffset% days from %Today_Bk%

; Days from specific date past
today = %EventDate%
today_bk = %Today%
dateoffset = -15
EnvAdd, today, %dateoffset%, days
MsgBox, 0, After EnvAdd-4, %today% is %DateOffset% days from %Today_Bk%


; Days between two dates defaulting to today
today =                                 ; Forces function to use current date
today_bk = %Today%
dateoffset = 20200101                   ; must be a date
EnvSub, today, %dateoffset%, days
MsgBox, 0, After EnvSub-1, There are %today% days between defult of today and %DateOffset%


; Days between two specific dates - both dates specified
today = %EventDate%
today_bk = %Today%
dateoffset = 20200101
EnvSub, today, %dateoffset%, days
MsgBox, 0, After EnvSub-2, There are %today% days between %DateOffset% and %Today_Bk%
