;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Find IP addresses in selected text and access the Web for geographic location. Hotkey CTRL+ALT+I
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; the following next expression is for complete validation within range of 0-255
; ^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$
; reduced expression for a match only
; \b(\d{1,3}\.){3}\d{1,3}\b 


^!I::
  Clipboard =
  SendInput, ^c
  ClipWait
CountIP := 1
Next := 1
Loop
{
  FoundPos := RegExMatch(Clipboard, "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" , ipaddress%CountIP%, Next)
  Next := FoundPos + StrLen(ipaddress%CountIP%)
  If FoundPos = 0
    Break
  CountIP++
}

If IPAddress1
  {
    IPList := ""
    CountIP--
    Loop, %CountIP%
    {
       CheckIP := ipaddress%A_Index%
       WhereIs := GetLocation(CheckIP)
       If StrLen(CheckIP) < 11
         Tab := "`t`t"
      Else
        Tab := "`t"
      IPList := IPList . ipaddress%A_Index% . Tab . whereis . "`r"
    }
}
Else
  IPList := "No IPs Found!"
MsgBox %IPList%

GetLocation(findip)
{
IPsearch := "http://ip-address-lookup-v4.com/lookup.php?host=ip-address-lookup-v4.com&ip=" . findip . "&x=31&y=29"
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", IPsearch)
whr.Send()
  sleep 100
version := whr.ResponseText
RegExMatch(version, "Near: <span class=""blueish"">(.*)</span>", Location) 
Return Location1
}




