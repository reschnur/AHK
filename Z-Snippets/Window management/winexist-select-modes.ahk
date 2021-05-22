;
SetTitleMatchMode Slow

; Force a new window
runwait, iexplore.exe https://www.eassets.ford.com/eassetsWeb/sms/reports/smspackage/openSmsPackageRpt.do

wingettitle wintitle, A
msgbox, 1,,Window is: %wintitle%


; 1 = starts with 2 = anywhere 3 = exact
SetTitleMatchMode, 1  

; Good
ifwinexist eAssets
{
msgbox, 1, , Mode 1: Window found - should have been found.
}

; Bad
if winexist Internet Explorer provided by Ford Motor Company
{
msgbox, 1, , Mode 1 bad string: Window found - should NOT have been.
}
else
msgbox, ,,Mode 1 bad string: Window found - should have been.


WinGetActiveTitle, Title
MsgBox, The active window is "%Title%".


; 1 = starts with 2 = anywhere 3 = exact
SetTitleMatchMode, 2  
ifwinexist eAssets
{
msgbox, 1, , Mode 2: Window found.
}

; 1 = starts with 2 = anywhere 3 = exact
SetTitleMatchMode, 3
ifwinexist eAssets PROD - Internet Explorer provided by Ford Motor Company
{
msgbox, 1, , Mode 3: Window found - should have been found.
}

ifwinexist eAssets PROD
{
msgbox, 1, , Mode 3: Window found - should NOT have been found.
}
else
msgbox, 1, , Mode 3: Window NOT found - should NOT have been found.

; 
SetTitleMatchMode, 2  
winclose, eAssets

exitapp