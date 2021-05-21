;

#SingleInstance, Force
SetTitleMatchMode, 2                ; 1 = Starts with, 2 = Anywhere, 3 = Exact

Script_Name = ScriptName

RetrieveINIValues:

if(!FileExist("D:\Richard\OneDrive\Games\Minecraft Tools\Minecraft RES Tool Suite\minecraft-tools.ini"))
{
   MsgBox, 48, %Script_Name% - Error-1, Could not find the INI file. Exiting.,2
   winactivate, Error
}

;           Out var,       file,       section, key
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

MsgBox, 48, %Script_Name%, 
(
Tools Folder`n %ToolsFolder%`n
BackupFolder`n %BackupFolder%`n
Local Folder`n %LocalFolder%`n
Cloud Folder`n %CloudFolder%`n
Install Review Folder`n %InstallReviewFolder%`n
World Names File: %WorldNamesFile%`n
Mods Used File: %ModsUsedFile%`n
Resoureces Used File: %ResourcePacksUsedFile%`n
Datapacks Used File: %DatapacksUsedFile%`n
Pix Folder: %ScreenCapOutputFolder%`n
GUI Color: %GUIBackgroundColor%`n
)
