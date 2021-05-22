Script_Name = Read file line-by-line

FileDelete, C:\Users\rschnur2\Desktop\AHK Scripts\read-file-line-by-line-out.txt

Loop
{
    FileReadLine, line, C:\Users\rschnur2\Desktop\AHK Scripts\read-file-line-by-line.txt, %A_Index%
    
	if ErrorLevel
	   {
	   MsgBox, 0, %script_name%, The end of the file has been reached or there was a problem., 6
       break
	   }
    
	MsgBox, 4, , Line #%A_Index% is "%line%".  Continue?
	
	gosub, create_output
    
	IfMsgBox, No
        return
	
	FileAppend, %line%, C:\Users\rschnur2\Desktop\AHK Scripts\read-file-line-by-line-out.txt
}

return

create_output:



return