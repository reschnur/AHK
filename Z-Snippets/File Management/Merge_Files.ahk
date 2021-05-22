;

myDir = C:\Users\rschnur2\Documents\Mainframe Automation\Bulkmail\Top 20

outputFile = C:\pathToTheOutputFile\201803TPP.csv

Loop, %myDir%\*.txt

{

  FileRead, aFileContents, %A_LoopFileFullPath% 

  FileAppend, %aFileContents%, %outputFile% 

}