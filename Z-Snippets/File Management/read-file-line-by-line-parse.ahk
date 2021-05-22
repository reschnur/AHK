; Example #4: Parse a comma separated value (CSV) file

; Journey Map has one JSON file per waypoint as oppposed to Voxel map having all waypoints in one file, oe line per waypoint.

;Voxel fields:
;  1	name
;  2	x
;  3	z
;  4	y
;  5	enabled
;  6	red
;  7	green
;  8	blue
;  9	suffix - this is the icon that shows
;  10	world
;  11	dimensions

Script_Name = Read file line-by-line

FileFolderBase = C:\Users\rschnur2\Desktop\AHK Scripts\

FileSelectFile, SelectedFile, 3, %FileFolderBase% ; , Text Documents (*.txt; *.doc)
if SelectedFile =
   {
   MsgBox, The user didn't select anything.
   exitapp
   }
else
    MsgBox, The user selected the following:`n%SelectedFile%


FileDelete, %FileFolderBase%\read-file-line-by-line-out.json

input_file = %SelectedFile%
output_file = C:\Users\rschnur2\Desktop\AHK Scripts\read-file-line-by-line-out.txt

Loop, read, %input_file% 
{
    LineNumber := A_Index
	
    MsgBox, 0, , Line #%A_Index% is %A_LoopReadLine%, 4 

    voxel_point = %A_LoopReadLine%
	
    StringSplit, waypoint_fields, voxel_point, `,
		  
	gosub, create_output
}

return


create_output:

; needed for building the id field
stringmid, id_val, waypoint_fields1, 6, 99     ; drop name: literal

stringmid, x_val, waypoint_fields2, 3, 9       ; drop x: literal
stringmid, y_val, waypoint_fields4, 3, 9       ; drop y: literal
stringmid, z_val, waypoint_fields3, 3, 9       ; drop z: literal

; the rgb values in Voxel do not translate directly to jm.
random, rand_r, 1,255
random, rand_g, 1,255
random, rand_b, 1,255

; write output records
FileAppend, {`n, %output_file%
FileAppend, "id": "%id_val%_%x_val%`,%y_val%`,%z_val%"`,`n, %output_file% 
FileAppend, "%waypoint_fields1%"`,`n, %output_file%             ; name 
FileAppend, "icon": waypoint-normal.png`,`n, %output_file% 
FileAppend, "%waypoint_fields2%"`,`n, %output_file%             ; x
FileAppend, "%waypoint_fields4%"`,`n, %output_file%             ; y
FileAppend, "%waypoint_fields3%"`,`n, %output_file%             ; z
FileAppend, "r": %rand_r%`,`n, %output_file%                    ; red
FileAppend, "g": %rand_g%`,`n, %output_file%                    ; green
FileAppend, "b": %rand_b%`,`n, %output_file%                    ; blue
FileAppend, "enable": true`,`n, %output_file% 
FileAppend, "type": "Normal"`,`n, %output_file% 
FileAppend, "origin": "journeymap"`,`n, %output_file% 
FileAppend, "dimensions": [`n, %output_file% 
FileAppend,    0`n, %output_file% 
FileAppend, ]`,`n, %output_file% 
FileAppend, "persistent": true`n, %output_file% 
FileAppend, }`n`n, %output_file%

return