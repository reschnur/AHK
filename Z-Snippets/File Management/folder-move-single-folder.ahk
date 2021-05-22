; Move the flash drive offload files to their respective hard drive locations.
dialoguetitle = Move a single world set from one minecraft profile to another

; msgbox, 0, %boxtitle%, Start move MC world files

basefolder = D:\Richard\My Documents\Google Drive\Games

; Select source folder/file - world name level
FileSelectFolder, SourceFolder, %basefolder%, 0, Select world folder to copy.
if ErrorLevel <> 0 ; User did not select a folder
{
;   msgbox, 0, Error Source,Error: %errorlevel%
   exitapp
}

; Select destination folder - world name level
FileSelectFolder, DestFolder, %basefolder%, 0, Select profile to copy to.
if ErrorLevel <> 0 ; User did not select a folder
{
;   msgbox, 0, Error Destination,Error: %errorlevel%
   exitapp
}
   
msgbox, 0, Title,To move:`n`nSource: %sourcefolder%`nDest:  %destFolder%\saves

; exitapp ; debug

;sourcefolder := %sourcefolder%\*.*
;destfolder := %destfolder%\save

; msgbox,0,,Before move

; need to strip the last level of the source path for the new destination
; Extract world name from path
SplitPath, SourceFolder, ProfileName  ; Extract only the folder name (world name) (last node) from its full path.
msgbox,4,%dialogtitle%,World Name: %profilename%

FileMoveDir, %SourceFolder%, %DestFolder%\saves\%profilename%, R

; msgbox,0,,After move

if ErrorLevel {
   MsgBox, 0, %boxtitle%, The files could not be moved. It is likely empty. %errorlevel%
   run explorer.exe %destFolder%\saves
}

;exitapp

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Select and move waypoints file
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Select source folder/file - world name level
FileSelectFile, SourceFile, 1, %sourcefolder%\mods\voxelmods\voxelmap, Select waypoints file for world to copy.
if ErrorLevel <> 0 ; User did not select a folder
   exitapp

msgbox, 0,,Source: %sourcefile%`nDest:%destfolder%\mods\voxelmods\voxelmap
   
FileMove, %Sourcefile%, %DestFolder%\mods\voxelmods\voxelmap, 0
   
exitapp
