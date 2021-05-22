; Sample splash image
; This is used with progress bars

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

; b = borderless
; fs = font size for sub text

; Create a borderless SplashImage window with some large text beneath the image:
SplashImage, C:\Users\rschnur2\Pictures\finger.png, b fs18, This is our company logo.

Sleep, 4000

SplashImage, Off

ExitApp