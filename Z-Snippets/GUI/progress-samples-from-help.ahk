; This was copied from the help file

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

ScriptName = Progress Examples

msgbox, 1



Progress, w200, My SubText, My MainText, %scriptname% ; My Title
Progress, 50 ; Set the position of the bar to 50%.
Sleep, 4000
Progress, Off

; exitapp

msgbox, 2
; Create a window just to display some 18-point Courier text:
Progress, m2 b fs18 zh0, This is the Text.`nThis is a 2nd line., , , Courier New

msgbox, 3
; Create a simple SplashImage window:
SplashImage, C:\My Pictures\Company Logo.gif

msgbox, 4
; Create a borderless SplashImage window with some large text beneath the image:
SplashImage, C:\My Pictures\Company Logo.gif, b fs18, This is our company logo.
Sleep, 4000
SplashImage, Off

msgbox, 5

; Here is a working example that demonstrates how a Progress window can be
; overlayed on a SplashImage to make a professional looking Installer screen:
IfExist, C:\WINDOWS\system32\ntimage.gif, SplashImage, %A_WinDir%\system32\ntimage.gif, A,,, Installation
Loop, %A_WinDir%\system32\*.*
{
    Progress, %A_Index%, %A_LoopFileName%, Installing..., Draft Installation
    Sleep, 50
    if A_Index = 100
        break
}
; There is similar example at the bottom of the GUI page. Its advantage is that it uses only a single
; window and it gives you more control over window layout.