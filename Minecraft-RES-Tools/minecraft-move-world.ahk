; Move the flash drive offload files to their respective hard drive locations.
dialogtitle = Move a single world set from one Google Drive minecraft profile to another

msgbox, 0, %boxtitle%, Start move MC world files.`n`nBefore moving worlds, PLEASE empty backpacks `nor the contents will be lost.

basefolder = D:\OneDrive\Games\Minecraft\Profile

; Select source folder - world name level
FileSelectFolder, SourceFolder, %basefolder%, 0, Select world folder to copy.
if ErrorLevel <> 0 ; User did not select a folder
{
;   msgbox, 0, Error Source,Error: %errorlevel%
   exitapp
}

; Extract world name from path
SplitPath, SourceFolder, WorldName  ; Extract only the folder name (world name) (last node) from its full path.
; msgbox,4,%dialogtitle%,World Name: %worldname%


; Select destination folder - profile name level
FileSelectFolder, DestFolder, %basefolder%, 0, Select profile to copy to.
if ErrorLevel <> 0 ; User did not select a folder
{
;   msgbox, 0, Error Destination,Error: %errorlevel%
   exitapp
}
   
; Extract destination profile name
SplitPath, DestFolder, DstProfileName  ; Extract only the folder name (world name) (last node) from its full path.   
   
; msgbox, 0, Title,To move:`n`nSource: %sourcefolder%`nDest:  %destFolder%\saves

;sourcefolder := %sourcefolder%\*.*
;destfolder := %destfolder%\save

FileMoveDir, %SourceFolder%, %DestFolder%\saves\%worldname%, R

; msgbox,0,,After move

if ErrorLevel {
   MsgBox, 0, %boxtitle%, The files could not be moved. It is likely empty. %errorlevel%
   run explorer.exe %destFolder%\saves
}


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Select and move waypoints file
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; msgbox,0,,%sourcefolder%

; Select source folder/file - world name level
FileSelectFile, SourceFilePoints, 1, %sourcefolder%\mods\voxelmods\voxelmap, Please select the %worldname% waypoints file.
if ErrorLevel <> 0 ; User did not select a folder
   exitapp

; msgbox, 0,,Source: %sourcefile%`nDest:%destfolder%\mods\voxelmods\voxelmap
   
; Destination folder already has the new profile name
FileMove, %SourcefilePoints%, %DestFolder%\mods\voxelmods\voxelmap, 0
   
exitapp
