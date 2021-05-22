

sourcefile = c:\users\rschnur2\desktop\bookmark.htm

; FileSelectFile, SourceFile, 3,, Pick a text or HTML file to analyze.
; if SourceFile =
;     return  ; This will exit in this case.

SplitPath, SourceFile,, SourceFilePath,, SourceFileNoExt
DestFile = %SourceFilePath%\%SourceFileNoExt% Extracted Links.csv
; msgbox, %destfile%

IfExist, %DestFile%
{
    MsgBox, 4,, Overwrite the existing links file? Press No to append to it.`n`nFILE: %DestFile%
    IfMsgBox, Yes
	{
        FileDelete, %DestFile%
	}
}

LinkCount = 0

Loop, read, %SourceFile%, %DestFile%
{
   
   WriteRecord = 0
   
   GoSub, URLCategoryExtract
   
   GoSub, URLExtract

}

MsgBox %LinkCount% links were found and written to "%DestFile%".

exitapp


URLCategoryExtract:

    ; a_loopreadline is used because assigning it to a varialble trims the leading spaces
	; and the following code is positionally dependent
    H3PosStart := InStr(A_LoopReadLine, "h3") 
    
    If H3PosStart = 0
    {
     return
    }
	
    ; msgbox, 1, H3 Info, %a_loopreadline%`n`nLength: %inputlength%`n`nH3Pos:  %H3PosStart%
	ifmsgbox, cancel
	{
	exitapp
	}
   
   ; extract folder name
   stringmid, FolderNameBase, A_LoopReadLine, H3PosStart + 1, 999
   ; msgbox, 1, FolderNameBase, %FolderNameBase%
   
   ; find end character	   
   FolderNameStart := InStr(FolderNameBase, ">") 
   ; msgbox, 1, FolderNameStart, FolderNameStartPos: %FolderNameStart%
	   
   ; extract folder name
   stringmid, FolderName1, FolderNameBase, FolderNameStart + 1, 999
   ; msgbox, 1, FolderName1, %FolderName1%
   
   ; drop end tag - no replace value = replace with null
   stringreplace, FolderName2, FolderName1, </h3>
   ; msgbox, 1, FolderName-2, %FolderName2%

   ; redisplay h3 start
   ; msgbox, 1, H3 Pos For Category, H3Pos: %H3PosStart%
   
   ; is it main folder or first subfolder? 10 = top level, 14 = bottom level
   if H3PosStart = 10
   {
      FolderNametop = %FolderName2%
	  FolderNameBottom = " "  ; reset
	  ; msgbox, 1,FolderNameTop,Top: %FolderNameTop%`n`nBottom: %FolderNameBottom%
	  URLCategory = %FolderNameTop%
      
   }
   else
   {
      FolderNameBottom = %FolderName2%
	  ; msgbox, 1,FolderNameTop,Top: %FolderNameTop%`n`nBottom: %FolderNameBottom%
	  URLCategory = %FolderNameTop% / %FolderNameBottom%
   }
   
   ; msgbox, 1, URLCategory, %URLCategory%
   
return



URLExtract:

;  AutoTrim, off
   URLSearchString = %A_LoopReadLine% 

   ifinstring, urlsearchstring, href
   {
   ; URLPosStart := InStr(URLSearchString, href=)
   ; msgbox, href found
   stringgetpos, URLPosStart, urlsearchstring, href=
   }
   else
   {
   ; msgbox, href not found
   return
   }

   ; msgbox, 1, URLPosStart, %urlsearchstring%`n`nURLPosStart: %URLPosStart%
   ifmsgbox, cancel
   {
   exitapp
   }
		
   ; out, in, start, count
   StringMid, string1_out, URLSearchString, URLPosStart + 7, 999
   ; string1_out := substr(urlsearchstring, urlposstart +7, 999)
   ; msgbox, 1, string1_out,%string1_out%

   ; Find position of " ADD_DATE (end of URL)
   ; Out, In, SearchText, offset
   stringGetPos, URLPosEnd, string1_out, ADD_DATE

   ; Extract the URL
   stringleft, LinkURL, string1_out, URLPosEnd - 2
   ; msgbox, 1,LinkURL,%LinkURL%
   ifmsgbox, cancel 
   {
      exitapp
   }

   ; msgbox, 1,URLPosEnd,%URLPosEnd%
   ifmsgbox, cancel 
   {
      exitapp
   }

   ; Everything after the URL in preparation for extracting the link name
   string4_out := substr(urlsearchstring, URLPosEnd, 999)
   ; msgbox, 1,string4_out,%string4_out%
   ifmsgbox, cancel 
   {
      exitapp
   }
       
   ; Find position of text start
   ; Out, In, SearchText, offset
   stringGetPos, TextPosStart, string4_out, >

   ; Find position of text end
   ; Out, In, SearchText, offset
   stringGetPos, TextPosEnd, string4_out, <

   ; msgbox, 1,TextPos,Start: %TextPosStart%`n`nEnd: %TextPosEnd%
   ifmsgbox, cancel 
   { 
      exitapp
   }

   ; Extract Text
   LinkNameLen := StrLen(LinkName)
   LinkNameLen = LinkNameLen - 4
   stringmid, LinkName, string4_out, TextPosStart + 2
   stringreplace, LinkName, LinkName, </a>

   ; msgbox, 1,LinkName,%LinkName%
   
   writerecord = 1
   
   ; Output Text, URL
   outputline = %URLCategory%,%linkname%,%linkurl%,`n
   ; msgbox, 1,outputline, %outputline%
   FileAppend, %outputline%, %DestFile%
   if errorlevel = 1
   {
      msgbox, Error writing = %a_lasterror%`n%LinkURL%
   }
	 
   LinkCount += 1

return