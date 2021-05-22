; Here is a working example that demonstrates how a Progress window can be
; overlayed on a SplashImage to make a professional looking Installer screen

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

IfExist, C:\Users\rschnur2\Pictures\image header.png 
   SplashImage, C:\Users\rschnur2\Pictures\image header.png, A,,, Installation

Loop, %A_WinDir%\system32\*.*
{
    Progress, %A_Index%, %A_LoopFileName%, Installing..., Draft Installation
    Sleep, 50
    if A_Index = 100
        break
}

return
