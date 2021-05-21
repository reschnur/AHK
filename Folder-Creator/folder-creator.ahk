#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
SetTitleMatchMode 2 ;  2 = anywhere

Script_Name = Bulk Folder Creator


SelectInput:

FileSelectFile, InputFile, m3, , Select Input File.

if (InputFile = "")
{
   MsgBox, No file selected. Cancel.
   exitapp
   }
else
   {
   msgbox, 0, %script_name%, File Selected: `n%InputFile%
   }


SelectOutput:

FileSelectFolder, DstFolder, m3, , Select Folder to Create In.

if (DstFolder = "")
{
   MsgBox, No files selected. Cancel.
   exitapp
   }
else
   {
   msgbox, 0, %script_name%, Destination Folder: `n%DstFolder%
}

msgbox, Start
              ; C:\Users\resch\OneDrive\Desktop\Web Course Unit Names.txt
Loop, Read, %InputFile%
;Loop, Read, C:\Users\resch\OneDrive\Desktop\Web Course Unit Names.txt
{

     MsgBox, 0, %Script_Name%, %A_LoopReadLine%
	
	msgbox, %DstFolder%\%A_LoopReadLine%
	
	; FileCreateDir, C:\Users\resch\Downloads\Udemy Web Developer Course\%A_LoopReadLine%
}	

MsgBox, End