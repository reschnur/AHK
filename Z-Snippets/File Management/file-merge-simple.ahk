
; Pick folder

SourceFolder = C:\pathToYourDirectoryHoldingTheTxtFiles

; same folder

outputFile = %SourceFolder%\theOutputFile.csv



Loop, %SourceFolder%\*.csv
{

  FileRead, aFileRecord, %A_LoopFileFullPath% 

  FileAppend, %aFileRecord%, %outputFile% 

}