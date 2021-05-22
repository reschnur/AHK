
dialogtitle = Display File Info

basefolder = G:\task related

; Select folder/file
FileSelectFile, PointsFileselect, 3, %basefolder%
if ErrorLevel <> 0 ; User did not select a folder
   exitapp


; Strip file name
splitpath, pointsfileselect, pointsfilename, pointsfilefolder, pointsfileextension, pointsfilenoextension, pointsfiledrive

msgbox, 0, %dialogtitle%, Selected: %pointsfileselect% `n`nName: %pointsfilename%`nFolder: %pointsfilefolder%`nExtension:      %pointsfileextension%`nNo extension: %pointsfilenoextension%`nDrive:        %pointsfiledrive%

return