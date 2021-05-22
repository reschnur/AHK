; include folders: 0 (default) = no, 1 = files & folders, 2 = only folders
; recurse 0 = no, 1 = yes

DialogTitle = Minecraft Move Screenshots
ScanFolder = g:\off load\business
;ScanFolder = g:\off load\personal
;ScanFolder = g:\off load\software
;ScanFolder = g:\off load\video

; Call the routine to count the files
filetally := CountFiles(ScanFolder)

; Display the results
if filetally > 0
   msgbox, 0, %DialogTitle%, Back from function.`n`nFile count: %filetally%, 4
else
   msgbox, 0, %DialogTitle%, Back from function.`n`nNo Files, 4

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CountFiles(filefolder)
{
;                     include folders, recurse
loop, %fileFolder%\*.*,1, 1
   {
   ; msgbox, 0, Title, %a_loopfilename%
   Number := A_Index
   }
	
; msgbox, 0, %DialogTitle%, File count: %number%, 2

return number

}
