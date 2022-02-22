;

; Ideas:
; Cloud or no cloud
; Colors
; 

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

Script_Name = Build INI File

; Convert to selection so user can set location?
INIFile     = D:\Richard\OneDrive\Games\Minecraft Tools\Minecraft RES Tool Suite\minecraft-tools.ini


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Get INI information
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

y_offset = 24
x_offset_1 = 24                      ; buttons
x_offset_2 = 90                      ; text label
x_offset_3 = 140                     ; selected folder display
label_width_1 = 160
label_width_2 = 500

Gui, font, s12, Verdana bold

Gui, Add, GroupBox, w800 r12 border, Select Folders to Store

Gui, font, s10, Verdana

Gui, Add, Button, x%x_offset_1%   y36   w80 h25  gSelectFolder_1, Select
Gui, font, bold
Gui, Add, Text,   xp+%x_offset_2% yp+4 w%label_width_1% h20,           Tools folder:
Gui, Add, Text,   xp+%x_offset_3% yp   w%label_width_2% h20 vFolder_1, Tools folder name
Gui, font, norm

Gui, Add, Button, x%x_offset_1%   yp+%y_offset% w80 h25  gSelectFolder_2, Select
Gui, font, bold
Gui, Add, Text,   xp+%x_offset_2% yp+4 w%label_width_1% h20,           Profile folder:
Gui, Add, Text,   xp+%x_offset_3% yp   w%label_width_2% h20 vFolder_2, Profile folder name
Gui, font, norm

Gui, Add, Button, x%x_offset_1%   yp+%y_offset% w80 h25  gSelectFolder_3, Select
Gui, font, bold
Gui, Add, Text,   xp+%x_offset_2% yp+4 w%label_width_1% h20,           Local folder:
Gui, Add, Text,   xp+%x_offset_3% yp   w%label_width_2% h20 vFolder_3, Local folder name
Gui, font, norm

Gui, Add, Button, x%x_offset_1%   yp+%y_offset% w80 h25  gSelectFolder_4, Select
Gui, font, bold
Gui, Add, Text,   xp+%x_offset_2% yp+4 w%label_width_1% h20,           Cloud folder:
Gui, Add, Text,   xp+%x_offset_3% yp   w%label_width_2% h20 vFolder_4, Cloud folder name
Gui, font, norm

Gui, Add, Button, x%x_offset_1%   yp+%y_offset% w80 h25  gSelectFolder_5, Select
Gui, font, bold
Gui, Add, Text,   xp+%x_offset_2% yp+4 w%label_width_1% h20,           Review file folder:
Gui, Add, Text,   xp+%x_offset_3% yp   w%label_width_2% h20 vFolder_5, Review file folder name
Gui, font, norm

; ~~~~~~~~~~~~~~~~~~~~~~~~~~

Gui, font, bold
Gui, Add, Button, x%x_offset_1%   y370 w80 h40 gStoreINIValues,    Store Values
Gui, Add, Button, xp+%x_offset_2% yp   w80 h40 gRetrieveINIValues, Retrieve Values
Gui, font, norm

Gui, Show, x400 y200 autosize, %Script_Name%

WinActivate, %Script_Name%

Return

GuiEscape:
; Fall thru

GuiClose:
; Fall thru

GUICancel:
gui, Destroy
ExitApp

/*
MsgBox, 48, %Script_Name%, 
(
Tools Folder`n %ToolsFolder%`n
BackupFolder`n %BackupFolder%`n
Local Folder`n %LocalFolder%`n
Cloud Folder`n %CloudFolder%`n
Install Review Folder`n %InstallReviewFolder%`n
World Names File: %WorldNamesFile%`n
Mods Used File: %ModsUsedFile%`n
Resources Used File: %ResourcePacksUsedFile%`n
Datapacks Used File: %DatapacksUsedFile%`n
Pix Folder: %ScreenCapOutputFolder%`n
GUI Color: %GUIBackgroundColor%`n
)
*/

SelectFolder_1:

FileSelectFolder, SelectedFolder, , 0    ; 0 = No make folder or text box

ToolsFolder = %SelectedFolder%
;               Control var, New value
GuiControl, , Folder_1, %ToolsFolder%

return


SelectFolder_2:

FileSelectFolder, SelectedFolder, , 0    ; 0 = No make folder or text box

ToolsFolder = %SelectedFolder%
;               Control var, New value
GuiControl, , Folder_2, %ToolsFolder%

return

SelectFolder_3:

FileSelectFolder, SelectedFolder, , 0    ; 0 = No make folder or text box

ToolsFolder = %SelectedFolder%
;               Control var, New value
GuiControl, , Folder_3, %ToolsFolder%

return

SelectFolder_4:

FileSelectFolder, SelectedFolder, , 0    ; 0 = No make folder or text box

ToolsFolder = %SelectedFolder%
;               Control var, New value
GuiControl, , Folder_4, %ToolsFolder%

return

SelectFolder_5:

FileSelectFolder, SelectedFolder, , 0    ; 0 = No make folder or text box

ToolsFolder = %SelectedFolder%
;               Control var, New value
GuiControl, , Folder_5, %ToolsFolder%

return

SelectFolder_6:

FileSelectFolder, SelectedFolder, , 0    ; 0 = No make folder or text box

ToolsFolder = %SelectedFolder%
;               Control var, New value
GuiControl, , Folder_6, %ToolsFolder%

return

SelectFolder_7:

FileSelectFolder, SelectedFolder, , 0    ; 0 = No make folder or text box

ToolsFolder = %SelectedFolder%
;               Control var, New value
GuiControl, , Folder_7, %ToolsFolder%

return

SelectFolder_8:

FileSelectFolder, SelectedFolder, , 0    ; 0 = No make folder or text box

ToolsFolder = %SelectedFolder%
;               Control var, New value
GuiControl, , Folder_8, %ToolsFolder%

return


StoreINIValues:

IniWrite, ToolsFolder, %INIFile%, FileLocations, ToolsFolder
IniWrite, BackupFolder, %INIFile%, FileLocations, BackupFolder
IniWrite, LocalFolder, %INIFile%, FileLocations, LocalFolder
IniWrite, CloudFolder, %INIFile%, FileLocations, CloudFolder
IniWrite, WorldNamesFile, %INIFile%, FileLocations, WorldNamesFile
IniWrite, InstallReviewFolder, %INIFile%, FileLocations, InstallReviewFolder
IniWrite, ModsUsedFile, %INIFile%, FileLocations, ModsUsedFile
IniWrite, ResourcePacksUsedFile, %INIFile%, FileLocations, ResourcePacksUsedFile
IniWrite, DatapacksUsedFile, %INIFile%, FileLocations, DatapacksUsedFile
IniWrite, ScreenCapOutputFolder, %INIFile%, FileLocations, ScreenCapOutputFolder
IniWrite, GUIBackgroundColor, %INIFile%, UX, GUIBackgroundColor

return


RetrieveINIValues:

if(!FileExist("C:\BulkMail-Paging\Test.ini"))
{
	MsgBox, 48, %Script_Name% - Error-1, Could not find the required INI file.
	winactivate, Error
}

IfMsgBox Cancel, ExitApp

IniRead, ToolsFolder, %INIFile%, FileLocations, ToolsFolder
IniRead, BackupFolder, %INIFile%, FileLocations, BackupFolder
IniRead, LocalFolder, %INIFile%, FileLocations, LocalFolder
IniRead, CloudFolder, %INIFile%, FileLocations, CloudFolder
IniRead, WorldNamesFile, %INIFile%, FileLocations, WorldNamesFile
IniRead, InstallReviewFolder, %INIFile%, FileLocations, InstallReviewFolder
IniRead, ModsUsedFile, %INIFile%, FileLocations, ModsUsedFile
IniRead, ResourcePacksUsedFile, %INIFile%, FileLocations, ResourcePacksUsedFile
IniRead, DatapacksUsedFile, %INIFile%, FileLocations, DatapacksUsedFile
IniRead, ScreenCapOutputFolder, %INIFile%, FileLocations, ScreenCapOutputFolder
IniRead, GUIBackgroundColor, %INIFile%, UX, GUIBackgroundColor

/*
MsgBox, 48, %Script_Name%, 
(
Tools Folder`n %ToolsFolder%`n
BackupFolder`n %BackupFolder%`n
Local Folder`n %LocalFolder%`n
Cloud Folder`n %CloudFolder%`n
Install Review Folder`n %InstallReviewFolder%`n
World Names File: %WorldNamesFile%`n
Mods Used File: %ModsUsedFile%`n
Resources Used File: %ResourcePacksUsedFile%`n
Datapacks Used File: %DatapacksUsedFile%`n
Pix Folder: %ScreenCapOutputFolder%`n
GUI Color: %GUIBackgroundColor%`n
)
*/

Return
