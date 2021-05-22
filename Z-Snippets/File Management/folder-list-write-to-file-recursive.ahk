; Scan a folder and write the file info to a file

dialogtitle = Scan Folder
basefolder = C:\Users\rschnur2\Documents\LSI\BulkMail\List Info XLS

filedelete, %basefolder%\file-info.csv

scanfolder = %basefolder%

MsgBox, 4, %dialogtitle%-2, Scan Path = %basefolder%`n`nContinue?
IfMsgBox, No
   exitapp

   ;                   include folders, recusrive
Loop %scanfolder%\*.*, 0, 0
{
	SplitPath, A_LoopFileLongPath , OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
	MsgBox, 4, %dialogtitle%-1, File Name: %outfilename%`nPath: %outdir%`nExtension: %outextension%`nNo Ext: %outnamenoext%`nDrive: %outdrive%
	IfMsgBox, No
       break
			
    fileappend, %OutDir%`,%OutFileName%`n, %basefolder%\file-info.csv ; The ` is required to force the , to be part of the data line
}

run, %basefolder%\file-info.csv

exitapp