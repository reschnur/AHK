;SavePictureAs Version 10.6 by Robert Jackson - Tested with AutoHotkey 1.1.13.01
;Download the most recent SavePictureAs version here http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/

;Save pictures from the web with Windows XP, Vista and Windows 7 using..
;Internet Explorer    (tested on version 11.0.9600.16521CO) 
;Google Chrome        (tested on version 33.0.1750.154 m)
;Google Chrome Canary (tested on version 30.0.1578.3)
;Cool Novo            (tested on version 2.0.9.11
;Comodo Dragon        (tested on version 28.0.4.0)
;Firefox              (tested on version 28.0)
;K-Meleon             (tested on version 1.5.4)
;Opera                (tested on version 20.0.1387.91)
;Maxthon              (tested on version 4.3.2.1000)
;Safari               (tested on version 5.1.7 [7534.57.2])
;RockMelt             (tested on version 0.16.91.483)
;Yandex               (tested on version 1.7.1364.15751 [91e222f])
;Avant                (tested on version 7.12.2013 build 110)
;Slim Browser         (tested on version 7.0 Build 091)

;Placing the mouse cursor over any picture on the webpage and pressing the "CTRL AND SPACEBAR" or user defined keys will save the picture to your hard drive.

; ======================================================================================================================
; This software is provided 'as-is', without any express or implied warranty.
; In no event will the authors be held liable for any damages arising from the use of this software.
; ======================================================================================================================

;Credits:
;(1) Thanks to the following people for the following code.
;   (A) Lexikos - Scrollable Gui code from http://www.autohotkey.com/forum/viewtopic.php?t=28496
;   (B) Lexikos - Resizable window border from http://www.autohotkey.com/board/topic/23969-resizable-window-border/#entry155480
;   (C) tic - Gdip functions to get image dimensions from
;       http://www.autohotkey.com/board/topic/29449-gdi-standard-library-145-by-tic/#entry187736
;   (D) Sean - Get right click menu contents function GetMenu(hMenu) code from http://www.autohotkey.com/forum/viewtopic.php?t=21451
;   (E) Sean - Retrieve AddressBar of Firefox through DDE Message code
;       from http://www.autohotkey.com/board/topic/17633-retrieve-addressbar-of-firefox-through-dde-message/
;   (F) Sean - Screen Capture from
;       http://www.autohotkey.com/board/topic/16677-screen-capture-with-transparent-windows-and-mouse-cursor/#entry108113
;   (G) Eddy & olfen - UrlDownloadToVar from 
;       http://www.autohotkey.com/community/viewtopic.php?f=2&t=10466&hilit=urldownloadtovar&start=75
;   (H) majkinetor - Common dialog for changing Gui & font colors from http://www.autohotkey.com/forum/viewtopic.php?t=17230
;   (I) majkinetor - DockA found here http://www.autohotkey.com/board/topic/46225-function-docka-10/#entry287726
;   (J) Huba  - Left click on system tray icon from http://www.autohotkey.com/forum/viewtopic.php?t=26720
;   (K) jaco0646 - User-defined Dynamic Hotkeys from http://www.autohotkey.com/board/topic/47439-user-defined-dynamic-hotkeys/
;   (L) derRaphael & JustMe for the Color Controls code from http://www.autohotkey.com/forum/topic33777.html and here 
;       http://www.autohotkey.com/board/topic/90401-control-colors-by-derraphael/
;   (M) heresy - run ahk scripts with less memory from 
;       http://www.autohotkey.com/board/topic/30042-run-ahk-scripts-with-less-half-or-even-less-memory-usage/
;   (N) Rseding91 - Calc_MD5 function posted by Rseding91 from http://www.autohotkey.com/board/topic/77408-md5-function-for-comparing-images/
;   (O) shimanov and Laszlo = Hide System Cursor from  http://www.autohotkey.com/board/topic/5727-hiding-the-mouse-cursor/#entry35098 and
;       http://www.autohotkey.com/board/topic/5727-hiding-the-mouse-cursor/#entry35221
;   (P) nepter - Read text under mouse from here http://www.autohotkey.com/board/topic/94619-ahk-l-screen-reader-a-tool-to-get-text-anywhere/page-1#entry596215
;   (Q) joedf - Check Internet Connection function found here http://www.ahkscript.org/boards/viewtopic.php?f=5&t=349#p3292
;   (R) Chris Mallett for AutoHotkey and Lexikos for continuing to develop AutoHotkey_L
;   (S) Sorry if I missed someone. If so, let me know and I will give credit where credit is due.
;----------------------------------------------------------------------------------------------------------------------------------
;Please Note:
;(1) The configure hotkey routine was created by jaco0646. Not all hotkey conbinations are assignable using the Configure Hotkeys gui. If the hotkey combination you want is not possible using the gui then edit the hotkey entries in SpaConfig.ini. If the hotkeys you write to the ini file are valid the hotkey gui should display them properly. I know very little about jaco0646's User-defined Dynamic Hotkeys . Please ask jaco0646 questions on how to modify the hotkey routine to assign the hotkey you need. Let me know of any alterations to the hotkey routine code that works on previously unassignable hotkeys and I will modify the source code for SavePictureAs. jaco0646's User-defined Dynamic Hotkeys can be found at http://www.autohotkey.com/board/topic/47439-user-defined-dynamic-hotkeys/

;(2) If you change the windows color and text color to the same color then the text is not visible. Choose "Reset All Colors" on the system tray to fix when this happens. Anyone know how to avoid this?

;(3) Capture Active Window only captures the visible part of the active window.

;(4) For Favorite Folder Hotkeys 1 thru 10, the Default Folder Hotkey, and Special Folder Hotkey requires the browser to be active. If you are trying to save a picture and the hotkey appears to not be working click anywhere on the browser to make it the active window.

;(5) For SavePictureAs to work properly, the script needs to be able to right click, send the letter v or the letter s (depending on browser), then wait for the Save Image, Save Picture or Save As window (depending on browser) to open, it will then save the picture to a temp folder. After saving to a temp folder SavePictureAs will apply the user chosen "Filenaming Convention" and check if a file by that name already exists in your chosen folder. If it does then SavePictureAs will apply the "How to Handle Duplicate" rules. Then if enabled the Confirmation Message will be displayed.

;(6) Please let me know of any issues and provide as many details as possible about what type of operating system and browser you are using by emailing Support@SavePictureAs.com

;(7) Requirements: If script is uncompiled Autohotkey 1.1.13.01 or later is required

;(8) SavePictureAs does not install anything on your computer. It runs from the folder you place SavePictureAs.ahk in. The first time you run SavePictureAs.ahk you will be asked where to save downloaded pictures and display program documentation. 

;(9) Running the program is as simple as choosing a default folder location on startup and placing the mouse cursor over a picture and pressing ctrl & the spacebar or user defined hotkeys. There are alot of other features in the system tray menu. 
;   (A) Favorites Toolbar - Save up to 10 favorite locations to save pictures. When you see a picture on the web that you want to save you can quickly change your "Default Folder" using the Favorites  Toolbar then press your "Default Hotkey" to save the picture.
;   (B) The Confirmation Message (done saving picture message), splash screen, saved picture location folders, system colors, Favorites Toolbar and more are configurable from the system tray icon.

;(10) Please read the Help and Program Documentation accessed from the system tray icon for more information.
;----------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------
;Version History:
;
;   Version 1.0 - Original program
;      1) copies pictures using internet explorer by placing mouse over picture and using hotkeys
;          Ctrl Space.
;
;      2) saves files in location defined in SavePictureAs-CtrlSpace.ahk. 
;
;      3) only tested in Windows XP  
;
;   Version 2.0 - Minor Update
;      1) created setup.ahk to allow user to select location to save pictures.
;  
;   Version 2.1 - Minor Update
;      1) merged setup.ahk into SavePictureAs-CtrlSpace.ahk.   
;
;   Version 2.2 - Minor Update
;      1) added code to prevent program from hanging when trying to save a picture that
;          does not have the "Save Picture As" context menu.
;
;   Version 2.3 - Minor update
;      1) added code to block user input (mouse and keyboard)  during code execution   
;
;      2) added code to clear clipboard to prevent user copied clipboard content from
;          interferring with program   
;
;      3) renamed filepath.ini to spafilepath.ini because other programs use
;          filepath.ini   
;
;      4) added title bars for dialog boxes. IE (Help, about...)   
;
;      5) changed code, now during inital setup when the user clicks on cancel instead
;          of choosing a picture location folder the program exits
;
;      6) added showonce.txt so user would be able to see splash screen again   
;
;      7) changed code so that the picture location path is not blank when the user
;          chooses to cancel the picture location select menu
;
;      8) added code to check to see if the current save picture as folder exists at
;          program startup. If the folder does not exist the program prompts user to
;          select another one.
;
;   Version 3.0 - Major update
;      1) added Confirmation Message that displays when a picture has been saved and added
;          option to disable the Confirmation Message
;
;      2) added Confirmation Message enabled/disabled status balloon to system tray,
;          and the ability to change the colors for the Confirmation Message.
;
;      3) program does not use spafilepath.ini or showsplash.txt anymore, uses
;          SpaConfig.ini for all user settings. The program will create
;          SpaConfig.ini with default settings if it does not exist.  
;
;      4) added ability to keep a history of pictures saved  
;
;      5) made the menu on the system tray open with left or right click  
;
;      6)  changed system tray icon from the green H to an icon showing a couple in
;           a hot tub (aka SPA) Save Picture As.  
;
;      7) added "Rename Last Picture", it also updates the history to reflect the
;          new filename.  
;
;   Version 4.0 - Major Update
;      1) added Last Saved Picture Menu to system tray menu
;         Last Saved Picture Menu includes...
;          a) View, Delete, Move, Copy & Rename last saved picture
;      2) added Splash Screen to system tray menu.
;      3) redesigned menus and display screens
;      4) added menu to change screen and text colors
;      5) added Reset All Settings to tray menu
;      6) added picture preview to the history screen
;      7) added Saved picture locations Favorites Toolbar
; 
;   Version 5.0 - Major Update
;      1) added ability to save pictures using Firefox, Opera and Google Chrome
;      2) added ability to save pictures using Windows Vista and Windows 7
; 
;   Version 5.1 - Minor Update
;      1) changed the way firefox saves pictures
;      2) made the History Menu, Program Documentation, Help Screen and Favorites Toolbar
;         configuration windows resizable.
;      3) Added Rename, Move and Copy buttons to History Menu
;      4) Removed Last Saved Picture Menu. The last saved picture can be viewed on the History Menu
;   Version 5.2 - Minor Update
;      1) minor bug fixes - removed some message boxes used for troubleshooting
;   Version 5.3 - Minor Update
;      1) add minimum size to the history window. Needed minimum size to display properly
;   Version 5.4 - Minor Update
;      1) Now if original extension was already in the edit1 control on Save Picture/Image As window then use that one otherwise do not add ext to filename
;   Version 5.5 - Minor Update
;      1) Now checks to see if user is running as admin. Windows 7 needs SavePictureAs to run as administrator due to SavePictureAs features to Move, Delete, Rename and Copy options on the History Menu.
;   Version 5.6 - Minor Update
;      1) Fixed minor bug if the folder chosen to save pictures to does not exist
;   Version 5.7 - Minor Update
;      1) Added Prompt for Filename. Now when enabled the image being saved can be given a user specified filename.
;      2) Added "Check For Updates" on startup and tray menu.
;   Version 5.8 - Minor Update
;      1) Added ability to view changes when a new version is available
;   Version 5.9 - Minor Update
;      1) Fixed issue with Firefox using different window classes across OS platforms
;   Version 6.0 - Minor Update
;      1) Found an issue with not being able to position the Confirmation Window
;   Version 6.1 - Minor Update
;      1) Removed Run As Admin and choose instead to display a message explaining UAC preventing moving and renaming pictures
;   Version 6.2 - Minor Update
;      1) Fixed issue with Google Chrome not saving images in certains conditions.
;   Version 6.3 - Minor Update
;      1) Fixed issue with Windows 7 and Firefox not able to verify image was successfully saved
;   Version 6.4 - Minor Update
;      1) Fixed issue with decimals places in History Gui X,Y, W and H values
;   Version 6.5 - Minor Update
;      1) Fixed issue with Google Chrome window class
;   Version 6.6 - Minor Update
;      1) Found a stray comma preventing Favorites Toolbar number 2 from saving the users choice
;      2) Used Floor(var) to fix a script calculated gui width with decimal places
;   Version 6.7 - Minor Update
;      1) Change updates location from Autohotkey.net to Dropbox
;   Version 6.8 - Minor Update
;      1) Changed SavePictureAs_Update.exe to SavePictureAs_Update.bat
;   Version 6.9 - Minor Update
;      1) Added user defined hotkeys for Save Picture As, Rename last saved picture and all 5 Favorite Folder Toolbar buttons
;   Version 7.0 - Minor Update
;      1) Changed the update process to be the same for SavePicturAs.ahk as it was for SavePictureAs.exe
;   Version 8.0 - Major Update
;      1) Added support for Maxthon, Safari and RockMelt
;      2) How To Handle Duplicates
;          A) "Ask What To Do" when duplicates are found displays both pictures with the following 4 options (Default)
;             a) Rename one or both
;             b) Delete one or both
;             c) Add Date & Time to one or both
;             d) Keep original filename for one picture and apply one of the above options for the other picture
;          B) Do not save duplicates with option to be notified when this happens
;          C) Always overwrite with option to be notified when this happens
;          D) Save duplicates by adding a Random Number to the filename with option to be notified when this happens
;          E) Save duplicates by adding the Date & Time with option to be notified when this happens;
;
;       3) Filenaming Convention (automatically name saved picture to one of the following)
;          A) Date and Time (choose from 6 options on format of Date And Time)
;          B) Filename-Date and time
;          C) Sequential Number
;          D) Random Number
;          E) Filename-Random Number
;          F) Original Filename (Default)
;          G) Option to add a prefix or suffix to any of the above;
;
;      4) Start with windows option (Default off - Does not start with windows)
;      5) Place Confirmation Message at mouse position option (Default off)
;      6) Clear History on exit option (Default off)
;      7) Turn off recording of Last Saved Picture (Default- Recording is on.)
;      8) Delete record of the Last Saved Picture on exit and Delete now options (Default off - do not delete on exit)
;      9) The user can now define how many pictures to list in the History Menu (Default 30)
;     10) Added "Wait for Save Picture window timeout" option to improve reliability on slower computers. (Default 5 seconds)
;     11) Added View Log File, Clear Log File and  Email Log File to Additional Settings Menu (Default - Logging turned off)
;     12) Added "More Info" for each of the above options on the Additional Settings Menu with detailed information on each
;     13) Increase the number of Favorite Folder and Hotkeys from 5 to 10.
;     14) Added "Special Folder" on the "Configure Hotkeys & Folders" menu (Click "HERE" on "Configure Hotkeys & Folders" screen for more information)
;     15) Fixed an issue with the Win Key not being saved as a modifier for hotkeys
;   Version 8.1 - Minor Update
;      1) Found issue with saving pictures using the Opera browser
;   Version 8.2 - Minor Update
;      1) Found an issue with saving changes when enabling/disabling the History.
;   Version 8.3 - Minor Update
;      1) Added support for the Avant, Comodo Dragon, and K-Meleon browsers.
;      2) Added support for Environment and Autohotkey built-in variables. (Click "HERE" on "Configure Hotkeys & Folders" screen for more information)
;      3) Added ability to turn Favorite Folders 1-10 into "Special Folders" (Click "HERE" on "Configure Hotkeys & Folders" screen for more information)
;      4) SavePictureAs hotkeys are now only active if one of the supported browsers is active.
;      5) Added "Change Tray Icon". User can choose from 10 built in icons or add their own icons to choose from. (max 99)
;      6) Added icons to the menu items on the system tray icon
;   Version 8.4 - Minor Update
;      1) Fixed an issue with displaying images properly on the history menu.
;   Version 8.5
;      1) Fixed an issue with Custom Picture Naming Options.
;   Version 8.6 - Minor Update
;      1) Fixed an issue with Google chrome saving pictures.
;   Version 8.7
;      1) Fixed an issue with reading users saved settings for Favorite Folders being used as Special Folders
;   Version 8.8
;      1) Fixed an issue with reading users saved settings for CustomFileNaming incorrectly
;   Version 8.9
;      1) Fixed an issue with PromptForPictureName not saving the picture.
;   Version 9.0 - Major Update
;      1) Added CaptureAreaOfScreen, click on the system tray icon, then "Settings" then "Capture Area Settings" to configure
;      2) Added CaptureActiveWindow
;      3) Added CaptureEntireScreen
;      4) Added "Check For Updates Daily"
;      5) Removed "Check for Updates on Start Up" if SavePictureAs was started on a flash drive
;      6) For Favorite Folder Hotkeys 1 thru 10, the Default Folder Hotkey, and the Special Folder Hotkey requires the browser to be active.
;         If you are trying to save a picture and the hotkey appears to not be working click anywhere on the browser to make it the active window.
;      7) Fixed various minor bugs, error detection and correction.
;      8) Added Disable/Enable All Hotkeys to the system tray icon
;   Version 9.1 - Minor Update
;      1) Fixed an issue when unable to load an icon would cause an error instead of silently not loading the icon.
;   Version 9.2 - Minor Update
;      1) Fixed minor display issues
;   Version 9.3 - Minor Update
;      1) Found a small typo error causing Check for Updates daily to not be enabled on startup
;   Version 9.4 - Minor Update
;      1) Found an issue with hotkeys starting enabled even though they were set to disabled in the ini file upon startup
;   Version 9.5 - Minor Update
;      1) Added End-User License Agreement (EULA)
;      2) Fixed spelling typos
;      3) Fixed missing Program Documentation icon when running SavePictureAs on Windows 8.0 
;   Version 9.6 - Minor Update
;      1) Found hotkeys not be turned back on when closing the Configure Hotkeys & Folders screen by clicking on the X.
;   Version 9.7 - Minor Update
;      1) Found issue with Don't Remind Me Until Next Update not saving the choice properly.
;   Version 9.8 - Minor Update
;      1) Added ability to compare the MD5 Checksum value of the duplicate picture with the MD5 Checksum value of the original to identify if the duplicate picture is identical to the original.
;         If the duplicate picture is identical to the original then the duplicate will not be saved. This setting can be changed on the Additional Settings Menu.
;      2) Added "Please provide feedback" survey option
;      3) Found an issue with "Do not save duplicates" showing message that a duplicate was found and not saved even though "&Notify Me" was not checkmarked on the Additional Settings Window
;      4) Found filename to be incorrect on all the "&Notify Me" message boxes when a duplicate was found.
;      5) Found an issue when a duplicate filename is found and the duplicate is deleted then "Rename Last Saved Picture" was recording the deleted duplicate as the last saved picture.
;      6) When updating to the newest version the update process will verify the downloaded update using the MD5 cryptographic hash function.
;      7) Added FileNaming options (Date & Time-FileName) and (Sequential Number-FileName)
;      8) Redesigned menus to display properly on DPI 96 and DPI 120
;   Version 9.9 - Minor Update
;      1) Improved Automatic updates to include alternate update links
;   Version 10.0 - Minor Update
;      1) Added alternate method to check for updates by entering a url provided by tech support
;      2) Fixed "View Current" and "View Changes" to display the correct Date-Time format if Date-Time format was chosen to be part of the new filename. 
;         This can be found by clicking on the System Tray icon, selecting Settings, Additional Settings, selecting "Custom Picture Name" then clicking on "Configure"  
;   Version 10.1 - Minor Update
;      1) Redesigned "Program Colors" configuration screen
;      2) Redesigned "Additional Settings Menu" to display properly on DPI 96 and DPI 120
;      3) Fixed minor display bug when changing screen colors.
;   Version 10.2 - Minor Update
;      1) Improved "Test Changes" process on the Program Colors settings page
;      2) Spaces before and after the "Prefix" and before and after the "Suffix" on the custom naming options are now allowed.
;      3) Added Date & Time option which allows a user defined "separator"  characters between the Date and Time values. 
;         Example (The AND sign and spaces were added with this option): 20140404 & 080109.jpg
;      4) Added "Use above options and Prompt for Filename" to the Custom Picture Name options. 
;         SavePictureAs will rename the picture to your choice then prompt you so you can change the new filename when saving a picture.
;      5) Added Custom Filenaming Option - [UserInput1] Date && Time [UserInput2] Original Filename (When saving a picture you will be prompted for UserInput)  
;      6) Added support for the Slim Browser
;      7) Redesigned "Prompt For Picture" name prompt
;   Version 10.3 - Minor Update
;      1) Found an issue displaying menu icons on Windows 8.1.
;   Version 10.4 - Minor Update
;      1) Found an issue with displaying the "Reset All Settings" icon
;   Version 10.5 - Minor Update
;      1) Found an issue with downloading updates via the "Check for Updates" tray menu option
;   Version 10.6 - Minor Update
;      1) Found an issue with displaying system tray menu icons on Windows 8
;    
;}
#Singleinstance Force
#NoEnv
#Persistent
#InstallMouseHook
#WinActivateForce
#UseHook
SetWorkingDir, %a_scriptdir%
SetTitleMatchMode, 3
SetBatchLines, -1
ComObjError(false)
DetectHiddenWindows, On
CurrentlyStartingUp = Loading...Please Wait
menu, tray, tip, %CurrentlyStartingUp%

ProgramName = SavePictureAs
Version = 10.6
Author = Robert Jackson (DataLife)

ForumURL =       http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/
UpdateLink1 =    http://sourceforge.net/projects/savepictureas/files/SavePictureAs_Info-3.txt/download
UpdateLink2 =    https://dl.dropboxusercontent.com/u/97612891/SavePictureAs/SavePictureAs_Info-3.txt
UpdateLink3 =    https://copy.com/QoGEFxsht7plHgoY
UpdateLink4 =    https://www.cubby.com/pli/SavePictureAs_Info-3.txt/_a5445eaf3a494f3aaa63449e717d44f9
UpdateLink5 =    https://onedrive.live.com/download?resid=AAA3D82D7A15CDC5`%21164
TestUpdateLink = http://sourceforge.net/projects/savepictureas/files/SavePictureAs_Info-0.txt/download
                   
Iniread,SetupStatus,SpaConfig.ini,SetupStatus,Status
If ( SetupStatus <> "Complete" )
 CurrentlyInSetup = Yes

IniRead,RestartAfterUpdating,SpaConfig.ini,RestartAfterUpdating,Status

IniRead,Eula,Spaconfig.ini,FirstRun,Eula

if Eula = Accept
 goto AfterEULA


Gui 55: font, s12, MS sans serif
colon = :
Gui 55: Add, ListBox, w920 h550  vscroll 0x100 choose1 , 
|End-User License Agreement (EULA)
|-------------------------------------------------------
|
|The following terms are used during the End-User License Agreement%colon% 
|
|SOFTWARE = SavePictureAs
|AUTHOR = Robert Jackson
|USER = anyone who downloads, and/or runs (i.e. USES) the SOFTWARE
|
|This is an agreement between the USER and the AUTHOR.
|The SOFTWARE is protected by copyright laws and is the intellectual property of the AUTHOR.
|
|All intellectual rights are reserved by the AUTHOR. The software is NOT the property of the USER, but only licensed
|for use according to the terms of this EULA.
|
|The SOFTWARE is freeware, which means that it can and should be distributed, copied, uploaded, downloaded and shared
|freely by anyone, but only in its entirety, the original distribution. Any attempts to reverse-engineer, modify or
|alter the executable binaries of the SOFTWARE in any way are strictly prohibited. Using parts of the SOFTWARE in any
|other software product is strictly prohibited.
|
|Distributing the whole SOFTWARE as part of another software product is bound to written permission of the AUTHOR,
|except for free software collections. Such bundling must always be done with proper credit given. Selling, hiring,
|lending, or making money in any way from any storage media (CD, DVD, floppy disk, hard disk, memory card, other) 
|which admittedly contains the SOFTWARE is bound to prior written permission of the AUTHOR.
|
|The SOFTWARE is provided by the AUTHOR in good faith but the AUTHOR does not make any representations or warranties
|of any kind, express or implied, in relation to all or any part of the SOFTWARE, and all warranties and representations
|are hereby excluded to the extent permitted by law.
|
|Disclaimer%colon% 
|
|THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
|BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
|NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
|DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
|SOFTWARE.
|
|
Gui 55: add, button,w80 h25 x385 y570 gAfterEULA, Accept
Gui 55: add, button,w80 h25 x485 y570 gDecline, Decline
Gui 55: Color, f1f1f1
Gui 55: Show, w950 H605 ,SavePictureAs V%Version% (End-User License Agreement (EULA))
Return
Decline:
MsgBox,4132,Confirm, Are you sure you want to exit setup?
IfMsgBox,Yes
  ExitApp
IfMsgBox,No
 return

AfterEULA:
IfWinExist,SavePictureAs V%Version% (End-User License Agreement (EULA))
 Gui 55: destroy

IfInString,A_OSVersion,WIN_8
 OS_Is_A_Variant_Of_Windows_8 = 1

if a_scriptdir = %A_Desktop%
 { 
  SplitPath,A_ScriptName,,,TempVar
  MsgBox,4164,SavePictureAs V%version%, SavePictureAs has detected it is located on your desktop.`n`nIt is recommended that you exit Setup and move SavePictureAs.%TempVar% to its own folder.`n`nSavePictureAs will place several support files (more than 15) in the same folder it is located in.`n`nDo you want to continue setup now and place these support files on your desktop?
  IfMsgBox, no
    Exitapp
 }

gosub CreatePictures&Icons ; 1.6 seconds to create 11 icons and SpaImage 
gosub CreateSpaImage       
gosub SplashScreenTextVar

IfExist,%a_scriptdir%\spatrayicon.ico
 Menu, TRAY, Icon, Spatrayicon.ico ;want  icon to be SpaTrayIcon.ico as soon in the script as possible

SetFormat,float,0.                 ;I don't remember why I used this, afraid to remove it and then see issues/bugs after releasing to the public
SetTitleMatchMode,2
SetWorkingDir, %A_ScriptDir%
onexit, quit

RegRead, DPI, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, AppliedDPI ;need to know if user is using 96, 120 or 144 DPI for gui design

VarSetCapacity(A_PicturesSF, 256) ;Need path to MyPictures for Favorites Toolbar, FileSelectFolder and Configure Hotkeys and Folders gui.
DllCall( "shell32\SHGetFolderPath", "uint", 0 , "int", 0x27 , "uint", 0 , "int", 0 , "str", A_PicturesSF)

;this groub allows IfWinActive, ahk_Group %BrowserWindows% so that hotkeys are only active when one of the supported browsers is active
GroupAdd, BrowserWindows, ahk_class IEFrame ;Internet explorer
GroupAdd, BrowserWindows, ahk_class Chrome_WidgetWin_0 ;Chrome, Canary, Rockmelt, Cool Novo, Comodo Dreagon
GroupAdd, BrowserWindows, ahk_class Chrome_WidgetWin_1 ;Chrome, Canary, Rockmelt, Cool Novo, Comodo Dreagon
GroupAdd, BrowserWindows, ahk_class YandexBrowser_WidgetWin_1 ;Yandex
GroupAdd, BrowserWindows, ahk_class KMeleon Browser Window ;K-Meleon
GroupAdd, BrowserWindows, ahk_class TAFfrmClient.UnicodeClass ;Avant 
GroupAdd, BrowserWindows, ahk_class OperaWindowClass  ;opera
GroupAdd, BrowserWindows, ahk_class MozillaUIWindowClass ;firefox
GroupAdd, BrowserWindows, ahk_class MozillaWindowClass ;firefox
GroupAdd, BrowserWindows, ahk_class Maxthon3Cls_MainFrm ;maxthon
GroupAdd, BrowserWindows, ahk_class {1C03B488-D53B-4a81-97F8-754559640193} ;safari
GroupAdd, BrowserWindows, ahk_class SlimBrowser MainFrameW
GoSub GetEnvironmentVariables
IniRead, MaxHistoryMenuPicturesToList,SpaConfig.ini,History,MaxHistoryMenuPicturesToList,30
iniread, DefaultPath, SpaConfig.ini, DefaultPath, Path,%A_PicturesSF%
if TreatPercentSignsAsVariables = 1
 { 
  CurrentPath = %DefaultPath%
  gosub CheckForEnvironmentVariablesAndBuiltInVariables
  if CurrentPath <> %DefaultPath%
    DefaultPath = %CurrentPath%
 }
 
iniread, ErrorLogging,SpaConfig.ini,ErrorLog,ErrorLogging,0
IniRead, HistoryValue, SpaConfig.ini, History, HistoryValue, ENABLED
IniRead, TimeOut,SpaConfig.ini,WaitForSavePictureAsWindow,TimeOut,5
IniRead, ConfirmationMessageValue, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageStatus, ENABLED 
IniRead, ConfirmationMessageXPos,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageXpos, %a_space%
IniRead, ConfirmationMessageYPos,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageYpos, %a_space%
if ( ConfirmationMessageXPos < 0 or ConfirmationMessageXPos > %A_ScreenWidth% )
 ConfirmationMessageXPos := ((A_ScreenWidth / 2) - 100 ) 
if ( ConfirmationMessageYPos < 0 or ConfirmationMessageYPos > %A_ScreenHeight% )
 ConfirmationMessageYPos := (( A_ScreenHeight / 2) - 100 )
IniRead, PlaceConfirmationMessageAtMousePosition, SpaConfig.ini, ConfirmationMessage, PlaceConfirmationMessageAtMousePosition, 0
IniRead, TurnOffRecordingOfTheLastSavedPicture,SpaConfig.ini, History,TurnOffRecordingOfTheLastSavedPicture,0

IniRead, PromptForFilename,SpaConfig.ini,NamingConvention,PromptForFilename, 0
IniRead, CustomFileNameFormat,SpaConfig.ini,NamingConvention,CustomFilenameFormat,0
IniRead, OriginalFileNameFormat,SpaConfig.ini,NamingConvention,OriginalFilenameFormat,1

IniRead, AskHowToHandleDuplicates,SpaConfig.ini,DuplicateFileNames,AskHowToHandleDuplicates,1
IniRead, DoNotSaveDuplicates,SpaConfig.ini,DuplicateFileNames,DoNotSaveDuplicates,0
IniRead, AlwaysOverWrite,SpaConfig.ini,DuplicateFileNames,AlwaysOverWrite,0
IniRead, SaveDuplicatesWithRandomNumber,SpaConfig.ini,DuplicateFileNames,SaveDuplicatesWithRandomNumber,0
IniRead, AddDateAndTimeWhenDuplicateIsFound,SpaConfig.ini,DuplicateFileNames,AddDateAndTimeWhenDuplicateIsFound,0
IniRead, CheckForIdenticalHashValues,SpaConfig.ini,DuplicateFileNames,CheckForIdenticalHashValues,0

;NotifyMe, these options will notify you when a duplicate is found and a Duplicate Rule was applied automatically.
IniRead, SaveDuplicatesWithRandomNumberAndNotifyMe,SpaConfig.ini,DuplicateFileNames,SaveDuplicatesWithRandomNumberAndNotifyMe,1
IniRead, DoNotSaveDuplicatesAndNotifyMe,Spaconfig.ini,DuplicateFileNames,DoNotSaveDuplicatesAndNotifyMe,1
IniRead, AlwaysOverWriteAndNotifyMe,SpaConfig.ini,DuplicateFileNames,AlwaysOverWriteAndNotifyMe,1
IniRead, AddDateAndTimeWhenDuplicateIsFoundAndNotifyMe,SpaConfig.ini,DuplicateFileNames,AddDateAndTimeWhenDuplicateIsFoundAndNotifyMe,1
IniRead, CheckForIdenticalHashValuesAndNotifyMe,SpaConfig.ini,DuplicateFileNames,CheckForIdenticalHashValuesAndNotifyMe,1

IniRead, DateTimeFormatDuplicates,spaconfig.ini,DateTimeFormat,Duplicates,MM dd yy - HH mm ss
IniRead, DateTimeFormatFilenamingConvention,spaconfig.ini,DateTimeFormat,FilenamingConvention,MM dd yy - HH mm ss

IniRead, TreatPercentSignsAsVariables,spaconfig.ini,FavoritePaths,TreatPercentSignsAsVariables,0

IniRead,HotkeysStatus,SpaConfig.ini,Hotkeys,HotkeysStatus

if HotkeysStatus = error
 HotkeysStatus = On
 
ActivatingCheckForUpdatesDaily = 0

OnMessage(0x84, "WM_NCHITTEST") ;horizontal (these 3 OnMessages are for the thin draggable, resizable GuiOutline used for CaptureAreaOfScreen)
OnMessage(0x83, "WM_NCCALCSIZE")
OnMessage(0x86, "WM_NCACTIVATE") ;vertical if nchittest is being used

OnMessage(0x115, "OnScroll") ; WM_VSCROLL Used for the User Help screen
OnMessage(0x114, "OnScroll") ; WM_HSCROLL

OnMessage(0x0133, "Control_Colors") ;WM_CTLCOLOREDIT = 0x0133, WM_CTLCOLORLISTBOX = 0x0134, ;WM_CTLCOLORSTATIC = 0x0138
OnMessage(0x0138, "Control_Colors") 

OnMessage(0x201, "WM_LBUTTONDOWN") ;used for ScreenCapture to drag borderless gui
OnMessage(0x203, "WM_LBUTTONDBLCLK") ;Used to double click on images in SavePictureAs Guis and have them be displayed in the OS's default image viewer.

if A_PtrSize = 4
    AhkBuild = 32-bit AutoHotkey ;for error logging
if A_PtrSize = 8
	AhkBuild = 64-bit AutoHotkey ;for error logging
if ( A_PtrSize <> 4 and A_PtrSize <> 8 ) ;for error logging
	AhkBuild = Unknown build of AutoHotkey

;determine max random number for naming pictures
SplitPath,A_AhkPath,,,,,Drive
DriveGet, FileSystem, FileSystem , %Drive%
if ErrorLevel = 1
 MaxRandomNumber = 512
if FileSystem = Fat
 MaxRandomNumber = 512
if FileSystem = Fat32
 MaxRandomNumber = 65534 
if FileSystem = NTFS          
 MaxRandomNumber = 2147483647                                 ;this is the largest allowed integer value / 4294967295 is max for NTFS file system

if A_IsCompiled = 1
 { 
   SavePictureAs = SavePictureAs.exe ;used for a message box
   menu, tray, deleteall
   menu, tray, NoStandard
 } 
else
 { 
  AddAutoHotkeyVersionIfCompiled = AutoHotkey:           %AhkBuild% ;used for logfile.txt
  SavePictureAs = SavePictureAs.ahk                                 ;used for a message box
 }

If ( A_OSVersion = "win_vista" or A_OSVersion = "win_7" or OS_Is_A_Variant_Of_Windows_8 = 1 )
 {
  IniRead,ShowAdminMessage,SpaConfig.ini,AdminMessage,ShowAdminMessage
  If (ShowAdminMessage = 1 or ShowAdminMessage = "ERROR" or ShowAdminMessage <> 0 ) ; 1 = show / 0 = Don't show / ERROR is because SpaConfig.ini has not been created.
   {
     gui 1: font, s12
     Gui 1: add, text, w350 ,SavePictureAs allows you to Delete, Move, Copy, and Rename the pictures you downloaded.`n`nUser Account Control (UAC) included with Windows Vista, Windows 7 and Windows 8 may prevent SavePictureAs from moving or renaming the pictures you downloaded.`n`nIf you have issues moving or renaming pictures using the History Menu then you can do one of the following.`n`nRight click SavePictureAs and choose "Run As Administrator"`nOR`nTurn off or change UAC settings.`n
    IfExist, SpaConfig.ini
     {
      Gui 1: add, checkbox, vChoice, Do not show this message again
      UseVar = 1
     }
    else
     UseVar = 0
    
    if ( CurrentlyInSetup = "yes" )
     UACbuttonText = Next
    else
     UACbuttonText = OK
    Gui 1: add, button, gUacbutton hwndHWND_UACbutton,%UACbuttonText%
    
    Gui 1: show, ,SavePictureAs & UAC Information
    gui 1: color, c0c0c0
    WinGet,UACID,id,SavePictureAs & UAC Information
    
    WinGetPos,,,TempvarGuiWidth,,ahk_id %UACID%
    NewUACButtonXpos := ( TempvarGuiWidth - 80 )
    ControlMove,,%NewUACButtonXpos%,,,,ahk_id %HWND_UACbutton%
    
    WinSet,AlwaysOnTop, On, SavePictureAs & UAC Information
    UseVar = 1
    Return
   }
 }
UACbutton:
guicancel:
If UseVar = 1
 {
  Gui 1: Submit
  Tempvar := !Choice
  iniwrite, %Tempvar%, SpaConfig.ini,AdminMessage,ShowAdminMessage 
 }
Gui 1: destroy

IniRead,CheckForUpdates,SpaConfig.ini,CheckForUpdates,CheckForUpdates, 1
If ( CheckForUpdates = 1 )
 gosub CheckForUpdates

IfWinExist, ahk_id %CheckingForUpdatesGui42ID%
 WinWaitClose, ahk_id %CheckingForUpdatesGui42ID%
IfWinExist, ahk_id %SavePictureAsUpdateCheckGui11ID%
 WinWaitClose, ahk_id %SavePictureAsUpdateCheckGui11ID%
IfWinExist, ahk_id %ErrorCheckingForUpdatesGui45ID%
 WinWaitClose, ahk_id %ErrorCheckingForUpdatesGui45ID%

IfExist,SavePictureAs_Update.bat
 FileDelete, SavePictureAs_Update.bat
IfExist,SavePictureAs_Update.exe ;clean up from previous versions that used SavePictureAs_Update.exe
 FileDelete, SavePictureAs_Update.exe
;Daily timer
IniRead,CheckForUpdatesDaily,spaconfig.ini,CheckForUpdates,CheckForUpdatesDaily,1
CheckForUpdatesDailyValue = 86400000
if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" )
 SetTimer,CheckForUpdatesDaily, %CheckForUpdatesDailyValue%  

gosub CreateReadMeFirstTxt
gosub CreateProgramInfoAndCreditsTxt

;===================================================================================================================================
if ( CurrentlyInSetup = "yes" )
 {
  SplashScreenForSetup:
  Gui 9: Default
  Gui 9: -SysMenu
  Gui 9: font
  Gui 9: font, s11, MS sans serif
  Gui 9: add, edit, w740 h600 vSplashScreenForSetupEditBox ReadOnly  , %SplashScreenTextVar% 
  Control_Colors("SplashScreenForSetupEditBox", "Set", "0xC0C0C0", "0x000000")  
  Gui 9: Add, Button, x82  y625 w120 h40 , Cancel Setup
  Gui 9: Add, Button, x312  y625 w140 h40 , Setup Details
  Gui 9: Add, Button, x562  y625 w120 h40 , Next 
  Gui 9: Color,  7995B0,c0c0c0
  Gui 9: -MinimizeBox 
  Gui 9:  +MinSize +MaxSize 
  Gui 9: Show, hide w765 h680 ,SavePictureAs V%Version% (SplashScreen) Setup
  Gui 9: Color, 7995B0
  WinGet,SplashScreenSetupID,ID, SavePictureAs V%Version% (SplashScreen) Setup
  ControlFocus,button1, ahk_id %SplashScreenSetupID%
  ControlClick,edit1,ahk_id %SplashScreenSetupID%
  winshow, ahk_id %SplashScreenSetupID%
  WinSet, alwaysontop, On ,SavePictureAs V%Version% (SplashScreen) Setup
  Return
  9ButtonSetupDetails:
  SysGet,MWA,MonitorWorkArea
  WinSet, alwaysontop, Off ,SavePictureAs V%Version% (SplashScreen) Setup
  gui 9: +disabled
  gui 20:+owner9
  Gui 20: font, s13 , MS sans serif
  if a_screendpi = 120
   TempVarGuiwidth := ( MWARight - 500)
  else
   TempVarGuiwidth := ( MWARight - 100)
  TempvarTextWidth := (TempVarGuiWidth - 20)
  ButtonXpos := (TempvarGuiWidth - 120 ) /2
  Gui 20: Add,Text, x6 y15 w%TempvarTextWidth% c000000,
   (
(1)   Displays End User License Agreement (EULA)     (Will only show 1 time but can be shown later via the system tray icon then "About")
(2)   Displays User Account Control information      (With option to not show again on startup)
(3)   Displays SplashScreen detailing key features of SavePictureAs with option to cancel the setup.     (With option to not show again on startup and can be accessed later via the system tray icon)
(4)   Checks for updates (This can be turned off by clicking on "Settings" then "Additional Settings" on the system tray icon)
(5)   Displays SavePictureAs new features window     (Will only show 1 time)
(6)   Prompts user to select Hotkeys and Favorite Folders to save pictures to.     (Will only show 1 time but options can be changed later via the system tray icon)
(7)   Displays options for "Create SavePictureAs" Desktop shortcut and Start SavePictureAs when windows starts     (Will only show 1 time but options can be changed later via the system tray icon)
(8)   Displays option for user to change the system tray icon     (Will only show 1 time but options can be changed later via the system tray icon)
(9)   Displays window asking for user feedback.     (Will only show 1 time but can be shown later via the system tray icon then "About")
(10) Displays Setup Complete Screen     (Will only show 1 time)

%SavePictureAs% does not install anything on your computer. It runs from the folder you place %SavePictureAs% in.

%SavePictureAs% will create support files in the current folder only.

Run %SavePictureAs% each time you want to start SavePictureAs.
    )
  Gui 20: font, s10 , MS sans serif
  Gui 20: Add, Button, x%ButtonXpos% y+35 w120 ,Close Window
  Gui 20: Show, w%TempvarGuiWidth% , SavePictureAs V%Version% (Setup Details)
  Gui 20: Color, c0c0c0
  winset,AlwaysOnTop, on, SavePictureAs V%Version% (Setup Details)
  Return
  20ButtonCloseWindow:
  20GuiEscape:
  20GuiClose:
  Gui 9: -disabled 
  WinSet, alwaysontop, On ,SavePictureAs Setup (SplashScreen)
  Gui 20: Destroy     
  Return
 }  
else
 goto SkipSplashScreenForSetup
;**************************************************************************************************
;*************************************End Enable/Disable Splash Screen*****************************
;**************************************************************************************************
9ButtonCancelSetup: ;cancel or continue setup
FileDelete,%a_scriptdir%\spaimage.jpg
FileDelete,%a_scriptdir%\Spatrayicon.ico
FileDelete,%a_scriptdir%\OriginalSpatrayicon.ico
FileDelete,%a_scriptdir%\BlackCamera.ico
FileDelete,%a_scriptdir%\BlueSkyGreenGrass.ico
FileDelete,%a_scriptdir%\FilmCanister.ico
FileDelete,%a_scriptdir%\PictureInBlueFolder.ico
FileDelete,%a_scriptdir%\PictureOnFolder.ico
FileDelete,%a_scriptdir%\PictureOnWall.ico
FileDelete,%a_scriptdir%\PictureWindow.ico
FileDelete,%a_scriptdir%\PinkSunset.ico
FileDelete,%a_scriptdir%\SunAndClouds.ico
FileDelete,%a_scriptdir%\readmefirst.txt
FileDelete,%A_ScriptDir%\SpaConfig.ini
FileDelete,%A_ScriptDir%\spaconfig2.ini
FileDelete,%A_ScriptDir%\transparent_square.ico
FileDelete,%A_ScriptDir%\Hotkeys.ico

DoNotRunEntireQuitLabel = 1 ;prevent the OnExit Quit label from running
ExitApp
9ButtonNext:
Gui 9: destroy
;====================================================Install Screen End============================================================
;====================================Create SpaConfig.ini - Choose Picture Location - ErrorLogging=================================
SkipSplashScreenForSetup: 
IniRead,ErrorLogging,SpaConfig.ini,Errorlog,Errorlogging,0
IfExist,spaconfig2.ini
 {
  IniRead,Value,Spaconfig2.ini,CheckForUpdates,CheckForUpdates, 1 ;needed to record user selection for Check For Updates
  IniWrite,%Value%,SpaConfig.ini,CheckForUpdates,CheckForUpdates ;before SpaConfig.ini is created
  FileDelete,spaconfig2.ini
 }  

skipFunctionalityNotice:
;================================Begin===Setup Hotkeys and if needed convert Version 7.0 hotkeys to Version 8.0 and higher===Begin================================================
;reads Hotkey11, this will be error if new setup or updating from Version 7.0
IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel11 
IniRead,TempVar2,SpaConfig.ini,FirstRun,ConfigureCaptureHotkeys
if ( TempVar = "ERROR" or TempVar2 = "ERROR" )              ;Moves default hotkey 7 to hotkey 11 (default folder) and Run configure hotkeys gui to setup capture hotkeys
 {                                                          ;if HKL11 is ERROR then the update is from 7.0 or earlier 
  if ( Tempvar = "ERROR" )
   {
    IniRead,Tempvar,SpaConfig.ini,Hotkeys,HotkeyLabel7       ;if HKL7 is ERROR then the update is from a version before 7.0
    if ( TempVar = "ERROR" )                                                            
     IniWrite,^Space,SpaConfig.ini,Hotkeys,HotkeyLabel11     ;write ctrl space to 11 if 7 was never assigned (pre 7.0 version)
    else
     IniWrite,%tempvar%,SpaConfig.ini,Hotkeys,HotkeyLabel11  ;move user choice from 7 to 11 if assigned (7.0)
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel7    ;erase 7 after moving 7 to 11 (7.0)
  
    IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel12      
    if ( TempVar = "ERROR" )                                 ;Moves default hotkey 6 to hotkey 12 (rename last saved picture)
     {                                                      ;if HKL12 is ERROR then the update is from 7.0 or earlier
      IniRead,Tempvar,SpaConfig.ini,Hotkeys,HotkeyLabel6     ;if HKL6 is ERROR then the update is from a version before 7.0
      if ( TempVar = "ERROR" ) 
       IniWrite,^/,SpaConfig.ini,Hotkeys,HotkeyLabel12        ;write ctrl / to 12 if 6 was never assigned (pre 7.0 version)
      else
       IniWrite,%tempvar%,SpaConfig.ini,Hotkeys,HotkeyLabel12 ;move user choice from 6 to 12 if assigned (7.0)
      IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel6   ;erase 6 after moving 6 to 12 (7.0)
     }
   }
  if ( TempVar2 := "ERROR" )
   MsgBox,4160,SavePictureAs New Features, SavePictureAs V%version% supports "Capturing" the Active Window, the Entire Screen and user Selected Areas of the screen.`n`nThe Configure Hotkeys & Folders configuration page will open next to allow you configure these hotkeys.`n`nFor more information click on "Help" at the bottom of the "Configure Hotkeys & Folders" configuration page.
  gosub ConfigureHotkeys ;When this gui is closed all hotkeys will be activated
  WinWaitClose, ahk_id %Chid%
  IniWrite,AlreadyShownOnceOnStartUp,SpaConfig.ini,FirstRun,ConfigureCaptureHotkeys
  ;========================================End===Convert Version 7.0 hotkeys to Version 8.0===End================================================
 }
else ;activate hotkeys
 {
  ;******************************************Begin===Create Favorite Folder Hotkeys===Begin**************************************************
  ;The hotkeys for Capture Entire Screen, Capture Active Window, Capture Area of Screen, Rename Last Saved Picture will always be active
  Hotkey, IfWinActive
  
  ;Rename Last Saved Picture #16 on Configure Hotkeys & Folders gui is HotkeyLabel12
  ;12
  IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel12
  if ( TempVar <> "ERROR" and TempVar <> "" )
   {
    Hotkey, %TempVar% ,HotkeyLabel12,On,UseErrorlevel 
    if ErrorLevel in 2,3,4
     {
      MsgBox,4112,SavePictureAs Error, The Hotkey for "Rename Last Saved Picture" is not valid.`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
      IniWrite,%a_space%,Spaconfig.ini,Hotkeys,HotkeyLabel12
     }
   }
  ;Special Folder #12 on Configure Hotkeys & Folders gui is HotkeyLabel13 (needs to be grouped with Favorite Hotkeys 1-10 and Default Folder 11)
  
  ;Active Window #13 on Configure Hotkeys & Folders gui is HotkeyLabel14
  ;14
  IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel14
  ;xxxx copy error msg box to configure hotkey gui
  if ( TempVar <> "ERROR" and TempVar <> "" )
   {
    Hotkey, %TempVar% ,HotkeyLabel14,On,UseErrorlevel 
    if ErrorLevel in 2,3,4
     {
      MsgBox,4112,SavePictureAs Error,The Hotkey for "Capture Active Window" is not valid.`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
      IniWrite,%a_space%,Spaconfig.ini,Hotkeys,HotkeyLabel14
     }
   }
  
  ;Entire Screen #14 on Configure Hotkeys & Folders gui is HotkeyLabel15
  ;15
  IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel15
  if ( TempVar <> "ERROR" and TempVar <> "" )
   {
    Hotkey, %TempVar% ,HotkeyLabel15,On,UseErrorlevel 
    if ErrorLevel in 2,3,4
     {
      MsgBox,4112,SavePictureAs Error,The Hotkey for "Capture Entire Screen" is not valid.`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
      IniWrite,%a_space%,Spaconfig.ini,Hotkeys,HotkeyLabel15
     }
   }
  ;Area Window #15 on Configure Hotkeys & Folders gui is HotkeyLabel16
  ;16
  IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel16
  if ( TempVar <> "ERROR" and TempVar <> "" )
   {
    Hotkey, %TempVar% ,HotkeyLabel16,On,UseErrorlevel 
    if ErrorLevel in 2,3,4
     {
      MsgBox,4112,SavePictureAs Error,The Hotkey for "Capture Area of Screen" is not valid.`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
      IniWrite,%a_space%,Spaconfig.ini,Hotkeys,HotkeyLabel16
     }
   }
 
  Hotkey, IfWinActive, ahk_group BrowserWindows ;hotkeys 1-10, Default Folder and Special Folder will only be active when one of the browser is active
  ;Favorite Folders 1-10 on Configure Hotkeys & Folders gui
  Loop, 10             ;create all hotkeys
   {
    IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel%a_index%
    if ( TempVar <> "ERROR" and TempVar <> "" )
     {
      Hotkey, %TempVar% ,HotkeyLabel%A_Index%,On,UseErrorlevel 
      if ErrorLevel in 2,3,4
       {
        MsgBox,4112,SavePictureAs Error,The Hotkey for "Favorite Folder" #%A_Index% is not valid.`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com 
        IniWrite,%a_space% SpaConfig.ini, Hotkeys, HotkeyLabel%a_index%
       }
     }
   }
 
 ;Default Folder #11 on Configure Hotkeys & Folders gui
  IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel11
  Hotkey, %TempVar% ,HotkeyLabel11,On,UseErrorlevel 
  if ErrorLevel in 2,3,4
   {
    MsgBox,4112,SavePictureAs Error,The Hotkey for the "Default Folder" is not valid.`n`nControl-Space will be used as the Default hotkey.`n`nTo change to your preference close this window then go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to change.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com 
    IniWrite,^space,Spaconfig.ini,Hotkeys,HotkeyLabel11
   }
 
  ;Special Folder #12 on Configure Hotkeys & Folders gui is HotkeyLabel13
  ;13 Special Folder
  IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel13
  if ( TempVar <> "ERROR" and TempVar <> "" )
   {
    Hotkey, %TempVar% ,HotkeyLabel13,On,UseErrorlevel 
    if ErrorLevel in 2,3,4
     {
      MsgBox,4112,SavePictureAs Error,The Hotkey for "Special Folder" #12 is not valid.`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com 
      IniWrite,%a_space%,Spaconfig.ini,Hotkeys,HotkeyLabel13
     }
   }
  Hotkey, IfWinActive 
 } ;closing brace for Else


IniRead,HotkeysStatus,SpaConfig.ini,Hotkeys,HotkeysStatus
if HotkeysStatus = error
 { 
  IniWrite,On,SpaConfig.ini,Hotkeys,HotkeysStatus
  HotkeysStatus = On
 }
if HotkeysStatus =  Off 
 gosub, TurnHotkeysOff
;******************************************End===Create Favorite Folder Hotkeys===End**************************************************
;******************************************Create Confirmation Message Gui and hide********************************************************
IniRead, ConfirmationMessageDelay, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageDelay, 1000
IniRead, TextColor, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageTextColor, 000000
IniRead, ConfirmationMessageWindowColor, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageWindowColor, 8b8b8b
TempXpos := (( A_ScreenWidth / 2 )- 50)
IniRead, ConfirmationMessageXPos,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageXpos, %TempXpos%
IniRead, ConfirmationMessageYPos,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageYpos, 215
IniWrite, %TempXpos%,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageXpos

Gui 17: -caption +owner
Gui 17: font
if Dpi <> 120
 {
  gui 17: font, s27 w700 , Times New Roman Bold italic
  Gui 17: add, text,x1 y27 w100 center c%textColor% vConfirmationMessageDone hwndHWND_ConfirmationMessageDone  , Done
 }
else
 {
  gui 17: font, s26 w700 , Times New Roman Bold italic
  Gui 17: add, text, x-10 y20 w100 center c%textColor% vConfirmationMessageDone hwndHWND_ConfirmationMessageDone  , Done
 }
Gui 17: Show, hide x%ConfirmationMessageXpos% y%ConfirmationMessageYpos%  w100 h100, Confirmation Message
Gui 17: Color, %ConfirmationMessageWindowColor%
WinSet, Region, 0-0 W100 H100  R100-100, Confirmation Message
WinGet, CMID,ID, Confirmation Message

;******************************************End Create Confirmation Message Gui and hide******************************************

;=================================================Create Tray Tip================================================================
iniread, DefaultPath, SpaConfig.ini, DefaultPath, Path, %A_PicturesSF%
if TreatPercentSignsAsVariables = 1
 {
  CurrentPath = %DefaultPath%
  gosub CheckForEnvironmentVariablesAndBuiltInVariables
  if CurrentPath <> %DefaultPath%
   DefaultPath = %CurrentPath%
 }
MaxChars := 100 ;shorten filename for traytip
TextToControl = %DefaultPath%
Gosub FixControlTextLength
menu, tray, tip, Default Folder  (%TextToControl%)
;===================================================================================================================================

SplitPath,a_scriptdir,,,,,DriveLetter
DriveGet,DriveType,Type,%DriveLetter%
if  DriveType <> Fixed ;( DriveType <> "CDROM" and DriveType <> "RamDisk" and DriveType <> "Unknown" )
 goto SkipGui

IniRead,CreateDesktopIcon,SpaConfig.ini,CreateDesktopIcon,CreateDesktopIcon
if CreateDesktopIcon <> ERROR     ;only will be shown once
 goto SkipGui

;=================== Start Desktop Icon and Start With Windows=============================================
Gui 4: -SysMenu
Gui 4: add, checkbox,vCreateDesktopIcon check0  ,%a_space%%a_space%Create SavePictureAs Desktop Shortcut
Gui 4: add, Checkbox, yp+25 vStartSavePictureAsWhenWindowsStarts check0 hwndHWND_StartWithWindows ,%a_space%%a_space%Start SavePictureAs when Windows Starts
if a_screendpi = 120
 TempVarButtonXpos = 160
else
 TempVarButtonXpos = 200
Gui 4: add, button, x%TempVarButtonXpos% y50  w80 h20 gNext hwndHWND_NextButton,Next
Gui 4: show, AutoSize ,SavePictureAs V%version%
Gui 4: color, c0c0c0
WinGet,SPASetupID,ID,SavePictureAs V%version%
WinSet,AlwaysOnTop,On,ahk_id %SPASetupID%
return

Next: ;create shortcut and start with windows
Gui 4: submit, nohide
Gui 4: destroy
IfExist,%A_ScriptDir%\SpaTrayIcon.ico
 iconfile :=  ( A_ScriptDir "\SpaTrayIcon.ico" )
else
 iconfile := ( A_AhkPath ) ;use autohotkey green H icon
if CreateDesktopIcon = 1
  FileCreateShortcut, %A_ScriptFullPath%, %A_Desktop%\SavePictureAs.lnk , %A_ScriptDir% , , Save Pictures from your Web Browser, %iconfile%
else
  FileDelete,%A_Desktop%\SavePictureAs.lnk
if StartSavePictureAsWhenWindowsStarts = 1
 FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\SavePictureAs.lnk , %A_ScriptDir% , , Save Pictures from your Web Browser, %iconfile%
else
 FileDelete,%A_Startup%\SavePictureAs.lnk
IniWrite,%CreateDesktopIcon%,SpaConfig.ini,CreateDesktopIcon,CreateDesktopIcon
IniWrite,%StartSavePictureAsWhenWindowsStarts%,SpaConfig.ini,StartWithWindows,StartWithWindows
;=================== End Desktop Icon and Start With Windows=============================================

;============================Begin ChangeTrayIcon==============================
SkipGui:
IniRead,Name,SpaConfig.ini,TrayIconChoice,Name
if Name = Error
 {
  gosub ChangeTrayIcon
  WinWaitClose, ahk_id %ChangeSystemTrayIconID%
 }
;============================End ChangeTrayIcon==============================
If CurrentlyInSetup <> Yes
 {
  IniRead, ShowSplashScreen, SpaConfig.ini, SplashScreenStatus, ShowSplashScreen, 1
  if ShowSplashScreen = 1
   Gosub SplashScreen 
 }

;The next 6 lines will show the Survey gui on startup only one time. After that it can be opened from the system tray icon then selecting "About"
IniRead,ShowSurveyOnlyOnce,Spaconfig.ini,ShowOnlyOnceMessages,Survey,0
if ShowSurveyOnlyOnce = 0
 gosub survey
WinWaitClose, ahk_id %SurveyID%
if ShowSurveyOnlyOnce = 0
 IniWrite,1,Spaconfig.ini,ShowOnlyOnceMessages,Survey

;==========================================================Install Screen===========================================================

;====================================================Display Setup Complete=========================================================

if ( CurrentlyInSetup = "yes" )
 {
  IfExist,%a_scriptdir%\spaimage.jpg
   {
    SplashImage,%A_ScriptDir%\SpaImage.jpg,  b fm14 zh350 zw-1 fs12 cwc0c0c0 ,Now find a picture on the web and press Ctrl-Space or your chosen hotkey and the picture will be saved to your hard drive.`n`nCheck out the system tray icon for more options.`n`nClick anywhere to continue,Setup is Complete`nSavePictureAs Version V%Version%,
    KeyWait, Lbutton, D
    SplashImage, Off
   }
  else
   {
    MsgBox,4160,Setup,Setup is Complete`n`nNow find a picture on the web and press ctrl-space or user defined keys and the picture will be saved to your hard drive.`n`nCheck out the system tray icon for more options.
   }
  CurrentlyInSetup = no
 }

IniRead,CheckForUpdatesDaily,spaconfig.ini,CheckForUpdates,CheckForUpdatesDaily,1
if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" )
  SetTimer,CheckForUpdatesDaily, %CheckForUpdatesDailyValue%  

;====================================================Tray Menu===================================================================
Menu Tray, Click, 1           ; Enable single click action on tray
Gosub AddMenu                 ; Add new default menu
Return                        ; End of initialization
Menu:
MouseGetPos MouseX, MouseY    ; Get current mouse position
CoordMode,tool,Screen
if MouseY < 120 ;prevents menu from being shown at the wrong y position when -------SavePictureAs------- is clicked on.
 Menu Tray, Show, %MouseX%, %MouseY% ; - 1  ; Show menu a little upper to enable next click on icon
AddMenu:
Menu, SaveArea, Add, Save Area, SaveArea
Menu, SaveArea, Add, Cancel, CancelSaveArea
Menu, SaveArea, color, c0c0c0
Menu, Tray, Add,-------SavePictureAs------- ,Menu ; Add temporary menu item
Menu, Tray, Default,-------SavePictureAs-------  ; Set to default
Menu, tray, add, About, about
Menu, tray, add, Help, UserHelp 
Menu, tray, add, Program Documentation, ProgramDocumentation
iniread,HotkeysStatus,SpaConfig.ini,Hotkeys,HotkeysStatus,On

if ( HotkeysStatus = "On" )
 {
  Menu, tray, add, Disable All Hotkeys,ToggleHotkeys
  if ( A_OSVersion = "Win_Xp" )
   {
    IfExist,%windir%\system32\cewmdm.dll
     Menu, tray, Icon, Disable All Hotkeys, cewmdm.dll, 1, 19
   }
  If ( A_OSVersion = "win_vista" or A_OSVersion = "win_7" or OS_Is_A_Variant_Of_Windows_8 = 1 )
   {
    IfExist,%A_ScriptDir%\Hotkeys.ico
     Menu, tray, Icon, Disable All Hotkeys, Hotkeys.ico     ,   , 18
   }
 }
else
 {
  Menu, tray, add, Enable All Hotkeys,ToggleHotkeys
  if ( A_OSVersion = "Win_Xp" )
   {
    IfExist,%windir%\system32\cewmdm.dll
     Menu, tray, Icon, Enable All Hotkeys, cewmdm.dll, 1, 19
   }
  If ( A_OSVersion = "win_vista" or A_OSVersion = "win_7" or OS_Is_A_Variant_Of_Windows_8 = 1 )
   {
     IfExist,%A_ScriptDir%\Hotkeys.ico
     Menu, tray, Icon, Enable All Hotkeys, Hotkeys.ico     ,   , 18
   }
 }

Menu, tray, Add, Favorites Tool Bar, FavoritesToolbar
Menu, tray, add, History Menu, ConfigureHistory
Menu, tray, add, Open Default Folder,OpenDefaultFolder
Menu, tray, add, Change Tray Icon,ChangeTrayIcon
;************************
;Adds Settings on tray menu then creates Submenu1 
;************************
Menu, Submenu1, add, Program Colors, systemcolors
Menu, Submenu1, Add, Confirmation Message, ConfigureConfirmationMessage
Menu, Submenu1, Add, Splash Screen, SplashScreen
Menu, Submenu1, Add, Reset All Settings, ResetAllDefaults
Menu, Submenu1, Add, Reset All Colors, ResetAllColors
Menu, Submenu1, Add, Check For Updates,CheckForUpdatesGui
Menu, Submenu1, Add, Capture Area Settings,ConfigureCaptureScreen
Menu, Submenu1, Add, Configure Hotkeys && Folders,ConfigureHotkeys
Menu, Submenu1, Add, Additional Settings, AdditionalSettingsMenu
Menu, tray, Add,Settings, :Submenu1
Menu, tray, add, Restart SavePictureAs, ReloadSavePictureAs
Menu, Tray, Add, Exit SavePictureAs, Quit
Menu, Tray, color, c0c0c0
menu, tray, tip, Default Folder  (%TextToControl%)
;I organized adding menu icons this way because even though most icons are the same across each OS, this can not be relied on. Also, this way makes it much easier to change the icons.
if ( A_OSVersion = "Win_Xp" )
 {
  IfExist, %windir%\system32\mmcndmgr.dll
   {
    Menu, tray, Icon, About, mmcndmgr.dll                           , 64, 16
    Menu, Submenu1, Icon, Additional Settings, mmcndmgr.dll         , 76, 16
    Menu, Submenu1, Icon, Reset All Colors, mmcndmgr.dll            , 32, 16
    Menu, Submenu1, Icon, Reset All Settings, mmcndmgr.dll          , 32, 16
   }
  IfExist, %windir%\system32\shell32.dll  
   {
    Menu, Submenu1, Icon, Check For Updates, shell32.dll            ,208, 16
    Menu, Submenu1, Icon, Configure Hotkeys && Folders, shell32.dll , 91, 16
    Menu, tray, Icon, Favorites Tool Bar, shell32.dll               , 44, 16
    Menu, tray, Icon, Settings, Shell32.dll                         ,170, 16
    Menu, Submenu1, Icon, Splash Screen, shell32.dll                ,143, 16
    Menu, tray, Icon, Help, shell32.dll                             ,176, 16
    Menu, tray, Icon, Open Default Folder, Shell32.dll              , 46, 16
    Menu, Submenu1, Icon, Program Colors, shell32.dll               ,162, 16 
    Menu, tray, Icon, Restart SavePictureAs, mmcndmgr.dll           , 47, 16
   }
 IfExist, %windir%\system32\ieframe.dll
  {
   Menu, Submenu1, Icon, Confirmation Message, ieframe.dll          , 13, 16
   Menu, tray, Icon, History Menu, Ieframe.dll                      , 47, 16
   Menu, tray, Icon, Program Documentation, ieframe.dll             , 25, 16
   }
 IfExist, %windir%\system32\user32.dll 
  {
   Menu, tray, Icon, Exit SavePictureAs, user32.dll                 , 4, 16
   Menu, SaveArea, Icon, Cancel, user32.dll                         , 4, 17
  }
}

if ( A_OSVersion = "Win_Vista" )
 {
  IfExist, %windir%\system32\mmcndmgr.dll
   {
    Menu, tray, Icon, About, mmcndmgr.dll                           , 64, 16
    Menu, Submenu1, Icon, Reset All Colors, mmcndmgr.dll            , 32, 16
    Menu, Submenu1, Icon, Reset All Settings, mmcndmgr.dll          , 32, 16
   }
  IfExist, %windir%\system32\shell32.dll
   {
    Menu, Submenu1, Icon, Additional Settings, shell32.dll          , 72, 16
    Menu, Submenu1, Icon, Check For Updates, shell32.dll            ,208, 16
    Menu, Submenu1, Icon, Configure Hotkeys && Folders, shell32.dll , 70, 16
    Menu, tray, Icon, Favorites Tool Bar, shell32.dll               , 44, 16
    Menu, tray, Icon, Help, shell32.dll                             ,176, 16
    Menu, tray, Icon, Open Default Folder, Shell32.dll              , 46, 16
    Menu, Submenu1, Icon, Program Colors, shell32.dll               , 81, 16
    Menu, tray, Icon, Settings, Shell32.dll                         ,170, 16
    Menu, Submenu1, Icon, Splash Screen, shell32.dll                ,143, 16
    Menu, tray, Icon, Restart SavePictureAs, mmcndmgr.dll            ,47, 16
   }
  IfExist, %windir%\system32\ieframe.dll
   {
    Menu, Submenu1, Icon, Confirmation Message, ieframe.dll         , 13, 16
    Menu, tray, Icon, History Menu, Ieframe.dll                     , 47, 16
    Menu, tray, Icon, Program Documentation, ieframe.dll            ,  3, 16
   }
  IfExist, %windir%\system32\user32.dll
   {
    Menu, SaveArea, Icon, Cancel, user32.dll                        ,  4, 17
    Menu, tray, Icon, Exit SavePictureAs, user32.dll                ,  4, 16
   }
 }
 
if ( A_OSVersion = "Win_7" )
 {
  IfExist, %windir%\system32\mmcndmgr.dll
   {
    Menu, tray, Icon, About, mmcndmgr.dll                           , 64, 16
    Menu, Submenu1, Icon, Reset All Colors, mmcndmgr.dll            , 32, 16
    Menu, Submenu1, Icon, Reset All Settings, mmcndmgr.dll          , 32, 16
   }
  IfExist, %windir%\system32\shell32.dll
   {
    Menu, Submenu1, Icon, Additional Settings, shell32.dll          , 72, 16
    Menu, Submenu1, Icon, Check For Updates, shell32.dll            ,217, 16
    Menu, Submenu1, Icon, Configure Hotkeys && Folders, shell32.dll , 70, 16
    Menu, tray, Icon, Favorites Tool Bar, shell32.dll               , 44, 16
    Menu, tray, Icon, Help, shell32.dll                             ,176, 16
    Menu, tray, Icon, Open Default Folder, Shell32.dll              , 46, 16
    Menu, Submenu1, Icon, Program Colors, shell32.dll               , 81, 16
    Menu, tray, Icon, Settings, Shell32.dll                         ,170, 16
    Menu, Submenu1, Icon, Splash Screen, shell32.dll                ,143, 16
    Menu, tray, Icon, Restart SavePictureAs, Shell32.dll            ,239, 16    
   }
  IfExist, %windir%\system32\ieframe.dll
   {
    Menu, Submenu1, Icon, Confirmation Message, ieframe.dll         , 13, 16
    Menu, tray, Icon, History Menu, Ieframe.dll                     , 47, 16
    Menu, tray, Icon, Program Documentation, ieframe.dll            , 3, 16
   }
  IfExist, %windir%\system32\user32.dll
   {
    Menu, SaveArea, Icon, Cancel, user32.dll                        ,  4, 17
    Menu, tray, Icon, Exit SavePictureAs, user32.dll                ,  4, 16
   }
 }

if ( OS_Is_A_Variant_Of_Windows_8 = 1 )
 {
  IfExist, %windir%\system32\mmcndmgr.dll
   {
    Menu, tray, Icon, About, mmcndmgr.dll                           , 64, 16
    Menu, Submenu1, Icon, Reset All Colors, mmcndmgr.dll            , 32, 16
    Menu, Submenu1, Icon, Reset All Settings, mmcndmgr.dll          , 32, 16
   }
  IfExist, %windir%\system32\shell32.dll
   {
    Menu, Submenu1, Icon, Additional Settings, shell32.dll          , 72, 16
    Menu, Submenu1, Icon, Check For Updates, shell32.dll            ,217, 16
    Menu, Submenu1, Icon, Configure Hotkeys && Folders, shell32.dll , 70, 16
    Menu, tray, Icon, Favorites Tool Bar, shell32.dll               , 44, 16
    Menu, tray, Icon, Help, shell32.dll                             ,176, 16
    Menu, tray, Icon, Open Default Folder, Shell32.dll              , 46, 16
    Menu, Submenu1, Icon, Program Colors, shell32.dll               , 81, 16
    Menu, tray, Icon, Settings, Shell32.dll                         ,170, 16
    Menu, Submenu1, Icon, Splash Screen, shell32.dll                ,143, 16
    Menu, tray, Icon, Restart SavePictureAs, Shell32.dll            ,239, 16    
   }
  IfExist, %windir%\system32\ieframe.dll
   {
    Menu, Submenu1, Icon, Confirmation Message, ieframe.dll         , 13, 16
    Menu, tray, Icon, History Menu, Ieframe.dll                     , 46, 16
    Menu, tray, Icon, Program Documentation, ieframe.dll            ,  3, 16
   }
  IfExist, %windir%\system32\user32.dll
   {
    Menu, SaveArea, Icon, Cancel, user32.dll                        ,  4, 17
    Menu, tray, Icon, Exit SavePictureAs, user32.dll                ,  4, 16
   }
 }

IfExist, %a_ScriptDir%\OriginalSpaTrayIcon.ico
 Menu, tray, Icon, Change Tray Icon, OriginalSpaTrayIcon.ico        ,   , 16
IfExist,%a_ScriptDir%\Transparent_Square.ico
 {
  Menu, SaveArea, Icon, Save Area, Transparent_Square.ico           ,   , 17
  Menu, Submenu1, Icon, Capture Area Settings,Transparent_Square.ico,   , 17
 }
emptymem()
if ( CurrentlyStartingUp = "Loading...Please Wait" )
 {
  if ( HotkeysStatus = "Off" )
   TrayTip,Hotkeys are disabled,Click the system tray icon then Enable All Hotkeys to enable,3
  SetTimer,CloseTraytip,-1000
 }
CurrentlyStartingUp = 
Iniread,SetupStatus,SpaConfig.ini,SetupStatus,Status
if ( SetupStatus <> "Complete" )
 IniWrite,Complete,SpaConfig.ini,SetupStatus,Status
return
ToggleHotkeys:
iniread,HotkeysStatus,SpaConfig.ini,Hotkeys,HotkeysStatus,On
if ( HotkeysStatus = "on" )
 {
  gosub, TurnHotkeysOff
  menu, tray, rename, Disable All Hotkeys, Enable All Hotkeys
  IniWrite,Off,SpaConfig.ini,Hotkeys,HotkeysStatus
  Traytip,Hotkey Status,Disabled,2 
  SetTimer,CloseTraytip,-100
 }
else
 {
  gosub, TurnHotkeysOn
  menu, tray, rename, Enable All Hotkeys, Disable All Hotkeys
  IniWrite,On,SpaConfig.ini,Hotkeys,HotkeysStatus
  Traytip,Hotkey Status,Enabled,2
  SetTimer,CloseTraytip,-100
 }
return
CloseTraytip:
sleep 2000
TrayTip
return
CheckForUpdatesDaily:
Connected := Ping()
if Connected <> 0 
 {
  ActivatingCheckForUpdatesDaily = 1
  StillSleeping = 1
  gosub checkforupdates
 }
return
;====================================================End of Tray Menu===============================================================
;*********************************************END OF AUTOEXECUTE SECTION*********************************************************
;********************************************************************************************************************************
HotkeyLabel1:
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,1
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder1,0
if FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder ;this gosub label looks for a valid folder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
goto SavePictureAs
HotkeyLabel2:
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,2
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder2,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
goto SavePictureAs
HotkeyLabel3:
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,3
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder3,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
goto SavePictureAs
HotkeyLabel4:
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,4
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder4,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
goto SavePictureAs
HotkeyLabel5:
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,5
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder5,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
goto SavePictureAs
HotkeyLabel6:
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,6
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder6,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
goto SavePictureAs
HotkeyLabel7:
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,7
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder7,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
goto SavePictureAs
HotkeyLabel8:
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,8
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder8,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
goto SavePictureAs
HotkeyLabel9:
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,9
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder9,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
goto SavePictureAs
HotkeyLabel10:
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,10
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder10,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
goto SavePictureAs
HotkeyLabel11: ;default path
SetTimer,CheckForUpdatesDaily,off
IniRead,CurrentPath,SpaConfig.ini,DefaultPath,Path
gosub CheckForValidPath
if NotValidPath = 1
 return
goto SavePictureAs

HotkeyLabel13:   ;special folder (portable)
SetTimer,CheckForUpdatesDaily,off
FoundMatchingSpecialFolder = 0
IniRead,TempVar,spaconfig.ini,FavoritePaths,SpecialFolder
if ( TempVar <> "ERROR" and TempVar <> "" )
 {
  StringTrimLeft,TempVar,TempVar,3
  DriveGet,Drives,List
  Loop Parse, Drives
   {
    DriveGet,DriveType,Type,%a_loopfield%:
    if ( DriveType <> "CDROM" and DriveType <> "RamDisk" and DriveType <> "Unknown" )
     {
      if FileExist(A_LoopField ":\" TempVar ) 
       {         
        CurrentPath = %A_LoopField%:\%TempVar%
        StringLen,Len,CurrentPath
        if Len = 3
         IfInString,CurrentPath,\
          StringTrimRight,CurrentPath,CurrentPath,1
         FoundMatchingSpecialFolder = 1
        break      
       }
     }
   }
 }
if FoundMatchingSpecialFolder = 0
 {
  MsgBox,4160,Error [1001A],Not able to find a matching "Special Folder" in any of your drives.
  Error1001Found = 1
  return
 }
else
 Error1001Found = 0
goto SavePictureAs

HotkeyLabel14: ;capture active window
RecordHistory = 1
SetTimer,CheckForUpdatesDaily,off
IfNotExist,%a_scriptdir%\TempFolder
 FileCreateDir, %a_scriptdir%\TempFolder
IfNotExist,%a_scriptdir%\TempFolder\DoNotUseThisFolder.txt
 FileAppend,Do not use this folder for files or folders. Everything will be deleted by SavePictureAs when it uses this folder while saving pictures.,%a_scriptdir%\TempFolder\DoNotUseThisFolder.txt
loop, %a_scriptdir%\TempFolder\*.*
 {
  if A_LoopFilename <> DoNotUseThisFolder.txt
   FileDelete, %a_scriptdir%\TempFolder\%A_LoopFileName%
 }
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,CaptureActiveWindow
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolderCaptureActiveWindow,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
CaptureActiveWindowAction = 1
goto SaveArea

HotkeyLabel15: ;capture entire screen
RecordHistory = 1
SetTimer,CheckForUpdatesDaily,off
IfNotExist,%a_scriptdir%\TempFolder
 FileCreateDir, %a_scriptdir%\TempFolder
IfNotExist,%a_scriptdir%\TempFolder\DoNotUseThisFolder.txt
 FileAppend,Do not use this folder for files or folders. Everything will be deleted by SavePictureAs when it uses this folder while saving pictures.,%a_scriptdir%\TempFolder\DoNotUseThisFolder.txt
loop, %a_scriptdir%\TempFolder\*.*
 {
  if A_LoopFilename <> DoNotUseThisFolder.txt
   FileDelete, %a_scriptdir%\TempFolder\%A_LoopFileName%
 }
IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,CaptureEntireScreen
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolderCaptureEntireScreen,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }
CaptureEntireScreenAction = 1
goto SaveArea

HotkeyLabel16:  ;capture area of screen
RecordHistory = 1
SetTimer,CheckForUpdatesDaily,off
IfNotExist,%a_scriptdir%\TempFolder
 FileCreateDir, %a_scriptdir%\TempFolder
IfNotExist,%a_scriptdir%\TempFolder\DoNotUseThisFolder.txt
 FileAppend,Do not use this folder for files or folders. Everything will be deleted by SavePictureAs when it uses this folder while saving pictures.,%a_scriptdir%\TempFolder\DoNotUseThisFolder.txt
loop, %a_scriptdir%\TempFolder\*.*
 {
  if A_LoopFilename <> DoNotUseThisFolder.txt
   FileDelete, %a_scriptdir%\TempFolder\%A_LoopFileName%
 }
IfWinExist, ahk_id %GuiPreview%
 {
  MsgBox,4112,Info, You must close the "Capture Area" settings window before attempting to capture an area of the screen.
  GoSub, UpdateCheckForUpdatesDailyTimer
  return
 }

IniRead,CurrentPath,SpaConfig.ini,FavoritePaths,CaptureAreaOfScreen
IniRead, FavoriteFolderSpecialFolder,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolderCaptureAreaOfScreen,0
if  FavoriteFolderSpecialFolder = 1
 gosub FavoriteFolderSpecialFolder
else
 {
  gosub CheckForValidPath
  if NotValidPath = 1
   return
 }

CaptureAreaOfScreenAction = 1
SaveAreaGui:
if Error1001Found = 1
 {
  Error1001Found = 0
  return
 }
IfWinExist,ahk_id %GuiOutline%
 return

IniRead, UserSelectAreaStyleChoice,SpaConfig.ini,UserSelectAreaStyleChoice,UserSelectAreaStyleChoice,1
If UserSelectAreaStyleChoice = 0
 SelectAreaStyleNumber = 52
else
 SelectAreaStyleNumber = 53

IniRead,Shade,SpaConfig.ini,UserSelectAreaStyleChoice,Shade, C0C0C0
IniRead,UseShade,SpaConfig.ini,UserSelectAreaStyleChoice,UseShade,0

Gui %SelectAreaStyleNumber%: default

If SelectAreaStyleNumber = 52
 {
  Gui %SelectAreaStyleNumber%:  +ToolWindow +Resize -caption +AlwaysOnTop
  Gui 52: Add, Text, Border vBorder hwndHWND_guitext ;only add text control if the Thin Border style is chosen
 }
else
 Gui %SelectAreaStyleNumber%:  +ToolWindow +Resize +AlwaysOnTop
 
if UseShade = 0
 shade = EEAA99 ;some color codes prevent the transparent window from being draggable. Some are shade 808080, 000000, 800080

Gui %SelectAreaStyleNumber%: Color, %shade% 

Gui %SelectAreaStyleNumber%: +LastFound

if UseShade = 0
 WinSet, TransColor, %shade% 
else
 WinSet, Transparent, 150

Gui %SelectAreaStyleNumber%: Show, W400 H400,GuiOutLine
WinGet, GuiOutline,id,GuiOutLine
If SelectAreaStyleNumber = 53
 Gui %SelectAreaStyleNumber%: -caption
return
CancelSaveArea:
Gui 52: destroy
Gui 53: destroy
GoSub, UpdateCheckForUpdatesDailyTimer
return
SaveArea:
if Error1001Found = 1
 {
  Error1001Found = 0
  return
 }
Random,TempVar,1000,%MaxRandomNumber%
If CaptureEntireScreenAction = 1
 CaptureScreen(,,A_ScriptDir "\tempfolder\CaptureEntireScreen-" TempVar ".jpg")

If CaptureAreaOfScreenAction = 1
 {
  WinGetPos,x,y,w,h,ahk_id %GuiOutLine%
  Gui 52: destroy
  Gui 53: destroy
  sleep 500
  if SelectAreaStyleNumber = 52
   CaptureScreen( x "," y "," x + W "," y + H ,, A_ScriptDir "\tempfolder\CaptureAreaOfScreen-" TempVar ".jpg") ;thin border
  else
   {
    SysGet,BorderWidth,32
    SysGet,BorderHeight,33
    CaptureScreen( x + BorderWidth "," y + BorderHeight "," x + W - BorderWidth "," y + H - BorderHeight ,%CaptureMouseCursor%, A_ScriptDir "\tempfolder\CaptureAreaOfScreen-" TempVar ".jpg") ;thick border, need to adjust to remove the border width on all sides
   }
 }

If CaptureActiveWindowAction = 1
 {
  pToken := Gdip_Startup() 
  pBitmap := Gdip_BitmapFromHwnd(WinExist("A"))
  Gdip_SaveBitmapToFile(pBitmap,A_ScriptDir "\tempfolder\CaptureActiveWindow-" TempVar ".jpg",100)
  Gdip_DisposeImage(pBitmap)
  Gdip_Shutdown(pToken)
 }
CaptureEntireScreenAction := 0, CaptureAreaOfScreenAction := 0, CaptureActiveWindowAction := 0, Class = "" 
goto FilenamingAndCheckForDuplicates

FavoriteFolderSpecialFolder:  ;used for favorites 1-10 and 13,14,15 if they have been turned into special folders. The currentpath is retrieve in the label HotkeyLabel1 thur 10.
IniRead,TreatPercentSignsAsVariables,SpaConfig.ini,FavoritePaths,TreatPercentSignsAsVariables,0
If TreatPercentSignsAsVariables = 1
 goSub CheckForEnvironmentVariablesAndBuiltInVariables
FoundMatchingSpecialFolder = 0
if ( CurrentPath <> "ERROR" and CurrentPath <> "" ) ;currentpath is being used for all folders
 {
  StringTrimLeft,CurrentPath,CurrentPath,3
  DriveGet,Drives,List
  Loop Parse, Drives
   {
    DriveGet,DriveType,Type,%a_loopfield%:
    if ( DriveType <> "CDROM" and DriveType <> "RamDisk" and DriveType <> "Unknown" )
     {
      if FileExist(A_LoopField ":\" CurrentPath ) 
       {         
        CurrentPath = %A_LoopField%:\%CurrentPath%
        StringLen,Len,CurrentPath
        if Len = 3
         IfInString,CurrentPath,\
          StringTrimRight,CurrentPath,CurrentPath,1
         FoundMatchingSpecialFolder = 1
        break      
       }
     }
   }
 }
if FoundMatchingSpecialFolder = 0
 {
  MsgBox,4160,Error [1001B],Not able to find a matching "Special Folder" in any of your drives.
  Error1001Found = 1
  return
 }
else
 Error1001Found = 0
return
CheckForValidPath:
IniRead,TreatPercentSignsAsVariables,SpaConfig.ini,FavoritePaths,TreatPercentSignsAsVariables,0
If TreatPercentSignsAsVariables = 1
 goSub CheckForEnvironmentVariablesAndBuiltInVariables
NotValidPath = 0
FileGetAttrib, Attributes, %CurrentPath%
IfNotInString, Attributes, D
 {
 MsgBox,4116,SavePictureAs V%Version%,This Hotkey is not assigned to a valid folder.`n`nWould you like to select a valid folder now?
  IfMsgBox, Yes
   {
    gosub ConfigureHotkeys
    WinWaitClose,ahk_id %CHID%
    MsgBox,4160, SavePictureAs V%Version%,You can now try to save your picture again.
    NotValidPath = 1
    return
   }
  else
   {
   MsgBox,4112,SavePictureAs V%Version%,Your picture can not be saved without a valid folder selected.
    NotValidPath = 1
    return
   }
 }
return
;---------User-defined Dynamic Hotkeys created by jaco0646 forum post here http://www.autohotkey.com/board/topic/47439-user-defined-dynamic-hotkeys--------;
ConfigureHotkeys:
IfWinExist,ahk_id %CHID%    
 { 
  WinRestore, ahk_id %CHID%
  WinActivate, ahk_id %CHID%
  return
 }
 
IniRead,TreatPercentSignsAsVariables,spaconfig.ini,FavoritePaths,TreatPercentSignsAsVariables,0
IniRead,ConfigureHotkeysColorGuiVar,SpaConfig.ini,SystemColors,ConfigureHotkeysColorGuiVar, c0c0c0
IniRead, ConfigureHotkeysColorGuiTextVar, SpaConfig.ini, SystemColors, ConfigureHotkeysColorGuiTextVar, 000000
Gui 25: default 
Gui 25: font, s12 c%ConfigureHotkeysColorGuiTextVar%
Gui 25: Add, Text, x25 y15, You can configure up to 16 hotkeys && 15 folders.`nOnly the "Default Hotkey" && Default Folder" are required.`nFor more information click on "Help" below.
Gui 25: font, s11 underline c%ConfigureHotkeysColorGuiTextVar%
Gui 25: add, Text, x25 y100, Hotkeys
Gui 25: font, 
Gui 25: font, s9 c%ConfigureHotkeysColorGuiTextVar%
#ctrls = 16                                                             ;I do not need the Hotkey Gui to enable the hotkeys. That is done later.
;Favorite Folder hotkeys 1-10
loop 10
 {  
  if a_index < 10
   {
    Gui 25: Add, Text, x25 yp+26, Favorite Folder                  
    gui 25: add, text, x175 yp-0, #%A_Index%:
   }
  else
   {
    Gui 25: Add, Text, x25 yp+26, Favorite Folder                
    Gui 25: add, text, x169 yp-0, #%A_Index%:
   }
  Hotkey, IfWinActive, ahk_group BrowserWindows ;these hotkeys will only be active when one of the browsers is active
  IniRead, savedHK%A_Index%, SpaConfig.ini, Hotkeys, HotkeyLabel%A_Index%, %A_Space%
  if ( savedHK%A_Index% <> "" and savedHK%a_index% <> "Error" ) 
   {
    Hotkey, % savedHK%A_Index% , HotkeyLabel%A_index%, Off, UseErrorLevel 
    if ErrorLevel in 2,3,4
     {
      ;add msg box about invalid hotkey from autoexecute section, look for ;xxxx, do this for all hotkeys
      IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel%a_index% ;if it is an invalid hotkey write a space in the ini file
      savedHK%a_index% =
     }
    }
  StringReplace, noMods, savedHK%A_Index%, ~         ;Remove tilde (~) and Win (#) modifiers...
  StringReplace, noMods, noMods, #,,UseErrorLevel ;They are incompatible with hotkey controls (cannot be shown).
  Gui 25: Add, Hotkey, x+5 yp-3 vHK%A_Index% gGuiHotkeyLabel, %noMods%            ;Add hotkey controls and show saved hotkeys.
  Gui 25: Add, CheckBox, x+5 yp+5 vCB%A_Index% Checked%ErrorLevel% gGuiHotkeyLabel, Win Key  ;Checkboxes for the Windows key (#) as a modifier...
}

;11 Default Folder
IniRead, savedHK11, SpaConfig.ini, Hotkeys, HotkeyLabel11, %A_Space% 
Gui 25: Add, Text, x25 yp+26, Default Folder                 
Gui 25: add, text, x169 yp-0, #11:
if ( savedHK11 <> "" and savedHK11 <> "Error" )
 {
  Hotkey, %savedHK11%, HotkeyLabel11, Off, UseErrorLevel
  if ErrorLevel in 2,3,4
   {
    ;add msg box about invalid hotkey from autoexecute section, look for ;xxxx, do this for all hotkeys
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel11 ;if it is an invalid hotkey write a space in the ini file
    savedHK11 =
   }
 }
StringReplace, noMods, savedHK11, ~         ;Remove tilde (~) and Win (#) modifiers...
StringReplace, noMods, noMods, #,,UseErrorLevel ;They are incompatible with hotkey controls (cannot be shown).
Gui 25: Add, Hotkey, x+5 yp-3 vHK11 gGuiHotkeyLabel, %noMods%            ;Add hotkey controls and show saved hotkeys.
Gui 25: Add, CheckBox, x+5 yp+5 vCB11 Checked%ErrorLevel% gGuiHotkeyLabel, Win Key  ;Checkboxes for the Windows key (#) as a modifier...
  
;Hotkey 12 and 13 were reversed when I rearranged the gui. Need to keep Special Folder at Hotkey Label13 for backward compatibility
;13 Special Folder
IniRead, savedHK13, SpaConfig.ini, Hotkeys, HotkeyLabel13, %A_Space% 
Gui 25: Add, Text, x25 yp+26, Special Folder                 
Gui 25: add, text, x169 yp-0, #12:
if ( savedHK13 <> "" and savedHK13 <> "Error" )
 {
  Hotkey, %savedHK13%, HotkeyLabel13, Off, UseErrorLevel 
  if ErrorLevel in 2,3,4
   {
    ;add msg box about invalid hotkey from autoexecute section, look for ;xxxx, do this for all hotkeys
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel13 ;if it is an invalid hotkey write a space in the ini file
    savedHK13 =
   }
 }
StringReplace, noMods, savedHK13, ~         ;Remove tilde (~) and Win (#) modifiers...
StringReplace, noMods, noMods, #,,UseErrorLevel ;They are incompatible with hotkey controls (cannot be shown).
Gui 25: Add, Hotkey, x+5 yp-3 vHK13 gGuiHotkeyLabel, %noMods%            ;Add hotkey controls and show saved hotkeys.
Gui 25: Add, CheckBox, x+5 yp+5 vCB13 Checked%ErrorLevel% gGuiHotkeyLabel, Win Key  ;Checkboxes for the Windows key (#) as a modifier...

Hotkey, IfWinActive ;turn off for Capture Active Window, Capture Entire Screen, Capture Area of Screen and Rename Last Saved Picture
;14 Capture Active Window ;off by one because SpecialFolder needs to stay at HotkeyLabel13 for backward compatibility
IniRead, savedHK14, SpaConfig.ini, Hotkeys, HotkeyLabel14, %A_Space% 
Gui 25: Add, Text, x25 yp+26, Capture Active Window  
Gui 25: add, text, x169 yp-0, #13:
if ( savedHK14 <> "" and savedHK14 <> "Error" ) 
 {
  Hotkey, %savedHK14%, HotkeyLabel14, Off, UseErrorLevel ;if hotkey read from ini is blank or error then turn it off, this can happen if the ini was altered manually after the hotkey was turned on 
  if ErrorLevel in 2,3,4
   {
    ;add msg box about invalid hotkey from autoexecute section, look for ;xxxx, do this for all hotkeys
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel14 ;if it is an invalid hotkey write a space in the ini file
    savedHK14 =
   }
 }
StringReplace, noMods, savedHK14, ~         ;Remove tilde (~) and Win (#) modifiers...
StringReplace, noMods, noMods, #,,UseErrorLevel ;They are incompatible with hotkey controls (cannot be shown).
Gui 25: Add, Hotkey, x+5 yp-3 vHK14 gGuiHotkeyLabel, %noMods%            ;Add hotkey controls and show saved hotkeys.
Gui 25: Add, CheckBox, x+5 yp+5 vCB14 Checked%ErrorLevel% gGuiHotkeyLabel, Win Key  ;Checkboxes for the Windows key (#) as a modifier...

;15 Capture Entire Screen - off by one because SpecialFolder needs to stay at HotkeyLabel13 for backward compatibility
IniRead, savedHK15, SpaConfig.ini, Hotkeys, HotkeyLabel15, %A_Space% 
Gui 25: Add, Text, x25 yp+26, Capture Entire Screen    
Gui 25: add, text, x169 yp-0, #14:
if ( savedHK15 <> "" and savedHK15 <> "Error" )
 {
  Hotkey, %savedHK15%, HotkeyLabel15, Off, UseErrorLevel ;if hotkey read from ini is blank or error then turn it off, this can happen if the ini was altered manually after the hotkey was turned on 
  if ErrorLevel in 2,3,4
   {
    ;add msg box about invalid hotkey from autoexecute section, look for ;xxxx, do this for all hotkeys
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel15 ;if it is an invalid hotkey write a space in the ini file
    savedHK15 =
   }
 }
StringReplace, noMods, savedHK15, ~         ;Remove tilde (~) and Win (#) modifiers...
StringReplace, noMods, noMods, #,,UseErrorLevel ;They are incompatible with hotkey controls (cannot be shown).
Gui 25: Add, Hotkey, x+5 yp-3 vHK15 gGuiHotkeyLabel, %noMods%            ;Add hotkey controls and show saved hotkeys.
Gui 25: Add, CheckBox, x+5 yp+5 vCB15 Checked%ErrorLevel% gGuiHotkeyLabel, Win Key  ;Checkboxes for the Windows key (#) as a modifier...

;16 Capture Area of Screen
IniRead, savedHK16, SpaConfig.ini, Hotkeys, HotkeyLabel16, %A_Space% 
Gui 25: Add, Text, x25 yp+26, Capture Area of Screen  
Gui 25: add, text, x169 yp-0, #15:
if ( savedHK16 <> "" and savedHK16 <> "Error" )
 {
  Hotkey, %savedHK16%, HotkeyLabel16, Off, UseErrorLevel ;if hotkey read from ini is blank or error then turn it off, this can happen if the ini was altered manually after the hotkey was turned on 
  if ErrorLevel in 2,3,4
   {
    ;add msg box about invalid hotkey from autoexecute section, look for ;xxxx, do this for all hotkeys
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel16 ;if it is an invalid hotkey write a space in the ini file
    savedHK16 =
   }
 }
StringReplace, noMods, savedHK16, ~         ;Remove tilde (~) and Win (#) modifiers...
StringReplace, noMods, noMods, #,,UseErrorLevel ;They are incompatible with hotkey controls (cannot be shown).
Gui 25: Add, Hotkey, x+5 yp-3 vHK16 gGuiHotkeyLabel, %noMods%            ;Add hotkey controls and show saved hotkeys.
Gui 25: Add, CheckBox, x+5 yp+5 vCB16 Checked%ErrorLevel% gGuiHotkeyLabel, Win Key  ;Checkboxes for the Windows key (#) as a modifier...

;12 Rename last saved picture has always been HK12, needed to keep it there for backward compatibility, but have to add it last because on the gui it has always been last and I don't want to take the chance of messing something up by moving it after HK11
IniRead, savedHK12, SpaConfig.ini, Hotkeys, HotkeyLabel12, %A_Space% 
Gui 25: Add, Text, x25 yp+35, Rename Last Saved Picture
Gui 25: add, text, x169 yp-0, #16:
if ( savedHK12 <> "" and savedHK12 <> "Error" )
 Hotkey, %savedHK12%, HotkeyLabel12, Off, UseErrorLevel ;if hotkey read from ini is blank or error then turn it off, this can happen if the ini was altered manually after the hotkey was turned on 
  if ErrorLevel in 2,3,4
   {
    ;add msg box about invalid hotkey from autoexecute section, look for ;xxxx, do this for all hotkeys
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel12 ;if it is an invalid hotkey write a space in the ini file
    savedHK12 =
   }
StringReplace, noMods, savedHK12, ~         ;Remove tilde (~) and Win (#) modifiers...
StringReplace, noMods, noMods, #,,UseErrorLevel ;They are incompatible with hotkey controls (cannot be shown).
Gui 25: Add, Hotkey, x+5 yp-3 vHK12 gGuiHotkeyLabel, %noMods%            ;Add hotkey controls and show saved hotkeys.
Gui 25: Add, CheckBox, x+5 yp+5 vCB12 Checked%ErrorLevel% gGuiHotkeyLabel, Win Key  ;Checkboxes for the Windows key (#) as a modifier...


Gui 25: font, s9 c000000 ;%ConfigureHotkeysColorGuiTextVar%
Loop,% #ctrls
 {
  If A_index < 11
   IniRead,TempVar,SpaConfig.ini,FavoritePaths,%a_index%,%a_space%
  If a_index = 11
   {
    IniRead,TempVar,SpaConfig.ini,DefaultPath,path,%a_space%
    if TempVar =
     TempVar := A_PicturesSF
   }
  if A_index = 12
   IniRead,TempVar,Spaconfig.ini,FavoritePaths,SpecialFolder,%a_space%
  
  if A_index = 13  
   IniRead, TempVar,Spaconfig.ini,FavoritePaths,CaptureActiveWindow,%a_space%
  if A_index = 14
   IniRead, TempVar,Spaconfig.ini,FavoritePaths,CaptureEntireScreen,%a_space%
  if A_index = 15
   IniRead, TempVar,Spaconfig.ini,FavoritePaths,CaptureAreaOfScreen,%a_space%
  
  ;add edit box and browse button
  if A_index = 1
   {
    Gui 25: add, edit, x450 y123 w320 -wrap r1,%TempVar% ;need to have a starting y position
    Gui 25: add, button, x780 yp-0 w70 h22 gbrowse,Browse
   }
  if ( A_index > 1 and A_index < 16 )    ; number 16 is Rename Last Saved Picture 
   {
    Gui 25: add, edit, x450 yp+28 w320 -wrap r1,%TempVar%
    Gui 25: add, button, x780 yp-0 w70 h22 gbrowse,Browse
   }
 }

;add special folder checkbox
YPOS = 128
Xpos = 920
loop 15
 {
  if a_index < 11
   {
    IniRead,FavoriteFolderSpecialFolder,SpaConfig.ini,FavoritePaths,FavoriteFolderSpecialFolder%a_index%,0
    Gui 25: add, Checkbox, x%xpos% y%ypos% vFavoriteFolderSpecialFolder%a_index% checked%FavoriteFolderSpecialFolder%,
   }
  if A_index = 11
   Gui 25: add, Checkbox, x%xpos% w60 vSpecialFolderCheckboxForDefaultFolder disabled  y%ypos% ,
  if a_index = 12
   Gui 25: add, Checkbox, x%xpos% w60 disabled checked y%ypos% ,
  
  if A_index = 13
   {
    IniRead,FavoriteFolderSpecialFolder,SpaConfig.ini,FavoritePaths,FavoriteFolderSpecialFolderCaptureActiveWindow,0
    Gui 25: add, Checkbox, x%xpos% w60  y%ypos% vFavoriteFolderSpecialFolderCaptureActiveWindow checked%FavoriteFolderSpecialFolder%,
   }
  if A_index = 14
   {
    IniRead,FavoriteFolderSpecialFolder,SpaConfig.ini,FavoritePaths,FavoriteFolderSpecialFolderCaptureEntireScreen,0
    Gui 25: add, Checkbox, x%xpos% w60  y%ypos% vFavoriteFolderSpecialFolderCaptureEntireScreen checked%FavoriteFolderSpecialFolder%,
   }
  if A_index = 15
   {
    IniRead,FavoriteFolderSpecialFolder,SpaConfig.ini,FavoritePaths,FavoriteFolderSpecialFolderCaptureAreaOfScreen,0
    Gui 25: add, Checkbox, x%xpos% w60  y%ypos% vFavoriteFolderSpecialFolderCaptureAreaOfScreen checked%FavoriteFolderSpecialFolder%,
   }
   YPOS := (YPOS+28)
 }

Gui 25: add, button, x785 yp+85 w70  gConfigureHotkeysHelp,Help
if ( CurrentlyInSetup = "yes" )
 Gui 25: Add, button, x875 yp-0 w70 gDone,Next
else
 Gui 25: Add, button, x875 yp-0 w70 gDone,Done


Gui 25: font, s10 c%ConfigureHotkeysColorGuiTextVar%
Gui 25: add, text, x25 yp-20 vAssociatedVariableSpecialFoldersClickHere, For more information on "Special Folders" click
Gui 25: add, text, x25 yp+20 vAssociatedVariableEnvironmentVariablesClickHere, For more information on "Environment Variables" click
Gui 25: add, text, x25 yp+20 vAssociatedVariableCaptureAreaClickHere, To Configure "Capture Area of Screen" Settings click

Gui 25: Show, w1000,SavePictureAs V%version% (Configure Favorite Folders & Hotkeys) 
Gui 25: color, %ConfigureHotkeysColorGuiVar%
WinGet,CHID,ID,SavePictureAs V%version% (Configure Favorite Folders & Hotkeys)

;add Special Folders click HERE text
GuiControlGet,SpecialFoldersClickHere,Pos, AssociatedVariableSpecialFoldersClickHere
tempvarXpos := ( SpecialFoldersClickHereW + 35)
Gui 25: add, Link, x%tempvarXpos% y%SpecialFoldersClickHereY%  gSpecialFolderInfo hwndHwndSpecialFolderInfo, <a id="1">HERE</a>

;add Environment Variables click HERE text
GuiControlGet,EnvironmentVariablesClickHere,Pos, AssociatedVariableEnvironmentVariablesClickHere
tempvarXpos := ( EnvironmentVariablesClickHereW + 35)
Gui 25: add, Link, x%tempvarXpos% y%EnvironmentVariablesClickHereY%  gEnvironmentVariablesInfo, <a id="1">HERE</a>

;add Capture Area click HERE text
GuiControlGet,CaptureAreaClickHere,Pos, AssociatedVariableCaptureAreaClickHere
tempvarXpos := ( CaptureAreaClickHereW + 35)
Gui 25: add, Link, x%tempvarXpos% y%CaptureAreaClickHereY%  gConfigureCaptureScreen, <a id="1">HERE</a>

;add Folder - Special Folders text
GuiControlGet,Edit1,Pos,Edit1
Gui 25: font, s11 underline c%ConfigureHotkeysColorGuiTextVar%
Gui 25: add, Text, x%Edit1X% y100, Folders

GuiControlGet,Button32,Pos,Button32
x := ( Button32X - 40 )
Gui 25: font, s11 underline c%ConfigureHotkeysColorGuiTextVar%
Gui 25: add, Text, x%x% yp-0 hwndHWND_SpecialFolderText, Special Folder

;ControlGetPos,x,,w,,,ahk_id %HWND_SpecialFolderText%
;TempVarNewGuiWidth := ( x + w + 45)
;WinGetPos,x,y,w,h,ahk_id %CHID% 
;DllCall("MoveWindow", UInt, CHID, UInt, x, UInt, y, UInt, TempVarNewGuiWidth, UInt, TempVarNewGuiHeight, Int, 1)

winset,alwaysontop,on,ahk_id %CHID%
winshow, ahk_id %Chid%
return

ConfigureCaptureScreen:
if TestingColors = 1
 return
IfWinExist,ahk_id %CaptureAreaOfScreenID%
 {
  WinRestore, ahk_id %CaptureAreaOfScreenID%
  WinActivate, ahk_id %CaptureAreaOfScreenID%
  return
 }
 
 IniRead, CaptureAreaOfScreenColorGuiVar, SpaConfig.ini, SystemColors, CaptureAreaOfScreenColorGuiVar, c0c0c0
 IniRead, CaptureAreaOfScreenColorGuiTextVar, SpaConfig.ini, SystemColors, CaptureAreaOfScreenColorGuiTextVar, 000000
 ;these x position, y position, width and height were put into variables to account for dpi settings other then 96. With ahk version 1.1.11.02 accounting for different dpi settings is built in. In time I will remove these variables and put the values directly in the code in place of the variables.
HeightAllRadioButtons = 30
GuiWidthCaptureAreaOfScreen = 225

;---------------Groupboxes begin
XposGroupBox = 15 ;includes both groupboxes
YposGroupBox1 = 10
YposGroupBox2 = 100
WidthAllGroupboxes = 195 ;includes both groupboxes
HeightGroupBox2 = 230 
;---------------Groupboxes end

;---------------thin and thick border radio begin
XposThinAndThickBorderWindowRadio = 22
WidthThinAndThickBorderWindowRadio = 150
;---------------thin and thick border radio 

;---------------Transparent and Shaded radio buttons begin
XposUseTransparentAndShadedWindowRadio = 22
YposUseTransparentWindowRadio = 115
WidthUseTransparentWindowRadio = 180  

YposUseShadedWindowRadio = 145
WidthUseShadedWindowRadio = 150
HeightUseShadedWindowRadio = 175
;---------------Transparent and Shaded radio buttons end
  
;---------------Color Radio Buttons begin
WidthAllColorRadios = 70
;Left Color Radios begin
YposRedRadio = 175 
YposCyanRadio = 205
YposBlueRadio = 235
YposSilverRadio = 265
YposGrayRadio = 295
;Right Color Radios begin
YposPurpleRadio = 175
YposYellowRadio = 205
YposLimeRadio = 235
YposGreenRadio = 265
YposOrangeRadio = 295
;-----------------Color Radio Buttons end  

;-----------------Apply, Cancel and MoreInfo Buttons begin
XposExitButton = 15 
YposExitButton = 345 
WidthExitButton = 95
   
XposCancelButton = 115 
YposCancelButton = 345 
WidthCancelButton = 95 

HeightAllButtons = 30

XposMoreInfoButton = 15
YposMoreInfoButton := 385
WidthMoreInfoButton :=  (GuiWidthCaptureAreaOfScreen - (2 * XposExitButton ))
;-----------------Apply, Cancel and MoreInfo Buttons end

Gui 60: font, s10 c%CaptureAreaOfScreenColorGuiTextVar%
HeightGroupBox1 = 75
YposThinBorderWindowRadio = 20
YposThickBorderWindowRadio = 50
XposLeftColorRadios = 37 
XposRightColorRadios = 115 

Iniread,WhatGuiStyle,Spaconfig.ini,UserSelectAreaStyleChoice,UserSelectAreaStyleChoice, 1 ;Thick window border
if WhatGuiStyle = 0
 {
  ThinWindowBorderChecked = 1
  ThickWindowBorderChecked = 0
  SelectAreaStyleNumber = 52
 }
 else
  {
   ThinWindowBorderChecked = 0
   ThickWindowBorderChecked = 1
   SelectAreaStyleNumber = 53
  }

 IniRead, UseShadedWindowChecked, Spaconfig.ini,UserSelectAreaStyleChoice, UseShade, 0
 if UseShadedWindowChecked = 0
  UseTransparentWindowChecked = 1
 else
  UseTransparentWindowChecked = 0
  
loop 10
 WhatColorChecked%a_index% = ;Make all blank because 1 will have a value each time the gui is ran
 
IniRead, WhatColorShouldBeChecked,SpaConfig.ini,UserSelectAreaStyleChoice, Shade 
if WhatColorShouldBeChecked = FF0000 ;Red
 WhatColorChecked1 = Checked
if WhatColorShouldBeChecked = 00FFFF ;Cyan
 WhatColorChecked2 = Checked
if WhatColorShouldBeChecked = 0000FF ;Blue
 WhatColorChecked3 = Checked 
if WhatColorShouldBeChecked = C0C0C0 ;Silver
 WhatColorChecked4 = Checked
if WhatColorShouldBeChecked = 808080 ;Gray
 WhatColorChecked5 = Checked
if WhatColorShouldBeChecked = 800080 ;Purple
 WhatColorChecked6 = Checked
if WhatColorShouldBeChecked = FFFF00 ;Yellow
 WhatColorChecked7 = Checked
if WhatColorShouldBeChecked = 00FF00 ;Lime
 WhatColorChecked8 = Checked
if WhatColorShouldBeChecked = 008000 ;Green
 WhatColorChecked9 = Checked
if WhatColorShouldBeChecked = FFA500 ;Orange
 WhatColorChecked10 = Checked

winset,alwaysontop,off,ahk_id %CHID%

Gui 60: Add, Radio,    x%XposThinAndThickBorderWindowRadio% y%YposThinBorderWindowRadio% w%WidthThinAndThickBorderWindowRadio% h%HeightAllRadioButtons% vThinBorderWindow gUseThinBorderWindow checked%ThinWindowBorderChecked%  , Thin Border Window
Gui 60: Add, Radio,    x%XposThinAndThickBorderWindowRadio% y%YposThickBorderWindowRadio% w%WidthThinAndThickBorderWindowRadio% h%HeightAllRadioButtons% gUseThickBorderWindow checked%ThickWindowBorderChecked% , Thick Border Window
Gui 60: add, groupbox, x%XposGroupBox% y%YposGroupBox1% w%WidthAllGroupBoxes% h%HeightGroupBox1%

Gui 60: Add, Radio, x%XposUseTransparentAndShadedWindowRadio% y%YposUseTransparentWindowRadio% w%WidthUseTransparentWindowRadio% h%HeightAllRadioButtons% gUsingTransparentWindowDisableColorRadios vUseTransparentWindow checked%UseTransparentWindowChecked% , Use Transparent Window
Gui 60: Add, Radio, x%XposUseTransparentAndShadedWindowRadio% y%YposUseShadedWindowRadio% w%WidthUseShadedWindowRadio% h%HeightAllRadioButtons% gUsingShadedWindowEnableColorRadios vUseShadedWindow Checked%UseShadedWindowChecked%, Use Shaded Window

Gui 60: add, groupbox, x%XposGroupBox% y%YposGroupBox2% w%WidthAllGroupBoxes% h%HeightGroupBox2%

Gui 60: Add, Radio, x%XposLeftColorRadios% y%YposRedRadio% w%WidthAllColorRadios% h%HeightAllRadioButtons% vWhatColor %WhatColorChecked1% gRed , Red       
Gui 60: Add, Radio, x%XposLeftColorRadios% y%YposCyanRadio% w%WidthAllColorRadios% h%HeightAllRadioButtons% %WhatColorChecked2% gCyan , Cyan     
Gui 60: Add, Radio, x%XposLeftColorRadios% y%YposBlueRadio% w%WidthAllColorRadios% h%HeightAllRadioButtons% %WhatColorChecked3% gBlue, Blue     
Gui 60: Add, Radio, x%XposLeftColorRadios% y%YposSilverRadio% w%WidthAllColorRadios% h%HeightAllRadioButtons% %WhatColorChecked4% gSilver, Silver 
Gui 60: Add, Radio, x%XposLeftColorRadios% y%YposGrayRadio% w%WidthAllColorRadios% h%HeightAllRadioButtons% %WhatColorChecked5% gGray , Gray     

Gui 60: Add, Radio, x%XposRightColorRadios% y%YposPurpleRadio% w%WidthAllColorRadios% h%HeightAllRadioButtons% %WhatColorChecked6% gPurple, Purple  
Gui 60: Add, Radio, x%XposRightColorRadios% y%YposYellowRadio% w%WidthAllColorRadios% h%HeightAllRadioButtons% %WhatColorChecked7% gYellow, Yellow  
Gui 60: Add, Radio, x%XposRightColorRadios% y%YposLimeRadio% w%WidthAllColorRadios% h%HeightAllRadioButtons% %WhatColorChecked8% gLime, Lime      
Gui 60: Add, Radio, x%XposRightColorRadios% y%YposGreenRadio% w%WidthAllColorRadios% h%HeightAllRadioButtons% %WhatColorChecked9% gGreen, Green    
Gui 60: Add, Radio, x%XposRightColorRadios% y%YposOrangeRadio% w%WidthAllColorRadios% h%HeightAllRadioButtons% %WhatColorChecked10% gOrange , Orange  

Gui 60: Add, Button, x%XposExitButton% y%YposExitButton% w%WidthExitButton% h%HeightAllButtons% gApplyAndExitCaptureAreaOfScreenGui default, Apply && Close      
Gui 60: Add, Button, x%XposCancelButton% y%YposCancelButton% w%WidthCancelButton% h%HeightAllButtons% default g60GuiClose, Cancel 
Gui 60: Add, Button, x%XposMoreInfoButton% y%YposMoreInfoButton% w%WidthMoreInfoButton% h%HeightAllButtons% gCaptureAreaOfScreenMoreInfo, More Info

XPosCaptureAreaOfScreen := ((A_ScreenWidth/2) -((394 + GuiWidthCaptureAreaOfScreen)/2))
Gui 60: Show, hide h430 x%XPosCaptureAreaOfScreen% w%GuiWidthCaptureAreaOfScreen%, Capture Area
if UseTransparentWindowChecked = 1
 gosub UsingTransparentWindowDisableColorRadios
WinGet,CaptureAreaOfScreenID,ID,Capture Area
WinShow,ahk_id %CaptureAreaOfScreenID%
winset,alwaysontop,on,ahk_id %CaptureAreaOfScreenID%
Gui 60: color, %CaptureAreaOfScreenColorGuiVar%

IniRead, UserSelectAreaStyleChoice,SpaConfig.ini,UserSelectAreaStyleChoice,UserSelectAreaStyleChoice,1
If UserSelectAreaStyleChoice = 0
 SelectAreaStyleNumber = 52
else
 SelectAreaStyleNumber = 53

IniRead,Shade,SpaConfig.ini,UserSelectAreaStyleChoice,Shade, C0C0C0
IniRead,UseShade,SpaConfig.ini,UserSelectAreaStyleChoice,UseShade,0
gosub SaveAreaPreviewGui
WinActivate, ahk_id %CaptureAreaOfScreenID% ;fix some display issues
return
CaptureAreaOfScreenMoreInfo:
IfWinExist,ahk_id %MoreInfoCaptureAreaOfScreenID%
 {
  WinRestore,ahk_id %MoreInfoCaptureAreaOfScreenID%
  WinActivate,ahk_id %MoreInfoCaptureAreaOfScreenID%
  return
 }
winset,alwaysontop,off,ahk_id %CaptureAreaOfScreenID%
Gui 61: font, s10
Gui 61: add, text, x15 w470 ,To capture an area of any screen using your Capture Area of Screen hotkey...`n`nPress your chosen hotkey for Capture Area of Screen.`n`nClick and drag the window to the area you would like to capture.`n`nClick and drag the window edges to position the window over exactly the area you would like to save.`n`nRight click any where on the screen and choose "Save Area".`n`nYour picture will be saved in the folder you preselected for this hotkey with a filename in the format of  "CaptureAreaOfScreen-3934098.jpg". The number will be a random number..`n`n As with all other hotkeys the Filenaming, Duplicate, History, Confirmation and Rename Last Saved Picture settings will be applied each time you save a picture using the Capture Area of Screen hotkey.`n`nPlease Note:`nNo hotkeys are active while the "Configure Favorite Folders && Hotkeys" window exists.
Gui 61: show, w500, (More Info) Capture Area of Screen
WinGet,MoreInfoCaptureAreaOfScreenID,ID, (More Info) Capture Area of Screen
Gui 61: color, c0c0c0
return
61GuiClose:
Gui 61: destroy
winset,alwaysontop,on,ahk_id %CaptureAreaOfScreenID%
return

UseThinBorderWindow:
SelectAreaStyleNumber = 52
ControlGet, OutputVar, Checked ,, Button4, ahk_id %CaptureAreaOfScreenID%  ;Is it transparent ;groupbox counts as a Button
if OutputVar = 1 ;It is a  transparent thin gui, no need to determine shade
{
 UseShade = 0
 goto SaveAreaPreviewGui
}
else ;It is a shaded thin gui. 
 {
  gosub SaveAreaPreviewGui
  Number = 7
  Loop 10
   {
    ControlGet, OutputVar, Checked ,, Button%Number%, ahk_id %CaptureAreaOfScreenID%
    if OutputVar = 1
     {
      if Number = 7
       Gosub Red
      if Number = 8
       Gosub Cyan
      if Number = 9
       Gosub Blue
      if Number = 10
       Gosub Silver
      if Number = 11
       Gosub Gray
      if Number = 12
       Gosub Purple
      if Number = 13
       Gosub Yellow
      if Number = 14
       Gosub Lime
      if Number = 15
       Gosub Green
      if Number = 16
       Gosub Orange
      break
     }
    number++
   }
 }
return
UseThickBorderWindow:
SelectAreaStyleNumber = 53
ControlGet, OutputVar, Checked ,, Button4, ahk_id %CaptureAreaOfScreenID%  ;Is it transparent ;groupbox counts as a Button
if OutputVar = 1 ;It is a  transparent thin gui, no need to determine shade
{
 UseShade = 0
 goto SaveAreaPreviewGui
}
else ;It is a shaded thin gui. 
 {
  gosub SaveAreaPreviewGui
  Number = 7
  Loop 10
   {
    ControlGet, OutputVar, Checked ,, Button%Number%, ahk_id %CaptureAreaOfScreenID%
    if OutputVar = 1
     {
      if Number = 7
       Gosub Red
      if Number = 8
       Gosub Cyan
      if Number = 9
       Gosub Blue
      if Number = 10
       Gosub Silver
      if Number = 11
       Gosub Gray
      if Number = 12
       Gosub Purple
      if Number = 13
       Gosub Yellow
      if Number = 14
       Gosub Lime
      if Number = 15
       Gosub Green
      if Number = 16
       Gosub Orange
      break
     }
    number++
   }
 }
return
SaveAreaPreviewGui:
Gui 52: destroy
Gui 53: destroy
Gui %SelectAreaStyleNumber%: default

If SelectAreaStyleNumber = 52
 {
  Gui %SelectAreaStyleNumber%:  +ToolWindow +Resize -caption +AlwaysOnTop
  Gui 52: Add, Text, Border vBorder ; hwndHWND_guitext ;only add text control if the Thin Border style is chosen
 }
else
 Gui %SelectAreaStyleNumber%:  +ToolWindow +Resize +AlwaysOnTop
 
if UseShade = 0
 shade = EEAA99 ;some color codes prevent the transparent window from being draggable. Some are shade 808080, 000000, 800080

Gui %SelectAreaStyleNumber%: Color, %shade% 

Gui %SelectAreaStyleNumber%: +LastFound

If SelectAreaStyleNumber = 53
 Gui %SelectAreaStyleNumber%: -caption

if UseShade = 0
 WinSet, TransColor, %shade% 
else
 WinSet, Transparent, 150

Gui %SelectAreaStyleNumber%: Show, Hide  W450 H450,GuiPreview

WinGet, GuiPreview,id,GuiPreview

IfWinExist,ahk_id %CaptureAreaOfScreenID%
 Docka(CaptureAreaOfScreenID, GuiPreview, "x(1.015) y(.5,-.5)") ;dock the GuiPreview selection window to Capture Area Settings Gui

WinShow, ahk_id %GuiPreview%
Return
Red:
Gui %SelectAreaStyleNumber%: Color, FF0000 
WinSet, Transparent, 150, ahk_id %GuiPreview%
return
Cyan:
Gui %SelectAreaStyleNumber%: Color, 00FFFF
WinSet, Transparent, 150, ahk_id %GuiPreview%
return
Blue:
Gui %SelectAreaStyleNumber%: Color, 0000FF
WinSet, Transparent, 150, ahk_id %GuiPreview%
return
Silver:
Gui %SelectAreaStyleNumber%: Color, C0C0C0
WinSet, Transparent, 150, ahk_id %GuiPreview%
return
Gray:
Gui %SelectAreaStyleNumber%: Color, 808080
WinSet, Transparent, 150, ahk_id %GuiPreview%
return
Purple:
Gui %SelectAreaStyleNumber%: Color, 800080
WinSet, Transparent, 150, ahk_id %GuiPreview%
return
Yellow:
Gui %SelectAreaStyleNumber%: Color, FFFF00
WinSet, Transparent, 150, ahk_id %GuiPreview%
return
Lime:
Gui %SelectAreaStyleNumber%: Color, 00FF00
WinSet, Transparent, 150, ahk_id %GuiPreview%
return
Green:
Gui %SelectAreaStyleNumber%: Color, 008000
WinSet, Transparent, 150, ahk_id %GuiPreview%
return
Orange:
Gui %SelectAreaStyleNumber%: Color, FFA500
WinSet, Transparent, 150, ahk_id %GuiPreview%
return

ApplyAndExitCaptureAreaOfScreenGui:
Gui 60: submit, nohide
if ThinBorderWindow = 1
 IniWrite,0,Spaconfig.ini,UserSelectAreaStyleChoice,UserSelectAreaStyleChoice ;Thin window
else
 IniWrite,1,Spaconfig.ini,UserSelectAreaStyleChoice,UserSelectAreaStyleChoice ;Thick window

if UseShadedWindow = 1
 IniWrite, 1, Spaconfig.ini,UserSelectAreaStyleChoice, UseShade
else
 IniWrite, 0, Spaconfig.ini,UserSelectAreaStyleChoice, UseShade
  
if WhatColor = 1 ;Red
 IniWrite, FF0000,SpaConfig.ini,UserSelectAreaStyleChoice, Shade
if WhatColor = 2 ;Cyan
 IniWrite, 00FFFF,SpaConfig.ini,UserSelectAreaStyleChoice, Shade
if WhatColor = 3 ;Blue
 IniWrite, 0000FF,SpaConfig.ini,UserSelectAreaStyleChoice, Shade
if WhatColor = 4 ;Silver
 IniWrite, C0C0C0,SpaConfig.ini,UserSelectAreaStyleChoice, Shade
if WhatColor = 5 ;Gray
 IniWrite, 808080,SpaConfig.ini,UserSelectAreaStyleChoice, Shade
if WhatColor = 6 ;Purple
 IniWrite, 800080,SpaConfig.ini,UserSelectAreaStyleChoice, Shade
if WhatColor = 7 ;Yellow
 IniWrite, FFFF00,SpaConfig.ini,UserSelectAreaStyleChoice, Shade
if WhatColor = 8 ;Lime
 IniWrite, 00FF00,SpaConfig.ini,UserSelectAreaStyleChoice, Shade
if WhatColor = 9 ;Green
 IniWrite, 008000,SpaConfig.ini,UserSelectAreaStyleChoice, Shade
if WhatColor = 10 ;Orange
 IniWrite, FFA500,SpaConfig.ini,UserSelectAreaStyleChoice, Shade
gui 52: destroy
gui 53: destroy
gui 60: destroy
winset,alwaysontop,on,ahk_id %CHID%
return

UsingTransparentWindowDisableColorRadios:
Number = 7
loop 10
 {
  Guicontrol, 60:disable,Button%Number%
  Number++
 }
Gui %SelectAreaStyleNumber%: Color, EEAA99
WinSet, TransColor, EEAA99, ahk_id %GuiPreview%
return
UsingShadedWindowEnableColorRadios:
Number = 7
loop 10
 {
  Guicontrol, 60:enable,Button%Number%
  Number++
 }
Number = 7
Loop 10
 {
  ControlGet, OutputVar, Checked ,, Button%Number%, ahk_id %CaptureAreaOfScreenID%
  if OutputVar = 1
   {
    if Number = 7
     Gosub Red
    if Number = 8
     Gosub Cyan
    if Number = 9
     Gosub Blue
    if Number = 10
     Gosub Silver
    if Number = 11
     Gosub Gray
    if Number = 12
     Gosub Purple
    if Number = 13
     Gosub Yellow
    if Number = 14
     Gosub Lime
    if Number = 15
     Gosub Green
    if Number = 16
     Gosub Orange
     break
    }
   number++
 }

return
60GuiClose:
winset,alwaysontop,on,ahk_id %CHID%
gui 52: destroy
gui 53: destroy
gui 60: destroy
return

SpecialFolderInfo:
MsgBox,4160,SavePictureAs V%version% (Special Folder Information),
(
This option on the Configure Favorite Folder & Hotkeys settings page allows you to have the same hotkey for the same folder on different computers. For example, if you have SavePictureAs on a flashdrive, you could have folder c:\dropbox as your "Special Folder" on one computer and e:\dropbox on another computer.
  
The hotkey assigned to your "Special Folder" will search all drives for the "Special Folder", when found the drive letter will be changed for your "Special Folder" to match the drive the "Special Folder" was found on and then save your picture there.

Make SavePictureAs Completely Portable Steps:
Create a "Special Folder" on your flash drive and give it a unique name. 
Put SavePictureAs anywhere on the same flash drive. 
Start SavePictureAs from your flash drive. 
On the "Configure Hotkeys and Folders" menu choose a "Special Folder" hotkey and assign the flash drive "Special Folder" to this hotkey.
Each time you save a picture using your "Special Folder" hotkey your picture will be saved to your flash drive.

Note: 
If you have a Favorite Folder set as a Special Folder, SavePictureAs does not validate you have entered a valid folder path until you attempt to save a picture. Then SavePictureAs will look at all drives, including network drives attached to your system for the folder you entered. 

Note:  
The checkbox for Default Folder #11 on the "Configure Hotkeys and Folders" menu is greyed out because the Default Folder can not be a Special Folder. This is by design.

Note:
The checkbox for Special Folder #12 on the "Configure Hotkeys and Folders" menu is already checked and greyed out because this folder is by default a "Special Folder" and can not be changed.
)
return
EnvironmentVariablesInfo:
IfWinExist,ahk_id %EnvironmentVariablesID%
 {
  WinRestore, ahk_id %EnvironmentVariablesID%
  WinActivate, ahk_id %EnvironmentVariablesID%
  return
 }
winset,alwaysontop,off,ahk_id %CHID%
IniRead,TreatPercentSignsAsVariables,spaconfig.ini,FavoritePaths,TreatPercentSignsAsVariables,0
IniRead,EnvironmentVariablesColorGuiVar,SpaConfig.ini, SystemColors,EnvironmentVariablesColorGuiVar,c0c0c0
IniRead,EnvironmentVariablesColorGuiTextVar,SpaConfig.ini, SystemColors,EnvironmentVariablesColorGuiTextVar,000000
EnvironmentVariablesMoreInfo =
(
SavePictureAs V8.2 and later supports Environment Variables.
 
Environment variables are a set of dynamic named values that can affect the way running processes will behave on a computer.
 
Environment variables supported by SavePictureAs V8.2 and later are as follows...
UserProfile
AllUsersProfile
AppData
CommonProgramFiles
CommonProgramW6432
HomeDrive
HomePath
LocalAppData
ProgramData
ProgramW6432
Public
SystemDrive
SystemRoot
Temp
TMP
Windir
HomeShare
 
SavePictureAs V8.2 and later also supports the following Autohotkey Built-In Variables.
A_WorkingDir
A_ScriptDir
A_ScriptFullPath
A_AhkPath
A_AhkData
A_AhkDataCommon  
A_Desktop
A_DesktopCommon
A_StartMenu
A_StartMenuCommon
A_Programs
A_ProgramsCommon
A_StartUpCommon
A_StartUp
A_MyDocuments
 
To use any of these variables put percent signs before and after the name. Example `%UserProfile`%, or `%UserProfile`%\MyPictures
)
Gui 47: +Resize +0x300000 ;  WS_VSCROLL | WS_HSCROLL
Gui 47: font, s11 c%EnvironmentVariablesColorGuiTextVar%
Gui 47: add, text,x15,%EnvironmentVariablesMoreInfo%
Gui 47: add, text,x15 vAssociatedVariableClickHere,To see what folders each of these variables point to click
Gui 47: add, checkbox,x15 vTreatPercentSignsAsVariables checked%TreatPercentSignsAsVariables%,Enable support for Environment and AutoHotkey built-in Variables
Gui 47: add, text,x15 yp+35
Gui 47: show, autosize, Environment Variables
Gui 47: color, %EnvironmentVariablesColorGuiVar%
WinGet,EnvironmentVariablesID,ID,Environment Variables

Gui 47: +LastFound
GroupAdd, MyGui, % "ahk_id " . WinExist()

;add Environment Variables More Info click "HERE" text
GuiControlGet,EnvironmentVariablesHelpClickHere,47:Pos, AssociatedVariableClickHere
tempvarXpos := (EnvironmentVariablesHelpClickHereW + 25)
Gui 47: add, Link, x%tempvarXpos% y%EnvironmentVariablesHelpClickHereY% cblue gEnvironmentVariablesExamples, <a id="1">HERE</a>
return
47GuiClose:
Gui 47: submit,nohide
IniWrite,%TreatPercentSignsAsVariables%,spaconfig.ini,FavoritePaths,TreatPercentSignsAsVariables
winset,alwaysontop,on,ahk_id %CHID%
Gui 47: destroy
return
EnvironmentVariablesExamples:
clipboard = %appdata%
IfWinExist,ahk_id %EnvironmentVariablesExamplesID%
 {
  WinRestore, ahk_id %EnvironmentVariablesExamplesID%
  WinActivate, ahk_id %EnvironmentVariablesExamplesID%
  return
 }

IniRead,EnvironmentVariablesColorGuiVar,SpaConfig.ini, SystemColors,EnvironmentVariablesColorGuiVar,c0c0c0
IniRead,EnvironmentVariablesColorGuiTextVar,SpaConfig.ini, SystemColors,EnvironmentVariablesColorGuiTextVar,000000

Gui 48: default
Gui 48: +Resize +0x300000 ;  WS_VSCROLL | WS_HSCROLL
Gui 48: font, s11 c%EnvironmentVariablesColorGuiTextVar%
Gui 48: add, text,x15,                          `%UserProfile`% 
if UserProfile =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                   = %UserProfile%

Gui 48: add, text,x15 y+5,                     `%AllUsersProfile`%
if AllUsersProfile =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %AllUsersProfile%

Gui 48: add, text,x15 y+5,                     `%AppData`% 
if AppData =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %AppData%

Gui 48: add, text,x15 y+5,                     `%CommonProgramFiles`% 
if CommonProgramFiles =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %CommonProgramFiles%

Gui 48: add, text,x15 y+5,                     `%CommonProgramW6432`% 
if CommonProgramW6432 =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %CommonProgramW6432%

Gui 48: add, text,x15 y+5,                     `%HomeDrive`% 
if HomeDrive =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %HomeDrive%

Gui 48: add, text,x15 y+5,                     `%HomePath`% 
if HomePath =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %HomePath%

Gui 48: add, text,x15 y+5,                     `%LocalAppData`% 
if LocalAppData =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %LocalAppData%

Gui 48: add, text,x15 y+5,                     `%ProgramData`% 
if ProgramData =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %ProgramData%

Gui 48: add, text,x15 y+5,                     `%ProgramW6432`% 
if ProgramW6432 =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %ProgramW6432%

Gui 48: add, text,x15 y+5,                     `%Public`% 
if Public =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %Public%

Gui 48: add, text,x15 y+5,                     `%SystemDrive`% 
if SystemDrive =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %SystemDrive%

Gui 48: add, text,x15 y+5,                     `%SystemRoot`% 
if SystemRoot =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %SystemRoot%

Gui 48: add, text,x15 y+5,                     `%Temp`% 
if Temp =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %Temp%

Gui 48: add, text,x15 y+5,                     `%TMP`% 
if TMP =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %TMP%

Gui 48: add, text,x15 y+5,                     `%Windir`% 
if Windir =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %Windir%

Gui 48: add, text,x15 y+5,                     `%HomeShare`% 
if HomeShare =
 Gui 48: add, text,x200 yp-0,                   = <Not Available>
else
 Gui 48: add, text,x200 yp-0,                  = %HomeShare%

Gui 48: add, text,x15 y+5,                     `%A_WorkingDir`% 
Gui 48: add, text,x200 yp-0,                  = %A_WorkingDir%

Gui 48: add, text,x15 y+5,                     `%A_ScriptDir`% 
Gui 48: add, text,x200 yp-0,                  = %A_ScriptDir%

Gui 48: add, text,x15 y+5,                     `%A_ScriptFullPath`% 
Gui 48: add, text,x200 yp-0,                  = %A_ScriptFullPath%

Gui 48: add, text,x15 y+5,                     `%A_AhkPath`% 
Gui 48: add, text,x200 yp-0,                  = %A_AhkPath%

Gui 48: add, text,x15 y+5,                     `%A_AppData`% 
Gui 48: add, text,x200 yp-0,                  = %A_AppData%

Gui 48: add, text,x15 y+5,                     `%A_AppDataCommon`% 
Gui 48: add, text,x200 yp-0,                  = %A_AppDataCommon%

Gui 48: add, text,x15 y+5,                     `%A_Desktop`% 
Gui 48: add, text,x200 yp-0,                  = %A_Desktop%

Gui 48: add, text,x15 y+5,                     `%A_DesktopCommon`% 
Gui 48: add, text,x200 yp-0,                  = %A_DesktopCommon%

Gui 48: add, text,x15 y+5,                     `%A_StartMenu`% 
Gui 48: add, text,x200 yp-0,                  = %A_StartMenu%

Gui 48: add, text,x15 y+5,                     `%A_StartMenuCommon`% 
Gui 48: add, text,x200 yp-0,                  = %A_StartMenuCommon%

Gui 48: add, text,x15 y+5,                     `%A_Programs`% 
Gui 48: add, text,x200 yp-0,                  = %A_Programs%

Gui 48: add, text,x15 y+5,                     `%A_ProgramsCommon`% 
Gui 48: add, text,x200 yp-0,                  = %A_ProgramsCommon%

Gui 48: add, text,x15 y+5,                     `%A_Startup`% 
Gui 48: add, text,x200 yp-0,                  = %A_Startup%

Gui 48: add, text,x15 y+5,                     `%A_StartupCommon`% 
Gui 48: add, text,x200 yp-0,                  = %A_StartupCommon%

Gui 48: add, text,x15 y+5,                     `%A_MyDocuments`% 
Gui 48: add, text,x200 yp-0,                  = %A_MyDocuments%

Gui 48: add, text,x15 y+15,                  

Gui 48: show, autosize,Environment Variables Examples
Gui 48: color, %EnvironmentVariablesColorGuiVar%
WinGet,EnvironmentVariablesExamplesID,id, Environment Variables Examples

Gui 48: +LastFound
GroupAdd, MyGui, % "ahk_id " . WinExist()
return

48GuiClose:
Gui 48: destroy
return
browse:
MouseGetPos,x,y,w,Control ;Control clicked on is the browse button. The editbox is 13 less then the browse button
stringtrimleft,control,control,6
control := ( control-16 )
winset,alwaysontop,off,ahk_id %CHID%
GetValidFolder:
FileSelectFolder, OutputVar, *%A_PicturesSF%, 3, Please select a valid folder
if errorlevel <> 1
 {
  FileGetAttrib, Attributes, %OutPutVar%
  OutPutVar := RegExReplace(OutPutVar, "\\$")  ; Removes the trailing backslash, if present.
  IfNotInString, Attributes, D
   {
   MsgBox,4112,SavePictureAs V%Version%,You have not chosen a valid folder. %OutputVar%`n`nPlease choose another folder
    Goto GetValidFolder
   }
  GuiControl,25:,edit%control%,%Outputvar%
 }

winset,alwaysontop,on,ahk_id %CHID%
if Control < 11
 IniWrite, %OutPutVar%, SpaConfig.ini, FavoritePaths, %control%
if Control = 11
 {
  IniWrite, %OutPutVar%, SpaConfig.ini, DefaultPath, path
  menu, tray, tip, Default Folder Location (%OutPutVar%)
 }
if control = 12 ;there is no browse button for "Rename Last Saved Picture" hotkey
  IniWrite, %OutPutVar%, SpaConfig.ini, FavoritePaths, SpecialFolder
if control = 13 
 IniWrite, %OutPutVar%, SpaConfig.ini, FavoritePaths, CaptureActiveWindow
if control = 14
 IniWrite, %OutPutVar%, SpaConfig.ini, FavoritePaths, CaptureEntireScreen
if control = 15
 IniWrite, %OutPutVar%, SpaConfig.ini, FavoritePaths, CaptureAreaOfScreen
return
ConfigureHotkeysHelp:
IfWinExist,ahk_id %CHhelpID%
 {
  WinRestore, ahk_id %CHhelpID%
  WinActivate, ahk_id %CHhelpID%
  return
 }
IniRead,ConfigureHotkeysHelpGuiColor,SpaConfig.ini,SystemColors,ConfigureHotkeysHelpGuiColor,c0c0c0
winset,alwaysontop,off,ahk_id %CHID%
GetTextWidth = 0

Tempvar1 =
(
*Favorite Hotkeys*
Pressing one of the your favorite hotkeys will save the picture to the associated folder.

For example...
 
Ctrl  0  would save your picture to C:\Documents and Settings\Users\John\MyPictures

Ctrl  1  would save your picture to C:\Documents and Settings\Users\John\Desktop

Ctrl  2  would save your picture to C:\Documents and Settings\Users\John\MyDocuments

Ctrl  3  would save your picture to C:\images\Animals

Ctrl  4  would save your picture to C:\images\Mountains

Ctrl  5  would save your picture to C:\images\People

Ctrl  6  would save your picture to C:\images\SkyScrapers

Ctrl  7  would save your picture to C:\images\FamousPeople

Ctrl  8  would save your picture to C:\images\WaterFalls

Ctrl  9  would save your picture to C:\images\Cars
)

Tempvar2 =
(
*Default Hotkey* ( by default Control Space )
Pressing the "Default Hotkey" will save the picture to your "Default Folder". 

You can change the "Default Folder" using the Toolbar. The Toolbars 10 buttons correspond to your 10 favorite folders.

For example.
 
The picture is of a mountain. 

You would click button 5 on the Favorites Toolbar, the default folder will change to C:\Images\Mountains

Then you press the default hotkey ("Ctrl Space" by default), the picture will be saved to C:\Images\Mountains. 

Each time you save a picture using the "Default Hotkey" it will be saved in C:\Images\Mountains until you change the 
default folder via the Favorites Toolbar or Configure Hotkeys && Folders.

This method is helpful if you can't remember all (up to 10) of your chosen hotkeys.

When you place your mouse over a button on the Favorites Toolbar a "tooltip" will appear above the button showing the 
folder assigned to that button.
)

Method3Page1 =
(
*Special Folders* 
This is variation of "Favorite Hotkeys" and differs in the following way.

This option allows you to have the same hotkey for the same folder on different computers. 

For example...
 
If you have SavePictureAs on a flashdrive, you could have folder c:\dropbox as your "Special Folder" on 
one computer and e:\dropbox on another computer.
  
The hotkey assigned to your "Special Folder" will search all drives for the "Special Folder", when found the drive 
letter will be changed for your "Special Folder" to match the drive the "Special Folder" was found on and then save 
your picture there.

Make SavePictureAs Completely Portable Steps:
Create a "Special Folder" on your flash drive and give it a unique name. 

Put SavePictureAs anywhere on the same flash drive. 

Start SavePictureAs from your flash drive. 

On the "Configure Hotkeys and Folders" menu choose a "Special Folder" hotkey and assign the flash drive 
"Special Folder" to this hotkey.

Each time you save a picture using your "Special Folder" hotkey your picture will be saved to your flash drive,
even if the drive letter of your flash drive has changed.
)
Tempvar4 =
(
With SavePictureAs V%version% you can capture the entire screen, capture the active window or capture an area of the screen using
hotkeys chosen by you.

1. Capture Entire Screen: Your screenshot will be placed in your pre-selected folder with a filename in the format of
   CaptureEntireScreen-3934098.jpg. The number will be a random number.

2. Capture Active Window: Your screenshot will be placed in your pre-selected folder with a filename in the format of
   CaptureActiveWindow-3934098.jpg. The number will be a random number.

3. Capture Area of Screen: The selection window can be a thin or thick bordered, transparent or shaded window.
   You can configure the settings for this window from the system tray icon, "Settings" then "Capture Area Settings" or from
   the system tray icon, "Settings" then "Configure Hotkeys && Folders" then click on "Here" at the bottom of this settings page.

To capture an area of any screen using your Capture Area of Screen hotkey...

(1) Press your chosen hotkey for Capture Area of Screen.
(2) Click and drag the window to the area you would like to capture.
(3) Click and drag the window edges to position the window over exactly the area you would like to save.
(4) Right click any where on the screen and choose "Save Area".

Your picture will be saved in the folder you preselected for this hotkey with a filename in the format of
CaptureAreaOfScreen-3934098.jpg. The number will be a random number.

Please Note:
As with all other hotkeys the Filenaming, Duplicate, History, Confirmation and Rename Last Saved Picture settings will be
applied each time you save a picture using the Capture Hotkeys.

Hotkeys are not active while the "Configure Favorite Folders && Hotkeys" window exists.
)

;temp gui to adjust for guiwidth for larger dpi settings
Gui 26: font,s9 c000000,
Gui 26: add, text,x15, %tempvar4% ;using the longest text control
Gui 26: show, hide autosize,GetTextWidthTempGui
WinGet,GetTextWidthTempGuiID,ID,GetTextWidthTempGui
WinGetPos,,,TempvarWidth,,ahk_id %GetTextWidthTempGuiID%
Gui 26: destroy

Gui 26: font,s12 c000000,
Gui 26: add, text,x15 y15, SavePictureAs V%version% has 4 methods to save pictures.
Gui 26: font,s10 c000000,

if Dpi <> 120
 TempvarTabWidth := (TempvarWidth + 130)
else
 TempvarTabWidth := (TempvarWidth + 20)

;Dpi 96 and 120 looks good

Gui 26: add, tab2, x15 y45 h515 w%TempvarTabWidth% , Method 1 - Favorite Hotkeys|Method 2 - Default Hotkey|Method 3 - Special Folders|Method 4 - Capture Screen 

Gui 26: font,s10 c000000,
Gui 26: add, text,x35 y95 , %TempVar1%

Gui 26: tab, Method 2 - Default Hotkey
Gui 26: add, text,x35 y95 , %tempvar2%

Gui 26: tab, Method 3 - Special Folders
Gui 26: add, text,x35 y95 , %Method3Page1%

if Dpi <> 120
 TempvarMethod3Page := ( TempvarTabWidth - 180 )
else
 TempvarMethod3Page := ( TempvarTabWidth - 140 )

Gui 26: font, s%FontSize% cblue underline
Gui 26: add, text, x%TempvarMethod3Page% y520 gMethod3PageText hwndMethod3Text, Go To Method 3 - Page 2

Gui 26: font ;remove underline
Gui 26: font,s10 c000000,

Gui 26: tab, Method 4 - Capture Screen
Gui 26: add, text,x35 y95 , %tempvar4%

Gui 26: font, s11
Gui 26: tab
Gui 26: add, text, x15 y570, Please Note: When configuring hotkeys be sure to use a key combination that your browser is not already using.
TempvarGuiWidth := (TempvarTabWidth + 30)
Gui 26: show, w%TempVarGuiWidth% h600,SavePictureAs V%version% (Configure Hotkeys and Favorite Folders Help)

Gui 26: color, %ConfigureHotkeysHelpGuiColor% 
WinGet,CHhelpID,id, SavePictureAs V%version% (Configure Hotkeys and Favorite Folders Help)
winset,alwaysontop,on,ahk_id %CHhelpID%
return
Method3PageText:
ControlGetText,ControlText,Static5, ahk_id %CHhelpID%
if ControlText = Go To Method 3 - Page 1
 {
  GuiControl,26:,Static5, Go To Method 3 - Page 2
  Method3PageText = %Method3Page1%
 }
else
 {
  GuiControl,26:,Static5,Go To Method 3 - Page 1
  Method3PageText =
(
 Another example...
 You could create Favorite Hotkeys & Folders 1 thru 5 on your desktop and 6 thru 10 on your laptop. 
 
 Checkmark "Special Folder" on all of them. When you close the "Configure Hotkeys && Folders" configuration window any folder with the "Special Folder" checkmark, SavePictureAs will not check if it is a valid folder.
 
 This is because the folder you have selected as a "Special Folder" may not be on the computer you currently are running SavePictureAs on.
 
 SavePictureAs will always check for a valid folder when you attempt to save a picture using the one of the 
 pre-definded hotkeys.
)
}
GuiControl,26:,Static4,%Method3PageText%
return
26GuiClose:
Gui 26: destroy
winset,alwaysontop,on,ahk_id %CHID%
return
25GuiClose:
Done:   
Gui 25: Submit, NoHide
;verify default hotkey is valid
IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel11 ;these hotkeys are written to the ini as they are being created in the gui.
if ( TempVar = "" or TempVar = "Error" ) ;"Default Hotkey" can not be blank
 {
 MsgBox,4116,SavePictureAs V%Version%, The "Default Folder" Hotkey can not be blank.`n`nWould you like to select a valid "Default Folder" Hotkey now?
  IfMsgBox, Yes
   {
    winset,alwaysontop,on,ahk_id %CHID%
    return
   }
  IfMsgBox, No
   {
    MsgBox,4160,SavePictureAs V%Version%,The "Default Folder" Hotkey can not be blank.`n`nCtrl Space will be used as the Hotkey for your "Default Folder"
    IniWrite,^space,SpaConfig.ini,Hotkeys,HotkeyLabel11
   }
 }

;get 10 Favorite folders paths
loop 10
 {
  IniWrite,% FavoriteFolderSpecialFolder%a_index%,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolder%a_index%
  ControlGetText,TempVar,Edit%a_index%,ahk_id %CHID%  
  if TempVar =
   IniWrite,%A_space%,SpaConfig.ini,FavoritePaths,%a_index%
  else
   {
    if TreatPercentSignsAsVariables = 1 ;converting environment variables here for the sole purpose of check if folder exists
     {
      PreviousCurrentPath = %CurrentPath%
      PreviousTempVar = %Tempvar%
      CurrentPath = %TempVar% ;CheckForEnvironmentVariablesAndBuiltInVariables checks CurrentPath
      gosub CheckForEnvironmentVariablesAndBuiltInVariables
      if CurrentPath <> %Tempvar%
       TempVar = %CurrentPath%
     }
    
    if FavoriteFolderSpecialFolder%a_index% = 0 ;only check for valid path if it is not a Special Folder. Special Folders can be on a different computer and is valided when picture is saved.
     {
      FileGetAttrib, Attributes, %tempvar%
      IfNotInString, Attributes, D
       {
       MsgBox,4116,SavePictureAs V%Version%, Favorite Folder %a_index% is not a valid folder.`n`nWould you like to select a valid folder now?
        IfMsgBox, Yes
         {
          winset,alwaysontop,on,ahk_id %CHID%
          return
         }
        IfMsgBox, No
         {
          if TreatPercentSignsAsVariables = 1
           TempVar = %PreviousTempVar%
          IniWrite,%TempVar%,SpaConfig.ini,FavoritePaths,%a_index%
         }
       }
      else ;else if it is a valid folder
       { 
        if TreatPercentSignsAsVariables = 1
         TempVar = %PreviousTempVar% ;if it is a valid folder return TempVar back to Environment Variable..ex c:\users\robert back to %UserProfile%
        IniWrite,%TempVar%,SpaConfig.ini,FavoritePaths,%a_index%
       }
     }
    else ;else if it is a Special Folder
     {
      if TreatPercentSignsAsVariables = 1
       TempVar = %PreviousTempVar% ;return TempVar back to Environment Variable..ex c:\users\robert back to %UserProfile%
      IniWrite,%TempVar%,SpaConfig.ini,FavoritePaths,%a_index%
     }
   }
 }

;11 get Default path
ControlGetText,TempVar,Edit11,ahk_id %CHID% 
if TreatPercentSignsAsVariables = 1
 {
  PreviousCurrentPath = %CurrentPath%
  PreviousTempVar = %Tempvar%
  CurrentPath = %TempVar%
  gosub CheckForEnvironmentVariablesAndBuiltInVariables
  if CurrentPath <> %Tempvar%
   TempVar = %CurrentPath%
 }

FileGetAttrib, Attributes, %tempvar%
IfNotInString, Attributes, D
 {
 MsgBox,4116,SavePictureAs V%Version%, The "Default Folder" is not a valid folder.`n`nWould you like to select a valid folder now?
  
  IfMsgBox, Yes
   {
    winset,alwaysontop,on,ahk_id %CHID%
    return
   }
  IfMsgBox, No
   {
    MsgBox,4160,SavePictureAs V%Version%,The "Default Folder" has to be valid folder`n`n%a_picturesSF% will be used as the "Default Folder"
    GuiControl,25:,edit11,%a_picturesSF%
    IniWrite,%a_picturesSF%,SpaConfig.ini,DefaultPath,path
   }
 }
else
 {
  if TreatPercentSignsAsVariables = 1
   TempVar = %PreviousTempVar% ;return TempVar back to Environment Variable..ex c:\users\robert back to %UserProfile%
  IniWrite,%TempVar%,SpaConfig.ini,DefaultPath,path
 }

;----------------13 get CaptureActiveWindow path begin
IniWrite,%FavoriteFolderSpecialFolderCaptureActiveWindow%,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolderCaptureActiveWindow
ControlGetText,TempVar,Edit13,ahk_id %CHID%  
if TempVar =
 IniWrite,%A_space%,SpaConfig.ini,FavoritePaths,CaptureActiveWindow
else
 {
  if TreatPercentSignsAsVariables = 1 ;convert to actual path
   {
    PreviousCurrentPath = %CurrentPath%
    PreviousTempVar = %Tempvar%
    CurrentPath = %TempVar%
    gosub CheckForEnvironmentVariablesAndBuiltInVariables
    if CurrentPath <> %Tempvar%
     TempVar = %CurrentPath%
   }
  ;don't check for valid folder if it is being used as a Special Folder
  if FavoriteFolderSpecialFolderCaptureActiveWindow = 0
   {
    FileGetAttrib, Attributes, %tempvar%
    IfNotInString, Attributes, D
     {
     MsgBox,4116,SavePictureAs V%Version%, The "Capture Active Window" folder is not a valid folder.`n`nWould you like to select a valid folder now?
      IfMsgBox, Yes
       {
        winset,alwaysontop,on,ahk_id %CHID%
        return
       }
     }
   }
  ;Check if it is an Environment Variable
  if TreatPercentSignsAsVariables = 1
   TempVar = %PreviousTempVar% ;return TempVar back to Environment Variable..ex c:\users\robert back to %UserProfile%
  IniWrite,%TempVar%,SpaConfig.ini,FavoritePaths,CaptureActiveWindow
 }
;----------------13 get CaptureActiveWindow path end
;{----------------14 get CaptureEntireScreen path begin
IniWrite,%FavoriteFolderSpecialFolderCaptureEntireScreen%,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolderCaptureEntireScreen
ControlGetText,TempVar,Edit14,ahk_id %CHID%  
if TempVar =
 IniWrite,%A_space%,SpaConfig.ini,FavoritePaths,CaptureEntireScreen
else
 { 
  if TreatPercentSignsAsVariables = 1 ;convert to actual path
   {
    PreviousCurrentPath = %CurrentPath%
    PreviousTempVar = %Tempvar%
    CurrentPath = %TempVar%
    gosub CheckForEnvironmentVariablesAndBuiltInVariables
    if CurrentPath <> %Tempvar%
     TempVar = %CurrentPath%
   }
  ;don't check for valid folder if it is being used as a Special Folder

  if FavoriteFolderSpecialFolderCaptureEntireScreen = 0
   {
    FileGetAttrib, Attributes, %tempvar%
    IfNotInString, Attributes, D
     {
     MsgBox,4116,SavePictureAs V%Version%, The "Capture Entire Screen" folder is not a valid folder.`n`nWould you like to select a valid folder now?
      IfMsgBox, Yes
       {
        winset,alwaysontop,on,ahk_id %CHID%
        return
       }
     }
   }
  if TreatPercentSignsAsVariables = 1
   TempVar = %PreviousTempVar% ;return TempVar back to Environment Variable..ex c:\users\robert back to %UserProfile%
  IniWrite,%TempVar%,SpaConfig.ini,FavoritePaths,CaptureEntireScreen
 }
;}----------------14 get CaptureEntireScreen path end

;{----------------15 get CaptureAreaOfScreen path begin
ControlGetText,TempVar,Edit15,ahk_id %CHID%  
IniWrite,%FavoriteFolderSpecialFolderCaptureAreaOfScreen%,Spaconfig.ini,FavoritePaths,FavoriteFolderSpecialFolderCaptureAreaOfScreen
if TempVar =
  IniWrite,%A_space%,SpaConfig.ini,FavoritePaths,CaptureAreaOfScreen
else 
 {
  if TreatPercentSignsAsVariables = 1 ;convert to actual path
   {
    PreviousCurrentPath = %CurrentPath%
    PreviousTempVar = %Tempvar%
    CurrentPath = %TempVar%
    gosub CheckForEnvironmentVariablesAndBuiltInVariables
    if CurrentPath <> %Tempvar%
     TempVar = %CurrentPath%
   }
  ;don't check for valid folder if it is being used as a Special Folder
  if FavoriteFolderSpecialFolderCaptureAreaOfScreen = 0
   {
    FileGetAttrib, Attributes, %tempvar%
    IfNotInString, Attributes, D
     {
     MsgBox,4116,SavePictureAs V%Version%, The "Capture Area Of Screen" folder is not a valid folder.`n`nWould you like to select a valid folder now?
      IfMsgBox, Yes
       {
        winset,alwaysontop,on,ahk_id %CHID%
        return
       }
     }
   }
  if TreatPercentSignsAsVariables = 1
   TempVar = %PreviousTempVar% ;return TempVar back to Environment Variable..ex c:\users\robert back to %UserProfile%
  IniWrite,%TempVar%,SpaConfig.ini,FavoritePaths,CaptureAreaOfScreen
 }
;}----------------15 get CaptureAreaOfScreen path end

;{-----------fix tray tip----------------------
iniread, DefaultPath, SpaConfig.ini, DefaultPath, Path
if TreatPercentSignsAsVariables = 1
 {
  CurrentPath = %DefaultPath%
  gosub CheckForEnvironmentVariablesAndBuiltInVariables
  if CurrentPath <> %DefaultPath%
   DefaultPath = %CurrentPath%
 }
MaxChars := 100 ;shorten filename for traytip
TextToControl = %DefaultPath%
Gosub FixControlTextLength
menu, tray, tip, Default Folder  (%TextToControl%)
;}-----------fix tray tip----------------------

;12 Special Folder
ControlGetText,TempVar,Edit12,ahk_id %CHID%  ;don't verify Special folder is valid because it may be on a different computer
IniWrite,%TempVar%,SpaConfig.ini,FavoritePaths,SpecialFolder 
Gui 25: destroy
IniRead,HotkeysStatus,SpaConfig.ini,Hotkeys,HotkeysStatus, on
if HotkeysStatus = On
 gosub, TurnHotkeysOn

IfWinExist, ahk_id %ToolbarID% ;update toolbar
 {
  Loop 10
   {
    IniRead, ButtonFavorite%a_index%, SpaConfig.ini, FavoritePaths, %a_index%,%a_space%
    if ButtonFavorite%a_index% =
     ButtonFavorite%a_index% = Unassigned ;this is needed because WatchCursor1 timer does not read the config file for ButtonFavorite1 thru 10
   }
 }
return
GuiHotkeyLabel:
If %A_GuiControl% in +,^,!,+^,+!,^!,+^! ;If the hotkey contains only modifiers, return to wait for a key.
 return
If InStr(%A_GuiControl%,"vk07")                                  ;vk07 = MenuMaskKey (see below)
 GuiControl,25:,%A_GuiControl%, % lastHK       ;Reshow the hotkey, because MenuMaskKey clears it.
Else
 validateHK(A_GuiControl)
return
validateHK(GuiControl)
 {
  global lastHK
  Gui 25: Submit, NoHide
  lastHK := %GuiControl%                      ;Backup the hotkey, in case it needs to be reshown.
  num := SubStr(GuiControl,3)                 ;Get the index number of the hotkey control.
  If (HK%num% != "") 
   {                                                              ;If the hotkey is not blank...
    StringReplace, HK%num%, HK%num%, SC15D, AppsKey                          ;Use friendlier names,
    StringReplace, HK%num%, HK%num%, SC154, PrintScreen             ;instead of these scan codes.
    If CB%num%              ;If the 'Win Key' box is checked, then add its modifier (#).
     HK%num% := "#" HK%num%
    If !RegExMatch(HK%num%,"[#!\^\+]")  ;If the new hotkey has no modifiers, add the (~) modifier.
     HK%num% := "~" HK%num%             ;This prevents any key from being blocked.
    checkDuplicateHK(num)
   }
  If (savedHK%num% || HK%num%)                                               ;Unless both are empty,
  setHK(num, savedHK%num%, HK%num%)                                          ;update INI/GUI
 }

checkDuplicateHK(num) 
 {
  global #ctrls
  Loop,% #ctrls
  If (HK%num% = savedHK%A_Index%) 
   {
    dup := A_Index
    Loop,6 
     {
      b:=!b
	  GuiControl,25:Disable %b%, HK%dup%
      Sleep,200
     }
    GuiControl,25:,HK%num%,% HK%num% :=""           ;Delete the hotkey and clear the control.
     break
   }
 }

setHK(num,INI,GUI) 
 {
  IniWrite,% GUI ? GUI:null, SpaConfig.ini, Hotkeys, HotkeyLabel%num%
  savedHK%num%  := HK%num%
 }

#MenuMaskKey vk07  

;Requires AHK_L 38+
#If ctrl := HotkeyCtrlHasFocus()
*AppsKey::                                                     ;Add support for these special keys,
*BackSpace::                             ;which the hotkey control does not normally allow.
*Delete::
*Enter::
*Escape::
*Pause::
*PrintScreen::
*Space::
*Tab::
modifier := ""
If GetKeyState("Shift","P")
 modifier .= "+"
If GetKeyState("Ctrl","P")
 modifier .= "^"
If GetKeyState("Alt","P")
 modifier .= "!"
Gui 25: Submit, NoHide       ;If BackSpace is the first key press, Gui has never been submitted.
If (A_ThisHotkey == "*BackSpace" && %ctrl% && !modifier) ;If the control has text but no modifiers held,
 GuiControl,,%ctrl%                             ;allow BackSpace to clear that text.
Else                                                                        ;Otherwise,
 {  ;Otherwise,
  GuiControl,25:,%ctrl%, % modifier SubStr(A_ThisHotkey,2)                  ;show the hotkey.
  tb := % modifier SubStr(A_ThisHotkey,2)
 }
validateHK(ctrl)
return
#If

HotkeyCtrlHasFocus() 
 {
  GuiControlGet, ctrl, 25:Focus                                              ;ClassNN
  If InStr(ctrl,"hotkey") 
   {
    GuiControlGet, ctrl, 25:FocusV                                           ;Associated variable
    Return, ctrl
   }
 }
return

HotkeyLabel12: ;RenameLastSavedPicture
IfWinExist,ahk_id %DuplicateExistsID%
 {
  MsgBox,4160,Info, Please close the "Duplicate Exists" window and then attempt to rename your picture.
  return
 }
InvalidChar1=\
InvalidChar2=/
InvalidChar3=`:
InvalidChar4=*
InvalidChar5=?
InvalidChar6="
InvalidChar7=<
InvalidChar8=>
InvalidChar9=|
InvalidChar10=.
IniRead, LastSavedPicture, SpaConfig.ini, History, LastSavedPicture
IniRead, TurnOffRecordingOfTheLastSavedPicture,SpaConfig.ini, History,TurnOffRecordingOfTheLastSavedPicture,0
if TurnOffRecordingOfTheLastSavedPicture = 0
 {
  if LastSavedPicture = 
   {
    Msgbox,4160,File Info,No record exists for Last Saved Picture!
    Return
   }
  ifnotexist, %LastSavedPicture%                             
   {
    if LastSavedPicture = ERROR
     Msgbox,4112,File Error,Can not find Last Saved Picture!
    else
     Msgbox,4112,File Error,Can not find Last Saved Picture! (%LastSavedPicture%)
    Return
   }
  }
else
 {
  MsgBox,4160,Not Available,Recording of the Last Saved Picture is turned off.`n`nThis can be turned on by clicking on the system tray icon, Settings, then Additional Settings, under the History section.
  return  
 }
Gui, +OwnDialogs
if FoundInvalidChar <> 1
 SplitPath,LastSavedPicture,,OutDir,OutExtension,newfilename
FoundInvalidChar = 0
InputBoxTitle = Rename this picture? ;used with Settimer to keep input box on top
SetTimer, KeepInputBoxOnTop, -50
InputBox, newfilename , Rename this picture?, Last Saved Picture is (%LastSavedPicture%)`nDo not include the file type in the filename. Example .jpg or .bmp,, 520, 245,,,,,%newfilename% 
if (errorlevel = 1 or newfilename = "") 
 return
IfWinExist,ahk_id %DuplicateExistsID%
 {
  MsgBox,4160,Info,Please close the "Duplicate Exists" window and then attempt to rename your picture.
  NewFileName := ( PreserveOriginalFileName )
  return
 }
loop 10
 {
  var := % InvalidChar%A_Index%
  IfInString,NewFilename,%var%
   {
   MsgBox,4112,Invalid filename "%newfilename%", Can not use \ / : * ? . " < > | Please try again.
    FoundInvalidChar = 1
    break
   }
 }  
if FoundInvalidChar = 1
 goto HotkeyLabel12
Else
 FoundInvalidChar = 0

SplitPath,LastSavedPicture,OldName,OutDir,OutExtension
ifExist, %OutDir%\%newfilename%.%OutExtension%
 {
 MsgBox,4112,Error renaming file, Duplicate filename exist, please choose another one.
  Goto   HotkeyLabel12
 }
Filemove, %LastSavedPicture%, %OutDir%\%newfilename%.%OutExtension%
IniRead,Value,SpaConfig.ini,History,History1
if ( Value = LastSavedPicture or HistoryValue = "Enabled" ) ;need history1, for the History Gui, to match last saved picture even if history is turned off
 IniWrite,%OutDir%\%newfilename%.%OutExtension%,SpaConfig.ini,History,History1
IniWrite,%OutDir%\%newfilename%.%OutExtension%,SpaConfig.ini,History,LastSavedPicture 
IfWinExist,ahk_id %HistoryID% ;update history gui
 {
  SendMessage 394, 1, 0,, ahk_id %LB% ;LB_GETTEXTLEN
  If (ErrorLevel = 0xFFFFFFFF)
   {
    MsgBox,4112,SavePictureAs V%version%,An error occurred, please try again.
    Return
   }
   VarSetCapacity(sText, ErrorLevel * (1 + !!A_IsUnicode), 0)
   SendMessage 393, 1, &stext,, ahk_id %LB% ;retrieve line 1 only
   if sText <> %LastSavedPicture% ;apparently the History was disabled when the Last Picture was saved
    return
   else
    {
     SendMessage, (LB_DELETESTRING:=0x182),1,0,, ahk_id %LB% 
     String = %OutDir%\%newfilename%.%OutExtension%
     SendMessage, (LB_INSERTSTRING:=0x181),1,&String,, ahk_id %LB%
    }
  }
WinActivate,ahk_class %class%
Return
KeepInputBoxOnTop:
WinSet,AlwaysOnTop,On,%InputBoxTitle%
return
IniReadSequential1:
IniRead,Sequential1,SpaConfig.ini,NamingConvention,Sequential1,1
if Sequential1 is not digit
 {
  Sequential1 = 1
  IniWrite,1,SpaConfig.ini,NamingConvention,Sequential1
 }
if Sequential1 =
 {
  Sequential1 = 1
  IniWrite,1,SpaConfig.ini,NamingConvention,Sequential1
 }
return
IniReadSequential2:
IniRead,Sequential2,SpaConfig.ini,NamingConvention,Sequential2,1
if Sequential2 is not digit
 {
  Sequential2 = 1
  IniWrite,1,SpaConfig.ini,NamingConvention,Sequential2
 }
if Sequential2 =
 {
  Sequential2 = 1
  IniWrite,1,SpaConfig.ini,NamingConvention,Sequential2
 }
return
IniReadSequential3:
IniRead,Sequential3,SpaConfig.ini,NamingConvention,Sequential3,1
if Sequential3 is not digit
 {
  Sequential3 = 1
  IniWrite,1,SpaConfig.ini,NamingConvention,Sequential3
 }
if Sequential3 =
 {
  Sequential3 = 1
  IniWrite,1,SpaConfig.ini,NamingConvention,Sequential3
 }
return

IniReadCustomBeforeAndAfter:
Iniread,CustomBefore,SpaConfig.ini,NamingConvention,CustomBefore,%a_space%
StringReplace,CustomBefore,CustomBefore,\,,All ;just incase some goof ball messed with the SpaConfig.ini
StringReplace,CustomBefore,CustomBefore,/,,All
StringReplace,CustomBefore,CustomBefore,:,,All
StringReplace,CustomBefore,CustomBefore,*,,All
StringReplace,CustomBefore,CustomBefore,?,,All
StringReplace,CustomBefore,CustomBefore,",,All
StringReplace,CustomBefore,CustomBefore,<,,All
StringReplace,CustomBefore,CustomBefore,>,,All
StringReplace,CustomBefore,CustomBefore,|,,All
StringReplace,CustomBefore,CustomBefore,.,,All
Iniread,CustomAfter,SpaConfig.ini,NamingConvention,CustomAfter,%a_space%
StringReplace,CustomAfter,CustomAfter,\,,All ;just incase some goof ball messed with the SpaConfig.ini
StringReplace,CustomAfter,CustomAfter,/,,All
StringReplace,CustomAfter,CustomAfter,:,,All
StringReplace,CustomAfter,CustomAfter,*,,All
StringReplace,CustomAfter,CustomAfter,?,,All
StringReplace,CustomAfter,CustomAfter,",,All
StringReplace,CustomAfter,CustomAfter,<,,All
StringReplace,CustomAfter,CustomAfter,>,,All
StringReplace,CustomAfter,CustomAfter,|,,All
StringReplace,CustomAfter,CustomAfter,.,,All
return
IniReadFileNameFormat:
IniRead,FileNameFormat,SpaConfig.ini,NamingConvention,FileNameFormat,7
if ( FileNameFormat <> 1 and FileNameFormat <> 2 and FileNameFormat <> 3 and FileNameFormat <> 4 and FileNameFormat <> 5 and FileNameFormat <> 6 and FileNameFormat <> 7 and FileNameFormat <> 8 and FileNameFormat <> 9 and FileNameFormat <> 10 )
 {
  FileNameFormat = 7
  IniWrite,7,SpaConfig.ini,NamingConvention,FileNameFormat
 }
return 
FileNameFormat: ;Custom filename begin
GuiControl,22:,button3,1
IfWinExist,ahk_id %FNFID%
 {
  WinRestore, ahk_id %FNFID%
  WinActivate, ahk_id %FNFID%
  return
 }
FormatTime, FormattedTime, %A_Now%,dddd MMMM d, yyyy hh mm ss tt
GoSub, IniReadCustomBeforeAndAfter
Gosub, IniReadFilenameFormat
IniRead,UseAboveOptionsAndPromptForFilename,Spaconfig.ini,NamingConvention,UseAboveOptionsAndPromptForFilename,0
iniread,FileNameFormatGuiColor,SpaConfig.ini,SystemColors,FileNameFormatGuiColor, c0c0c0
iniread,FileNameFormatGuiTextColor,SpaConfig.ini,SystemColors,FileNameFormatGuiTextColor, 000000
;determining X and Y pos this way allows the gui to be centered without having to calculate position based on screen width and height and prevents the Gui from being hidden off screen with no way of dragging it back onto the screen.

SysGet,MWA,MonitorWorkArea ;Retrieve MonitorWorkArea more then once in case the MonitorWorkArea has changed        

;-------------------This won't be used until I save the gui postion when it is closed-----------------------------------------
IniRead,FNFXpos,SpaConfig.ini,NamingConvention,FNFXpos ;Get previous X position of Additional Settings gui (Gui 2)
if FNFXpos is not Integer ;prevents Xpos values that include non numbers i.e. h100 c0c0co
 FNFXpos =

if (FNFXpos < (MWAleft - 588) and FNFXpos <> "")    ;if the right edge of the gui is beyond the left edge of the screen make it 10 pixels visible to right of MWAleft
 FNFXpos := (MWAleft - 588)                    
if (FNFXpos > (MWAright - 20) and FNFXpos <> "")    ;if the left edge of the gui is beyond the right edge of the screen make it 10 pixels visible to left of MWAright
 FNFXpos := (MWAright - 20)

IniRead,FNFYpos,SpaConfig.ini,NamingConvention,FNFYpos ;Get previous Y position of Additional Settings gui (Gui 2)
if FNFYpos is not Integer                           ;prevents Ypos values that include non numbers i.e. h100 c0c0co
 FNFYpos =
if (FNFYpos > (MWAbottom - 20) and FNFYpos <> "")   ;if the top edge of the gui is beyond the bottom of the screen
 FNFYpos := (MWAbottom - 20)                        ;make it 10 pixels above the bottom of the screen

if (FNFYpos < MWAtop and FNFYpos <> ""   )          ;if the top edge of the gui is beyond the top edge of the screen
 FNFYpos = %MWAtop%                                 ; make it equal to the top edge of the screen

if FNFXpos is Integer                               ;if HelpXpos is a valid integer turn xpos into format X%Xpos% i.e. x300
 xpos := ("X"FNFXpos)                                                     
else
 xpos =                                             ;if xpos is blank the gui will be centered horizontally.

if FNFYpos is Integer                               ;if HelpYpos is a valid integer turn ypos into format Y%Ypos% i.e. x300
 ypos := ("Y"FNFYpos)
else
 ypos =                                             ;if ypos is blank the gui will be centered vertically

StringTrimLeft,RecalculatedXpos,xpos,1              ;remove the x or the y then write value to the config file
StringTrimLeft,RecalculatedYpos,ypos,1
IniWrite,%RecalculatedXpos%,SpaConfig.ini,NamingConvention,FNFXpos ;write xpos and ypos to ini file in case they
IniWrite,%RecalculatedYpos%,SpaConfig.ini,NamingConvention,FNFYpos ;were recalculated above

random,RandomNumber,1,%MaxRandomNumber%

loop 10
 {
  if FileNameFormat = %a_index%
   ValueOfCheck%a_index% = Checked
  else
   ValueOfCheck%a_index% =
  }

LowerSample := ( MaxRandomNumber / 2 )
LowerSample := Floor(LowerSample)
Gui 10: font, s10 c%FileNameFormatGuiTextColor% 
Gui 10: Add, Text, x12 y10 w590 h20 , How do you want the filename to be formatted?
Gui 10: Add, Text, x0 y30 h20 , ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Gui 10: Add, Text, x12 y50  h30 , Add this before the filename:
Gui 10: Add, Edit, x280 y50 w455 h22 gVerifyEditBox vEditBoxCustomTextBefore , %CustomBefore%
Gui 10: Add, Text, x12 y80  h30 , Add this after the filename:
Gui 10: Add, Edit, x280 y80 w455 h22 gVerifyEditBox vEditBoxCustomTextAfter , %CustomAfter%

Gui 10: Add, Radio, x12 y110  h30 vSelectedFormat  %ValueOfCheck1% hwndHWND_FileNameDateAndTimeText , Date && Time (example: %FormattedTime%.jpg)

Gui 10: Add, Radio, x12 y170  h30 %ValueOfCheck2%                                                   , Filename-Date && Time (example: FileName%a_space%-%a_space%%FormattedTime%.jpg)



Gui 10: Add, Radio, x12 y260  h30 %ValueOfCheck3%  hwndHWND_Sequential1Text                         , Sequential Numbers (example: 1.jpg, 2.jpg, 3.jpg, etc...)

Gui 10: Add, Radio, x12 y230  h30 %ValueOfCheck4%  hwndHWND_Sequential2Text                         , Filename-Sequential Number (example: Filename-1.jpg, Filename-2.jpg)
Gui 10: Add, Radio, x12 y350  h30 %ValueOfCheck5%                                                   , Random Number from 1 to %MaxRandomNumber% (example: %LowerSample%.jpg, %MaxRandomNumber%.jpg)
Gui 10: Add, Radio, x12 y320  h30 %ValueOfCheck6%                                                   , Filename-Random Number from 1 to %MaxRandomNumber% (example: Filename-%MaxRandomNumber%.jpg)

Gui 10: Add, Radio, x12 y380  h30 %ValueOfCheck7%                                                   , Original Filename (example: Filename.jpg)

Gui 10: Add, Radio, x12 y140  h30 %ValueOfCheck8%                                                   , Date && Time-Filename (example: %FormattedTime%%a_space%-%a_space%Filename.jpg)
Gui 10: Add, Radio, x12 y290 h30 %ValueOfCheck9%  hwndHWND_Sequential3Text                          , Sequential Number-Filename (example: 1-Filename.jpg, 2-Filename.jpg)


;radio buttons have to be out of order because of retrieving the checked values later
Gui 10: Add, Radio, x12 y200 h30 %ValueOfCheck10%                                                   , [UserInput1] Date && Time [UserInput2] Original Filename (When saving a picture you will be prompted for UserInput) 

Gui 10: font, s9
Gui 10: Add, Button, x315 y260 h17 w60 gResetSequential1 hwndHWND_ResetSequential1Button, Reset
Gui 10: Add, Button, x435 y200 h17 w60 gResetSequential2 hwndHWND_ResetSequential2Button, Reset
Gui 10: Add, Button, x435 y290 h17 w60 gResetSequential3 hwndHWND_ResetSequential3Button, Reset

Gui 10: Add, Button, x535 y117 h17 w140 gDateFormat hwndHWND_ConfigureDateFormatButton, Configure Date Format

Gui 10: Add, Button, x5   y450 w140 h25 , View Current
Gui 10: Add, Button, x155 y450 w140 h25 , View Changes
Gui 10: Add, Button, x305 y450 w140 h25 , Save Changes
Gui 10: Add, Button, x455 y450 w140 h25 gSaveChangesExit , Save Changes && Close
Gui 10: Add, Button, x605 y450 w140 h25 g10GuiClose default, Close

Gui 10: font, s10
Gui 10: Add, Checkbox, x12 y420 w700 vUseAboveOptionsAndPromptForFilename checked%UseAboveOptionsAndPromptForFilename% ,Use above options AND Prompt for Filename

Gui 10: Show, %Xpos% %Ypos% h490 w750, Custom Picture Name Options

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_Sequential1Text%
ControlMove,,% TempvarWpos + 35,% TempvarYpos + 5,,,ahk_id %HWND_ResetSequential1Button%

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_Sequential2Text%
ControlMove,,% TempvarWpos + 35,% TempvarYpos + 5,,,ahk_id %HWND_ResetSequential2Button%

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_Sequential3Text%
ControlMove,,% TempvarWpos + 35,% TempvarYpos + 5,,,ahk_id %HWND_ResetSequential3Button%

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_FileNameDateAndTimeText%
ControlMove,,% TempvarWpos + 35,% TempvarYpos + 5,,,ahk_id %HWND_ConfigureDateFormatButton%

WinGet,FNFID,ID, A
Gui 10: color, %FileNameFormatGuiColor% 
ControlFocus,button11,ahk_id %FNFID%
Return
DateFormat:
IfWinExist,ahk_id %DateAndTimeFormatForFilenamingConventionID%
 {
  WinRestore,ahk_id %DateAndTimeFormatForFilenamingConventionID%
  WinActivate,ahk_id %DateAndTimeFormatForFilenamingConventionID%
  return
 }
IniRead,DateAndTimeFormatScreensGuiColor,SpaConfig.ini,SystemColors,DateAndTimeFormatScreensGuiColor,c0c0c0
IniRead,DateAndTimeFormatScreensGuiTextColor,SpaConfig.ini,SystemColors,DateAndTimeFormatScreensGuiTextColor,000000
IniRead,SeparatorOptionFilenamingConvention,spaconfig.ini,DateTimeFormat,SeparatorOptionFilenamingConvention,%a_space%
IniRead,SeparatorCharFilenamingConvention,SpaConfig.ini,DatetimeFormat,SeparatorCharFilenamingConvention,-

DateTimeFormats = 7
DateTimeFormat1 = dddd MMMM d, yyyy hh mm ss tt
DateTimeFormat2 = 'Date' MM dd yy 'Time' hh mm ss tt
DateTimeFormat3 = h mm ss
DateTimeFormat4 = HH mm ss
DateTimeFormat5 = MM dd yy - HH mm ss
DateTimeFormat6 = yyyyMMddhhmmss
DateTimeFormat7a = yyyyMMdd
DateTimeFormat7b = hhmmss

FormatTime, DateTimeFormatFilenamingConvention1, , %DateTimeFormat1%
FormatTime, DateTimeFormatFilenamingConvention2, , %DateTimeFormat2%
FormatTime, DateTimeFormatFilenamingConvention3, , %DateTimeFormat3%
FormatTime, DateTimeFormatFilenamingConvention4, , %DateTimeFormat4%
FormatTime, DateTimeFormatFilenamingConvention5, , %DateTimeFormat5%
FormatTime, DateTimeFormatFilenamingConvention6, , %DateTimeFormat6%
FormatTime, DateTimeFormatFilenamingConvention7a,, %DateTimeFormat7a%
FormatTime, DateTimeFormatFilenamingConvention7b,, %DateTimeFormat7b%

Loop %DateTimeFormats%
 StringReplace,DateTimeFormatFilenamingConvention%a_index%,DateTimeFormatFilenamingConvention%a_index%,:,%a_space%

Gui 37: Default
Gui 37: font, s11 c%DateAndTimeFormatScreensGuiTextColor%
Gui 37: add, text,,Choose how you want the "Date and Time" formatted when it is added to the filename.
IniRead,OriginalSetting,spaconfig.ini,DateTimeFormat,FilenamingConvention,MM dd yy - HH mm ss
Loop %DateTimeFormats%
 {
  if OriginalSetting = % DateTimeFormat%a_index%
   {
    Checked%a_index% = 1 ;to start radio button off checked
    FilenamingConventionRadioCheckMark = %a_index% ;used to determine if anything changed with clicking the X close button and editbox
    FormatTime,DisplayTime,,% DateTimeFormat%a_index% ;for options 1,2 and 5 editbox display
    FormatTime,Tempvar,, mm ss ;for options 3 and 4 editbox display
   }
  else
   {
    if SeparatorOptionFilenamingConvention = SeparatorOptionFilenamingConvention
     {
      Checked7 = 1
      FilenamingConventionRadioCheckMark = 7
     }
    else
     Checked%a_index% = 0
   }
 }

Gui 37: font
Gui 37: font, s10 c%DateAndTimeFormatScreensGuiTextColor%

Gui 37: add, radio,x15 y45  vFormatDateAndTimeFilenamingConvention1 gRadioButtonDateTimeFilenamingConvention Checked%checked1%, %DateTimeFormatFilenamingConvention1%
Gui 37: add, radio,x15 y65  vFormatDateAndTimeFilenamingConvention2 gRadioButtonDateTimeFilenamingConvention checked%checked2%, %DateTimeFormatFilenamingConvention2%
Gui 37: add, radio,x15 y85  vFormatDateAndTimeFilenamingConvention3 gRadioButtonDateTimeFilenamingConvention checked%checked3%, 9%a_space%%Tempvar%
Gui 37: add, radio,x15 y105 vFormatDateAndTimeFilenamingConvention4 gRadioButtonDateTimeFilenamingConvention checked%checked4%, 09%a_space%%tempvar%
Gui 37: add, radio,x15 y125 vFormatDateAndTimeFilenamingConvention5 gRadioButtonDateTimeFilenamingConvention checked%checked5%, %DateTimeFormatFilenamingConvention5%
Gui 37: add, radio,x15 y145 vFormatDateAndTimeFilenamingConvention6 gRadioButtonDateTimeFilenamingConvention checked%checked6%, %DateTimeFormatFilenamingConvention6%
Gui 37: add, radio,x15 y165 vFormatDateAndTimeFilenamingConvention7 gRadioButtonDateTimeFilenamingConvention checked%checked7%, %DateTimeFormatFilenamingConvention7a%
Gui 37: add, text, x15 y195,Example:

;this adds the Example edit box
if ( FilenamingConventionRadioCheckMark = 1 or FilenamingConventionRadioCheckMark = 2 or FilenamingConventionRadioCheckMark = 5 or FilenamingConventionRadioCheckMark = 6 )
 Gui 37: add, edit, x90 y190 w500 ReadOnly center hwndHWND_ExampleEditBoxForFileNamingConventionEditBox1256, Filename - %displaytime%.jpg
if FilenamingConventionRadioCheckMark = 3
 Gui 37: add, edit, x90 y190 w500 ReadOnly center hwndHWND_ExampleEditBoxForFilenamingConventionEditBox3, Filename - 9%a_space%%tempvar%.jpg
if FilenamingConventionRadioCheckMark = 4
 Gui 37: add, edit, x90 y190 w500 ReadOnly center hwndHWND_ExampleEditBoxForFilenamingConventionEditBox4, Filename - 09%a_space%%tempvar%.jpg
if FilenamingConventionRadioCheckMark = 7
 Gui 37: add, edit, x90 y190 w500 ReadOnly center hwndHWND_ExampleEditBoxForFilenamingConventionEditBox7, Filename - %DateTimeFormatFilenamingConvention7a%%SeparatorCharFilenamingConvention%%DateTimeFormatFilenamingConvention7b%

Gui 37: add, button,x600 y190 h25 w120 gApplyDateTimeFormatFilenamingConvention hwndHWND_ApplyAndExitFilenamingConventionButton,Apply && Close
Gui 37: font
Gui 37: font, s9
Gui 37: add, edit, x0 y235 w730 vEditbox1 ReadOnly center,Email:  support@SavePictureAs.com to suggest more Date & Time options
Control_Colors("Editbox1", "Set", "0xd8d8d8", "0x000000")

Gui 37: font, s9
;this adds option 7 edit box on the same line as the radio button
Gui 37: add, edit, x95 y165 w40 h15 center vFormatDateAndTimeFilenamingConvention7Separator gRadioButtonDateTimeFilenamingConventionSeparator, %SeparatorCharFilenamingConvention%
Gui 37: font, s10

Gui 37: add, text,x140 y165 gClickRadioButtonDuplicates , %DateTimeFormatFilenamingConvention7b%
Gui 37: font, s9
Gui 37: add, link,x670 y25 gMoreInfoForFileNamingConventionDateTimeOptions, <a id="1">More Info</a>
;xxxxx

Gui 37: show, w730 h255,Date and Time Format for Custom Filenaming

if ( FilenamingConventionRadioCheckMark = 1 or FilenamingConventionRadioCheckMark = 2 or FilenamingConventionRadioCheckMark = 5 or FilenamingConventionRadioCheckMark = 6 or FilenamingConventionRadioCheckMark = 7  )
 ControlGetPos,,TempvarYpos,,,,ahk_id %HWND_ExampleEditBoxForFilenamingConventionEditBox1%
if FilenamingConventionRadioCheckMark = 3
 ControlGetPos,,TempvarYpos,,,,ahk_id %HWND_ExampleEditBoxForFilenamingConventionEditBox3%
if FilenamingConventionRadioCheckMark = 4
 ControlGetPos,,TempvarYpos,,,,ahk_id %HWND_ExampleEditBoxForFilenamingConventionEditBox4%

ControlMove,,,% TempvarYpos,,,ahk_id %HWND_ApplyAndExitFilenamingConventionButton% ;need to do this to fix display issue when the OS is set to a different DPI

Gui 37: color, %DateAndTimeFormatScreensGuiColor%

WinGet,DateAndTimeFormatForFilenamingConventionID,ID,Date and Time Format for Custom Filenaming
return
MoreInfoForFileNamingConventionDateTimeOptions:
IfWinExist,ahk_id %MoreInfoForFileNamingConventionDateTimeOptions%
 {
  WinRestore,ahk_id %MoreInfoForFileNamingConventionDateTimeOptions%
  WinActivate,ahk_id %MoreInfoForFileNamingConventionDateTimeOptions%
  return
 }
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000

Gui 59: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 59: add, text, x15 y15 w580,There are 7 options to choose from in this section.

Gui 59: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 59: add, groupbox,x15 y35 w600 h180,Date and Time Options
Gui 59: font,
Gui 59: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 59: add, text, x25  y55  w580,(1)  %DateTimeFormatFilenamingConvention1% (Day of Week, Month, Day, Year, Hour, Minutes, Seconds, AM/PM )
Gui 59: add, text, x25  y75  w580,(2)  %DateTimeFormatFilenamingConvention2% ("Date" Month, Day, Year, "Time" Hour, Minutes, Seconds, AM/PM)
Gui 59: add, text, x25  y95  w580,(3)  9%a_space%%Tempvar% (Hour, Minutes, Seconds)
Gui 59: add, text, x25  y115 w580,(4)  09%a_space%%tempvar% (Hour, Minutes, Seconds)
Gui 59: add, text, x25  y135 w580,(5)  %DateTimeFormatFilenamingConvention5% (Month, Day, Year, - , Hour, Minutes, Seconds)
Gui 59: add, text, x25  y155 w580,(6)  %DateTimeFormatFilenamingConvention6% (Year Month Day Hour Minutes Seconds)
Gui 59: add, text, x25  y175 w580,(7)  %DateTimeFormatFilenamingConvention7a% 
Gui 59: add, edit, x95  y175 w40 h15 center Disabled, %SeparatorCharFilenamingConvention%
Gui 59: add, text, x140 y175, %DateTimeFormatFilenamingConvention7b% (Year Month Day [user chosen separator] Hour Minutes Seconds) 

Gui 59: add, button,x565 y220 w50 h22 g59GuiClose, Close
Gui 59: show,  w630 h250,More Info (Date and Time Options)
WinGet,MoreInfoForFileNamingConventionDateTimeOptions,id,More Info (Date and Time Options)
Gui 59: color, %AdditionalSettingsMenuColorGuiVar%
return
59GuiEscape:
59GuiClose:
Gui 59: destroy
return

ClickRadioButtonFileNamingConvention:
GuiControl,37:,button7,1
return
RadioButtonDateTimeFilenamingConventionSeparator: ;glabel for Separator date time option number 7, check for invalid char and update Example edit box
GuiControl,37:,button7,1
Gui 37: submit, nohide
StringSplit,SeparatorCharArray, FormatDateAndTimeFilenamingConvention7Separator
Loop %SeparatorCharArray0%
 {
  if SeparatorCharArray%a_index% in \,/,:,*,?,",<,>,|,.                                                   
   {
    FoundInvalidChar = 1
    InvalidCharIS := ( SeparatorCharArray%a_index% )
    break
   }
 }
if FoundInvalidChar = 1
 {
  MsgBox,4160,Invalid Character,( %InvalidCharIS% ) is an invalid filename character.`nPlease try again. 
  Send,{BS}
  FoundInvalidChar = 
  return
 }
GuiControl,37:,edit1,Filename - %DateTimeFormatFilenamingConvention7a%%FormatDateAndTimeFilenamingConvention7Separator%%DateTimeFormatFilenamingConvention7b%.jpg
FoundInvalidChar = 
return
RadioButtonDateTimeFilenamingConvention: ;updates Example edit box when a radio button is checked
Gui 37: submit, nohide
Loop %DateTimeFormats%
 {
  if FormatDateAndTimeFilenamingConvention%a_index% = 1   
  {
   tempvar2 = % DateTimeFormatFilenamingConvention%a_index%
   if ( A_index = 1 or A_index = 2 or A_index = 5 or A_index = 6 )
    GuiControl,37:,edit1,Filename - %tempvar2%.jpg
   if A_index = 3
    GuiControl,37:,edit1,Filename - 9%A_Space%%tempvar%.jpg
   if A_index = 4
    GuiControl,37:,edit1,Filename - 09%a_space%%tempvar%.jpg
   InvalidFileNameCharacters = \/:*?"<>|.
   if A_index = 7
    {
     IfInString, InvalidFileNameCharacters, %FormatDateAndTimeFilenamingConvention7Separator%
      return
     GuiControl,37:,edit1,Filename - %DateTimeFormatFilenamingConvention7a%%FormatDateAndTimeFilenamingConvention7Separator%%DateTimeFormatFilenamingConvention7b%.jpg
    }
  }
 }
return
37GuiClose: 
ChangesHaveBeenMade = 0
Gui 37: submit, nohide

Loop %DateTimeFormats%
 {
  if FormatDateAndTimeFilenamingConvention%a_index% = 1
   NewSetting = %a_index%
 }

if FormatDateAndTimeFilenamingConvention7 = 1
 if FormatDateAndTimeFilenamingConvention7Separator <> %SeparatorCharFilenamingConvention%
  ChangesHaveBeenMade = 1
 
if FilenamingConventionRadioCheckMark <> %NewSetting%
 ChangesHaveBeenMade = 1

if ChangesHaveBeenMade = 1
 MsgBox,4131,Confirm,Do you want to save your changes?
IfMsgBox,no
 Gui 37: Destroy
IfMsgBox,yes
 goto ApplyDateTimeFormatFilenamingConvention
IfMsgBox,cancel
 return
Gui 37: Destroy
return
ApplyDateTimeFormatFilenamingConvention:
Gui 37: submit
Loop %DateTimeFormats%
 {
  if FormatDateAndTimeFilenamingConvention%a_index% = 1
   {
    DateTimeFormatFilenamingConvention = % DateTimeFormat%a_index%
    FilenamingConventionRadioCheckMark = %A_Index%
    if FilenamingConventionRadioCheckMark = 7
     {
      IniWrite,%FormatDateAndTimeFilenamingConvention7Separator%,SpaConfig.ini, DatetimeFormat,SeparatorCharFilenamingConvention
      IniWrite,SeparatorOptionFilenamingConvention,spaconfig.ini,DateTimeFormat,SeparatorOptionFilenamingConvention ;SeparatorOption for Filenaming Convention
     }
    else
     {
      IniWrite,%DateTimeFormatFilenamingConvention%,spaconfig.ini,DateTimeFormat,FilenamingConvention
      IniWrite,%a_space%,spaconfig.ini,DateTimeFormat,SeparatorOptionFilenamingConvention ;by writing a space here it indicates not to use DateTime with separator option
     }
    break
   }
 }
Gui 37: Destroy
return
ResetSequential1:
Gosub, IniReadSequential1
if Sequential1 = 1
 {
  MsgBox,4160,SavePictureAs V%version% (Information),The Sequential Number is already set to 1.
  return  
 }
MsgBox,4116,SavePictureAs V%version% (Reset),This option will reset the Sequential Numbers back to 1.`n`nResetting this number takes effect immediately.`n`nDo you want to continue?
IfMsgBox Yes
 {
  IniWrite,1,SpaConfig.ini,NamingConvention,Sequential1
  Sequential1 = 1
 }
return
ResetSequential2:
Gosub, IniReadSequential2
if Sequential2 = 1
 {
  MsgBox,4160,SavePictureAs V%version% (Information),The Sequential Number is already set to 1.
  return  
 }
MsgBox,4116,SavePictureAs V%version% (Reset),This option will reset the Sequential Numbers back to 1.`n`nResetting this number takes effect immediately.`n`nDo you want to continue?
IfMsgBox Yes
 {
  IniWrite,1,SpaConfig.ini,NamingConvention,Sequential2
  Sequential2 = 1
 }
return
ResetSequential3:
Gosub, IniReadSequential3
if Sequential3 = 1
 {
  MsgBox,4160,SavePictureAs V%version% (Information),The Sequential number is already set to 1.
  return  
 }
MsgBox,4116,SavePictureAs V%version% (Reset),This option will reset the Sequential numbers back to 1.`n`nResetting this number takes effect immediately.`n`nDo you want to continue?
IfMsgBox Yes
 {
  IniWrite,1,SpaConfig.ini,NamingConvention,Sequential3
  Sequential3 = 1
 }
return
VerifyEditBox:
gui 10: submit, nohide
InvalidFileNameCharacters = \/:*?"<>|.

StringLen,len1,EditBoxCustomTextBefore

len1--
StringTrimLeft,EditBoxCustomTextBefore,EditBoxCustomTextBefore,%len1%

StringLen,len2,EditBoxCustomTextAfter
len2--
StringTrimLeft,EditBoxCustomTextAfter,EditBoxCustomTextAfter,%len2%

if EditBoxCustomTextBefore <>
IfInString, InvalidFileNameCharacters, %EditBoxCustomTextBefore%
 {
   MsgBox,4160,Invalid Character,( %EditBoxcustomTextBefore% ) is an invalid filename character.`nPlease try again.
   Send,{BS}
   return
 }
if EditBoxCustomTextAfter <>
IfInString, InvalidFileNameCharacters, %EditBoxCustomTextAfter%
 {
   MsgBox,4160,Invalid Character,( %EditBoxcustomTextAfter% ) is an invalid filename character.`nPlease try again.
   Send,{BS}
   return
 }
return
10ButtonViewCurrent:
GoSub, IniReadFileNameFormat
Gosub, IniReadSequential1
Gosub, IniReadSequential2
Gosub, IniReadSequential3

IniRead,var,spaconfig.ini,DateTimeFormat,FilenamingConvention,MM dd yy - HH mm ss
FormatTime,FormattedTime,,%var%

if UseAboveOptionsAndPromptForFilename = 0
  TempVarForDisplay =
if UseAboveOptionsAndPromptForFilename = 1
  TempVarForDisplay := ( "`n`n" "User Above Option AND Prompt For Filename")
  
IniRead,SeparatorOptionFilenamingConvention,Spaconfig.ini,DateTimeFormat,SeparatorOptionFilenamingConvention
if SeparatorOptionFilenamingConvention = SeparatorOptionFilenamingConvention
 {
  FormatTime, DateTimeFormatFilenamingConvention7a, T12, yyyyMMdd
  IniRead,SeparatorCharFilenamingConvention,Spaconfig.ini,DateTimeFormat,SeparatorCharFilenamingConvention
  FormatTime, DateTimeFormatFilenamingConvention7b, T12, hhmmss
  FormattedTime := ( DateTimeFormatFilenamingConvention7a SeparatorCharFilenamingConvention DateTimeFormatFilenamingConvention7a )
 }

if CustomBefore =
 CustomTextBefore = 
else
 CustomTextBefore = Custom Before |%a_space%
if CustomAfter =
 CustomTextAfter = 
else
 CustomTextAfter =  %a_space%| Custom After
if FileNameFormat = 1
 MsgBox,4160,Current Filename Format,Format:`n%CustomTextBefore%Date and Time%CustomTextAfter%`n`nExample:`n%CustomBefore%%FormattedTime%%CustomAfter%.jpg%TempVarForDisplay%
  
if FileNameFormat = 2
 MsgBox,4160,Current Filename Format,Format:`n%CustomTextBefore%FileName-Date and Time%CustomTextAfter%`n`nExample:`n%CustomBefore%Filename%a_space%-%a_space%%FormattedTime%%CustomAfter%.jpg%TempVarForDisplay%

if FileNameFormat = 3
 MsgBox,4160,Current Filename Format,Format:`n%CustomTextBefore%Sequential %CustomTextAfter%`n`nExample:`n%CustomBefore%%Sequential1%%CustomAfter%.jpg%TempVarForDisplay%

if FileNameFormat = 4
 MsgBox,4160,Current Filename Format,Format:`n%CustomTextBefore%FileName-Sequential %CustomTextAfter%`n`nExample:`n%CustomBefore%Filename-%Sequential2%%CustomAfter%.jpg%TempVarForDisplay%

if FileNameFormat = 5
 MsgBox,4160,Current Filename Format,Format:`n%CustomTextBefore%Random Number%CustomTextAfter%`n`nExample:`n%CustomBefore%%RandomNumber%%CustomAfter%.jpg%TempVarForDisplay%

if FileNameFormat = 6
 MsgBox,4160,Current Filename Format,Format:`n%CustomTextBefore%FileName-Random Number%CustomTextAfter%`n`nExample:`n%CustomBefore%Filename-%RandomNumber%%CustomAfter%.jpg%TempVarForDisplay%

if FileNameFormat = 7
 MsgBox,4160,Current Filename Format,Format:`n%CustomTextBefore%FileName%CustomTextAfter%`n`nExample:`n%CustomBefore%Filename%CustomAfter%.jpg%TempVarForDisplay%

If FileNameFormat = 8
 MsgBox,4160,Current Filename Format,Format:`n%CustomTextBefore%Date and Time-FileName%CustomTextAfter%`n`nExample:`n%CustomBefore%%FormattedTime%%a_space%-%a_space%Filename%CustomAfter%.jpg%TempVarForDisplay%

If FileNameFormat = 9
 MsgBox,4160,Current Filename Format,Format:`n%CustomTextBefore%Sequential-FileName%CustomTextAfter%`n`nExample:`n%CustomBefore%%Sequential3%-FileName%CustomAfter%.jpg%TempVarForDisplay%
If FileNameFormat = 10
 MsgBox,4160,Current Filename Format,Format:`n [UserInput1] Date and Time [UserInput2] Original Filename`n`nExample:`n[UserInput1]%FormattedTime%[UserInput2]OriginalFilename.jpg%TempVarForDisplay%
 return
10ButtonViewChanges:
gui 10: submit, nohide

GoSub, IniReadFileNameFormat
IniRead,var,spaconfig.ini,DateTimeFormat,FilenamingConvention,MM dd yy - HH mm ss ;need to know what the current choice is for the format of Date and time
IniRead,SeparatorOptionFilenamingConvention,Spaconfig.ini,DateTimeFormat,SeparatorOptionFilenamingConvention
IniRead,OriginalUseAboveOptionsAndPromptForFilename,SpaConfig.ini,NamingConvention,UseAboveOptionsAndPromptForFilename,0
FormatTime,FormattedTime,,%var%
if UseAboveOptionsAndPromptForFilename = 0
  TempVarForDisplay =
if UseAboveOptionsAndPromptForFilename = 1
  TempVarForDisplay := ( "`n`n" "User Above Option AND Prompt For Filename")
  
if SeparatorOptionFilenamingConvention = SeparatorOptionFilenamingConvention
 {
  FormatTime, DateTimeFormatFilenamingConvention7a, T12, yyyyMMdd
  IniRead,SeparatorCharFilenamingConvention,Spaconfig.ini,DateTimeFormat,SeparatorCharFilenamingConvention
  FormatTime, DateTimeFormatFilenamingConvention7b, T12, hhmmss
  FormattedTime := ( DateTimeFormatFilenamingConvention7a SeparatorCharFilenamingConvention DateTimeFormatFilenamingConvention7a )
 }

Gosub, IniReadCustomBeforeAndAfter
Gosub, IniReadSequential1
Gosub, IniReadSequential2
Gosub, IniReadSequential3

if EditBoxCustomTextBefore =
 CustomTextBefore = 
else
 CustomTextBefore = Custom Before |%a_space%

if EditBoxCustomTextAfter =
 CustomTextAfter = 
else
 CustomTextAfter =  %a_space%| Custom After

if (FileNameFormat = SelectedFormat and CustomBefore = EditBoxCustomTextBefore and CustomAfter = EditBoxCustomTextAfter and OriginalUseAboveOptionsAndPromptForFilename = UseAboveOptionsAndPromptForFilename ) 
 {
  MsgBox,4160,No Pending Changes,No changes have been made
  return
 }
if SelectedFormat = 1
 MsgBox,4160, View Pending Changes, Format:`n%CustomTextBefore%Date and Time%CustomTextAfter%`n`nExample:`n%EditBoxCustomTextBefore%%FormattedTime%%EditBoxCustomTextAfter%.jpg%TempVarForDisplay%
  
if SelectedFormat = 2
 MsgBox,4160, View Pending Changes, Format:`n%CustomTextBefore%FileName-Date and Time%CustomTextAfter%`n`nExample:`n%EditBoxCustomTextBefore%Filename%a_space%-%a_space%%FormattedTime%%EditBoxCustomTextAfter%.jpg%TempVarForDisplay%

if SelectedFormat = 3
 MsgBox,4160, View Pending Chafdnges, Format:`n%CustomTextBefore%Sequential%CustomTextAfter%`n`nExample:`n%EditBoxCustomTextBefore%%Sequential1%%EditBoxCustomTextAfter%.jpg%TempVarForDisplay%

if SelectedFormat = 4
 MsgBox,4160, View Pending Changes, Format:`n%CustomTextBefore%FileName-Sequential%CustomTextAfter%`n`nExample:`n%EditBoxCustomTextBefore%Filename-%Sequential2%%EditBoxCustomTextAfter%.jpg%TempVarForDisplay%

if SelectedFormat = 5
 MsgBox,4160, View Pending Changes, Format:`n%CustomTextBefore%Random Number%CustomTextAfter%`n`nExample:`n%EditBoxCustomTextBefore%%RandomNumber%%EditBoxCustomTextAfter%.jpg%TempVarForDisplay%

if SelectedFormat = 6
 MsgBox,4160, View Pending Changes, Format:`n%CustomTextBefore%FileName-Random Number%CustomTextAfter%`n`nExample:`n%EditBoxCustomTextBefore%FileName-%RandomNumber%%EditBoxCustomTextAfter%.jpg%TempVarForDisplay%

if SelectedFormat = 7
 MsgBox,4160, View Pending Changes, Format:`n%CustomTextBefore%Original FileName%CustomTextAfter%`n`nExample:`n%EditBoxCustomTextBefore%FileName%EditBoxCustomTextAfter%.jpg%TempVarForDisplay%

if SelectedFormat = 8
 MsgBox,4160, View Pending Changes, Format:`n%CustomTextBefore%Date and Time-FileName%CustomTextAfter%`n`nExample:`n%EditBoxCustomTextBefore%%FormattedTime%%a_space%-%a_space%FileName%EditBoxCustomTextAfter%.jpg%TempVarForDisplay%

if SelectedFormat = 9
 MsgBox,4160, View Pending Changes, Format:`n%CustomTextBefore%Sequential-FileName%CustomTextAfter%`n`nExample:`n%EditBoxCustomTextBefore%%Sequential3%-Filename%EditBoxCustomTextAfter%.jpg%TempVarForDisplay%

if SelectedFormat = 10
 MsgBox,4160, View Pending Changes, Format:`n[UserInput1] Date && Time [UserInput2] Original Filename`n`nExample:`n[UserInput1]%FormattedTime%[UserInput2]OriginalFilename.jpg%TempVarForDisplay%

return
10ButtonSaveChanges:
gui 10: submit, nohide
GoSub, IniReadFileNameFormat
Gosub, IniReadCustomBeforeAndAfter
IniRead,OriginalUseAboveOptionsAndPromptForFilename,SpaConfig.ini,NamingConvention,UseAboveOptionsAndPromptForFilename,0

if (FileNameFormat = SelectedFormat and CustomBefore = EditBoxCustomTextBefore and CustomAfter = EditBoxCustomTextAfter and OriginalUseAboveOptionsAndPromptForFilename = UseAboveOptionsAndPromptForFilename ) ;check all these values,
 {
  MsgBox,4160, No Pending Changes, No changes need to be saved
  return
 }
IniWrite,"%EditBoxCustomTextBefore%",SpaConfig.ini,NamingConvention,CustomBefore ;[] are used to preserve spaces in variables, they are removed before displaying or renaming a file.
IniWrite,"%EditBoxCustomTextAfter%",SpaConfig.ini,NamingConvention,CustomAfter
IniWrite,%SelectedFormat%,SpaConfig.ini,NamingConvention,FileNameFormat
IniWrite,%UseAboveOptionsAndPromptForFilename%,SpaConfig.ini,NamingConvention,UseAboveOptionsAndPromptForFilename
MsgBox,4160,Save Changes,Changes have been saved
return

SaveChangesExit:
gui 10: submit, nohide
GoSub, IniReadFileNameFormat
Gosub, IniReadCustomBeforeAndAfter
IniRead,OriginalUseAboveOptionsAndPromptForFilename,SpaConfig.ini,NamingConvention,UseAboveOptionsAndPromptForFilename,0

if (FileNameFormat = SelectedFormat and CustomBefore = EditBoxCustomTextBefore and CustomAfter = EditBoxCustomTextAfter and OriginalUseAboveOptionsAndPromptForFilename = UseAboveOptionsAndPromptForFilename ) ;check all these values,
 {
  MsgBox,4160, No Pending Changes, No changes need to be saved
  WinGetPos,x,y,,,ahk_id %FNFID%
  IniWrite,%x%,SpaConfig.ini,NamingConvention,FNFXpos
  IniWrite,%y%,SpaConfig.ini,NamingConvention,FNFYpos
  Gui 10: destroy
  return
 }

IniWrite,"%EditBoxCustomTextBefore%",SpaConfig.ini,NamingConvention,CustomBefore ;"" are used to preserve spaces in variables, they are removed before displaying or renaming a file.
IniWrite,"%EditBoxCustomTextAfter%",SpaConfig.ini,NamingConvention,CustomAfter
IniWrite,%SelectedFormat%,SpaConfig.ini,NamingConvention,FileNameFormat
IniWrite,%UseAboveOptionsAndPromptForFilename%,SpaConfig.ini,NamingConvention,UseAboveOptionsAndPromptForFilename
WinGetPos,x,y,,,ahk_id %FNFID%
IniWrite,%x%,SpaConfig.ini,NamingConvention,FNFXpos
IniWrite,%y%,SpaConfig.ini,NamingConvention,FNFYpos
Gui 10: destroy
return
10GuiClose:
ChangesHaveBeenMade = 0
gui 10: submit, nohide
IniRead,OriginalUseAboveOptionsAndPromptForFilename,Spaconfig.ini,NamingConvention,UseAboveOptionsAndPromptForFilename,0
GoSub, IniReadFileNameFormat
Gosub, IniReadCustomBeforeAndAfter

if (FileNameFormat = SelectedFormat and CustomBefore = EditBoxCustomTextBefore and CustomAfter = EditBoxCustomTextAfter and UseAboveOptionsAndPromptForFilename = OriginalUseAboveOptionsAndPromptForFilename  ) ;check all these values,
 {
  WinGetPos,x,y,,,ahk_id %FNFID%
  IniWrite,%x%,SpaConfig.ini,NamingConvention,FNFXpos
  IniWrite,%y%,SpaConfig.ini,NamingConvention,FNFYpos
  Gui 10: destroy
 }
else
 {
   MsgBox,4131,Confirm,Do you want to save your changes?
   IfMsgBox,no
    {
     WinGetPos,x,y,,,ahk_id %FNFID%
     IniWrite,%x%,SpaConfig.ini,NamingConvention,FNFXpos
     IniWrite,%y%,SpaConfig.ini,NamingConvention,FNFYpos
     Gui 10: destroy
    }
   IfMsgBox,yes
    goto SaveChangesExit
   IfMsgBox,cancel
    return
 }

return
;********************************************************************************************************************************
;*************************************************** Save Picture Section********************************************************
;********************************************************************************************************************************
SavePictureAs:  ;Saving the picture code 
if Error1001Found = 1
 {
  Error1001Found = 0
  return
 }
EmptyMem()
FoundDuplicate = 0
IfNotExist,%a_scriptdir%\TempFolder
 FileCreateDir, %a_scriptdir%\TempFolder
IfNotExist,%a_scriptdir%\TempFolder\DoNotUseThisFolder.txt
 FileAppend,Do not use this folder for files or folders. Everything will be deleted by SavePictureAs when it uses this folder while saving pictures.,%a_scriptdir%\TempFolder\DoNotUseThisFolder.txt
RecordHistory = 1      ;This gets changed when a filename already exists and the user decides not to save the duplicate
loop, %a_scriptdir%\TempFolder\*.*
 {
  if A_LoopFilename <> DoNotUseThisFolder.txt
   FileDelete, %a_scriptdir%\TempFolder\%A_LoopFileName%
 }

SetControlDelay, -1
SetTitleMatchMode,2

MouseGetPos,,,ID ;make sure the correct window class is retrieved
WinActivate,ahk_id %id% ;activate window. Just placing the mouse over a window does not activate it
WinGetClass,class, ahk_id %id%
if Class = KMeleon Browser Window
 SetTimer,KMeleon,10
  
WinGetTitle, title, A
if ErrorLogging = ; I am currently disabling this part of the error log until futher ErrorLog development
 {
  URL =
  If (Class = "Chrome_WidgetWin_0" or Class = "Chrome_WidgetWin_1")
   {
    SavedClipboard = %Clipboard%
    send {F6}^c
    send {right} ;remove highlight
    Url = %Clipboard%
    Clipboard = %SavedClipboard%
   } ;ControlgetText, url, Chrome_OmniboxView1, %title% does not work on latest chrome update
  if Class = IEFrame
   ControlgetText, url, Edit1, %title%
  If Class =  OperaWindowClass 
   {
    sServer := "Opera"   
    gosub GetURL
   }
  If ( Class = "MozillaUIWindowClass" or Class = "MozillaWindowClass" ) 
   {
    sServer := "FireFox"
    gosub GetURL
   }
  ;can not get url in safari
  ;can not get url in maxthon
  FormatTime, SavedTime ,   , MM\dd\yy HH:mm:ss
  FileAppend,
   (
`n----------------------Begin Logging >>>>>>>>>>>>>>>>>>>>
LogIndex:             1
Time:                 %SavedTime%
PromptForFileName:    %PromptForFileName%
ConfirmationMessage:  %ConfirmationMessageValue%
History:              %HistoryValue%
WaitForSPAWindow:     %TimeOut%
SPA Version:          %Version%
Browser Class:        %Class%
Url:                  %url%
OS:                   %A_OsVersion%
Language:             %A_Language%
Admin:                %A_IsAdmin%
32BitOR64BitOS:       %A_Is64bitOS%
%AddAutoHotkeyVersionIfCompiled%
----------------------End Logging <<<<<<<<<<<<<<<<<<<<<<<<`n               
   ),LogFile.txt
 }  ; end brace for "if ErrorLogging = 1"

WinGetActiveTitle,title 

If (Class = "YandexBrowser_WidgetWin_1" or Class = "Chrome_WidgetWin_0" or Class = "Chrome_WidgetWin_1" or Class = "MozillaUIWindowClass" or Class = "MozillaWindowClass"  or Class = "IEframe" or Class = "Maxthon3Cls_MainFrm" or Class = "{1C03B488-D53B-4a81-97F8-754559640193}" or class = "TAFfrmClient.UnicodeClass" or class = "KMeleon Browser Window" or class = "SlimBrowser MainFrameW"  ) ;send rbutton to open right click context menu
 {
  Sleep, 300
  If (Class = "Chrome_WidgetWin_0" or Class = "Chrome_WidgetWin_1" or Class = "MozillaUIWindowClass" or Class = "MozillaWindowClass" or Class = "Maxthon3Cls_MainFrm") 
   {
    IfInString,Title,Google Search ;specifically added sleep 700 below due to google search image results zoom picture preview when mouse is over image. In Chrome, Maxthon, Opera and Firefox, until the picture enlarges (zoom) it is not a savable picture. In IE it is a bmp file before it zooms, then a jpg after zooming. Opera does not Zoom the picture.  
     sleep 700                     
   }                              
   
   Send {rbutton} 
  }

;Opera, send ctrl-alt-click version 12.16 not v20
If Class = OperaWindowClass ;open Save As window - works in all os versions - no need for rbutton with Opera
 {
  sleep 300
  PictureImage = As
  send {ctrldown}{altdown}{lbutton}{altup}{ctrlup}
 }

;Chrome, RockMelt, FireFox, Yandex, send v
If (Class = "YandexBrowser_WidgetWin_1" or Class = "Chrome_WidgetWin_0" or Class = "Chrome_WidgetWin_1" or Class = "MozillaUIWindowClass"  or Class = "MozillaWindowClass") ;send v to open Save Image or Save As window
 {
  If ( Class = "YandexBrowser_WidgetWin_1" or Class = "Chrome_WidgetWin_0" or Class = "Chrome_WidgetWin_1" )
   PictureImage = As
  If (Class = "MozillaUIWindowClass"  or Class = "MozillaWindowClass")
   PictureImage = Image
  sleep 500
  send v ;for Chrome, Firefox, Yandex and RockMelt
 } 

;Internet Explorer, send s and Gosub
If ( Class = "IEframe" or class = "TAFfrmClient.UnicodeClass" or class = "SlimBrowser MainFrameW" )
 {
  Gosub CheckWindowContents
  if NotInRightClickMenu = 0 ;CheckWindowContents label displays error message if Save Picture As is not in right click menu
   return
  send s 
  PictureImage = Picture
 }

if ( Class = "KMeleon Browser Window" )
 {
  sleep 300
  gosub CheckWindowContents
  IfInString, sContents, I&mage
   {
    send m
    sleep 300
   }
  send s
  PictureImage = As
  sContents =  
 }

if ( Class = "Maxthon3Cls_MainFrm" )
 {
  sleep 300
  send s
  PictureImage = As
 }

if ( Class = "{1C03B488-D53B-4a81-97F8-754559640193}" ) ;safari
 {
  PictureImage = As
  sleep 500
  send s
  sleep 100
  send s
  sleep 200
  IfWinNotActive, Save As
   send {enter}
 }
if TimeOut < 5
 TimeOut = 5

WinWaitActive,Save %PictureImage%,,%TimeOut%

If Errorlevel = 1
 {
  if ( ErrorLogging = 1 )
   {
    FormatTime, SavedTime ,   , MM\dd\yy HH:mm:ss
    FileAppend,
     (
LogIndex:            3
Time:                %SavedTime%
PromptForFileName:   %PromptForFileName%
ConfirmationMessage: %ConfirmationMessageValue%
History:             %HistoryValue%
WaitForSPAWindow:    %TimeOut%
SPA Version:         %Version%
Browser Class:       %Class%
OS:                  %A_OsVersion%
Url:                  %url%
Language:             %A_Language%
Admin:                %A_IsAdmin%
32BitOR64BitOS:       %A_Is64bitOS%
%AddAutoHotkeyVersionIfCompiled%
Error:               Timed out (%TimeOut% seconds) waiting for the Save %PictureImage% window to open.
Notes1:              Most likey you are trying to save a picture that is not savable.
Possible Fix1:       Verify that you can right click and choose Save %PictureImage%. If you can not then SavePictureAs will not be 
                     able to either.
Notes2:              You may also encounter this error if your PC in running slow due to issues like an Antivirus
                     program running a scan in the background.
Possible Fix2:       Select Settings then Additional Settings Menu under the system tray icon and change the
                     time out period longer than 5 seconds for the WaitForSavePictureAsWindow value`n
     ),LogFile.txt
   } ;ending brace If ErrorLogging = 1 for WinWaitActive, Save %PictureImage%, , %TimeOut%
   

 MsgBox,4112,SavePictureAs V%Version% Error Message,This may not be a savable picture. If you are sure this is a savable picture, try to save it again. Some pictures are protected from download by the website creator.`n`nYou can also save an area of the screen using your "Capture Area of Screen" hotkey.
  Gosub, TrimErrorLog
  GoSub, UpdateCheckForUpdatesDailyTimer
  Return
 } ;ending brace if ErrorLevel = 1

LoopCount = 0
Loop ;as soon as the filename is retrieved then the loop breaks
   {
    sleep 200
    LoopCount++ ; max 5 seconds (25 loops)
    ControlgetText, ActualFilename, Edit1, Save %pictureimage%  ;get filename from Save Image/Picture/As 
    sleep 50
    If ActualFilename <>
     break
    Else
     If LoopCount > 25
      { 
       if ErrorLogging = 1
        {
         FormatTime, SavedTime ,   , MM\dd\yy HH:mm:ss
         FileAppend,     
          (
`nLogIndex:            4
Time:                %SavedTime%
SPA Version:         %Version%
Browser Class:       %Class%
OS:                  %A_OsVersion%
Url:                  %url%
Language:             %A_Language%
Admin:                %A_IsAdmin%
32BitOR64BitOS:       %A_Is64bitOS%
%AddAutoHotkeyVersionIfCompiled%
Error:               Note able to retreive filename from the edit box
Notes:               No known reason for this
Current Fix:         Will use SavePictureAs filename for this picture only`n
          ),LogFile.txt
        }
       ActualFilename = SavePictureAs ;use SavePictureAs for the filename if the original filename cannot be retrieved.
      }
   } ;end brace loop
  
ControlFocus,Edit1,Save %PictureImage%
ControlSetText , Edit1,,Save %PictureImage% ;blank the edit box for safety
sleep 100

SendInput {Raw}%A_ScriptDir%\TempFolder\%ActualFileName% ;leave no spaces between {Raw} and %A_ScriptDir%\TempFolder\%FileName%
sleep 1000

;NOTES 1: Reason for using SendInput {Raw} instead of Send
;Send Car+Mustang+-+1999+Red+06 actually sends CarMustang_!999Red)6
;SendInput {Raw} Car+Mustang+-+1999+Red+06 actually sends Car+Mustang+-+1999+Red+06
;NOTES 2: Reason for using SendInput {Raw} instead of ControSetText. When using some broswers on some OS's ControlSetText puts the text in the control but then when sending enter, alt s, or (ControlClick, &Save) to save the image it always trys to save the original filename without the new path. For example it continues to try to save - images.jpg instead of c:\NewPath\images.jpg This behavior is in windows vista and windows 7.

counter = 0
ClickAgain:
ControlClick , &Save, Save %PictureImage%,,,,NA 
;NOTES 1: Reason for using &Save instead of button1 or Send Enter
;Save is button1 on some browsers in some os's in others it is button2
;Sending {Enter} instead of ControlClick was not reliable on all browsers in all os's
IfWinActive, Save %PictureImage%
 {
  sleep 300
  counter++
  if counter < 16
   goto ClickAgain   ;occasionally ControlClick does not trigger the Save button, it will put focus on the button but not click it.
  ;xxx should decide on what to do if the window will not close, maybe prompt the user to close the window
 }

FilenamingAndCheckForDuplicates: ;CaptureEntireScreen, CaptureActiveWindow and CaptureAreaOfScreen (HotkeyLabel14 and 15 and 16) goto here.

KeepWaitingForFileToExistCounter = 0
SkipBrowserSpecificCode:
filename =

If (Class = "Chrome_WidgetWin_0" or Class = "Chrome_WidgetWin_1" or Class = "YandexBrowser_WidgetWin_1")
 sleep 1500 ;this allows chrome or Yandex to do its integrity check
Loop %A_ScriptDir%\TempFolder\*.*  ;I could use WinWaitClose but I need to know for sure the file is there before continuing
 {
  if A_loopFileName <> DoNotUseThisFolder.txt
   {
    ;Filename = %A_LoopFileName%
    Filename := ( A_LoopFileName )
    SplitPath,filename,,,extt
    if extt = crdownload ;related to chrome browser, file is still being downloaded
     {
      sleep 100
      KeepWaitingForFileToExistCounter++
      if KeepWaitingForFileToExistCounter = 50 ;5 seconds
       {
        extt =
        break
       }
      extt =
      goto SkipBrowserSpecificCode
     }
    FileMove, %A_ScriptDir%\TempFolder\%Filename%,%A_ScriptDir%\TempFolder\FileCheck%Filename% ;The file can exist but not be fully downloaded. If this fails then the file is still in use.
    IfNotExist, %A_ScriptDir%\TempFolder\FileCheck%Filename%
     {
      sleep 100
      KeepWaitingForFileToExistCounter++
      if KeepWaitingForFileToExistCounter = 50 ;5 seconds
       break
      goto SkipBrowserSpecificCode
     }
     else
      {
       FileMove, %A_ScriptDir%\TempFolder\FileCheck%Filename%,%A_ScriptDir%\TempFolder\%Filename%
       KeepWaitingForFileToExistCounter = 0
      }
   }
 }
if FileName =
 {
  sleep 100
  KeepWaitingForFileToExistCounter++
  if KeepWaitingForFileToExistCounter < 50 ;5 seconds
   goto SkipBrowserSpecificCode
 }

if KeepWaitingForFileToExistCounter > 49
 {
  MsgBox,4112,Error [1002], Something went wrong and the picture may not have been saved`n`nPlease try again.
  if ErrorLogging = 1
   {
    ;moved msgbox from here to above if errorlogging = 1
    Gosub, TrimErrorLog
    GoSub, UpdateCheckForUpdatesDailyTimer
    FormatTime, SavedTime ,   , MM\dd\yy HH:mm:ss
    FileAppend,
       (
`nTime:                %SavedTime%
LogIndex:            5
SPA Version:         %Version%
Browser Class:       %Class%
OS:                  %A_OsVersion%
%AddAutoHotkeyVersionIfCompiled%
Filename:            %Filename%
Error:               SavePictureAs was not able to verify the picture was saved.`nIf this problem persists try to "Right Click" and choose "Save %PictureImage% and check if you can save it manually.`nIf you can save it manually, please email the log file to support@SavePictureAs.com`n`n
     ),LogFile.txt
    Return
   } ;ending brace if ( ErrorLogging = 1 )
 } ;ending brace if KeepWaitingForFileToExistCounter = 50
 
;File has been confirmed to be in the TempFolder
CloseWindowCounter = 0 ;for KMeleon Brower Window

SplitPath,Filename,OutFileName,,OutExtension,OutNameNoExt
if ( OutExtension = "htm" or OutExtension = "webarchive" or OutExtension = "html" or OutExtension = "xhtml")
 {
  if Class = KMeleon Browser Window
   {
    IfWinActive,ahk_class #32770
     {
      CloseWindow:
      CloseWindowCounter++
      ControlClick , Close, A ;close if the file has downloaded completely
      ControlClick , Cancel, A ;cancel if it is still downloading
      IfWinActive,ahk_class #32770
       {
        if CloseWindowCounter = 5
         goto SkipClosingWindow
        else
         goto CloseWindow
       }
     }
   }
  SkipClosingWindow:
  MsgBox,4112,Error,This is not an savable picture.
  GoSub, UpdateCheckForUpdatesDailyTimer
  return
 }

if Class = KMeleon Browser Window
 {
  WaitForWindowToNotExist:
  IfWinExist, `% of %Filename%
   {
    sleep 200
    goto WaitForWindowToNotExist
    SetTimer,KMeleon,Off
   }
 }
 
;How to name the picture (7 options)
if PromptForFilename = 1
 {
  GuiWasCanceled = 0
  Gui 65: font, s10
  Gui 65: add, text, x15 y15, Type in a filname
  Gui 65: add, edit, x15  y45 w200 r1 vPromptForFilenameFilename gCheckForInvalidCharPromptForFilename, %OutNameNoExt%
  Gui 65: font, s16
  Gui 65: add, text, x217 y45, .
  Gui 65: font, s10
  Gui 65: add, edit, x226 y45 w35 ReadOnly, %OutExtension%
  Gui 65: add, button, x143 y85 w55 h25 g65GuiClose, Cancel
  Gui 65: add, button, x208 y85 w55 h25 g65GuiSubmit Default, Submit
  Gui 65: show, w275,Prompt For Picture Name
  Gui 65: color, c0c0c0
  WinGet,PromptForFilenameID,ID,Prompt For Picture Name
  WinWaitClose,ahk_id %PromptForFilenameID%
  if GuiWasCanceled = 1
   return
  NewFilename := ( PromptForFilenameFileName "." OutExtension )
  FileMove, %A_ScriptDir%\TempFolder\%Filename%,%A_ScriptDir%\TempFolder\%NewFilename%
  FilenameOnDisk := ( Newfilename )
 } ;ending brace for If PromptForFilename = 1

if CustomFileNameFormat = 1
 { 
  GoSub, IniReadFileNameFormat
  Gosub, IniReadCustomBeforeAndAfter
  ;{ Left here for reference
  ;FileNameFormat = 1 ;Filename will be Date & Time plus optional custom before and custom after
  ;FileNameFormat = 2 ;Filename will be Date & Time & FileName plus optional custom before and custom after
  ;FileNameFormat = 3 ;Filename will be Sequential  plus optional custom before and custom after
  ;FileNameFormat = 4 ;Filename will be Sequential  and FileName plus optional custom before and custom after
  ;FileNameFormat = 5 ;Filename will be Random plus optional custom before and custom after
  ;FileNameFormat = 6 ;Filename will be Random & FileName plus optional custom before and custom after
  ;FileNameFormat = 7 ;Filename will be Original Filename plus optional custom before and custom after
  ;}
  ;xxx
  GetFormattedTime:
  IniRead,DateTimeFormatFilenamingConvention,spaconfig.ini,DateTimeFormat,FilenamingConvention,MM dd yy - HH mm ss
  FormatTime, FormattedTime, ,%DateTimeFormatFilenamingConvention% ;this is for the first 6 time formats
  
  FormatTime, DateTimeFormat7a, ,yyyyMMdd ;this is for format7
  FormatTime, DateTimeFormat7b, ,hhmmss  ;this is for format7
  IniRead,SeparatorCharFilenamingConvention,SpaConfig.ini,DatetimeFormat,SeparatorCharFilenamingConvention,- ;this is for format7 separator option
  IniRead,SeparatorOptionFilenamingConvention,spaconfig.ini,DateTimeFormat,SeparatorOptionFilenamingConvention,%a_space%   ;separatorOption,%A_Space%
  IniRead,UseAboveOptionsAndPromptForFilename,Spaconfig.ini,NamingConvention,UseAboveOptionsAndPromptForFilename,0
  ;The below 7 FileNameFormats only rename the file while still in the tempfolder and have nothing to do with finding and renaming duplicates in the Save To folder
  if FileNameFormat = 1
   {  ;current date and time
    if SeparatorOptionFilenamingConvention = SeparatorOptionFilenamingConvention
     ;NewFileName = %CustomBefore%%DateTimeFormat7a%%SeparatorCharFilenamingConvention%%DateTimeFormat7b%%CustomAfter%.%OutExtension%
     NewFileName := (  CustomBefore DateTimeFormat7a SeparatorCharFilenamingConvention DateTimeFormat7b CustomAfter "." OutExtension )
    else
     NewFileName = %CustomBefore%%FormattedTime%%CustomAfter%.%OutExtension%
    NewFileName := ( CustomBefore FormattedTime CustomAfter "." OutExtension )
    IfExist,%currentpath%\%Newfilename%
     goto GetFormattedTime
   }
  if FileNameFormat = 2
   {  ;original name and current date and time
    if SeparatorOptionFilenamingConvention = SeparatorOptionFilenamingConvention
     ;NewFileName = %CustomBefore%%OutNameNoExt%%a_space%-%a_space%%DateTimeFormat7a%%SeparatorCharFilenamingConvention%%DateTimeFormat7b%%CustomAfter%.%OutExtension%
     NewFileName := ( CustomBefore OutNameNoExt a_space "-" a_space DateTimeFormat7a SeparatorCharFilenamingConvention DateTimeFormat7b CustomAfter "." OutExtension )
    else
     ;NewFileName = %CustomBefore%%OutNameNoExt%%a_space%-%a_space%%FormattedTime%%CustomAfter%.%OutExtension%
     NewFileName := ( CustomBefore OutNameNoExt a_space "-" a_space FormattedTime CustomAfter "." OutExtension )
    IfExist,%currentpath%\%Newfilename%
     goto GetFormattedTime
   }
  if FileNameFormat = 3                                                       ;Sequential1 Number and optional custom before and custom after
   {    
    Gosub, IniReadSequential1
    NewFileName := ( CustomBefore Sequential1 CustomAfter  )
    if ( NewFileName = "com1" or  NewFileName = "com2" or NewFileName = "com3" or NewFileName = "com4" or NewFileName = "com5" or NewFileName = "com6" or NewFileName = "com7" or NewFileName = "com8" or NewFileName = "com9" or NewFileName = "lpt1" or  NewFileName = "lpt2" or NewFileName = "lpt3" or NewFileName = "lpt4" or NewFileName = "lpt5" or NewFileName = "lpt6" or NewFileName = "lpt7" or NewFileName = "lpt8" or NewFileName = "lpt9" ) ; or NewFileName = "con" or NewFileName = "nul" or NewFileName = "prn"  )
   	NewFileName := ( CustomBefore Sequential1 CustomAfter "-" FormattedTime "." OutExtension  ) ;adding FormattedTime prevents one of the above invalid filenames from being used. Example would be if CustomBefore is Com and the sequential number is 1 thru 9. Then the filename would be com1 thur com9 and are invalid.
    else
     NewFileName := ( CustomBefore Sequential1 CustomAfter "." OutExtension  ) 
    Sequential1++
    iniwrite,%Sequential1%,spaconfig.ini,NamingConvention,Sequential1
   } ;if filenameformat = 3 closing brace     
  if FileNameFormat = 4                             ;original name and Sequential2 Number and optional custombefore and customafter 
   {      
    Gosub, IniReadSequential2
    ;NewFileName = %CustomBefore%%OutNameNoExt%-%Sequential2%%CustomAfter%.%OutExtension%
    NewFileName := ( CustomBefore OutNameNoExt "-" Sequential2 CustomAfter "." OutExtension )
    Sequential2++
    iniwrite,%Sequential2%,spaconfig.ini,NamingConvention,Sequential2
   }
  if FileNameFormat = 5                                              ;random number name with optional custombefore and customafter
   {  
    GetRandomNumber1:
    random,RandomNumber,1, %MaxRandomNumber%
    NewFileName := ( CustomBefore RandomNumber CustomAfter )
    if ( NewFileName = "com1" or  NewFileName = "com2" or NewFileName = "com3" or NewFileName = "com4" or NewFileName = "com5" or NewFileName = "com6" or NewFileName = "com7" or NewFileName = "com8" or NewFileName = "com9" or NewFileName = "lpt1" or  NewFileName = "lpt2" or NewFileName = "lpt3" or NewFileName = "lpt4" or NewFileName = "lpt5" or NewFileName = "lpt6" or NewFileName = "lpt7" or NewFileName = "lpt8" or NewFileName = "lpt9" ) ; or NewFileName = "con" or NewFileName = "nul" or NewFileName = "prn"  ) ;it can't equal con or nul or prn because there will be a random number as part of the filename
     goto GetRandomNumber1
    else
     NewFileName := ( CustomBefore RandomNumber CustomAfter "." OutExtension )
    IfExist,%currentpath%\%Newfilename%
     goto GetRandomNumber1
   }
  if FileNameFormat = 6                                  ;original name and random number and optional custombefore and customafter
   {
    GetRandomNumber2:
    random,RandomNumber,1,%MaxRandomNumber%
    ;NewFileName = %CustomBefore%%OutNameNoExt%-%RandomNumber%%CustomAfter%.%OutExtension%
    NewFileName := ( CustomBefore OutNameNoExt "-" RandomNumber CustomAfter "." OutExtension )
    IfExist,%currentpath%\%Newfilename%
     goto GetRandomNumber2
   }
  if FileNameFormat = 7
   ;NewFileName = %CustomBefore%%OutNameNoExt%%CustomAfter%.%OutExtension%
   NewFileName := ( CustomBefore OutNameNoExt CustomAfter "." OutExtension )
  if FileNameFormat = 8                                                       ;current date & time and original Filename and optional custombefore and customafter
   { 
    if SeparatorOptionFilenamingConvention = SeparatorOptionFilenamingConvention
     ;NewFileName = %CustomBefore%%DateTimeFormat7a%%SeparatorCharFilenamingConvention%%DateTimeFormat7b%%a_space%-%a_space% %OutNameNoExt%%CustomAfter%.%OutExtension%
     NewFileName :=  ( CustomBefore DateTimeFormat7a SeparatorCharFilenamingConvention DateTimeFormat7b a_space "-" a_space OutNameNoExt CustomAfter "." OutExtension )
    else
    ;NewFileName = %CustomBefore%%FormattedTime%%a_space%-%a_space%%OutNameNoExt%%CustomAfter%.%OutExtension%
    NewFileName := ( CustomBefore FormattedTime a_space "-" a_space OutNameNoExt CustomAfter "." OutExtension )
    IfExist,%currentpath%\%Newfilename%
     goto GetFormattedTime
   }
  if FileNameFormat = 9                                                       ;Sequential3 number and original Filename and optional custombefore and customafter 
   {      
    Gosub, IniReadSequential3
    ;NewFileName = %CustomBefore%%Sequential3%-%OutNameNoExt%%CustomAfter%.%OutExtension%
    NewFileName := ( CustomBefore Sequential3 "-" OutNameNoExt CustomAfter "." OutExtension )
    Sequential3++
    iniwrite,%Sequential3%,spaconfig.ini,NamingConvention,Sequential3
   }
  if FileNameFormat = 10 ;UserInput
   {
    if SeparatorOptionFilenamingConvention = SeparatorOptionFilenamingConvention
     FormattedTime := (DateTimeFormat7a SeparatorCharFilenamingConvention DateTimeFormat7b)
    if UseAboveOptionsAndPromptForFilename = 1 ;if it equals 1 then the gui will be shown below
     NewFileName := ( CustomBefore "[UserInput1]" FormattedTime "[UserInput2]" OutNameNoExt CustomAfter "." OutExtension)
     else
     {
       GuiWasCanceled = 0
       Gui 64: add, text,x10  y15      ,Add UserInput1 and/or UserInput2      (UserInput can be blank)
       Gui 64: add, text,x10  y45      ,%CustomBefore%
       
       Gui 64: add, edit,x10  y42  w100 vUserInput1 gCheckForInvalidCharUserInput1 HwndHWND_UserInput1,[UserInput1]
       Gui 64: add, text,     y45       HwndHWND_FormattedTime,%FormattedTime%
       
       Gui 64: add, edit,    y42  w100 vUserInput2 gCheckForInvalidCharUserInput2 HwndHWND_UserInput2,[UserInput2]
       Gui 64: add, text, y45  HwndHWND_OutNameNoExt,%OutNameNoExt%
       Gui 64: add, text, y45  HwndHWND_CustomAfterAndExtension,%CustomAfter%.%OutExtension%
       Gui 64: add, button, x10 y75 w80 g64GuiClose, Cancel
       Gui 64: add, button, x105 y75 w80 g64GuiSubmit HwndHWND_UserInputSubmitButton, Submit
       Gui 64: show, hide autosize,UserInput Date & Time UserInput Original Filename
       WinGet,UserInputID,ID,UserInput Date & Time UserInput Original Filename
       ControlGetPos,TempvarXpos,,,,,ahk_id %HWND_UserInput1%
       ControlMove,,% TempvarXpos + 100,,,,ahk_id %HWND_FormattedTime%
       ControlGetPos,TempvarXpos,,TempvarWidth,,,ahk_id %HWND_FormattedTime%
       NewUserInput2Pos := ( TempvarXpos + TempvarWidth)
       ControlMove,,%NewUserInput2Pos%,,,,ahk_id %HWND_UserInput2%
       ControlMove,,% NewUserInput2Pos + 100,,,,ahk_id %HWND_OutNameNoExt%
       ControlGetPos,TempvarXpos,,TempvarWidth,,,ahk_id %HWND_OutNameNoExt%
       TempVar := (TempvarXpos + TempvarWidth)
       ControlMove,,TempVar,,,,ahk_id %HWND_CustomAfterAndExtension%
       ControlGetPos,TempvarXpos,,TempvarWidth,,,ahk_id %HWND_CustomAfterAndExtension%
       GuiWidth := (TempvarXpos + TempvarWidth + 15)
       ControlMove,,% guiWidth - 95,,,,ahk_id %HWND_UserInputSubmitButton%
       
       WinMove, ahk_id %UserInputID%,,,,%GuiWidth%
       WinShow,ahk_id %UserInputID%
       WinActivate, ahk_id %UserInputID%
       Gui 64: color, c0c0c0
       WinWaitClose,ahk_id %UserInputID%
       if GuiWasCanceled = 1
        return
       NewFileName := (CustomBefore UserInput1 FormattedTime UserInput2 OutNameNoExt CustomAfter "." OutExtension)
       ;xxxxx check if exist then get date and time again
     }
   }
  
  if UseAboveOptionsAndPromptForFilename = 1
   {
    SplitPath,NewFileName,,,OutExtension,OutNameNoExt
    GuiWasCanceled = 0
    Gui 66: font, s10
    Gui 66: add, text, x15 y15, Type in a filname
    Gui 66: add, edit, x15  y45 w300 r1 vUseAboveOptionsAndPromptForFilenameFilename gCheckForInvalidCharUseAboveOptionsAndPromptForFilename, %OutNameNoExt%
    Gui 66: font, s16
    Gui 66: add, text, x317 y45, .
    Gui 66: font, s10
    Gui 66: add, edit, x326 y45 w35 ReadOnly, %OutExtension%
    Gui 66: add, button, x243 y85 w55 h25 g66GuiClose, Cancel
    Gui 66: add, button, x308 y85 w55 h25 g66GuiSubmit Default, Submit
    Gui 66: show, w375,Use Above Options And Prompt For Filename
    Gui 66: color, c0c0c0
    WinGet,UseAboveOptionsAndPromptForFilenameID,ID,Use Above Options And Prompt For Filename
    WinWaitClose,ahk_id %UseAboveOptionsAndPromptForFilenameID%
    if GuiWasCanceled = 1
     return
    NewFilename := ( UseAboveOptionsAndPromptForFilenameFilename "." OutExtension )
    UseAboveOptionsAndPromptForFilename = 0
   } ;ending brace for if UseAboveOptionsAndPromptForFilename = 1
   
  FileMove, %A_ScriptDir%\TempFolder\%Filename%,%A_ScriptDir%\TempFolder\%NewFilename% ;this applies to all formats and is only renaming the file not actually moving it.
  ;xxx need to fix this because moving a file on to itself is always considered successful, need to loop folder and compare what it finds to NewFilename
  if errorlevel <> 0
   {
    MsgBox,4112,Error [1003],An error occured and your picture could not be saved.
    return
   }
   FilenameOnDisk := ( Newfilename )
 } ;if CustomFileNameFormat = 1

if OriginalFilenameFormat = 1 ;keep original filename
 {
  FilenameOnDisk := ( Filename )
  NewFilename := ( Filename )
 }

DoNotRecordLastPictureSavedInformation = 0
HashValuesAreTheSame = 0

IfNotExist, %CurrentPath%\%NewFilename% ;duplicate does not exist in destination
 {
  If (Class = "Chrome_WidgetWin_0" or Class = "Chrome_WidgetWin_1" or )
   sleep 1000 ;give Chromes download integrity check time to complete (prevent "failed - download error"  and "virus scan failed" chrome messages)
  FileMove,%A_ScriptDir%\TempFolder\%FilenameOnDisk%,%CurrentPath%\%NewFilename%
  if errorlevel <> 0
   {
    MsgBox,4112,Error [1003],An error occured and your picture could not be saved.
    return
   }
 }
else ;file does exist in destination
 {      
  ;CheckForIdenticalHashValues takes precedence over the following 5 settings.
  
  ;Option 1 = AskHowToHandleDuplicates:
  ;Option 2 = DoNotSaveDuplicates
  ;Option 3 = AlwaysOverwrite
  ;Option 4 = SaveDuplicatesWithRandomNumber
  ;Option 5 = AddDateAndTimeWhenDuplicateIsFound
  ;Only 1 of the above 5 can be chosen at a time
  
  FoundDuplicate = 1
  if CheckForIdenticalHashValues = 1        ;if the filenames are the same this checks the original and duplicate pictures for identical MD5 checksums
   {                                        ;notify msgbox is after Done message      
    FileRead,File,%A_ScriptDir%\Tempfolder\%NewFilename%
    FileGetSize,FileSize,%A_ScriptDir%\Tempfolder\%NewFilename%
    MD5ValueDuplicate := Calc_MD5(&File,FileSize)
   
    FileRead,File,%CurrentPath%\%NewFilename%
    FileGetSize,FileSize,%CurrentPath%\%NewFilename%
    MD5ValueOriginal := Calc_MD5(&File,FileSize)

    if MD5ValueOriginal = %MD5ValueDuplicate%
     {
      FileDelete, %A_ScriptDir%\Tempfolder\%NewFilename%
      RecordHistory = 0
      HashValuesAreTheSame = 1
      DoNotRecordLastPictureSavedInformation = 1
      goto continue ;since the picture is deleted, need to skip all "How to handle duplicate options"
     }
   }
  if AskHowToHandleDuplicates = 1           ;displays DuplicateExists gui 
   {
    PreserveOriginalFileName := ( Newfilename ) ;need this to fix issue if DuplicateExists gui is open when RenameLastSavedPicture gui is closed.
    ErrorRetrievingDuplicateFileInformation = 0  
    ErrorRetrievingOriginalFileInformation = 0
    IfWinExist, ahk_id %DuplicateExistsID%
     Gui 36: destroy
    counter = 0
    GetOriginalImageDetails:
    ImageFile = %CurrentPath%\%NewFileName%
    FileGetSize,Size, %ImageFile%,K 
    Gosub GetDimensions
    OriginalWidth = %w%
    OriginalHeight = %h%
    OriginalImageForErrorLogging  = %ImageFile% 
    OriginalWidthForErrorlogging  = %w%
    OriginalHeightForErrorlogging = %h%
    if ( OriginalWidth = 0 or OriginalHeight = 0 )
     {
      sleep 1000
      counter++
      if counter  > 3
       {
        MsgBox,4112,Error [1004], SavePictureAs found a duplicate picture and was not able to retreive any information about it.`n`nThe "Original" picture may not display properly on the "Ask What To Do" Window.
        ErrorRetrievingOriginalFileInformation = 1
       }
      else
       Goto GetOriginalImageDetails
     }
    
    Counter = 0
    GetDuplicateImageDetails:
    ImageFile = %A_ScriptDir%\TempFolder\%FilenameOnDisk%
    Gosub GetDimensions
    DuplicateWidth = %w%
    DuplicateHeight = %h%
    DuplicateImageForErrorLogging  = %ImageFile%
    DuplicateWidthForErrorlogging  = %w%
    DuplicateHeightForErrorlogging = %h%
    if ( DuplicateWidth = 0 or DuplicateHeight = 0 )
     {
      sleep 1000
      counter++
      if counter  > 3
       {
        MsgBox,4112,Error [1005], SavePictureAs found a duplicate picture and was not able to retreive any information about it.`n`nThe "Duplicate" picture may not display properly on the "Ask What To Do" Window.
        ErrorRetrievingDuplicateFileInformation = 1
       }
      else
       Goto GetDuplicateImageDetails
     }
    
    if ErrorRetrievingOriginalFileInformation = 1
     {
      OriginalWidth = 380
      OriginalHeight = 380
      if  ErrorLogging = 1 
       {
        FormatTime, SavedTime ,   , MM\dd\yy HH:mm:ss
        FileAppend,
(
`nLogIndex:             6
Time:                 %SavedTime%
PromptForFileName:    %PromptForFileName%
ConfirmationMessage:  %ConfirmationMessageValue%
History:              %HistoryValue%
WaitForSPAWindow:     %TimeOut%
SPA Version:          %Version%
Browser Class:        %Class%
OS:                   %A_OsVersion%
Url:                  %url%
Language:             %A_Language%
Admin:                %A_IsAdmin%
32BitOR64BitOS:       %A_Is64bitOS%
%AddAutoHotkeyVersionIfCompiled%
Error:                   GetDimensions (Ask How To Handle Duplicates)
Prompt For Picture Name: (%PromptForPictureName%)
Custom Filename:         (%CustomFilenameFormat%)
Filenaming Convention:   (%FilenameFormat%)
Original Image Width:    (%OriginalWidthForErrorlogging%)
Original Image Height:   (%OriginalWidthForErrorlogging%)
Original Image:          (%OriginalImageForErrorLogging%)
Possible Fix:            Unknown Cause
),LogFile.txt
       }
     }
    if ErrorRetrievingDuplicateFileInformation = 1
     {
      DuplicateWidth = 380
      DuplicateHeight = 380
      if ErrorLogging = 1 
       {
        FormatTime, SavedTime ,   , MM\dd\yy HH:mm:ss
        FileAppend,
(
`nLogIndex:             7
Time:                 %SavedTime%
PromptForFileName:    %PromptForFileName%
ConfirmationMessage:  %ConfirmationMessageValue%
History:              %HistoryValue%
WaitForSPAWindow:     %TimeOut%
SPA Version:          %Version%
Browser Class:        %Class%
OS:                   %A_OsVersion%
Url:                  %url%
Language:             %A_Language%
Admin:                %A_IsAdmin%
32BitOR64BitOS:       %A_Is64bitOS%
%AddAutoHotkeyVersionIfCompiled%
Error:                    GetDimensions (Ask How To Handle Duplicates)
Prompt For Picture Name:  (%PromptForPictureName%)
Custom Filename:          (%CustomFilenameFormat%)
Filenaming Convention:    (%FilenameFormat%)
Duplicate Image Width:    (%DuplicateWidthForErrorlogging%)
Duplicate Image Height:   (%DuplicateHeightForErrorlogging%)
Duplicate Image:          (%DuplicateImageForErrorLogging%)
Possible Fix:             Unknown Cause
),LogFile.txt
       }
     }
    IniRead,DateTimeFormatDuplicates,spaconfig.ini,DateTimeFormat,Duplicates,yyyyMMddhhmmss
    FormatTime, FormattedTime, ,%DateTimeFormatDuplicates% ;this is for the first 6 time formats
    IniRead,SeparatorCharDuplicates,SpaConfig.ini,DatetimeFormat,SeparatorCharDuplicates,- ;this is for format7 separator option
    IniRead,SeparatorOptionDuplicates,spaconfig.ini,DateTimeFormat,SeparatorOptionDuplicates,%a_space%   ;separatorOption,%A_Space%
    
    if SeparatorOptionFilenamingConvention <>
     {
      FormatTime, DateTimeFormat7a, ,yyyyMMdd ;this is for format7
      FormatTime, DateTimeFormat7b, ,hhmmss  ;this is for format7
      SavedTime1 := (DateTimeFormat7a SeparatorCharDuplicates DateTimeFormat7b)
      sleep 1000
      FormatTime, DateTimeFormat7a, ,yyyyMMdd ;this is for format7
      FormatTime, DateTimeFormat7b, ,hhmmss  ;this is for format7
      SavedTime2 := (DateTimeFormat7a SeparatorCharDuplicates DateTimeFormat7b)
     }
    else
     { 
      FormatTime, SavedTime1 ,   , %DateTimeFormatDuplicates%
      sleep 1000
      FormatTime, SavedTime2 ,   , %DateTimeFormatDuplicates%
     }
    SplitPath,NewFileName,,,Ext,NewFileNameNoExt
    gui 36: -dpiscale     
    IniRead,DuplicateExistsGuiColor,spaconfig.ini,SystemColors,DuplicateExistsGuiColor,c0c0c0
    IniRead,DuplicateExistsGuiTextColor,spaconfig.ini,SystemColors,DuplicateExistsGuiTextColor,000000
    Gui 36: Default
    Gui 36:  -SysMenu
    
    Gui 36: font, 
    Gui 36: font, s11 c%DuplicateExistsGuiTextColor%
    
    Gui 36: Add, Text, x15 y9 w760 h20                       , A duplicate filename was found in your "Save To" folder.
    Gui 36: Add, Text, x15 y39 w760 h20                      , What would you like to do?

    Gui 36: font, 
    Gui 36: font, s9 c%DuplicateExistsGuiTextColor%
        
    Gui 36: Add, Picture, x36 y105, ;Original
    
    Gui 36: Add, Radio, x36  y520 w140 h20 vCheckValue1 Group gToggleCheck, Enter New Name
    Gui 36: Add, Radio, x36  y540 w200 h20 vCheckValue2       gToggleCheck, Add Date && Time to filename
    Gui 36: Add, Radio, x36  y560 w380 h20 vCheckValue3       gToggleCheck, Delete this picture
    Gui 36: Add, Radio, x36  y580 w380 h20 vCheckValue4       gToggleCheck, Keep with same filename

    Gui 36: Add, Edit, x190 y520 w190 h19 gVerifyEditBoxForDuplicates vVerifyValidChars1, %NewFilenameNoExt%
    Gui 36: Add, Edit, x236 y540 w144 h19 gVerifyEditBoxForDuplicates vVerifyValidChars2, %NewFilenameNoExt%-%SavedTime1%
    ;-------------------------------------------------------------------------------------------------------------------------
    Gui 36: Add, Picture, x475 y105, ;Duplicate
   
    Gui 36: Add, Radio, x476 y520 w140 h20 vCheckValue5 Group gToggleCheck, Enter New Name
    Gui 36: Add, Radio, x476 y540 w200 h20 vCheckValue6       gToggleCheck, Add Date && Time to filename
    Gui 36: Add, Radio, x476 y560 w380 h20 vCheckValue7       gToggleCheck, Delete this picture 
    Gui 36: Add, Radio, x476 y580 w380 h20 vCheckValue8       gToggleCheck, Keep with same filename

    Gui 36: Add, Edit, x630 y520 w190 h19  gVerifyEditBoxForDuplicates vVerifyValidChars3, %NewFilenameNoExt%
    Gui 36: Add, Edit, x676 y540 w144 h19  gVerifyEditBoxForDuplicates vVerifyValidChars4, %NewFilenameNoExt%-%SavedTime2%

    Gui 36: Add,  text, x382 y522 ,.
    Gui 36: Add,  Edit, x387 y520 w34 h19 vExtEditbox1 ReadOnly,%ext%
    Control_Colors("ExtEditbox1", "Set", "0xC0C0C0", "0x000000")
   
    Gui 36: Add,  text, x382 y542 ,.
    Gui 36: Add,  Edit, x387 y540 w34 h19 vExtEditbox2 ReadOnly,%ext%
    Control_Colors("ExtEditbox2", "Set", "0xC0C0C0", "0x000000")

    Gui 36: Add,  text, x821 y522 ,.
    Gui 36: Add,  Edit, x826 y520 w34 h19 vExtEditbox3 ReadOnly,%ext%
    Control_Colors("ExtEditbox3", "Set", "0xC0C0C0", "0x000000")

    Gui 36: Add,  text, x821 y542 ,.
    Gui 36: Add,  Edit, x826 y540 w34 h19 vExtEditbox4 ReadOnly,%ext%
    Control_Colors("ExtEditbox4", "Set", "0xC0C0C0", "0x000000")

    Gui 36: Add, GroupBox, x16 y80 w420 h525 , Original
    Gui 36: Add, GroupBox, x456 y80 w420 h525 , Duplicate

    Gui 36: Add, Button, x756 y630 w120 h20 g36GuiClose, Apply && Close
    Gui 36: Add, text, x17 y610 ,How To Handle Duplicates is set for "Ask What To Do When Duplicates Are Found"
    Gui 36: Add, text, x17 y630 vClickHere ,This setting can be changed via the System tray icon, Settings, then Additional Settings or click
    
    Gui 36: Add, text, x470 y630 gAdditionalSettingsMenu hwndHWND_HowToHandleDuplicatesClickHere cblue,HERE

    Gui 36: Add, text,x170 y280 ,Generating preview...
    Gui 36: Add, text,x608 y280 ,Generating preview...
      
    Gui 36: color,%DuplicateExistsGuiColor%                                                   
    
    GuiControl, 36:Hide, static3
    GuiControl, 36:Hide, static4

    Gui 36: Show, w899 h670, Duplicate Exists ;do not want to hide then show gui when it is done add all the text, due to needing Generating preview to be visible.
    
    WinGet,DuplicateExistsID,ID,Duplicate Exists
    
    GuiControlGet,HowToHandleDuplicatesClickHere,Pos,ClickHere
    
    if Dpi <> 96
     ControlMove,,HowToHandleDuplicatesClickHereW+25,HowToHandleDuplicatesClickHereY+30,,,ahk_id %HWND_HowToHandleDuplicatesClickHere% ;move Here text
    else
     {
      if a_osversion = win_xp ;for some reason 96 dpi on winxp put "Here" higher up on the screen then the 96 dpi on vista or win7
        ControlMove,,HowToHandleDuplicatesClickHereW+25,HowToHandleDuplicatesClickHereY+30,,,ahk_id %HWND_HowToHandleDuplicatesClickHere%
      else
       ControlMove,,HowToHandleDuplicatesClickHereW+25,HowToHandleDuplicatesClickHereY+25,,,ahk_id %HWND_HowToHandleDuplicatesClickHere%
     }
    
    if ( OriginalWidth < 381 and OriginalHeight < 381 )
     GuiControl,36:,Static3, *w%OriginalWidth% *h%OriginalHeight% %CurrentPath%\%NewFilename%
    else
     {
      if ( OriginalWidth = OriginalHeight or OriginalWidth > OriginalHeight )
       GuiControl,36:,Static3, *w380 *h-1 %CurrentPath%\%NewFilename%
      if OriginalWidth < %OriginalHeight%
       GuiControl,36:,Static3, *h380 *w-1 %CurrentPath%\%NewFilename%
     }

     if ( DuplicateWidth < 381 and DuplicateHeight < 381 )
     GuiControl,36:,Static4, *w%DuplicateWidth% *h%DuplicateHeight% %A_ScriptDir%\TempFolder\%FilenameOnDisk%
    else
     {
      if ( DuplicateWidth = DuplicateHeight or DuplicateWidth > DuplicateHeight )
       GuiControl,36:,Static4, *w380 *h-1 %A_ScriptDir%\TempFolder\%FilenameOnDisk%
      if DuplicateWidth < %DuplicateHeight%
       GuiControl,36:,Static4, *h380 *w-1 %A_ScriptDir%\TempFolder\%FilenameOnDisk%
     }
     
    GuiControlGet, Original, 36:Pos, Static3
    OriginalLeftXPos :=   ( ( (418 - OriginalW) / 2 ) + 20 ) - 3
    OriginalLeftYpos := ( ( (413 - OriginalH) / 2 ) + 117)  
    OriginalLeftXPos := Floor(OriginalLeftXPos)
    OriginalLeftYPos := Floor(OriginalLeftYPos)

    GuiControlGet, Duplicate, 36:Pos, Static4
    DuplicateRightXPos :=   ( ( (418 - DuplicateW) / 2 ) + 460 ) - 3
    DuplicateRightYpos :=  (((413 - DuplicateH) / 2 ) + 117) 
    DuplicateRightXPos := Floor(DuplicateRightXPos)
    DuplicateRightYPos := Floor(DuplicateRightYPos) 
      
    ControlMove, static3, %OriginalLeftXPos%, %OriginalLeftYPos%, , , ahk_id %DuplicateExistsID%
    ControlMove, static4, %DuplicateRightXPos%, %DuplicateRightYPos%, , , ahk_id %DuplicateExistsID%
    GuiControl, 36:Hide, static12
    GuiControl, 36:Show, static3
    GuiControl, 36:Hide, static13
      
    OriginalSizeYPos := ( OriginalLeftYpos + OriginalH - 20 )
    DuplicateSizeYPos := ( DuplicateRightYpos + DuplicateH -20 )
      
    if ErrorRetrievingOriginalFileInformation = 0
     {
      OriginalSizeForDisplayW = %OriginalWidth%
      OriginalSizeForDisplayH = %OriginalHeight%
      Gui 36: Add, Text, x%OriginalLeftXPos% y%OriginalSizeYPos%  , Actual Size:  w%OriginalSizeForDisplayW% x h%OriginalSizeForDisplayH%
     }
    else
     Gui 36: Add, Text, x%OriginalLeftXPos% y%OriginalSizeYPos%  , Actual Size:  Unknown
    if ErrorRetrievingDuplicateFileInformation = 0
     {
      DuplicateSizeForDisplayW = %OriginalWidth%
      DuplicateSizeForDisplayH = %OriginalHeight%
      Gui 36: Add, Text, x%DuplicateRightXPos% y%DuplicateSizeYPos%  , Actual Size:  w%DuplicateSizeForDisplayW% x h%DuplicateSizeForDisplayH%
     }
    else
     Gui 36: Add, Text, x%DuplicateRightXPos% y%DuplicateSizeYPos%  , Actual Size:  Unknown
      
    GuiControl, 36:Show, static4
    Gui 36: color, %DuplicateExistsGuiColor%
    ControlFocus,static1,ahk_id %DuplicateExistsID% ;prevent the first radio button having focus
    return
    
    VerifyEditBoxForDuplicates:
    gui 36: submit, nohide
    InvalidFileNameCharacters = \/:*?"<>|.
    Loop 4 
     {
      StringLen,len%a_index%,VerifyValidChars%a_index%
      len%a_index%--
      tempvar := Len%a_index%
      StringTrimLeft,VerifyValidChars%a_index%,VerifyValidChars%a_index%,%tempvar%
      tempvar := VerifyValidChars%a_index%
      if tempvar <>
      IfInString, InvalidFileNameCharacters, %tempvar%
       {
        MsgBox,4160,Invalid Character, ( %tempvar% ) is an invalid filename character.`nPlease try again.
        Send,{BS}
        return
       }
     }
    return

    ToggleCheck:
    MouseGetPos,x,y,w,Control
    StringTrimLeft,ControlNumber,Control,6
    if ControlNumber = 4 ;Uncheck button8
     { ;braces for code folding
      GuiControl,36:,Button8,0
     }
    if ControlNumber = 8 ;uncheck button4
     { ;braces for code folding
      GuiControl,36:,Button4,0
     }
    Loop 2              ;if ControlNumber = 1 or 2 put focus on editbox
     {
      if ControlNumber = %A_index%
       {
        If State%a_index% = 1
         {
          ControlFocus,edit%a_index%,ahk_id %DuplicateExistsID%
          send {shiftdown}{end}{ShiftUp}
         }
       }
     }
    if ControlNumber = 5 ;put focus on edit box
     {
      If State5 = 1
       {
        ControlFocus,edit3,ahk_id %DuplicateExistsID%
        send {shiftdown}{end}{ShiftUp}
       }
     }
    if ControlNumber = 6 ;put focus on edit box
     {
      If State6 = 1
       {
        ControlFocus,edit4,ahk_id %DuplicateExistsID%
        send {shiftdown}{end}{ShiftUp}
       }
     }
    return ;for ToggleCheck label
    36GuiClose:
    Gui 36: submit, nohide
    OriginalChoice1 = 0
    OriginalChoice2 = 0
    OriginalChoice3 = 0
    OriginalChoice4 = 0
    DuplicateChoice5 = 0
    DuplicateChoice6 = 0
    DuplicateChoice7 = 0
    DuplicateChoice8 = 0
    OriginalChoiceIsReadyToBeProcessed = 0
    DuplicateChoiceIsReadyToBeProcessed = 0
    NumberOfOriginalRadioButtonsChecked  := (CheckValue1 + CheckValue2 + CheckValue3 + CheckValue4)
    NumberOfDuplicateRadioButtonsChecked := (CheckValue5 + CheckValue6 + CheckValue7 + CheckValue8)
    if NumberOfOriginalRadioButtonsChecked = 0
     {
      MsgBox,4112,Original?, You must make a decison on what to do with the Original picture.
      return
     }
    if NumberOfDuplicateRadioButtonsChecked = 0
     {
      MsgBox,4112,Duplicate?, You must make a decison on what to do with the Duplicate picture.
      return
     }
    ;Original side of Ask What To Do gui are CheckValue 1 thru 4
    if ( CheckValue1 = 1 ) ;checks for blank editbox for left rename to user choice
     {
      if VerifyValidChars1 =
       {
        MsgBox,4112,Filename Error!, Filename can not be blank!`n`nPlease choose another filename for the "Original Picture"
        return
       }
      if CheckValue5 = 1
      if (VerifyValidChars1 = VerifyValidChars3 )  
       {
        MsgBox,4112,Filename Error, The Original and Duplicate filenames can not be the same
        return
       }
      if CheckValue6 = 1
      if (VerifyValidChars1 = VerifyValidChars4 )  
       {
        MsgBox,4112,Filename Error, The Original and Duplicate filenames can not be the same
        return
       }
      if (CheckValue5 = 1 or CheckValue6 = 1) ;now check to see if either are equal to the original filename
       {
        IsOriginalNameTheSame = 0
        
        if CheckValue5 = 1
         if VerifyValidChars3 = NewFileNameNoExt
          IsOriginalNameTheSame = 1
        if CheckValue6 = 1
         if VerifyValidChars4 = NewFileNameNoExt
          IsOriginalNameTheSame = 1
        
        if IsOriginalNameTheSame = 1
        if (VerifyValidChars1 = VerifyValidChars3 or VerifyValidChars1 = VerifyValidChars4 )
         {
          MsgBox,4112,Filename Error, The Original and Duplicate filenames can not be the same
          return
         }
       }
      If ( VerifyValidChars1 <> NewFilenameNoExt )
       {
        IfExist, %CurrentPath%\%VerifyValidChars1%.%ext%
         {
          MsgBox,4112,Filename not available!, Filename already exists in your "Save To" folder`n`nPlease choose another filename for the "Original Picture"
          return
         }
	   }
      if NumberOfDuplicateRadioButtonsChecked <> 0
       OriginalChoice1 = 1
     } ;If CheckValue = 1 ending brace
    
    if ( CheckValue2 = 1 ) ;checks for blank editbox for left DateTime 
     {
      if VerifyValidChars2 =
       {
        MsgBox,4112,Filename Error!, Filename can not be blank!`n`nPlease choose another filename for the "Original Picture"
        return
       }
      if CheckValue5 = 1
      if (VerifyValidChars2 = VerifyValidChars3 )  
       {
        MsgBox,4112,Filename Error, The Original and Duplicate filenames can not be the same
        return
       }
      if CheckValue6 = 1
      if (VerifyValidChars2 = VerifyValidChars4 )  
       {
        MsgBox,4112,Filename Error, The Original and Duplicate filenames can not be the same
        return
       }
      
      if (CheckValue5 = 1 or CheckValue6 = 1) ;now check to see if either are equal to the original filename
       {
        IsOriginalNameTheSame = 0
        if CheckValue5 = 1
         if VerifyValidChars3 = NewFileNameNoExt
          IsOriginalNameTheSame = 1
        if CheckValue6 = 1
         if VerifyValidChars4 = NewFileNameNoExt
          IsOriginalNameTheSame = 1
        if IsOriginalNameTheSame = 1
        if (VerifyValidChars2 = VerifyValidChars3 or VerifyValidChars2 = VerifyValidChars4 )
         {
          MsgBox,4112,Filename Error, The Original and Duplicate filenames can not be the same
          return
         }
       }
      if ( VerifyValidChars1 <> NewFilenameNoExt )
       {
        IfExist, %CurrentPath%\%VerifyValidChars2%.%ext%
         {
          MsgBox,4112,Filename not available!, Filename already exists in your "Save To" folder`n`nPlease choose another filename for the "Original Picture"
          return
         }
	   }
      if NumberOfDuplicateRadioButtonsChecked <> 0
       OriginalChoice2 = 1
     } ;if CheckValue2 = 1 ending brace
     
    if ( CheckValue3 = 1 and NumberOfDuplicateRadioButtonsChecked <> 0 ) ;delete original, only do this if 1 of the duplicate
     OriginalChoice3 = 1
    
    if ( CheckValue4 = 1 ) 
     OriginalChoice4 = 1 ;Leave file in destination folder alone

    if ( CheckValue5 = 1 ) ;rename to user choice
     {
      if VerifyValidChars3 =
       {
        MsgBox,4112,Filename Error!, Filename can not be blank!`n`nPlease choose another filename for the "Duplicate Picture"
        return
       }
      if ( VerifyValidChars1 = NewFilenameNoExt )
	   { 
        IsOriginalNameTheSame = 0
        if CheckValue1 = 1 or CheckValue2 = 1
         {
          if CheckValue1 = 1
           if VerifyValidChars1 = NewFileNameNoExt
            IsOriginalNameTheSame = 1
          if CheckValue2 = 1
           if VerifyValidChars2 = NewFileNameNoExt
            IsOriginalNameTheSame = 1
         
         if IsOriginalNameTheSame = 0
          IfExist, %CurrentPath%\%VerifyValidChars3%.%ext% 
          {
           MsgBox,4112,Filename not available!, Filename already exists in your "Save To" folder`n`nPlease choose another filename for the "Duplicate Picture"
           return
          }
         }
       }
      if NumberOfOriginalRadioButtonsChecked <> 0
       DuplicateChoice5 = 1
     }  ;if CheckValue5 ending brace
      
    if ( CheckValue6 = 1 ) ;rename with date and time
     {
      if VerifyValidChars4 =
       {
        MsgBox,4112,Filename Error!, Filename can not be blank!`n`nPlease choose another filename for the "Duplicate Picture"
        return
       }
      IsOriginalNameTheSame = 0
      if CheckValue1 = 1 or CheckValue2 = 1
       {
        if CheckValue1 = 1
         if VerifyValidChars1 = NewFileNameNoExt
          IsOriginalNameTheSame = 1
        if CheckValue2 = 1
         if VerifyValidChars2 = NewFileNameNoExt
          IsOriginalNameTheSame = 1
        if IsOriginalNameTheSame = 0
	     IfExist, %CurrentPath%\%VerifyValidChars4%.%ext%
          {
           MsgBox,4112,Filename not available!, Filename already exists in your "Save To" folder`n`nPlease choose another filename for the "Duplicate Picture"
           return
          }
       }
      if NumberOfOriginalRadioButtonsChecked <> 0
       DuplicateChoice6 = 1
     } ;if CheckValue6 = 1 ending brace
    
    if ( CheckValue7 = 1 and NumberOfOriginalRadioButtonsChecked <> 0 ) ;do not save duplicate picture - do not record history
     DuplicateChoice7 = 1
    
    if ( CheckValue8 = 1 and NumberOfOriginalRadioButtonsChecked <> 0 ) ;save with same filename, ;only do this if 1 of the 
     DuplicateChoice8 = 1
    
    OriginalChoiceIsReadyToBeProcessed := ( OriginalChoice1 + OriginalChoice2 + OriginalChoice3 + OriginalChoice4 )
    DuplicateChoiceIsReadyToBeProcessed := ( DuplicateChoice5 + DuplicateChoice6 + DuplicateChoice7 + DuplicateChoice8)

    if (OriginalChoiceIsReadyToBeProcessed > 0 and DuplicateChoiceIsReadyToBeProcessed > 0 )
     {
      if OriginalChoice1 = 1
       {
        ;xxx need to fix this because moving a file onto itself is always considered successful
        FileMove,%CurrentPath%\%NewFileName%,%CurrentPath%\%VerifyValidChars1%.%ext%,1
        if errorlevel <> 0
         {
          Gui 36: destroy
          MsgBox,4112,Error [1006],An error occured and your picture could not be saved.
          return
         }
       }

      if OriginalChoice2 = 1
       {
        ;xxx need to fix this because moving a file onto itself is always considered successful
        FileMove,%CurrentPath%\%NewFileName%,%CurrentPath%\%VerifyValidChars2%.%ext%,1
        if errorlevel <> 0
         {
          Gui 36: destroy
          MsgBox,4112,Error [1007],An error occured and your picture could not be saved.
          return
         }
       }

      if OriginalChoice3 = 1
       FileDelete, %CurrentPath%\%NewFileName%

      ;If OriginalChoice4 = 1 
      ;Leave file in destination folder alone
  
      if DuplicateChoice5 = 1
       {
        FileMove,%A_ScriptDir%\TempFolder\%FilenameOnDisk%,%CurrentPath%\%VerifyValidChars3%.%ext%,1
        if errorlevel <> 0
         {
          Gui 36: destroy
          MsgBox,4112,Error [1008],An error occured and your picture could not be saved.
          return
         }
        NewFilename := ( VerifyValidChars3 "." ext )
        ;NewFilename = %VerifyValidChars3%.%ext%
       }

      if DuplicateChoice6 = 1
       {
        FileMove,%A_ScriptDir%\TempFolder\%FilenameOnDisk%,%CurrentPath%\%VerifyValidChars4%.%ext%,1
        if errorlevel <> 0
         {
          Gui 36: destroy
          MsgBox,4112,Error [1009],An error occured and your picture could not be saved.
          return
         }
        NewFilename := ( VerifyValidChars4 "." ext )
        ;NewFilename = %VerifyValidChars4%.%ext%
       }

      if DuplicateChoice7 = 1
       {
        RecordHistory = 0
        DoNotRecordLastPictureSavedInformation = 1
        FileDelete, %a_scriptdir%\TempFolder\%FilenameOnDisk%
       }
      
      if DuplicateChoice8 = 1
       {
        FileMove, %a_scriptdir%\TempFolder\%FilenameOnDisk%,%CurrentPath%\%NewFileName%  
        if errorlevel <> 0
         {
          Gui 36: destroy
          MsgBox,4112,Error [1010],An error occured and your picture could not be saved.
          return
         } ;NewFilename has not changed. So no need to do NewFilename = 
       }
     } ;if (OriginalChoiceIsReadyToBeProcessed > 0 and DuplicateChoiceIsReadyToBeProcessed > 0 )
    Gui 36: destroy
    gosub continue1
    return ;return required
   } ;if AskHowToHandleDuplicates = 1 ending brace
  If DoNotSaveDuplicates = 1                ;notify msgbox is after Done message      
   {
    FileDelete, %a_scriptdir%\TempFolder\%FilenameOnDisk%
    DoNotRecordLastPictureSavedInformation = 1
    RecordHistory = 0
   }
  If AlwaysOverwrite = 1                    ;notify msgbox is after Done message
   { 
    FileDelete,%CurrentPath%\%NewFilename%
    FileMove, %A_ScriptDir%\TempFolder\%FilenameOnDisk%,%CurrentPath%\%NewFilename%
    if errorlevel <> 0
     {
      MsgBox,4112,Error [1011],An error occured and your picture could not be saved.
      return
     }
   }
  If SaveDuplicatesWithRandomNumber = 1     ;notify msgbox is after Done message
   {
    SplitPath,NewFilename,,,OutExtension,OutNameNoExt
    GetNewRandomNumber: 
    Random, Number, 0, 999999
    IfExist, %CurrentPath%\%OutNameNoExt%%Number%.%OutExtension%
     goto GetNewRandomNumber
    else
     NewFilename := ( OutNameNoExt Number "." OutExtension )
     ;NewFilename = %OutNameNoExt%%Number%.%OutExtension%
     FileMove, %A_ScriptDir%\TempFolder\%FilenameOnDisk%,%CurrentPath%\%NewFilename%
    if errorlevel <> 0
     {
      MsgBox,4112,Error [1012],An error occured and your picture could not be saved.
      return
     }
   }
  If AddDateAndTimeWhenDuplicateIsFound = 1 ;notify msgbox is after Done message
   {
    IniRead,SeparatorOptionDuplicates,spaconfig.ini,DateTimeFormat,SeparatorOptionDuplicates,%a_space%   ;separatorOption,%A_Space%
    if SeparatorOptionDuplicates = SeparatorOptionDuplicates
     {
      FormatTime, DateTimeFormat7a, ,yyyyMMdd ;this is for format7
      FormatTime, DateTimeFormat7b, ,hhmmss  ;this is for format7
      IniRead,SeparatorCharDuplicates,SpaConfig.ini,DatetimeFormat,SeparatorCharDuplicates,- ;this is for format7 separator option
      FormattedTime := ( DateTimeFormat7a SeparatorCharDuplicates DateTimeFormat7b )
     }
    else
     {
      IniRead,DateTimeFormatDuplicates,SpaConfig.ini,DateTimeFormat,Duplicates
      FormatTime, FormattedTime, ,%DateTimeFormatDuplicates%
     }
    StringReplace,FormattedTime,FormattedTime,:,%a_space%
    SplitPath,NewFilename,,,OutExtension,OutNameNoExt
    NewFilename = ( OutNameNoExt "-" FormattedTime "." OutExtension )
    ;NewFilename = %OutNameNoExt%-%FormattedTime%.%OutExtension%
    FileMove, %A_ScriptDir%\TempFolder\%FilenameOnDisk%,%CurrentPath%\%NewFilename%
    if errorlevel <> 0
     {
      MsgBox,4112,Error [1013],An error occured and your picture could not be saved.
      return
     }
   }
  continue1:
  gosub continue
  return ;return required
 } ;else (IfNotExist, %CurrentPath%\%NewFilename%) which is How to handle duplicates example Ask, Do not save, Save with random number, add date and time

continue:

if ( TurnOffRecordingOfTheLastSavedPicture <> 1 and DoNotRecordLastPictureSavedInformation <> 1 ) ;DoNotRecordLastPictureSavedInformation is to temporary turn off recording of last saved picture.
 {
  LastSavedPicture = %CurrentPath%\%NewFilename%
  IniWrite,%LastSavedPicture%,SpaConfig.ini,history,LastSavedPicture
 }
MyList =
if ( HistoryValue = "ENABLED" and RecordHistory = 1 ) ;update history / RecordHistory is needed due to Duplicate not being saved
 {                                                                      ;with "AskHowToHandleDuplicate"
  HistoryFilename :=  ( CurrentPath "\" NewFilename )
    ;need to compare History1 to HistoryFilename
  ;if exactly the same then don't adjust counter and read the next line (replace a_index with counter) (number of lines will equal counter)
  SkipHistory = 0
  loop %MaxHistoryMenuPicturesToList% ;read and clear history until blank line
   {
    iniread, History%a_index%, SpaConfig.ini, History, History%a_index%,%a_space%
    if History1 = %HistoryFilename%
     {
      SkipHistory = 1
      break
     }
    if History%a_index% =
     break
    numberoflines := a_index
    ;xxx need to determine if writing a space here is needed.
    IniWrite,%A_Space%,SpaConfig.ini,history,history%a_index%
   }
  If SkipHistory = 1
   goto SkipHistory
  NumberOfLines++
  if NumberOfLines > %MaxHistoryMenuPicturesToList% 
   NumberOfLines = %MaxHistoryMenuPicturesToList%
  loop %NumberOfLines%  ;write history back
   {
    if a_index = 1
     IniWrite, %HistoryFilename%, SpaConfig.ini, History, History%a_index%
    else
     {
      AddNextLine := (a_index-1)
      IniWrite, % History%AddNextLine%, SpaConfig.ini, History, History%a_index% 
     }
   }
  IfWinExist, ahk_id %HistoryID% ;update history window
   {
    controlget,MyList,list,,listbox1,ahk_id %HistoryID%
    StringTrimLeft,MyList,MyList,65
    Mylist := ( "Use arrow keys to scroll through the pictures to view them below" "`n" HistoryFilename "`n" Mylist ) ;add last downloaded image to MyList
    SendMessage, 0x188, 0, 0, ListBox1, ahk_id %HistoryID% ;need to position highlight line after saving history
    CurrentLineSelected = %ErrorLevel% 
    CurrentLineSelected++ 
    guicontrol, 3:,listbox1, |    ;blanks listbox
    Loop, Parse, mylist ,`n,`r  ;retrieve 1 line at a time
     {
      if ( a_index < MaxHistoryMenuPicturesToList + 2 )
      GuiControl, 3:, ListBox1, %A_LoopField%  ;add one line at a time back to listbox
     }
    If CurrentLineSelected <> 1
     CurrentLineSelected++ 
    if CurrentLineSelected > %MaxHistoryMenuPicturesToList%
     CurrentLineSelected := ( MaxHistoryMenuPicturesToList + 1 ) ;this is needed when the currently highlighted line is deleted due to max history menu pictures to list has been reached.
    GuiControl, 3: Choose, listbox1, %CurrentLineSelected%       ;(MaxHistoryMenuPicturesToList + 1 is always the last picture, which is the picture that is being deleted)
    Gosub ViewHistoryItems  
   }
 } ;end brace if HistoryValue = ENABLED ;update history 
SkipHistory:
if ErrorLogging = 1 ;this done after the picture is saved and should not affect performance on next picture save
 gosub TrimErrorLog 

if ConfirmationMessageValue = ENABLED  ;Done message
 {
  if PlaceConfirmationMessageAtMousePosition = 1
   {
    CoordMode, Mouse,screen
    MouseGetPos,ConfirmationMessageXpos,ConfirmationMessageYpos
    ConfirmationMessageXpos := (ConfirmationMessageXpos-50)
    ConfirmationMessageYpos := (ConfirmationMessageYpos-50)
   }
  
  if ( ConfirmationMessageXpos = "" or ConfirmationMessageYpos = "" )
   {
    ConfirmationMessageXpos := ((A_ScreenWidth/2)-100)
    ConfirmationMessageypos := ((A_ScreenHeight/2)-100)
   }
  Gui 17: Show, x%ConfirmationMessageXpos% y%ConfirmationMessageYpos% , Confirmation Message
  sleep %ConfirmationMessageDelay%
  Gui 17: Hide
  CoordMode, Mouse,Relative
 }

if ( FoundDuplicate = 1 and DonotSaveDuplicates = 1 and DoNotSaveDuplicatesAndNotifyMe = 1 and HashValuesAreTheSame <> 1 )
  MsgBox,4160, Found Duplicate, %FilenameOnDisk% already exists in %CurrentPath%`n`nSavePictureAs is set to not save duplicates and notify me.`n`nThis can be changed by clicking on the system tray icon and selecting Settings then Additional Settings.

if ( FoundDuplicate = 1 and AlwaysOverwrite = 1 and AlwaysOverwriteAndNotifyMe = 1 and HashValuesAreTheSame <> 1 )
 MsgBox,4160, Found Duplicate, %FilenameOnDisk% already existed in %CurrentPath% and was overwritten.`n`nSavePictureAs is set to overwrite duplicates.`n`nThis setting can be changed by clicking on the system tray icon and selecting Settings then Additional Settings.
  
if ( FoundDuplicate = 1 and SaveDuplicatesWithRandomNumber = 1 and SaveDuplicatesWithRandomNumberAndNotifyMe = 1 and HashValuesAreTheSame <> 1 )
 MsgBox,4160, Found Duplicate, %FilenameOnDisk% already exists in %CurrentPath%`n`nSavePictureAs is set to "Save Duplicates With A Random Number" added to the filename.`n`nThis picture was saved as (%NewFilename%).`n`nThis setting can be changed by clicking on the system tray icon and selecting Settings then Additional Settings.

if ( FoundDuplicate = 1 and AddDateAndTimeWhenDuplicateIsFound = 1 and AddDateAndTimeWhenDuplicateIsFoundAndNotifyMe = 1 and HashValuesAreTheSame <> 1 )
 MsgBox,4160, Found Duplicate, %FilenameOnDisk% already exists in %CurrentPath%`n`nSavePictureAs is set to "Save Duplicates by Adding the Date and Time" to the filename.`n`nThis picture was saved as (%NewFilename%).`n`nThis setting can be changed by clicking on the system tray icon and selecting Settings then Additional Settings.

if ( FoundDuplicate = 1 and HashValuesAreTheSame = 1 and CheckForIdenticalHashValuesAndNotifyMe = 1 )
 MsgBox,4160, Found Duplicate, %FilenameOnDisk% already exists in %CurrentPath%`n`nSavePictureAs is set to "Check for Identical Picture using MD5 algorithm"`n`nThis picture was not saved.`n`nThis setting can be changed by clicking on the system tray icon and selecting Settings then Additional Settings.

GoSub, UpdateCheckForUpdatesDailyTimer
return
Wait3SecondsCloseTraytip:
sleep 3000
traytip
return

64GuiClose: ;UserInput Date & Time UserInput Original Filename gui
RecordHistory = 0
GuiWasCanceled = 1
FileDelete,%a_scriptdir%\TempFolder\%FileName%
Gui 64: destroy
return
64GuiSubmit:
Gui 64: submit,nohide
Gui 64: destroy
return

65GuiClose: ;Prompt For Picture Name gui
FileDelete,%a_scriptdir%\TempFolder\%FileName%
RecordHistory = 0
GuiWasCanceled = 1
Gui 65: destroy
return
65GuiSubmit:
Gui 65: submit,nohide
Gui 65: destroy
return

66GuiClose: ;Use Above Options AND Prompt for Filename gui. If this is canceled then need to return Sequencial numbers back to 1 less if FilenameFormat is 3,4 or 9 which all have sequencial numbers.
FileDelete,%a_scriptdir%\TempFolder\%FileName%
RecordHistory = 0
GuiWasCanceled = 1
Gui 66: destroy
if FilenameFormat = 3
 {
  IniRead,Tempvar,Spaconfig.ini,NamingConvention,Sequential1,2 ;if the key can not be read then set to 2 so that TempVar-- will return it to 1
  TempVar--
  IniWrite,%TempVar%,Spaconfig.ini,NamingConvention,Sequential1
 }
if FilenameFormat = 4
 {
  IniRead,Tempvar,Spaconfig.ini,NamingConvention,Sequential2,2
  TempVar--
  IniWrite,%TempVar%,Spaconfig.ini,NamingConvention,Sequential2
 }
if FilenameFormat = 9
 {
  IniRead,Tempvar,Spaconfig.ini,NamingConvention,Sequential3,2
  TempVar--
  IniWrite,%TempVar%,Spaconfig.ini,NamingConvention,Sequential3
 }
return
66GuiSubmit:
Gui 66: submit,nohide
Gui 66: destroy
return
CheckForInvalidCharUserInput1:
Gui 64: submit, nohide
StringSplit,UserInput1CharArray, UserInput1
Loop %UserInput1CharArray0%
 {
  if UserInput1CharArray%a_index% in \,/,:,*,?,",<,>,|,.                                                   
   {
    FoundInvalidChar = 1
    InvalidCharIS := ( UserInput1CharArray%a_index% )
    break
   }
 }
if FoundInvalidChar = 1
 {
  if InvalidCharIS = .
    MsgBox,4160,Invalid Character,SavePictureAs does not support ( %InvalidCharIS% ) as a valid filename character.`nPlease try again. 
  else
    MsgBox,4160,Invalid Character,( %InvalidCharIS% ) is an invalid filename character.`nPlease try again. 
  Send,{BS}
 }
Loop %UserInput1CharArray0%
 UserInput1CharArray%a_index% =
FoundInvalidChar = 
InvalidCharIS =
return
CheckForInvalidCharUserInput2:
Gui 64: submit, nohide
StringSplit,UserInput2CharArray, UserInput2
Loop %UserInput2CharArray0%
 {
  if UserInput2CharArray%a_index% in \,/,:,*,?,",<,>,|,.                                                   
   {
    FoundInvalidChar = 1
    InvalidCharIS := ( UserInput2CharArray%a_index% )
    break
   }
 }
if FoundInvalidChar = 1
 {
  if InvalidCharIS = .
    MsgBox,4160,Invalid Character,SavePictureAs does not support ( %InvalidCharIS% ) as a valid filename character.`nPlease try again. 
  else
    MsgBox,4160,Invalid Character,( %InvalidCharIS% ) is an invalid filename character.`nPlease try again. 
  Send,{BS}
 }
Loop %Len%
 UserInput2CharArray%a_index% =
FoundInvalidChar = 0
InvalidCharIS =
return
CheckForInvalidCharPromptForFilename:
Gui 65: submit, nohide
StringSplit,PromptForFilenameCharArray, PromptForFilenameFilename
Loop %PromptForFilenameCharArray0%
 {
  if PromptForFilenameCharArray%a_index% in \,/,:,*,?,",<,>,|,.                                                   
   {
    FoundInvalidChar = 1
    InvalidCharIS := ( PromptForFilenameCharArray%a_index% )
    break
   }
 }
if FoundInvalidChar = 1
 {
  if InvalidCharIS = .
    MsgBox,4160,Invalid Character,SavePictureAs does not support ( %InvalidCharIS% ) as a valid filename character.`nPlease try again. 
  else
    MsgBox,4160,Invalid Character,( %InvalidCharIS% ) is an invalid filename character.`nPlease try again. 
  Send,{BS}
 }
Loop %Len%
 PromptForFilenameCharArray%a_index% =
FoundInvalidChar = 0
InvalidCharIS =
return
CheckForInvalidCharUseAboveOptionsAndPromptForFilename:
Gui 66: submit, nohide
StringSplit,UseAboveOptionsAndPromptForFilenameCharArray, UseAboveOptionsAndPromptForFilenameFilename
Loop %UseAboveOptionsAndPromptForFilenameCharArray0%
 {
  if UseAboveOptionsAndPromptForFilenameCharArray%a_index% in \,/,:,*,?,",<,>,|,.                                                   
   {
    FoundInvalidChar = 1
    InvalidCharIS := ( UseAboveOptionsAndPromptForFilenameCharArray%a_index% )
    break
   }
 }
if FoundInvalidChar = 1
 {
  if InvalidCharIS = .
    MsgBox,4160,Invalid Character,SavePictureAs does not support ( %InvalidCharIS% ) as a valid filename character.`nPlease try again. 
  else
    MsgBox,4160,Invalid Character,( %InvalidCharIS% ) is an invalid filename character.`nPlease try again. 
  Send,{BS}
 }
Loop %Len%
 UseAboveOptionsAndPromptForFilenameCharArray%a_index% =
FoundInvalidChar = 0
InvalidCharIS =
return
TrimErrorLog:
;{
IniRead,MaxErrorLogSize,SpaConfig.ini,ErrorLog,MaxErrorLogSize,200
Loop, Read, LogFile.txt ;get total line count - no need to store all lines in variables unless over 200 lines
 TotalLines = %a_index%
if TotalLines > %MaxErrorLogSize%
 {
  traytip,Preparing ErrorLog,%a_space%,15
  FileRead,AllLines,LogFile.txt
  AllLines:=RegExReplace(AllLines,"\s*$","") ;remove all blank lines from end of varible AllLines
  Loop, Parse, AllLines ,`n,`r
   {
    if a_loopfield =
     {
      If A_index <> 1
       {
        FoundBlankLine = %a_index%
		NewLength := ( TotalLines - FoundBlankLine )
        if ( NewLength < MaxErrorLogSize )
         {
          FirstBlankLine = %FoundBlankLine%
          break
         } ;if ( NewLength < MaxErrorLogSize )
	   } ;if a_index <> 1
	 } ;if a_loopfield =
   } ;loop pase
 } ;if totallines > maxerrorlogsize
 else
  return
 FileDelete,LogFile.txt
 Loop, Parse, AllLines ,`n,`r 
  {
   If A_index > %FirstBlankLine%
    FileAppend,%A_LoopField%`n,LogFile.txt
  }
TrayTip
Return
;}
KMeleon:
IfWinExist, `% of %Filename%
 {
  CloseKMeleonDownloadDialog:
  WinGet,KMeleonDownloadDialogId,id,`% of %Filename%
  sleep 50
  WinClose, ahk_id %KMeleonDownloadDialogId%
  WinWaitClose, ahk_id %KMeleonDownloadDialogId%,,1
  if ErrorLevel = 1
   goto CloseKMeleonDownloadDialog
  SetTimer,KMeleon,off
 }
return 
;********************************************************************************************************************************
;**************************************************End Save Picture Section******************************************************
;********************************************************************************************************************************
;================================================================================================================================
;===================================================Menu Tray Labels=============================================================
;================================================================================================================================
OpenDefaultFolder:
IniRead,DefaultPath,SpaConfig.ini,DefaultPath,path,%A_PicturesSF%
IfExist, %DefaultPath%
 Run, Explorer %DefaultPath%
else
 MsgBox,4112,Error [1112], SavePictureAs can not find your chosen Picture Location folder.....`n`n%DefaultPath%
Return
;*****************************************************************************************************
;Program Documentation 
;*****************************************************************************************************
ProgramDocumentation:
IfWinExist, ahk_id %PDID%
 {
  WinRestore,ahk_id %PDID%
  Sleep 10
  ControlFocus,edit1,ahk_id %PDID% ;trying to prevent the text in the edit box from being highlighted when first loaded.
  ControlClick,edit1,ahk_id %PDID%
  return
 } 
iniread, ProgramDocumentationColorGuiVar, SpaConfig.ini, SystemColors, ProgramDocumentationColorGuiVar,7995B0
iniread, ProgramDocumentationColorEditboxVar, SpaConfig.ini, SystemColors, ProgramDocumentationColorListboxVar,c0c0c0
StringSplit,Array,ProgramDocumentationColorEditBoxVar
ProgramDocumentationColorEditBoxVar := (Array5 Array6 array3 Array4 array1 Array2)
iniread, ProgramDocumentationColorEditboxTextVar, SpaConfig.ini, SystemColors, ProgramDocumentationColorListboxTextVar,000000
StringSplit,Array,ProgramDocumentationColorEditBoxTextVar
ProgramDocumentationColorEditBoxTextVar := (Array5 Array6 array3 Array4 array1 Array2)
ProgramDocumentationTextVar1 =
(
SavePictureAs easily saves pictures from the web using a web browser.
   
         * Supports Windows XP, Vista and Windows 7 using...
           Internet Explorer, Firefox, Opera, Maxthon, Safari, RockMelt, K-Meleon, Comodo Dragon, Avant, Yandex, Slim Browser
           and Google Chrome.

         * Windows 8 was in Desktop mode when testing SavePictureAs.

Quick Tutorial
         * Place mouse cursor over picture in one of the supported web browsers.

         * Press Ctrl and the Spacebar or user defined keys and the picture will be saved to the folder you chose during setup or from the system tray icon.
          
         * Click on "Configure Hotkeys and Folders" via the system tray icon to configure up to 10 Favorite Folders & Hotkeys 
           and the "Default Hotkey" & "Default Folder"

         * Use the system tray icon to launch the Favorites Toolbar. 
           Leave the Favorites Toolbar open and you can quickly change the "Default Folder" associated wth the "Default Hotkey" by clicking on 
           one of the 10 Favorite Folder buttons. 

         * Use the system tray icon to launch menu to change screen & text colors.
         
         * Use the system tray icon to launch the history screen to view, delete, rename or copy the last %MaxHistoryMenuPicturesToList% pictures saved. 
           This number can be changed to virtually any number via the Additional Settings Menu.

         * Use the system tray icon to disable the Confirmation Message or history.

         * Check out the Additional Settings menu via the system tray icon for many more options.

         * Exit the program by clicking the system tray icon. 

Version History
       Version 1.0 - Original program
         1) copies pictures in internet explorer by placing mouse over picture and using hotkeys Ctrl Space.
         2) saves files in location defined in SavePictureAs-CtrlSpace.ahk. 
         3) only tested in Windows XP  

       Version 2.0 - Minor Update
         1) created setup.ahk to allow user to select location to save pictures.
  
       Version 2.1 - Minor Update
         1) merged setup.ahk into SavePictureAs-CtrlSpace.ahk.   

       Version 2.2 - Minor Update
         1) added code to prevent program from hanging when trying to save a picture that does not have the "Save Picture As"  context menu.

       Version 2.3 - Minor update
         1) added code to block user input (mouse and keyboard)  during code execution   
         2) added code to clear clipboard to prevent user copied clipboard content from interferring with program   
         3) renamed filepath.ini to spafilepath.ini because other programs use filepath.ini   
         4) added title bars for dialog boxes. IE (Help, about...)   
         5) changed code, now during inital setup when the user clicks on cancel instead of choosing a picture location folder the program exits
         6) added showonce.txt so user would be able to see splash screen again   
         7) changed code so that the picture location path is not blank when the user chooses to cancel the picture location select menu
         8) added code to check to see if the current "save picture as" folder exists at program startup. 
            If the folder does not exist the program prompts user to select another one.

       Version 3.0 - Major update
         1) added Confirmation Message that displays when a picture has being saved and added option to disable the Confirmation  Message
         2) added Confirmation Message enabled/disabled status balloon to system tray, and the ability to change the colors for the Confirmation Message.
         3) program does not use spafilepath.ini or showsplash.txt anymore, uses SpaConfig.ini for all user settings.
            The program will create SpaConfig.ini with default settings if it does not exist.  
         4) added ability to keep a history of pictures saved  
         5) made the menu on the system tray open with left or right click  
         6) changed system tray icon from the green H to an icon showing a couple in a hot tub (aka SPA) Save Picture As.  
         7) added "Rename Last Picture", it also updates the history to reflect the new filename.  

       Version 4.0 - Major Update
         1) added Last Saved Picture Menu to system tray menu
            Last Saved Picture Menu includes...
             A) View, Delete, Move, Copy & Rename last saved picture
         2) added Splash Screen to system tray menu.
         3) redesigned menus and display screens
         4) added menu to change screen and text colors
         5) added Reset All Settings to tray menu
         6) added picture preview to the history screen
         7) added Saved picture locations Favorites Toolbar
 
       Version 5.0 - Major Update
         1) added ability to save pictures using Firefox, Opera, and Google Chrome
         2) added ability to save pictures using Windows Vista and Windows 7
 
       Version 5.1 - Minor Update
         1) changed the way firefox saves pictures
         2) made the History Menu, Program Documentation, Help Screen and Favorites Toolbar configuration windows resizable. (removed in later versions)
         3) Added Rename, Move and Copy buttons to History Menu
         4) Removed Last Saved Picture Menu. The last saved picture can be viewed on the History Menu

       Version 5.2 - Minor Update
         1) minor bug fixes - removed some message boxes used for troubleshooting

       Version 5.3 - Minor Update
         1) add minimum size to the history window. Needed minimum size to display properly

       Version 5.4 - Minor Update
         1) Now if original extension was already in the edit1 control on Save Picture/Image As window then use that one, otherwise do not add extension to filename

       Version 5.5 - Minor Update
         1) Now checks to see if user is administrator. 
            Windows 7 needs SavePictureAs to Run As Administrator due to SavePictureAs features to Move, Delete, Rename and Copy options on the History Menu.

       Version 5.6 - Minor Update
         1) Fixed minor bug if the folder chosen to save pictures to does not exist

       Version 5.7 - Minor Update
         1) Added Prompt for Filename. Now when enabled the image being saved can be given a user specified filename.
         2) Added "Check For Updates" on startup and tray menu. (Default - Checks for updates on startup)

       Version 5.8 - Minor Update
         1) Added ability to view changes when a new version is available

       Version 5.9 - Minor Update
         1) Fixed issue with Firefox using different window classes across OS platforms

       Version 6.0 - Minor Update
         1) Found an issue with not being able to position the Confirmation Window

       Version 6.1 - Minor Update
         1) Removed Run As Admin and choose instead to display a message explaining UAC may prevent moving and renaming pictures

       Version 6.2 - Minor Update
         1) Fixed issue with Google Chrome not saving images in certains conditions.

       Version 6.3 - Minor Update
         1) Fixed issue with Windows 7 and Firefox not able to verify image was successfully saved

       Version 6.4 - Minor Update
         1) Fixed issue with decimals places in History Gui X,Y, W and H values

       Version 6.5 - Minor Update
         1) Fixed Google Chrome window class

       Version 6.6 - Minor Update
         1) Found a stray comma preventing Favorites Toolbar number 2 from saving the users choice
         2) Used Floor(var) to fix a script calculated gui width with decimal places

       Version 6.7 - Minor Update
         1) Added Error Logging
         2) Redesigned "About" box

       Version 6.8 - Minor Update
         1) Changed SavePictureAs_Update.exe to SavePictureAs_Update.bat

       Version 6.9 - Minor Update
         1) Added user defined hotkeys for Save Picture As, Rename last saved picture and all 5 Favorite Folder Toolbar buttons

       Version 7.0 - Minor Update
         1) Changed the update process to be the same for SavePicturAs.ahk as it is for SavePictureAs.exe

       Version 8.0 - Major Update
         1) Added support for Maxthon, Safari and RockMelt
         2) How To Handle Duplicates
             A) "Ask What To Do" when duplicates are found displays both pictures with the following 4 options (Default)
                a) Rename one or both
                b) Delete one or both
                c) Add Date & Time to one or both
                d) Keep original filename for one picture and apply one of the above options for the other picture
             B) Do not save duplicates with option to be notified when this happens
             C) Always overwrite with option to be notified when this happens
             D) Save duplicates by adding a Random Number to the filename with option to be notified when this happens
             E) Save duplicates by adding the Date & Time with option to be notified when this happens

         3) Filenaming Convention (automatically name saved picture to one of the following)
             A) Date and Time (choose from 6 options on format of Date And Time)
             B) Filename-Date and time
             C) Sequential Number
             D) Filename-Sequential Number
             E) Random Number
             F) Filename-Random Number
             G) Original Filename (Default)
             H) Option to add a prefix or suffix to any of the above

         4) Start with windows option (Default off - Does not start with windows)
            (Default off - Confirmation Message is centered on screen)
         6) Clear History on exit option (Default off)
         7) Turn off recording of Last Saved Picture (Default off - records Last Saved Picture)
         8) Delete record of the Last Saved Picture on exit and Delete now options
            (Default off - does not delete Last Saved Picture on exit)
         9) The user can now define how many pictures to list in the History Menu (Default 30)
        10) Added "Wait for Save Picture window timeout" option to improve reliability on slower computers.
            (Default 5 seconds)
        11) Added View Log File, Clear Log File and  Email Log File to Additional Settings Menu 
            (Default - Logging turned off)
        12) Added "More Info" for each of the above options on the Additional Settings Menu with detailed
            information on each
        13) Increase the number of Favorite Folder and Hotkeys from 5 to 10.
        14) Added "Special Folder" on the "Configure Hotkeys & Folders" menu 
            (Click "HERE" on "Configure Hotkeys & Folders"screen for more information)
        15) Fixed an issue with the Win Key not being saved as a modifier for hotkeys 

       Version 8.1 - Minor Update
         1) Found issue with saving pictures using the Opera browser
       
       Version 8.2 - Minor Update
         1) Found an issue with saving changes when enabling/disabling the History.
       
       Version 8.3 - Minor Update
         1) Added support for the Avant, Comodo Dragon, and K-Meleon browsers.
         2) Added support for Environment and Autohotkey built-in variables. (Click "HERE" on "Configure Hotkeys & Folders" screen for more information)
         3) Added ability to turn Favorite Folders 1-10 into "Special Folders" (Click "HERE" on "Configure Hotkeys & Folders" screen for more information)
         4) SavePictureAs hotkeys are now only active if one of the supported browsers is active.
         5) Added "Change Tray Icon". User can choose from 10 built in icons or add their own icons to choose from. (max 99)
         6) Added icons to the menu items on the system tray icon
       
       Version 8.4 - Minor Update
         1) Fixed an issue with displaying images properly on the history menu.
       
       Version 8.5
         1) Added "Check For Updates Daily"
         2) Removed and or disabled "Check for Updates on Start Up" if SavePictureAs was started on a flash drive
       
       Version 8.6
         1) Fixed an issue with Google chrome saving pictures
       
       Version 8.7
         1) Fixed an issue with reading users saved settings for Favorite Folders being used as Special Folders
       
       Version 8.8
         1) Fixed an issue with reading users saved settings for CustomFileNaming incorrectly
       
       Version 8.9
         1) Fixed an issue with PromptForPictureName not saving the picture.
       
       Version 9.0 - Major Update
         1) Added CaptureAreaOfScreen, click on the system tray icon, then "Settings" then "Capture Area Settings" to configure
         2) Added CaptureActiveWindow
         3) Added CaptureEntireScreen
         4) Added "Check For Updates Daily"
         5) Removed "Check for Updates on Start Up" if SavePictureAs was started on a flash drive
         6) For Favorite Folder Hotkeys 1 thru 10, the Default Folder Hotkey, and Special Folder Hotkey requires the browser to be active. 
            If you are trying to save a picture and the hotkey appears to not be working click anywhere on the browser to make it the active window.
         7) Redesigned some of the windows to display properly with DPI settings larger then 96
         8) Fixed various minor bugs, error detection and correction.
         9) Added Disable/Enable All Hotkeys to the system tray icon
       
       Version 9.1 - Minor Update
         1) Fixed an issue when unable to load an icon would cause an error instead of silently not loading the icon.
       
       Version 9.2 - Minor Update
         1) Fixed an issue with displaying the history menu properly.
       
       Version 9.3 - Minor Update
         1) Found a small typo error causing Check for Updates daily to not be enabled on startup
       
       Version 9.4 - Minor Update
         1) Found an issue with hotkeys starting enabled even though they were set to disabled in the ini file upon startup
       
       Version 9.5 - Minor Update
         1) Added End-User License Agreement (EULA)
         2) Fixed spelling typos
         3) Fixed missing Program Documentation icon when running SavePictureAs on Windows 8.0 
       
       Version 9.6 - Minor Update
         1) Found hotkeys not be turned back on when closing the Configure Hotkeys & Folders screen by clicking on the X.
       
       Version 9.7 - Minor Update
         1) Found issue with Don't Remind Me Until Next Update not saving the choice properly.
       
       Version 9.8 - Minor Update    
         1) Added ability to compare the MD5 Checksum value of the duplicate picture with the MD5 Checksum value of the original to identify if the  duplicate picture is identical to the original.
            If the duplicate picture is identical to the original then the duplicate will not be saved. 
            This setting can be changed on the Additional Settings Menu.
         2) Added "Please provide feedback" survey option
         3) Found an issue with "Do not save duplicates" showing message that a duplicate was found and not saved even though "&Notify Me" was not checkmarked on the Additional Settings Window
         4) Found filename to be incorrect on all the "&Notify Me" message boxes when a duplicate was found.
         5) Found an issue when a duplicate filename is found and the duplicate is deleted then "Rename Last Saved Picture" was recording the deleted duplicate as the last saved picture.
         6) When updating to the newest version the update process will verify the downloaded update using the MD5 cryptographic hash function.
         7) Added FileNaming options (Date & Time-FileName) and (Sequential Number-FileName)
         8) Redesigned menus to display properly on DPI 96 and DPI 120
         
       Version 9.9 - Minor Update
         1) Improved Automatic updates to include alternate update links
 )
 
ProgramDocumentationTextVar2 =
(
       
       Version 10.0 - Minor Update
         1) Added alternate method to check for updates by entering a url provided by tech support
         2) Fixed "View Current" and "View Changes" to display the correct Date-Time format if Date-Time format was chosen to be part of the new filename. 
           This can be found by clicking on the System Tray icon, selecting Settings, Additional Settings
           and selecting "Custom Picture Name" then clicking on "Configure" 
       
       Version 10.1 - Minor Update      
         1) Redesigned "Program Colors" configuration screen
         2) Redesigned "Additional Settings Menu" to display properly on DPI 96 and DPI 120
         3) Fixed minor display bug when changing screen colors.
         
       Version 10.2 - Minor Update
         1) Improved "Test Changes" process on the Program Colors settings page
         2) Spaces before and after the "Prefix" and before and after the "Suffix" on the custom naming options are now allowed.
         3) Added Date & Time option which allows a user defined "separator"  characters between the Date and Time values. 
            Example (The AND sign and spaces were added with this option): 20140404 & 080109.jpg
         4) Added "Use above options and Prompt for filename" to the Custom Picture Name options. 
            SavePictureAs will rename the picture to your choice then prompt you so you can change the new filename when saving a picture.
         5) Added Custom Filenaming Option - [UserInput1] Date && Time [UserInput2] Original Filename (When saving a picture you will be prompted for UserInput)  
         6) Added support for the Slim Browser
         7) Redesigned "Prompt For Picture" name prompt   
         
       Version 10.3 - Minor Update
         1) Found an issue displaying menu icons on Windows 8.1.
         
       Version 10.4 - Minor Update
         1) Found an issue with displaying the "Reset All Settings" icon
       
       Version 10.5 - Minor Update
         1) Found an issue with downloading updates via the "Check for Updates" tray menu option
         
       Version 10.6 - Minor Update
        1) Found an issue with displaying system tray menu icons on Windows 8

Thanks for using SavePictureAs
email support@SavePictureAs.com with any questions and suggestions for this program. 

Created by  -=Robert Jackson=-   2008
If you would like you can donate to donate@SavePictureAs.com using PayPal.
(Maybe my wife will see some benefit in me spending so many hours programming SavePictureAs)


)

Gui 7: default
gui 7: font, s11, MS sans serif
Gui 7: add, edit, w970 h700 vProgramDocumentationEditBox ReadOnly  , 
(
%ProgramDocumentationTextVar1% 
%ProgramDocumentationTextVar2%
)

Control_Colors("ProgramDocumentationEditBox", "Set", "0x" ProgramDocumentationColorEditBoxVar, "0x" ProgramDocumentationColorEditboxTextVar)

Gui 7: Color,  %ProgramDocumentationColorGuiVar% 
if TestingColors = 1
 Gui 7: Show, x%tempx% y%tempy% w1000 ,SavePictureAs V%Version% (Program Documentation)
else
 Gui 7: Show, w1000 ,SavePictureAs V%Version% (Program Documentation)

WinGet,PDID,ID,SavePictureAs V%Version% (Program Documentation)
Sleep 10
ControlFocus,edit1,ahk_id %PDID% ;trying to prevent the text in the edit box from being highlighted when first loaded.
ControlClick,edit1,ahk_id %PDID%
Return
7GuiClose:
Gui 7: destroy
return
;*****************************************************************************************************
;Favorites Toolbar
;*****************************************************************************************************
FavoritesToolbar:
IfWinExist,ahk_id %FavoritesToolbarID%
 {
  WinRestore,ahk_id %FavoritesToolbarID%
  WinActivate,ahk_id %FavoritesToolbarID%
  return
 }
Loop 10
 {
  IniRead, ButtonFavorite%a_index%, SpaConfig.ini, FavoritePaths, %a_index%,%a_space%
  if ButtonFavorite%a_index% =
   ButtonFavorite%a_index% = Unassigned
 }
IniRead, ToolbarXPos,SpaConfig.ini,ToolbarPos,ToolbarXpos,750
IniRead, ToolbarYPos,SpaConfig.ini,ToolbarPos,ToolbarYpos,20
iniread, FavoritesToolbarGuiVar, SpaConfig.ini, SystemColors, FavoritesToolbarGuiVar, 7995B0
tempvarx = 3
tempvary = 2
Loop 10
 {
  Gui 51: Add, Button, x%tempvarx% y%tempvary% w30 h30 gFavoriteFolderButtons, %a_index%
  tempvarx := (tempvarx + 30)
  if a_index = 5
   {
    tempvarx=3
    tempvary=32
   }
 }
Gui 51: Add, Button, x3 y62 w100 h20  gConfigureHotkeys , Configure
Gui 51: Add, Button, x103 y62 w50 h20 gFavoriteToolbarHelp , Help
Gui 51: -MaximizeBox
Gui 51: Show, x%ToolbarXpos% y%ToolbarYpos% h82 w156, Toolbar
Gui 51: Color, %FavoritesToolbarGuiVar%, 
WinGet,ToolbarID,ID, Toolbar
WinSet, alwaysontop, On , ahk_id %ToolbarID%
IfWinNotExist,ahk_id %CHID%
 SetTimer, WatchCursor1 
Return
FavoriteToolbarHelp:
IfWinExist,ahk_id %FTBHID%
 {
  WinRestore,ahk_id %FTBHID%
  WinActivate,ahk_id %FTBHID%
  return
 }
Gui 28: add, text,x15 y15,
(
The Toolbars 10 buttons correspond to your 10 favorite folders.
 
The "Default Folder" to save pictures to using the "Default Hotkey" can be changed by clicking on one of your Favorite Folder buttons on the Toolbar.

This is the "Default Hotkey" method of saving pictures.

This is how it works:
For example:
There is a picture of a mountain in your browser. 

You would click button 5 on the Favorites Toolbar, the default folder will change to C:\Images\Mountains

Then you press the "Default Hotkey" ("Ctrl Space" by default), the picture will be saved to C:\Images\Mountains. 

Each time you save a picture using the "Default Hotkey" it will be saved in C:\Images\Mountains until you change the "Default Folder" via the Favorites Toolbar.

This method is helpful if you can't remember all (up to 10) of your chosen hotkeys and folders.

When you place your mouse over a button on the Favorites Toolbar a "tooltip" will appear above the button showing the folder 
assigned to that button.

Please Note: When configuring hotkeys be sure to use a key combination that your browser is not already using.
)
Gui 28: show, autosize,SavePictureAs V%version% (Favorites Toolbar Help)
WinGet,FTHID,id,SavePictureAs V%version% (Favorites Toolbar Help)
Gui 28: color, c0c0c0
Return
28GuiClose:
Gui 28: destroy
return
WatchCursor1:
MouseGetPos, , ,TitleID , ToolbarControl
WinGetTitle, title, ahk_id %TitleID%
if (ToolbarControl = "Button1" or ToolbarControl = "Button2" or ToolbarControl = "Button3" or ToolbarControl = "Button4" or ToolbarControl = "Button5" or ToolbarControl = "Button6" or ToolbarControl = "Button7" or ToolbarControl = "Button8" or ToolbarControl = "Button9" or ToolbarControl = "Button10" & (title = "Toolbar"))
 {
  loop 10
  {
   if title = Toolbar
    if ToolbarControl = button%a_index% 
     ToolTip, % buttonfavorite%a_index%
  }
 SetTimer, WatchCursor1end, 100
 Return
 
 WatchCursor1end: ;removes tooltip when cursor is not over Toolbar 
 if (title <> "Toolbar" or ToolbarControl = "button11" or ToolbarControl = "button12" or ToolbarControl = "") 
  ToolTip
  Return
 }
Return
FavoriteFolderButtons:
MouseGetPos, , , , control
StringTrimLeft,FavoriteFolderNumber,control,6
IniRead, tempvar2, SpaConfig.ini, FavoritePaths, %FavoriteFolderNumber%, %a_space%
if ( tempvar2 <> "Error" and tempvar2 <> "" )
 {
  IniWrite, %TempVar2%, SpaConfig.ini, DefaultPath, path
  MaxChars := 100
  TextToControl = %TempVar2%
  Gosub,FixControlTextLength
  menu, tray, tip, Default Folder  (%TextToControl%)
  TrayTip,Default Folder Changed to:,(%texttocontrol%),3
  DefaultPath = %tempvar2%
  Tempvar = 1
  SetTimer,CloseToolTip1,100
 }
 else
  MsgBox,4112,Invalid Selection, There is no folder assigned to this button`n`nPlease choose another.
  return
CloseToolTip1:
sleep 100
Tempvar++
if Tempvar = 15
 {
  
  SetTimer,CloseToolTip1,Off
  Traytip
 }
Return
51GuiEscape:
51GuiClose:

WinGet, State,MinMax,ahk_id %ToolbarID% ;Don't save position if minimized
if State > -1
  {
   WinGetPos,ToolbarXPos,ToolbarYPos,,,Toolbar ;position Toolbar where it was last located on next use
   IniWrite, %ToolbarXPos%,SpaConfig.ini,ToolbarPos,ToolbarXpos
   IniWrite, %ToolbarYPos%,SpaConfig.ini,ToolbarPos,ToolbarYpos
  }
SetTimer, WatchCursor1,off
SetTimer, WatchCursor1end, off
Gui 51: Destroy
Return

;*****************************************************************************************************
;Favorites Toolbar End
;*****************************************************************************************************
;*****************************************************************************************************
;History Menu
;*****************************************************************************************************
ConfigureHistory:
IfWinExist, ahk_id %HistoryID%
 {
  WinRestore,ahk_id %HistoryID%
  WinActivate,ahk_id %HistoryID%
  Return
 }  
MyList=
IfNotExist, %A_ScriptDir%\spaimage.jpg
 Gosub CreateSpaImage
SysGet, MWA, MonitorWorkArea ;place history as high on the screen as possible due to height, get monitorworkarea here in case the taskbar was moved to top of screen after SavePictureAs was started
SysGet, TitleBarHeight, 4 ;need to know the titlebar height to center the image vertically
iniread, HistoryColorGuiVar, SpaConfig.ini, SystemColors, HistoryColorGuiVar, 8080ff
iniread, HistoryColorGuiTextVar, SpaConfig.ini, SystemColors, HistoryColorGuiTextVar, 000000
iniread, HistoryColorListboxVar, SpaConfig.ini, SystemColors, HistoryColorListboxVar, 0xdcdbd1
iniread, HistoryColorListBoxTextVar, SpaConfig.ini, SystemColors, HistoryColorListBoxTextVar,000000
iniRead, HistoryValue, SpaConfig.ini, History, HistoryValue, ENABLED
  GuiWidth = 740 
if A_ScreenDPI = 120
 GuiHeight := (MWABottom - titlebarheight)*.75
else
 GuiHeight := (MWABottom - titlebarheight)*.98
GuiHeight := Floor(GuiHeight)
DefaultGuiXPos := (MWARight-GuiWidth)/2
DefaultGuiXPos := Floor(DefaultGuiXPos)     ;whole numbers only
DefaultGuiYPos := (MWABottom-GuiHeight-30)/2
DefaultGuiYPos := Floor(DefaultGuiYPos)
IniRead,GuiXpos,SpaConfig.ini,HistoryMenuPos,XPos,%GuiXpos%,%DefaultGuiXPos%
IniRead,GuiYpos,SpaConfig.ini,HistoryMenuPos,YPos,%GuiYpos%,%DefaultGuiYPos%
if ( GuiXpos = "" or GuiXpos = "ERROR" or GuiXpos < 0 or GuiXpos > MWARight )
 GuiXpos = %DefaultGuiXPos%
if ( GuiYpos = "" or GuiYpos = "ERROR" or GuiYpos < 0 or GuiYpos > MWABottom )
 GuiYpos = %DefaultGuiYPos%
Static1FontSize = 16
ListBoxheight = 148
ListboxWidth = 720
ButtonWidth = 102 
ButtonHeight = 40
ListBoxXpos = 10
ButtonXpos = 10
ButtonYpos := (GuiHeight - 55)
Gui 3: font, s14 c%HistoryColorGuiTextVar%, MS sans serif
Gui 3: Add, Text, x%ListBoxXpos% w%GuiWidth% vControlHistoryMenuStatic1Text ,Newest Entries on Top        History is %HistoryValue%       
Gui 3: font, s12 c%HistoryColorListBoxTextVar%, MS sans serif
Gui 3: Add, ListBox, x%ListBoxXpos% w%ListBoxWidth% h%ListBoxHeight% hwndLB vscroll choose1 gViewHistoryItems vHighLightedLine 0x100 Hscroll,Use arrow keys to scroll through the pictures to view them below 
Gui 3: font, s9, MS sans serif
if HistoryValue = Enabled
 TempVar = Disable History
else
 TempVar = Enable History
Gui 3: Add,  Button,hwndHistoryHandle1 x%ButtonXpos% y%ButtonYpos% w%ButtonWidth% h%ButtonHeight% gEnableDisableHistoryButton , %TempVar%
Gui 3: Add,  Button,hwndHistoryHandle2 x+1   y%ButtonYpos% w%ButtonWidth% h%ButtonHeight% gClearHistory, Clear History
Gui 3: Add,  Button,hwndHistoryHandle3 x+1   y%ButtonYpos% w%ButtonWidth% h%ButtonHeight% gDeletePicture, Delete Picture
Gui 3: Add,  Button,hwndHistoryHandle4 x+1   y%ButtonYpos% w%ButtonWidth% h%ButtonHeight% gMovePicture, Move Picture
Gui 3: Add,  Button,hwndHistoryHandle5 x+1   y%ButtonYpos% w%ButtonWidth% h%ButtonHeight% gCopyPIcture, Copy Picture
Gui 3: Add,  Button,hwndHistoryHandle6 x+1   y%ButtonYpos% w%ButtonWidth% h%ButtonHeight% gRenamePicture, Rename Picture
Gui 3: Add,  Button,hwndHistoryHandle7 x+1   y%ButtonYpos% w%ButtonWidth% h%ButtonHeight% gImageDetails, Image Details
Gui 3: Add, Picture,hwndHistoryHandle8 x123  y3000  w-1  h315 -Background, spaimage.jpg 
;Gui 3: Add, text,x280 y430,Generating preview... ;will add later
Gui 3: Color,  %HistoryColorGuiVar%,%HistoryColorListboxVar%, 
Gui 3: Show, x%GuiXpos% y%GuiYpos% w%GuiWidth% h%GuiHeight% ,SavePictureAs V%Version% (History)
WinGet,HistoryID,ID, SavePictureAs V%Version% (History)
control,hide,,static2, ahk_id %HistoryID%
loop %MaxHistoryMenuPicturesToList%
 {
  iniread, History%a_index%, SpaConfig.ini, History, History%a_index%, %a_space%
  if History%a_index% <>
   MyList :=  ((MyList)(History%a_index%)"|")
   if History%a_index% =
   break
 }
guicontrol, 3:,listbox1, |    ;blanks listbox
guicontrol, 3:,listbox1,Use arrow keys to scroll through the pictures to view them below
Loop, Parse, mylist ,|,`r  ;retrieve 1 line at a time
 {
  IfNotExist,%a_loopfield%
   {
    if a_loopfield <>
     guicontrol, 3:,listbox1,File does not exist----> %A_LoopField%
   }
   else
   GuiControl, 3:, ListBox1, %A_LoopField%  ;add one line at a time back to listbox
 }
GuiControl, 3:Choose, listbox1, 1
ImageFile = %A_ScriptDir%\SpaImage.jpg

ControlGetPos,Button1x,Button1y,Button1w,Button1h,Button1,ahk_id %HistoryID%
ControlGetPos,ListBox1x,ListBox1y,ListBox1w,ListBox1h,Listbox1,ahk_id %HistoryID%
WinGetPos,,,GuiWidth,GuiHeight,ahk_id %HistoryID%
ShowHighLightedLine =
gosub ViewHistoryItems
IniRead, HistoryValue, SpaConfig.ini, History, HistoryValue, Enabled
MyList =
Gui 3: font, s14 c%historyColorGuiTextVar%, MS sans serif ;Main window text
GuiControl, 3: Font, static1 
Return
ViewHistoryItems:
SetTimer, PictureScroll, -10 
Return 
PictureScroll:
NotFound = 0
Guicontrolget, HighLightedLine, 3:
if HighLightedLine = 
 Return 

SendMessage, 0x188, 0, 0, ListBox1, ahk_id %HistoryID% ; 0x188 is LB_GETCURSEL 
CurrentLineSelected = %ErrorLevel% 
ShowSpaImage = 0
IfNotInString,HighLightedLine,File does not exist---->
 {
  IfNotInString,HighLightedLine,Use arrow keys to scroll through the pictures to view them below
   {
    Ifnotexist %HighLightedLine%
     {
      NotFound = 1
      NotFoundFileName := ( HighLightedLine )
      ;NotFoundFileName = %HighLightedLine%
      SendMessage, (LB_DELETESTRING:=0x182),%CurrentLineSelected%,0,, ahk_id %LB%
      String := ("File does not exist---->" HighLightedLine )
      SendMessage, (LB_INSERTSTRING:=0x181),%CurrentLineSelected%,&String,, ahk_id %LB%
      HighLightedLine = %A_ScriptDir%\spaimage.jpg
      CurrentLineSelected++
      GuiControl, 3:Choose, listbox1, %CurrentLineSelected%
      ControlFocus,listbox1,ahk_id %HistoryID%
      ShowSpaImage = 1
     }
  }
 }
if HighLightedLine = Use arrow keys to scroll through the pictures to view them below
 {
  HighLightedLine := ( A_ScriptDir "\spaimage.jpg" )
  ;HighLightedLine = %A_ScriptDir%\spaimage.jpg
  ShowSpaImage = 1
 }
IfInString, HighLightedLine, File does not exist---->
 {
  HighLightedLine =  %A_ScriptDir%\spaimage.jpg
  ShowSpaImage = 1
 }
if ShowSpaImage = 0 ; if ShowSpaImage = 1 then HighLightedLine does not change from spaimage.jpg
 {
  loop %MaxHistoryMenuPicturesToList%
   {
    if CurrentLineSelected = %A_Index%
     {
      iniread, HighLightedLine, SpaConfig.ini, History, History%A_Index%,1 ;allow to displayed line number
      break
     }
   }    
 }
if ( ShowHighLightedLine <> HighLightedLine ) ;prevent spaimage from flashing when no picture can be shown
 {
  ShowHighLightedLine = %HighLightedLine%
  WinGetPos,,,GuiWidth,GuiHeight,ahk_id %HistoryID%
  ImageFile = %ShowHighLightedLine%
  Gosub GetDimensions ;returns w and h
  MaxImageHeight := ( Button1Y - ListBox1Y - ListBox1H - 30 ) 
  MaxImageWidth := (GuiWidth-30)
  ;if original width and height are smaller then the area available then display the image without resizing
  if ( W < (MaxImageWidth) and H < (MaxImageHeight) ) 
   {
     MaxImageWidth = %W%
     MaxImageHeight = %H%
   }
  
  GuiControl, 3:Hide, static2,
  
  if W > %H% ;place image on screen based on original width and height
   guicontrol, 3: ,static2, *h-1 *w%MaxImageWidth% %ShowHighLightedLine%
  else
   guicontrol, 3: ,static2, *w-1 *h%MaxImageHeight% %ShowHighLightedLine% ;if width and height are the same then this line is executed
  
  ControlGetPos,Picx,Picy,Picw,Pich,Static2, ahk_id %HistoryID%  
  ;if new sizes are too big then resize again, 

  if PicH > %MaxImageHeight%
   {
    guicontrol, 3: ,static2, *w-1 *h%MaxImageHeight% %ShowHighLightedLine%
    ControlGetPos,Picx,Picy,Picw,Pich,Static2, ahk_id %HistoryID%  
   }
  if PicW > %MaxImageWidth%
   {
    guicontrol, 3: ,static2, *h-1 *w%MaxImageWidth% %ShowHighLightedLine%
    ControlGetPos,Picx,Picy,Picw,Pich,Static2, ahk_id %HistoryID%  
   }
  
  ;------------------------------------------------------------------------------
  ;------------------------------------------------------------------------------
  ImageXpos := (GuiWidth-PicW)/2
  ImageXpos := Floor(ImageXpos)
  ImageYpos := ((( Button1Y - (Listbox1Y + Listbox1H)  ) - pich) /2 ) + (Listbox1Y + Listbox1h)
  ImageYpos := Floor(ImageYpos)   
  ControlMove,static2,%ImageXpos%,%ImageYpos%,%PicW%,%PicH%,ahk_id %HistoryID% ;resize image to calculated dimensions
  GuiControl, 3:Show, static2,
 }
If NotFound = 1
 Msgbox,4112, File Error, Picture was deleted, moved, or renamed!`n%NotFoundFilename% 
Return
RemoveToolTipHE:
SetTimer, RemoveToolTipHE, Off
ToolTip
Return
EnableDisableHistoryButton:
MouseGetPos,,,,Control
ControlGetText,ControlText,%Control%,ahk_id %HistoryID%
IfInString,ControlText,Disable
 {
  IniWrite, DISABLED, SpaConfig.ini, History, HistoryValue     
  ControlSetText,%Control%,Enable History,ahk_id %HistoryID%
  ControlFocus,listbox1,ahk_id %HistoryID%
  Guicontrol, ,static1, Newest Entries on Top        History is Disabled
  IfWinExist,Additional Settings Menu,
   Control, Uncheck , , Do not keep history of pictures saved, Additional Settings Menu
  ToolTip, History is [Disabled]
  SetTimer, RemoveToolTipHE, 3000
 }
else
 {
  IniWrite, ENABLED, SpaConfig.ini, History, HistoryValue     
  ControlSetText,%Control%,Disable History,ahk_id %HistoryID%
  ControlFocus,listbox1,ahk_id %HistoryID%
  Guicontrol, ,static1, Newest Entries on Top        History is Enabled
  IfWinExist,Additional Settings Menu,
   Control, check , , Do not keep history of pictures saved, Additional Settings Menu 
  ToolTip, History is [Enabled]
  SetTimer, RemoveToolTipHE, 3000
 }
iniRead, HistoryValue, SpaConfig.ini, History, HistoryValue, ENABLED
return

RemoveToolTipHD:
SetTimer, RemoveToolTipHD, Off
ToolTip
Return
ClearHistory:

tempvar =

loop %MaxHistoryMenuPicturesToList% ;this is needed to detemine if all history items are already blank
 {
  IniRead,tempvar , SpaConfig.ini, History, History%A_Index%
  if tempvar <>
   break
 }
if tempvar =
 {
  MsgBox,262208,SavePictureAs V%version% (Clear History),There are no items to erase.
  return
 }	

Msgbox,4132, SavePictureAs V%version% (Clear History),This option erases only the history of files saved.`nNo files are deleted.`n`nDo you want to continue?
IfMsgBox Yes
 {
  loop 
   {
    IniRead,TempVar,Spaconfig.ini,History,History%a_index%
    ;IniWrite,%a_space% , SpaConfig.ini, History, History%A_Index%
    History%A_index% =
    IniDelete,Spaconfig.ini,History,History%a_index%
    if TempVar = Error
     break
   }
  Ifwinexist,ahk_id %HistoryID%
   {
    guicontrol, 3:,listbox1, |    ;blanks listbox
    guicontrol, 3:,highlightedline ,Use arrow keys to scroll through the pictures to view them below
    GuiControl, 3:Choose, listbox1, 1
    goto viewhistoryitems
    ControlFocus, ListBox1, ahk_id %HistoryID%
   }
 }
Return
DeletePicture:
MyList =
Guicontrolget, HighLightedLine    
if HighLightedLine = Use arrow keys to scroll through the pictures to view them below
 {
  MsgBox,262208, SavePictureAs V%Version% (History Menu),No picture has been selected.
  ControlFocus, ListBox1, ahk_id %HistoryID%
  Return
 }
SendMessage, 0x188, 0, 0, ListBox1, A ; 0x188 is LB_GETCURSEL ;Line number of hightlighted line 
Pos = %ErrorLevel% 
Pos++ ;add one because errorlevel starts with zero
Msgbox,4132, Confirm File Deletion, Do you want to delete %HighLightedLine%?
IfMsgBox Yes
 {
  IfInString, HighLightedLine, File does not exist---->
  StringTrimLeft,HighLightedLine,HighLightedLine, 25
  loop %MaxHistoryMenuPicturesToList% ;recreate MyList without the file to be deleted
   {
    iniread, History%a_index%, SpaConfig.ini, History, History%a_index%, %a_space%
    if History%a_index% =
     break
    else
    if History%A_Index% <> %HighLightedLine%
     {
      IfExist, % History%a_index%
       MyList :=  ((MyList)(History%a_index%)"|")
     }
   }
  loop %MaxHistoryMenuPicturesToList% ;clear inifile
   IniDelete,SpaConfig.ini,History,history%a_index%
  guicontrol, 3:,listbox1, |    ;blanks listbox
  guicontrol, 3:,listbox1,Use arrow keys to scroll through the pictures to view them below
  Loop, Parse, mylist ,|,`r  ;retrieve 1 line at a time
   {
    if a_loopfield =
     {
      BlankLine = %A_Index%
      BlankLine++
      break
     }
    iniwrite,%A_LoopField%,SpaConfig.ini,history,history%a_index%
    IfNotExist,%a_loopfield%
     guicontrol, 3:,listbox1,File does not exist----> %A_LoopField%
    else
     guicontrol, 3:,listbox1,%A_LoopField%
   }
FileSetAttrib, -R, %HighLightedLine% 
FileRecycle, %HighLightedLine%
SendMessage, (LB_GETCOUNT := 0x18B), 0, 0, ListBox1, A 
LineCount = %ErrorLevel% 
If Pos > %Linecount%
 Pos = %Linecount%
GuiControl, 3:Choose, listbox1, %pos%
ControlFocus, ListBox1, ahk_id %HistoryID%
mylist = 
Goto ViewHistoryItems  
}
IfMsgBox no
 ControlFocus, ListBox1, ahk_id %HistoryID%
Return
MovePicture:
MyList =
Guicontrolget, HighLightedLine    
if HighLightedLine = Use arrow keys to scroll through the pictures to view them below
 {
  MsgBox,262208, SavePictureAs V%Version% (History Menu),No picture has been selected.
  ControlFocus, ListBox1, ahk_id %HistoryID%
  Return
 }
IfInString, HighLightedLine, File does not exist---->
 Return
SendMessage, 0x188, 0, 0, ListBox1, ahk_id %HistoryID% ;need to position highlight line after moving picture
CurrentLineSelected = %ErrorLevel% 
SplitPath,HighLightedLine,CurrentFilename
FileSelectFolder, OutPutVar, *%A_MyDocuments%, 3, Please choose a folder to move`n%CurrentFilename% to
if errorlevel = 1
 {
  ControlFocus, ListBox1, ahk_id %HistoryID%
  Return
 }
OutPutVar := RegExReplace(OutPutVar, "\\$")  ; Removes the trailing backslash, if present.
FileGetAttrib, Attributes, %OutPutVar%
IfNotInString, Attributes, D
 {
  MsgBox,4112,SavePictureAs V%Version%,You have not chosen a valid folder. %OutputVar%`n`nPlease choose another location
  goto MovePicture
 }
ifexist %OutPutVar%\%currentfilename%
 {
  Msgbox,4112, File Error, %currentfilename% already exist in %OutPutVar%
  goto MovePicture
 }
FileSetAttrib, -R, %HighLightedLine% 
FileMove, %HighLightedLine%, %OutPutVar%
iniwrite, %OutPutVar%\%CurrentFileName%, SpaConfig.ini, History, History%CurrentLineSelected%
controlget,MyList,list,,listbox1,ahk_id %HistoryID%
Loop, Parse, mylist ,`n,`r  ;retrieve 1 line at a time
 {
  if A_LoopField = %HighLightedLine%
   {   
    SendMessage, (LB_DELETESTRING:=0x182),%CurrentLineSelected%,0,, ahk_id %LB%
    String = %OutPutVar%\%CurrentFileName%
    SendMessage, (LB_INSERTSTRING:=0x181),%CurrentLineSelected%,&String,, ahk_id %LB%
    break
   }
 }
CurrentLineSelected++
GuiControl, 3: Choose, listbox1, %CurrentLineSelected%
ControlFocus, ListBox1, ahk_id %HistoryID%
mylist = 
Goto ViewHistoryItems
Return
CopyPicture:

MyList =
Guicontrolget, HighLightedLine    
if HighLightedLine = Use arrow keys to scroll through the pictures to view them below
 {
  Msgbox,262208,SavePictureAs V%Version% (History Menu),No picture has been selected.
  ControlFocus, ListBox1, ahk_id %HistoryID%
  Return
 }
IfInString, HighLightedLine, File does not exist---->
 Return
SendMessage, 0x188, 0, 0, ListBox1, ahk_id %HistoryID% ;need to position highlight line after moving picture
CurrentLineSelected = %ErrorLevel% 
SplitPath,HighLightedLine,CurrentFilename
FileSelectFolder, OutPutVar, *%A_MyDocuments%, 3, Please choose a folder to copy %CurrentFilename% to
if errorlevel = 1
{
  ControlFocus, ListBox1, ahk_id %HistoryID%
  Return
 }
OutPutVar := RegExReplace(OutPutVar, "\\$")  ; Removes the trailing backslash, if present.
FileGetAttrib, Attributes, %OutPutVar%
IfNotInString, Attributes, D
 {
 MsgBox,4112,SavePictureAs V%Version%,You have not chosen a valid folder. %OutputVar%`n`nPlease choose another location
  goto CopyPicture
 }
ifexist %OutPutVar%\%currentfilename%
 {
 MsgBox,4112, File Error, %currentfilename% already exist in %OutPutVar%
  goto MovePicture
 }
FileCopy, %HighLightedLine%, %OutPutVar%
if ErrorLevel <> 0
MsgBox,4112,Error, The file was not able to be copied. Ensure the destination folder exists and is not write protected.
ControlFocus, ListBox1, ahk_id %HistoryID%
Return
RenamePicture:

MyList =
Guicontrolget, HighLightedLine    
if HighLightedLine = Use arrow keys to scroll through the pictures to view them below
 {
 MsgBox,262208, SavePictureAs V%Version% (History Menu),No picture has been selected.
  ControlFocus, ListBox1, ahk_id %HistoryID%
  Return
 }
IfInString, HighLightedLine, File does not exist---->
 Return
SendMessage, 0x188, 0, 0, ListBox1, A ; 0x188 is LB_GETCURSEL ;Line number of hightlighted line
CurrentLineSelected = %ErrorLevel% 
SplitPath,HighLightedLine,OriginalFileNameWithExt,OriginalPath,OriginalExt,OriginalFileNameWithoutExt
Gui, +OwnDialogs
InputBoxTitle = Rename this file?
SetTimer, KeepInputBoxOnTop, -50
InputBox, newfilename , Rename this file?, Type a new filename for (%OriginalFilenameWithExt%)`nDo not include the file type in the filename. Example .jpg or .bmp,, 520, 245,,,,,%OriginalFileNameWithoutExt% 
if (errorlevel = 1 or newfilename = "") 
 {
  ControlFocus, ListBox1, ahk_id %HistoryID%
  Return
 }
FoundInvalidCharPos := % RegExMatch( NewFileName, "[\\/:.*?""<>|]" )
if FoundInvalidCharPos = 0
 goto FileNameIsValid
FoundInvalidCharPos--
StringTrimLeft,TempFileName,NewFileName,%FoundInvalidCharPos%
StringLen,Length,TempFileName
Length--
StringTrimRight,InvalidChar,TempFileName,%Length%
Msgbox, 4112, Invalid Filename "%newfilename%", Can not use %InvalidChar%`nPlease try again.
goto RenamePicture
TempFileName=
InvalidChar=
Length=
FileNameIsValid:

ifExist, %originalpath%\%newfilename%.%originalExt%
 {
 MsgBox,4112, Error renaming file, Duplicate filename exist, please choose another one.
  Goto   RenamePicture
 }
;xxx need to fix this because moving a file onto itself is always considered successful
Filemove, %HighLightedLine%, %originalpath%\%newfilename%.%originalEXT%
if ErrorLevel <> 0
 {
 MsgBox,4112,Error, The file was not able to be renamed. Ensure folder exists and is not write protected.
  Return
 }
IniWrite, %originalpath%\%newfilename%.%originalEXT%, SpaConfig.ini, History, History%CurrentLineSelected% 
controlget,MyList,list,,listbox1,ahk_id %HistoryID%
Loop, Parse, mylist ,`n,`r  ;retrieve 1 line at a time
 {
  if A_LoopField = %HighLightedLine%
   {   
    SendMessage, (LB_DELETESTRING:=0x182),%CurrentLineSelected%,0,, ahk_id %LB%
    String = %originalpath%\%newfilename%.%originalEXT%
    SendMessage, (LB_INSERTSTRING:=0x181),%CurrentLineSelected%,&String,, ahk_id %LB%
    break
   }
 }
CurrentLineSelected++
GuiControl, 3: Choose, listbox1, %CurrentLineSelected%
ControlFocus, ListBox1, ahk_id %HistoryID%
Return
ImageDetails:

Guicontrolget, HighLightedLine
if HighLightedLine = Use arrow keys to scroll through the pictures to view them below
 {
  ControlFocus, ListBox1, ahk_id %HistoryID%
  Return
 }
IfInString, HighLightedLine, File does not exist---->
 {
  ControlFocus, ListBox1, ahk_id %HistoryID%
  Return
 }
;some of these may have values from other places in script and may not be overwritten below.
 OutDir=
 OutFileName=
 width=
 height=
 size=
 timestamp=
 SendMessage, 0x188, 0, 0, ListBox1, A ; 0x188 is LB_GETCURSEL 
 CurrentLineSelected = %ErrorLevel% 
 iniread, Image, SpaConfig.ini, History, History%CurrentLineSelected%
 ImageFile = %Image%
 Gosub GetDimensions
 Width = %w%
 Height = %h%
  
 SplitPath, Image , OutFileName, OutDir
 FileGetSize, size, %Image%, k
 FileGetTime, TimeStamp, %Image%, c
 FormatTime, TimeStamp , %timestamp%, dddd MMMM d, yyyy hh:mm:ss tt
 IfExist, %Image%
  msgbox,262208,SavePictureAs V%Version% (Image Details), Location on computer: %OutDir%`n`nImage Name: %OutFileName%`n`nImage dimensions: %width%x%height%`n`nImage Size: %size%k`n`nImage Date: %TimeStamp%
 else
  MsgBox,4112,Error [1014], Not able to retrieve picture details.
 OutDir=
 OutFileName=
 width=
 height=
 size=
 timestamp=
 ControlFocus, ListBox1, ahk_id %HistoryID%
 Return
3GuiClose:
WinGet, State,MinMax,ahk_id %HistoryID%
if State > -1
 {
  IfWinExist, ahk_id %HistoryID%
   {
    WinGetPos,x,y,,,ahk_id %HistoryID%
    IniWrite,%x%,SpaConfig.ini,HistoryMenuPos,XPos
    IniWrite,%y%,SpaConfig.ini,HistoryMenuPos,YPos
   } 
 }
gui 3: destroy
Return
;*****************************************************************************************************
;About Gui
;*****************************************************************************************************
ABOUT:
IfWinExist, ahk_id %AboutID%
 {
   WinRestore,ahk_id %AboutID%
   WinActivate,ahk_id %AboutID%
   return
 }
Gui 5: Default
iniread, AboutColorGuiVar, SpaConfig.ini, SystemColors, AboutColorGuiVar, c0c0c0
iniread, AboutColorGuiTextVar, SpaConfig.ini, SystemColors, AboutColorGuiTextVar, 000000
Gui 5: font, s12 , MS sans serif bold
Gui 5: Add, Text, x6 y10  w610 center c%AboutColorGuiTextVar%, Program Name = SavePictureAs 
Gui 5: Add, Text, x6 y40  w610 center c%AboutColorGuiTextVar%, Version = %Version% (Released June 2014)
Gui 5: Add, Text, x6 y70  w610 center c%AboutColorGuiTextVar%, Created April 2008 by -=Robert Jackson=-
Gui 5: Add, Text, x6 y120 w610 c%AboutColorGuiTextVar%, This program was written with AutoHotkey, a GPLed open source scripting language, and includes AutoHotkey code needed to execute the program.

Gui 5: Add, Link,c%AboutColorGuiTextVar%, Source code for AutoHotkey can be found at: <a href="http://www.AhkScript.org">www.AhkScript.org</a>

Gui 5: Font, s12 , Verdana bold
Gui 5: Add, link, x6 y260 cblue g12ButtonCheckForUpdatesNow , <a id="1">Check for Updates</a>

Gui 5: Add, link, x250 y260 cblue gEula , <a id="1">Eula</a>
Gui 5: Add, link, x380 y260 cblue gSurvey , <a id="1">Survey</a>

Gui 5: Add, link, x540 y260 w80 gCredits , <a id="1">Credits</a>
Gui 5: font,
Gui 5: font, s9 
Gui 5: add, edit,x-10 y290 w670 h50 vAboutEditBox center ReadOnly,If you would like you can donate to donate@SavePictureAs.com using PayPal.`n(Maybe my wife will see some benefit in me spending so many hours programming SavePictureAs)
Control_Colors("AboutEditbox", "Set", "0xd8d8d8", "0x000000")

Gui 5:  +MinSize +MaxSize -MaximizeBox  
Gui 5: Show, h330 w630, SavePictureAs V%Version% (About)

WinGet,AboutID,id,  SavePictureAs V%Version% (About)
ControlFocus,static1,ahk_id %aboutid%
Gui 5: Color, %AboutColorGuiVar%,
Return

5guiclose:
gui 5: destroy
return
Credits:
IfWinExist, ahk_id %CreditsID%
 {
   WinRestore,ahk_id %CreditsID%
   WinActivate,ahk_id %CreditsID%
   return
 }
iniread, CreditsColorGuiVar, SpaConfig.ini, SystemColors, CreditsColorGuiVar, c0c0c0
iniread, CreditsColorGuiTextVar, SpaConfig.ini, SystemColors, CreditsColorGuiTextVar, 000000
Gui 54: font, s12 c%CreditsColorGuiTextVar%
Gui 54: add, text,,Thanks to the following people from the Autohotkey forums for the following code.
Gui 54: add, link,,The Autohotkey forums can be access here <a href="http://www.AhkScript.org/boards">www.AhkScript.org/boards</a> and here <a href="http://www.AutoHotkey.com/boards">www.AutoHotkey.com/boards</a>

Gui 54: add, text,,
(
(A) Lexikos - Scrollable Gui code from http://www.autohotkey.com/forum/viewtopic.php?t=28496
(B) Lexikos - Resizable window border from http://www.autohotkey.com/board/topic/23969-resizable-window-border/#entry155480
(C) tic - Gdip functions to get image dimensions from
    http://www.autohotkey.com/board/topic/29449-gdi-standard-library-145-by-tic/#entry187736
(D) Sean - Get right click menu contents function GetMenu(hMenu) code from http://www.autohotkey.com/forum/viewtopic.php?t=21451
(E) Sean - Retrieve AddressBar of Firefox through DDE Message code
    from http://www.autohotkey.com/board/topic/17633-retrieve-addressbar-of-firefox-through-dde-message/
(F) Sean - Screen Capture from
    http://www.autohotkey.com/board/topic/16677-screen-capture-with-transparent-windows-and-mouse-cursor/#entry108113
(G) Eddy & olfen - UrlDownloadToVar from 
    http://www.autohotkey.com/community/viewtopic.php?f=2&t=10466&hilit=urldownloadtovar&start=75
(H) majkinetor - Common dialog for changing Gui & font colors from http://www.autohotkey.com/forum/viewtopic.php?t=17230
(I) majkinetor - DockA found here http://www.autohotkey.com/board/topic/46225-function-docka-10/#entry287726
(J) Huba  - Left click on system tray icon from http://www.autohotkey.com/forum/viewtopic.php?t=26720
(K) jaco0646 - User-defined Dynamic Hotkeys from http://www.autohotkey.com/board/topic/47439-user-defined-dynamic-hotkeys/
(L) derRaphael & JustMe for the Color Controls code from http://www.autohotkey.com/forum/topic33777.html and here 
    http://www.autohotkey.com/board/topic/90401-control-colors-by-derraphael/
(M) heresy - run ahk scripts with less memory from 
    http://www.autohotkey.com/board/topic/30042-run-ahk-scripts-with-less-half-or-even-less-memory-usage/
(N) Rseding91 - Calc_MD5 function posted by Rseding91 from http://www.autohotkey.com/board/topic/77408-md5-function-for-comparing-images/
(O) shimanov and Laszlo - Hide System Cursor from  http://www.autohotkey.com/board/topic/5727-hiding-the-mouse-cursor/#entry35098 and
    http://www.autohotkey.com/board/topic/5727-hiding-the-mouse-cursor/#entry35221
(P) nepter - Read text under mouse from here http://www.autohotkey.com/board/topic/94619-ahk-l-screen-reader-a-tool-to-get-text-anywhere/page-1#entry596215
(Q) joedf - Check Internet Connection function found here http://www.ahkscript.org/boards/viewtopic.php?f=5&t=349#p3292
(R) Chris Mallett for AutoHotkey and Lexikos for continuing to develop AutoHotkey_L
(S) Sorry if I missed someone. If so, let me know and I will give credit where credit is due.
)
Gui 54: show, autosize, Credits
WinGet,CreditsID,ID,Credits
Gui 54: Color, %CreditsColorGuiVar%
return
54GuiClose:
Gui 54: destroy
return

return
AutoHotkeyCom:
Run  http://www.AhkScript.org
Return
;*****************************************************************************************************
;Help Gui
;*****************************************************************************************************
USERHELP:
IfWinExist, ahk_id %UserHelpID%
 {
  WinRestore,ahk_id UserHelpID
  WinActivate,ahk_id UserHelpID
  return
 }
iniread, HelpColorGuiVar, SpaConfig.ini, SystemColors, HelpColorGuiVar, c0c0c0
iniread, HelpColorGuiTextVar, SpaConfig.ini, SystemColors, HelpColorGuiTextVar, 000000
IniRead, MaxHistoryMenuPicturesToList, SpaConfig.ini,History, MaxHistoryMenuPicturesToList,30
Gui 6: +Resize +0x300000 ;  WS_VSCROLL | WS_HSCROLL
gui 6: font, s12 , MS sans serif

Gui 6: Add, Text, x6 y10 w938 c%HelpColorGuiTextVar%,
(
Please Note: 
For Favorite Folder Hotkeys 1 thru 10, the Default Folder Hotkey, and Special Folder Hotkey requires 
the browser to be active. If you are trying to save a picture and the hotkey appears to not be working click anywhere
on the browser to make it the active window.`n
  1. Place the mouse cursor over a picture on a webpage.
  2. Press the "ctrl and spacebar" or user defined keys to save the picture to your hard drive.
 
  3. Configure Hotkeys and Favorite Folders via the system tray icon
  4. Use the system tray menu item "History" to view, copy, rename and delete the last %MaxHistoryMenuPicturesToList% 
     %a_space%(or user defined number) saved pictures.
  5. Use the system tray icon to launch the Favorites Toolbar and configure up to ten buttons to quickly change
      the Default picture location.
  6. Use the system tray icon to launch menu to change screen and text colors.
  7. Click the system tray icon, "Settings" then "Additional Settings" for more options.
  8. Exit the program by clicking the system tray icon.

  9. Make SavePictureAs Completely Portable:    
      Create a "Special Folder" on your flash drive and give it a unique name. 
      Put SavePictureAs anywhere on the same flash drive.
      Start SavePictureAs from your flash drive. 
      On the "Configure Hotkeys and Folders" menu choose a "Special Folder" hotkey and assign the flash drive 
      "Special Folder" to this hotkey.
    
     Each time you save a picture using your "Special Folder" hotkey your picture will be saved to your flash drive. 
 
 10. The configure hotkey routine was created by jaco0646 from the forum at Autohotkey.com. Not all hotkey combinations are
       assignable using the Configure Hotkeys gui. If the hotkey combination you want is not possible using the gui then edit
       the hotkey entries in SpaConfig.ini. If the hotkeys you write to the ini file are valid the hotkey gui should display
       them properly. I know very little about jaco0646s hotkey routine. 
     
       For questons on how to modify the hotkey routine to assign the hotkey you want ask jaco0646. The dynamic Hotkey forum
       post for Jaco0646's routine can be found at (http://www.autohotkey.com/board/topic/47439-user-defined-dynamic-hotkeys/).

      Let me know of any alterations to the hotkey routine code that works on previously unassignable hotkeys and I will modify
      the source code for SavePictureAs.

11. If you change the windows color and text color to the same color then the text is not visible. Choose "Reset All Colors"
      on the system tray to fix when this happens. 

12. For SavePictureAs to work properly, the script needs to be able to right click, send the letter v or the letter "s"
      (depending on browser), then wait for the Save Image, Save Picture or Save As window (depending on browser) to open,
      it will then save the picture to a temp folder. After saving to a temp folder SavePictureAs will apply the user chosen
      "Filenaming Convention" and check if a file by that name already exists in your chosen folder. If it does then SavePictureAs
      will apply the "How to Handle Duplicate" rules.

Please Note:
(1) For Favorite Folder Hotkeys 1 thru 10, the Default Folder Hotkey, and Special Folder Hotkey requires the browser to be active. If you are trying to save a picture and the hotkey appears to not be working click anywhere on the browser to make it the active window.

(2) SavePictureAs saves the picture in a temp folder, then SavePictureAs renames and moves the picture per user settings.

(3) The Confirmation Message (Done) only confirms that the hotkey operation has completed. If your picture was not saved you will get an error message except in the following senarios....
    (A) You have selected "Do not save duplicates" and "notify me" is turned off on the Additional Settings Menu. In this case no picture is saved if a file with the same filename is found in the Save To folder, therefore no error message is shown.
    (B) You have "Check for Identical Picture" selected and "notify me" is turned off on the Additional Settings Menu. In this case no picture is saved if an identical picture with the same filename is found in the Save To folder, therefore no error message is shown.
    
    -END USER HELP- 
    
    
)
Gui 6: add, text, x25 y+30, For more information on the "Special Folder" click
Gui 6: font, s12 underline
Gui 6: add, text, xp+435 yp+3 cblue gSpecialFolderInfo, HERE
Gui 6: Show,  autosize, SavePictureAs V%Version% (Help)
WinGet,UserHelpID,id,SavePictureAs V%Version% (Help)
Gui 6: Color, %HelpColorGuiVar%, 
Gui 6: +LastFound
GroupAdd, MyGui, % "ahk_id " . WinExist()
Return
6GuiClose:
Gui 6: destroy
return
;*****************************************************************************************************
;Change System Colors Gui
;*****************************************************************************************************
SystemColors:
WinSet,AlwaysOnTop,off, ahk_id %CHID%
IfWinExist, ahk_id %SystemColorsID%
 {
  WinRestore,ahk_id %SystemColorsID%
  WinActivate,ahk_id %SystemColorsID%
  return
 }
IniRead, ProgramColorsMenuColorGuiVar, SpaConfig.ini, SystemColors, ProgramColorsMenuColorGuiVar, c0c0c0
IniRead, ProgramColorsMenuColorGuiTextVar, SpaConfig.ini, SystemColors, ProgramColorsMenuColorGuiTextVar, 000000
Gui 15: Add, Groupbox, x10 y5 w240 h520,
Gui 15: Add, text,x25 y25 cblue gResetAllColors,Reset all colors to default
;Gui 15: Add, text,x25 y40 cblue,Choose a Theme 
Gui 15: font, s11
Gui 15: Add, text,x25 y+20, STEP 1:
Gui 15: Add, text, x25 yp+20, Choose Individual Screen
Gui 15: font
Gui 15: Add, text,x25 yp+25 w210 cblue gAboutLink, About Screen
Gui 15: Add, text,x25 yp+20 w210 cblue gAdditionalSettingsMenuLink, Additional Settings Menu
Gui 15: Add, text,x25 yp+20 w210 cblue gCaptureAreaOfScreenLink, Capture Area of Screen
Gui 15: Add, text,x25 yp+20 w210 cblue gChangeSystemTrayIconLink, Change System Tray Icon
Gui 15: Add, text,x25 yp+20 w210 cblue gCheckForUpdatesLink, Check for Updates Screens
Gui 15: Add, text,x25 yp+20 w210 cblue gConfigureHotkeysMenuLink, Configure Hotkeys && Folders
Gui 15: Add, text,x25 yp+20 w210 cblue gConfirmationMessageMenuLink, Confirmation Message && Menu
Gui 15: Add, text,x25 yp+20 w210 cblue gCreditsLink, Credits (accessed via the "About" screen)
Gui 15: Add, text,x25 yp+20 w210 cblue gCustomPictureNameOptionsLink, Custom Picture Name Options
Gui 15: Add, text,x25 yp+20 w210 cblue gDateAndTimeFormatScreensLink, Date && Time Naming Format 
Gui 15: Add, text,x25 yp+20 w210 cblue gDuplicateExistsLink, Duplicate Exists
Gui 15: Add, text,x25 yp+20 w210 cblue gEnvironmentVariablesLink, Environment Variables
Gui 15: Add, text,x25 yp+20 w210 cblue gEULALink, EULA (accessed via the "About" screen)
Gui 15: Add, text,x25 yp+20 w210 cblue gFavoritesToolbarLink, Favorites Toolbar
Gui 15: Add, text,x25 yp+20 w210 cblue gHelpScreenLink, Help Screen
Gui 15: Add, text,x25 yp+20 w210 cblue gHistoryLink, History Menu
Gui 15: Add, text,x25 yp+20 w210 cblue gProgramDocumentationLink, Program Documentation
Gui 15: Add, text,x25 yp+20 w210 cblue gResetAllSettingsScreenLink, Reset All Settings Screen
Gui 15: Add, text,x25 yp+20 w210 cblue gSplashScreenLink, Splash Screen
Gui 15: Add, text,x25 yp+20 w210 cblue gSurveyLink, Survey (accessed via the "About" screen)

Gui 15: Add, Groupbox, x265 y5 w240 h520,

Gui 15: Add, text, x280 y25 w220, To configure individual screens, click on a link on the left then click on each link below.
Gui 15: font, s11
Gui 15: Add, text, x280 yp+48, STEP 2:
Gui 15: Add, text, x280 yp+20 w215 vChooseLinkOnLeftFirst HwndHwndChooseLinkOnLeftFirst, Choose link on left first
Gui 15: font
Gui 15: Add, text, x280 yp+25 w210 cblue              gID1, Main Window Color
Gui 15: Add, text, x280 yp+20 w210 cblue vChangeLink2 gID2, Main Window Text Color
Gui 15: Add, text, x280 yp+20 w210 cblue vChangeLink3 gID3, Interior Window Color
Gui 15: Add, text, x280 yp+20 w210 cblue vChangeLink4 gID4, Interior Window Text Color
Gui 15: Add, text, x280 yp+20 w210 cblue vChangeLink5 gID5, Test Changes
Gui 15: Show, w515 h535, SavePictureAs V%Version% (Program Colors)
WinGet,SystemColorsID,ID, SavePictureAs V%Version% (Program Colors)
Gui 15: Color, %ProgramColorsMenuColorGuiVar%
return

/*
All more info screens will be the same
Help screens go with main gui screens
Credits goes with About screen
Delay menu goes with Confirmation Message
All Check for Updates will be the same
TroubleShooting check for updates will be the same as Check for Updates
Email log file will be the same as Additional Settings Menu color
Wait For Save Picture As Window will be the same as Additional Settings Menu
Log File will be the same as Additional Settings Menu
*/
15GuiEscape:
15GuiClose:
ToolTip
;AlwaysOnTop leaves gui on top in order below
IfWinExist, ahk_id %ChangeSystemTrayIconID%
 WinSet,AlwaysOnTop,on, ahk_id %ChangeSystemTrayIconID%
IfWinExist, ahk_id %CHID%
 WinSet,AlwaysOnTop,on, ahk_id %CHID%
IfWinExist, ahk_id %CaptureAreaOfScreenID%
 winset,alwaysontop,on,ahk_id %CaptureAreaOfScreenID%
IfWinExist, ahk_id %ToolbarID%
 WinSet,alwaysOnTop, on, ahk_id %ToolbarID%
gui 15: destroy
IfWinExist,ahk_id %PDID%
 {
  Sleep 10
  ControlFocus,edit1,ahk_id %PDID% ;trying to prevent the text in the edit box from being highlighted when System Colors Gui is destroyed.
  ControlClick,edit1,ahk_id %PDID%
 }
IfWinExist,ahk_id %SplashScreenID%
 {
  Sleep 10
  ControlFocus,edit1,ahk_id %SplashScreenID% ;trying to prevent the text in the edit box from being highlighted when System Colors Gui is destroyed.
  ControlClick,edit1,ahk_id %SplashScreenID%
 }
Return
TurnOffToolTip: ;used for SystemColors label
sleep 1000
ToolTip
return

;link on left of gui goes to one of the labels below. Each label changes the static controls on the right, and also saves the link choice in ****LinkClicked. So that the links on the right of the gui know which link on the left is clicked. When the link on the right is clicked it goes to one of the ID labels (ID1 thru ID5) below. The ID links tells the actual color changing label which item in the gui to change the color. As in Main Window, Main Window Text. The SystemColors Gui was done this way do to converting from the old way to the new way.
AboutLink:
GuiControl,,ChooseLinkOnLeftFirst,About Screen
GuiControl,,ChangeLink2,Main Window Text Color
GuiControl,,ChangeLink3,Test Changes
GuiControl,,ChangeLink4,
GuiControl,,ChangeLink5,
gosub ClearVariables
AboutLinkClicked = 1
ToolTip,About Screen
SetTimer,TurnOffToolTip,-1
return
AdditionalSettingsMenuLink:
GuiControl,,ChooseLinkOnLeftFirst,Additional Settings Menu
GuiControl,,ChangeLink2,Main Window Text Color
GuiControl,,ChangeLink3,Test Changes
GuiControl,,ChangeLink4,
GuiControl,,ChangeLink5,
gosub ClearVariables
AdditionalSettingsMenuLinkClicked = 1
ToolTip, Additional Settings Menu
SetTimer,TurnOffToolTip,-1
return
CaptureAreaOfScreenLink:
GuiControl,,ChooseLinkOnLeftFirst,Capture Area of Screen
GuiControl,,ChangeLink2,Main Window Text Color
GuiControl,,ChangeLink3,Test Changes
GuiControl,,ChangeLink4,
GuiControl,,ChangeLink5,
gosub ClearVariables
CaptureAreaOfScreenLinkClicked = 1
ToolTip, Capture Area of Screen
SetTimer,TurnOffToolTip,-1
return
ChangeSystemTrayIconLink:
GuiControl,,ChooseLinkOnLeftFirst,Change System Tray Icon
GuiControl,,ChangeLink2,Main Window Text Color
GuiControl,,ChangeLink3,Test Changes
GuiControl,,ChangeLink4,
GuiControl,,ChangeLink5,
gosub ClearVariables
ChangeSystemTrayIconLinkClicked = 1
ToolTip, Change System Tray Icon
SetTimer,TurnOffToolTip,-1
return
CheckForUpdatesLink:
GuiControl,,ChooseLinkOnLeftFirst,Check For Updates Screens
GuiControl,,ChangeLink2,Main Window Text Color
GuiControl,,ChangeLink3,Test Changes
GuiControl,,ChangeLink4,
GuiControl,,ChangeLink5,
gosub ClearVariables
CheckForUpdatesLinkClicked = 1
ToolTip, Check For Updates Screens
SetTimer,TurnOffToolTip,-1
return
CreditsLink:
GuiControl,,ChooseLinkOnLeftFirst,Credits Screen
GuiControl,,ChangeLink2,Main Window Text Color
GuiControl,,ChangeLink3,Test Changes
GuiControl,,ChangeLink4,
GuiControl,,ChangeLink5,
gosub ClearVariables
CreditsLinkClicked = 1
ToolTip,  Credits (accessed via the "About" screen)
SetTimer,TurnOffToolTip,-1
return
CustomPictureNameOptionsLink:
GuiControl,,ChooseLinkOnLeftFirst,Custom Picture Name Options
GuiControl,,ChangeLink2,Main Window Text Color
GuiControl,,ChangeLink3,Test Changes
GuiControl,,ChangeLink4,
GuiControl,,ChangeLink5,
gosub ClearVariables
CustomPictureNameOptionsLinkClicked = 1
ToolTip, Custom Picture Name Options
SetTimer,TurnOffToolTip,-1
return
DateAndTimeFormatScreensLink:
GuiControl,,ChooseLinkOnLeftFirst, Date && Time Naming Format
GuiControl,,ChangeLink2,Main Window Text Color
GuiControl,,ChangeLink3,Test Changes
GuiControl,,ChangeLink4,
GuiControl,,ChangeLink5,
gosub ClearVariables
DateAndTimeFormatScreensLinkClicked = 1
ToolTip, Date & Time Naming Format
SetTimer,TurnOffToolTip,-1
return
DuplicateExistsLink:
GuiControl,,ChooseLinkOnLeftFirst,Duplicate Exists
GuiControl,,ChangeLink2,Main Window Text Color
GuiControl,,ChangeLink3,Test Changes
GuiControl,,ChangeLink4,
GuiControl,,ChangeLink5,
gosub ClearVariables
DuplicateExistsLinkClicked = 1
ToolTip, Duplicate Exists
SetTimer,TurnOffToolTip,-1
return
EnvironmentVariablesLink:
GuiControl,,ChooseLinkOnLeftFirst, Environment Variables
GuiControl,,ChangeLink2,Main Window Text Color
GuiControl,,ChangeLink3,Test Changes
GuiControl,,ChangeLink4,
GuiControl,,ChangeLink5,
gosub ClearVariables
EnvironmentVariablesLinkClicked = 1
ToolTip, Environment Variables
SetTimer,TurnOffToolTip,-1
return
EULALink:
GuiControl,,ChooseLinkOnLeftFirst,EULA Screen
GuiControl,,ChangeLink2, Interior Window Color
GuiControl,,ChangeLink3, Interior Window Text Color
GuiControl,,ChangeLink4, Test Changes 
GuiControl,,ChangeLink5, 
gosub ClearVariables
EULALinkClicked = 1
ToolTip, EULA (accessed via the "About" screen)
SetTimer,TurnOffToolTip,-1
return
HistoryLink:
GuiControl,,ChooseLinkOnLeftFirst,History Menu
GuiControl,,ChangeLink2, Main Window Text Color
GuiControl,,ChangeLink3, Interior Window Color
GuiControl,,ChangeLink4, Interior Window Text Color
GuiControl,,ChangeLink5, Test Changes
gosub ClearVariables
HistoryLinkClicked = 1
ToolTip, History Menu
SetTimer,TurnOffToolTip,-1
return
SplashScreenLink:
GuiControl,,ChooseLinkOnLeftFirst,Splash Screen
GuiControl,,ChangeLink2, Interior Window Color
GuiControl,,ChangeLink3, Interior Window Text Color
GuiControl,,ChangeLink4, Test Changes 
GuiControl,,ChangeLink5, 
gosub ClearVariables
SplashScreenLinkClicked = 1
ToolTip, Splash Screen
SetTimer,TurnOffToolTip,-1
return
ProgramDocumentationLink:
GuiControl,,ChooseLinkOnLeftFirst,Program Documentation
GuiControl,,ChangeLink2, Interior Window Color
GuiControl,,ChangeLink3, Interior Window Text Color
GuiControl,,ChangeLink4, Test Changes
GuiControl,,ChangeLink5, 
gosub ClearVariables
ProgramDocumentationLinkClicked = 1
ToolTip, Program Documentation
SetTimer,TurnOffToolTip,-1
return
ConfirmationMessageMenuLink:
GuiControl,,ChooseLinkOnLeftFirst,Confirmation Message && Menu
GuiControl,,ChangeLink2, Circle Color
GuiControl,,ChangeLink3, Circle Text Color
GuiControl,,ChangeLink4, Test Changes
GuiControl,,ChangeLink5,
gosub ClearVariables
ConfirmationMessageMenuLinkClicked = 1
ToolTip, Confirmation Message & Menu
SetTimer,TurnOffToolTip,-1
return
FavoritesToolbarLink:
GuiControl,,ChooseLinkOnLeftFirst,Favorites Toolbar
GuiControl,,ChangeLink2, Test Changes
GuiControl,,ChangeLink3, 
GuiControl,,ChangeLink4, 
GuiControl,,ChangeLink5, 
gosub ClearVariables
FavoritesToolbarLinkClicked = 1
ToolTip, Favorites Toolbar
SetTimer,TurnOffToolTip,-1
return
ConfigureHotkeysMenuLink:
GuiControl,,ChooseLinkOnLeftFirst,Configure Hotkeys && Folders
GuiControl,,ChangeLink2, Main Window Text
GuiControl,,ChangeLink3, Test Changes
GuiControl,,ChangeLink4, 
GuiControl,,ChangeLink5,
gosub ClearVariables
ConfigureHotkeysMenuLinkClicked = 1
ToolTip, Configure Hotkeys & Folders
SetTimer,TurnOffToolTip,-1
return
HelpScreenLink:
GuiControl,,ChooseLinkOnLeftFirst,Help Screen
GuiControl,,ChangeLink2, Main Window Text
GuiControl,,ChangeLink3, Test Changes
GuiControl,,ChangeLink4, 
GuiControl,,ChangeLink5, 
gosub ClearVariables
HelpScreenLinkClicked = 1
ToolTip, Help Screen
SetTimer,TurnOffToolTip,-1
return
ResetAllSettingsScreenLink:
GuiControl,,ChooseLinkOnLeftFirst,Reset All Settings Screen
GuiControl,,ChangeLink2, Main Window Text
GuiControl,,ChangeLink3, Test Changes
GuiControl,,ChangeLink4, 
GuiControl,,ChangeLink5, 
gosub ClearVariables
ResetAllSettingsScreenLinkClicked = 1
ToolTip, Reset All Settings Screen
SetTimer,TurnOffToolTip,-1
return
SurveyLink:
GuiControl,,ChooseLinkOnLeftFirst,Survey Screen
GuiControl,,ChangeLink2, Main Window Text Color
GuiControl,,ChangeLink3, Interior Window Color
GuiControl,,ChangeLink4, Interior Window Text Color
GuiControl,,ChangeLink5, Test Changes
ToolTip, Survey (accessed via the "About" screen)
SetTimer,TurnOffToolTip,-1
gosub ClearVariables
SurveyLinkClicked = 1
return
ID1:
ControlGetText,tempvar,,ahk_id %HwndChooseLinkOnLeftFirst%
if tempvar = Choose link on left first
 { 
  MsgBox,270336,Information,Click link on left first
  return
 }
AboutScreenColors = Main Window
AdditionalSettingsMenuColors = Main Window
HistoryColors = Main Window
SplashScreenColors = Main Window
ProgramDocumentationColors = Main Window
ConfirmationMessageMenuColors = Main Window
FavoritesToolbarColors = Main Window
ConfigureHotkeysMenuColors = Main Window
HelpScreenColors = Main Window
CaptureAreaOfScreenColors = Main Window
ChangeSystemTrayIconColors = Main Window
CheckForUpdatesColors = Main Window
CreditsScreenColors = Main Window
CustomPictureNameOptionsColors = Main Window
DateAndTimeFormatScreensColors = Main Window
DuplicateExistsColors = Main Window
ResetAllSettingsScreenColors = Main Window
EnvironmentVariablesColors = Main Window
EULAColors = Main Window
SurveyColors = Main Window
Goto JumpLink ;use JumpLink to avoid duplicating JumpLink code 5 times.
ID2:
ControlGetText,tempvar,,ahk_id %HwndChooseLinkOnLeftFirst%
if tempvar = Choose link on left first
 { 
  MsgBox,270336,Information,Click link on left first
  return
 }
AboutScreenColors = Main Window Text
AdditionalSettingsMenuColors = Main Window Text
HistoryColors = Main Window Text
SplashScreenColors = Interior Window
ProgramDocumentationColors = Interior Window
ConfirmationMessageMenuColors = Circle Color
FavoritesToolbarColors = Test Colors
ConfigureHotkeysMenuColors = Main Window Text
HelpScreenColors = Main Window Text
CaptureAreaOfScreenColors = Main Window Text
ChangeSystemTrayIconColors = Main Window Text
CheckForUpdatesColors = Main Window Text
CreditsScreenColors = Main Window Text
CustomPictureNameOptionsColors = Main Window Text
DateAndTimeFormatScreensColors = Main Window Text
DuplicateExistsColors = Main Window Text
ResetAllSettingsScreenColors = Main Window Text
EnvironmentVariablesColors = Main Window Text
EULAColors = Interior Window
SurveyColors = Main Window Text
Goto JumpLink
ID3:
ControlGetText,tempvar,,ahk_id %HwndChooseLinkOnLeftFirst%
if tempvar = Choose link on left first
 { 
  MsgBox,270336,Information,Click link on left first
  return
 }
AboutScreenColors = Test Colors
HistoryColors = Interior Window
SplashScreenColors = Interior Window Text
ProgramDocumentationColors = Interior Window Text
ConfirmationMessageMenuColors = Circle Color Text
ConfigureHotkeysMenuColors = Test Colors
HelpScreenColors = Test Colors
CaptureAreaOfScreenColors = Test Colors
ChangeSystemTrayIconColors = Test Colors
CheckForUpdatesColors = Test Colors
CreditsScreenColors = Test Colors
CustomPictureNameOptionsColors = Test Colors
DateAndTimeFormatScreensColors = Test Colors
DuplicateExistsColors = Test Colors
ResetAllSettingsScreenColors = Test Colors
AdditionalSettingsMenuColors = Test Colors
EnvironmentVariablesColors = Test Colors
EULAColors = Interior Window Text
SurveyColors = Interior Window
Goto JumpLink
ID4:
ControlGetText,tempvar,,ahk_id %HwndChooseLinkOnLeftFirst%
if tempvar = Choose link on left first
 { 
  MsgBox,270336,Information,Click link on left first
  return
 }
HistoryColors = Interior Window Text
SplashScreenColors = Test Colors
ProgramDocumentationColors = Test Colors
ConfirmationMessageMenuColors = Test Colors
EULAColors = Test Colors
SurveyColors = Interior Window Text
Goto JumpLink

ID5:
ControlGetText,tempvar,,ahk_id %HwndChooseLinkOnLeftFirst%
if tempvar = Choose link on left first
 { 
  MsgBox,270336,Information,Click link on left first
  return
 }
HistoryColors = Test Colors
SurveyColors = Test Colors
JumpLink:
Tooltip
if AboutLinkClicked = 1
 goto AboutScreenColors
if HistoryLinkClicked = 1
 goto HistoryColors
if SplashScreenLinkClicked = 1
 goto SplashScreenColors
if ProgramDocumentationLinkClicked = 1
 goto ProgramDocumentationColors
if ConfirmationMessageMenuLinkClicked = 1
 goto ConfirmationMessageMenuColors
if FavoritesToolbarLinkClicked = 1
 goto FavoritesToolbarColors
if ConfigureHotkeysMenuLinkClicked = 1
 goto ConfigureHotkeysMenuColors
if HelpScreenLinkClicked = 1
 goto HelpScreenColors
if CaptureAreaOfScreenLinkClicked = 1
 goto CaptureAreaOfScreenColors
if ChangeSystemTrayIconLinkClicked = 1
 goto ChangeSystemTrayIconColors
if CreditsLinkClicked = 1
 goto CreditsScreenColors
if AdditionalSettingsMenuLinkClicked = 1
 goto AdditionalSettingsMenuColors
if CheckForUpdatesLinkClicked = 1
 goto CheckForUpdatesColors
if CustomPictureNameOptionsLinkClicked = 1
 goto CustomPictureNameOptionsColors
if DateAndTimeFormatScreensLinkClicked = 1
 goto DateAndTimeFormatScreensColors
if EnvironmentVariablesLinkClicked = 1
 goto EnvironmentVariablesColors
if EULALinkClicked = 1
 goto EULAcolors
if SurveyLinkClicked = 1
 goto SurveyColors
if DuplicateExistsLinkClicked = 1
 goto DuplicateExistsColors
if ResetAllSettingsScreenLinkClicked = 1
 goto ResetAllSettingsScreenColors
return
ClearVariables:
AboutLinkClicked =
AdditionalSettingsMenuLinkClicked = 
HistoryLinkClicked = 
SplashScreenLinkClicked =
ProgramDocumentationLinkClicked =
ConfirmationMessageMenuLinkClicked =
FavoritesToolbarLinkClicked =
ConfigureHotkeysMenuLinkClicked =
HelpScreenLinkClicked =
CaptureAreaOfScreenLinkClicked =
ChangeSystemTrayIconLinkClicked =
CheckForUpdatesLinkClicked =
CreditsLinkClicked =
CustomPictureNameOptionsLinkClicked =
DateAndTimeFormatScreensLinkClicked =
EnvironmentVariablesLinkClicked =
EULAlinkClicked = 
SurveyLinkClicked = 
DuplicateExistsLinkClicked =
ResetAllSettingsScreenLinkClicked =
return
HistoryColors:
if HistoryColors = Test Colors
 {
  IfWinExist,ahk_id %HistoryID%
   {
    WinGet, State,MinMax,ahk_id %HistoryID%
    WinActivate, ahk_id %HistoryID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %HistoryID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, ConfigureHistory
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 3: destroy
    Return
   }
 }
ToolTip,%HistoryColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if historyColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, historyColorGuiVar
if historyColors = Main Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, historyColorGuiTextVar
if historyColors = Interior Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, historyColorListBoxVar
if historyColors = Interior Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, historyColorListBoxTextVar
IfWinExist, ahk_id %HistoryID%
 {
  IniRead, HistoryColorGuiVar,SpaConfig.ini, SystemColors,historyColorGuiVar,7995B0
  IniRead, historyColorListBoxVar, SpaConfig.ini, SystemColors, historyColorListBoxVar, c0c0c0
  IniRead, historyColorGuiTextVar, SpaConfig.ini, SystemColors, historyColorGuiTextVar, 000000
  IniRead, historyColorListBoxTextVar, SpaConfig.ini, SystemColors, historyColorListBoxTextVar, 000000
  Gui 3: font, s12 c%historyColorGuiTextVar%, MS sans serif ;Main window text
  GuiControl, 3: Font, static1 ;Main window text
  Gui 3: font, s12 c%HistoryColorListBoxTextVar%, MS sans serif ;Listbox text
  GuiControl, 3: Font, listbox1 ;Listbox text
  Gui 3: Color,  %HistoryColorGuiVar%, %HistoryColorListboxVar% ;Main windows and listbox colors  
 }
Return
SplashScreenColors:
if SplashScreenColors = Test Colors 
 {
  IfWinExist,ahk_id %SplashScreenID%
   {                 ;need to disable here even though the message box below will disable all guis anyway. Otherwise the edit box color 
    WinGet, State,MinMax, ahk_id %SplashScreenID%
    WinActivate, ahk_id %SplashScreenID%
    Gui 50: +disabled ;changes to the main gui color, when activating SavePictureAs V%Version% (Program Colors)
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %SplashScreenID%
    WinActivate, ahk_id %SystemColorsID%
    Gui 50: -disabled
    Return
   } 
  Else
   {
    GoSub, SplashScreen
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 50: destroy
    Return
   }
 }
ToolTip,%SplashScreenColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2

if SplashScreenColors = Main Window 
 IniWrite, %color%, SpaConfig.ini, SystemColors, SplashScreenColorGuiVar
 
if SplashScreenColors = Interior Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, SplashScreenColorEditBoxVar

if SplashScreenColors = Interior Window Text 
 IniWrite, %color%, SpaConfig.ini, SystemColors, SplashScreenColorEditBoxTextVar
   
IfWinExist, ahk_id %SplashScreenID%
 {
  IniRead, SplashScreenColorGuiVar, SpaConfig.ini, SystemColors, SplashScreenColorGuiVar, d9d9fd
  
  IniRead, SplashScreenColorEditBoxVar, SpaConfig.ini, SystemColors, SplashScreenColorEditBoxVar, c0c0c0
  StringSplit,Array,SplashScreenColorEditBoxVar
  SplashScreenColorEditBoxVar := (Array5 Array6 array3 Array4 array1 Array2)
    
  IniRead, SplashScreenColorEditBoxTextVar, SpaConfig.ini, SystemColors, SplashScreenColorEditBoxTextVar, 000000
  StringSplit,Array,SplashScreenColorEditBoxTextVar
  SplashScreenColorEditBoxTextVar := (Array5 Array6 array3 Array4 array1 Array2)
  
  Gui 50: Default
  Gui 50: font, s12 c%SplashScreenColorEditBoxTextVar%, MS sans serif
  Control_Colors("SplashScreenEditBox", "Set", "0x" SplashScreenColorEditBoxVar, "0x" SplashScreenColorEditBoxTextVar)
  WinSet,redraw,,ahk_id %SplashScreenID%
  Gui 50: Color,  %SplashScreenColorGuiVar%
 }
Return

ProgramDocumentationColors:
if ProgramDocumentationColors = Test Colors 
 {
  IfWinExist,ahk_id %PDID%
   {                 ;need to disable here even though the message box below will disable all guis anyway. Otherwise the edit box color 
    WinGet, State,MinMax,ahk_id %PDID%
    Gui 7: +disabled ;changes to the main gui color, when activating SavePictureAs V%Version% (Program Colors)
    WinRestore, ahk_id %PDID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %PDID%
    WinActivate, ahk_id %SystemColorsID%
    Gui 7: -disabled
    Return
   }
  Else
   {
    GoSub, ProgramDocumentation
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 7: destroy
    Return
   }
 }
ToolTip,%ProgramDocumentationColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if ProgramDocumentationColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, ProgramDocumentationColorGuiVar

if ProgramDocumentationColors = Interior Window 
 IniWrite, %color%, SpaConfig.ini, SystemColors, ProgramDocumentationColorListBoxVar
 
if ProgramDocumentationColors = Interior Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, ProgramDocumentationColorListBoxTextVar

IfWinExist,SavePictureAs V%Version% (Program Documentation)
 {
  IniRead, ProgramDocumentationColorGuiVar,SpaConfig.ini, SystemColors, ProgramDocumentationColorGuiVar,7995B0
  IniRead, ProgramDocumentationColorEditBoxVar, SpaConfig.ini, SystemColors, ProgramDocumentationColorListBoxVar, c0c0c0
  StringSplit,Array,ProgramDocumentationColorEditBoxVar
  ProgramDocumentationColorEditBoxVar := (Array5 Array6 array3 Array4 array1 Array2)
  
  IniRead, ProgramDocumentationColorEditBoxTextVar, SpaConfig.ini, SystemColors, ProgramDocumentationColorListBoxTextVar, 000000
  StringSplit,Array,ProgramDocumentationColorEditBoxTextVar
  ProgramDocumentationColorEditBoxTextVar := (Array5 Array6 array3 Array4 array1 Array2)
    
  Gui 7: default
  Gui 7: font, s12 c%ProgramDocumentationColorEditBoxTextVar%
  Control_Colors("ProgramDocumentationEditBox", "Set", "0x" ProgramDocumentationColorEditBoxVar, "0x" ProgramDocumentationColorEditboxTextVar)
  WinSet,redraw,,SavePictureAs V%Version% (Program Documentation)
  
  Gui 7: Color,  %ProgramDocumentationColorGuiVar%
 }
Return

ConfirmationMessageMenuColors:
if ConfirmationMessageMenuColors = Test Colors
 {
  IfWinExist, ahk_id %CMCID%
   {
    WinGet, State,MinMax,ahk_id %CMCID%
    WinActivate, ahk_id %CMCID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %CMCID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, ConfigureConfirmationMessage ;displays Gui 8 and Gui 17
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 8: destroy
    Gui 17: Hide
    Return
   }
 }
ToolTip,%ConfirmationMessageMenuColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if ConfirmationMessageMenuColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, ConfigureConfirmationMessageColorGuiVar
if ConfirmationMessageMenuColors = Circle Color
 IniWrite, %color%, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageWindowColor
if ConfirmationMessageMenuColors = Circle Color Text
 IniWrite, %color%, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageTextColor
IfWinExist, ahk_id %CMCID%
 {
  IniRead, ConfigureConfirmationMessageColorGuiVar, SpaConfig.ini, SystemColors, ConfigureConfirmationMessageColorGuiVar, 7995B0
  IniRead, ConfirmationMessageWindowColor, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageWindowColor, 8b8b8b
  IniRead, ConfirmationMessageTextColor, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageTextColor, 000000
  Gui 17: font
  gui 17: font, s26 w700 c%ConfirmationMessageTextColor% , Times New Roman Bold italic
  GuiControl, 17: Font, static1
  Gui 8:  color, %ConfigureConfirmationMessageColorGuiVar%
  Gui 17: color, %ConfirmationMessageWindowColor%
 }
Return
FavoritesToolbarColors:
if FavoritesToolbarColors = Test Colors
 {
  IfWinExist, ahk_id %ToolbarID%
   {
    WinRestore, ahk_id %ToolbarID%
    WinActivate, ahk_id %ToolbarID%
    Gui 51: color, %color%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    WinSet,AlwaysOnTop,off, ahk_id %ToolbarID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, FavoritesToolbar
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 51: destroy
    Return
   }
 }
ToolTip,%FavoritesToolbarColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if FavoritesToolbarColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, FavoritesToolbarGuiVar
IfWinExist, ahk_id %ToolbarID%
 {
  IniRead, FavoritesToolbarGuiVar, SpaConfig.ini, SystemColors, FavoritesToolbarGuiVar, 7995B0
  Gui 51: color, %FavoritesToolbarGuiVar%
 }
Return
ConfigureHotkeysMenuColors:
if ConfigureHotkeysMenuColors = Test Colors
 {
  IfWinExist, ahk_id %CHID%
   {
    WinGet, State,MinMax,ahk_id %CHID%
    WinRestore,ahk_id %CHID%
    WinActivate, ahk_id %CHID%
    WinSet,AlwaysOnTop,Off,ahk_id %CHID%
    MsgBox,270336,Preview Colors,Click Ok to continue
    if State = -1
     WinMinimize,ahk_id %CHID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, ConfigureHotkeys
    WinSet,AlwaysOnTop,Off,ahk_id %CHID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 25: destroy
    Return
   }
 }
ToolTip,%ConfigureHotkeysMenuColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if ConfigureHotkeysMenuColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, ConfigureHotkeysColorGuiVar
if ConfigureHotkeysMenuColors = Main Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, ConfigureHotkeysColorGuiTextVar

IfWinExist, ahk_id %CHID%
 {
  IniRead, ConfigureHotkeysColorGuiVar, SpaConfig.ini, SystemColors, ConfigureHotkeysColorGuiVar, c0c0c0
  IniRead, ConfigureHotkeysColorGuiTextVar, SpaConfig.ini, SystemColors, ConfigureHotkeysColorGuiTextVar, 000000
  Gui 25: font
  Gui 25: font, s12 c%ConfigureHotkeysColorGuiTextVar%
  GuiControl, 25: Font, static1
    
  Gui 25: font
  Gui 25: font, s11 underline c%ConfigureHotkeysColorGuiTextVar%
  GuiControl, 25: Font, static2
  GuiControl, 25: Font, static38
  GuiControl, 25: Font, static39
    
  Gui 25: font
  Gui 25: font, s10 c%ConfigureHotkeysColorGuiTextVar%
  GuiControl, 25: Font, static35
  GuiControl, 25: Font, static36
  GuiControl, 25: Font, static37
    
  Gui 25: font
  Gui 25: font, s9 c%ConfigureHotkeysColorGuiTextVar%
  loop 39
   {
    if ( a_index > 2 and a_index < 35 )
     GuiControl, 25: Font, static%a_index%
   }
  loop 16
   GuiControl, 25: Font, button%a_index%
  Gui 25: color, %ConfigureHotkeysColorGuiVar%
 }
WinActivate, ahk_id %SystemColorsID%
Return
HelpScreenColors:
if HelpScreenColors = Test Colors
 {
  IfWinExist, ahk_id %UserHelpID%
   {
    WinGet, State,MinMax,ahk_id %UserHelpID%
    WinActivate, ahk_id %UserHelpID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %UserHelpID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, UserHelp
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 6: destroy
    Return
   }
 }
ToolTip,%HelpScreenColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if HelpScreenColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, HelpColorGuiVar
if HelpScreenColors = Main Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, HelpColorGuiTextVar
IfWinExist, ahk_id %UserHelpID%
 {
  IniRead, HelpColorGuiTextVar, SpaConfig.ini, SystemColors, HelpColorGuiTextVar, 000000
  IniRead, HelpColorGuiVar, SpaConfig.ini, SystemColors, HelpColorGuiVar, c0c0c0
  Gui 6: font
  Gui 6: font, s14 c%HelpColorGuiTextVar%, MS sans serif
  GuiControl, 6: Font, static1
  Gui 6: color, %HelpColorGuiVar%
 }
WinActivate, ahk_id %SystemColorsID%
Return
CaptureAreaOfScreenColors:
if CaptureAreaOfScreenColors = Test Colors
 {
  IfWinExist, ahk_id %CaptureAreaOfScreenID%
   {
    WinGet, State,MinMax,ahk_id %CaptureAreaOfScreenID%
    winset,alwaysontop,off,ahk_id %CaptureAreaOfScreenID%
    TestingColors = 1
    WinActivate, ahk_id %CaptureAreaOfScreenID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %CaptureAreaOfScreenID%
    WinActivate, ahk_id %SystemColorsID%
    TestingColors = 0
    Return
   }
  Else
   {
    GoSub, ConfigureCaptureScreen
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 60: destroy
    Return
   }
 }
ToolTip,%CaptureAreaOfScreenColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if CaptureAreaOfScreenColors = Main Window
  IniWrite, %color%, SpaConfig.ini, SystemColors, CaptureAreaOfScreenColorGuiVar
if CaptureAreaOfScreenColors = Main Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, CaptureAreaOfScreenColorGuiTextVar
IfWinExist, ahk_id %CaptureAreaOfScreenID%
 {
  IniRead, CaptureAreaOfScreenColorGuiTextVar, SpaConfig.ini, SystemColors, CaptureAreaOfScreenColorGuiTextVar, 000000
  IniRead, CaptureAreaOfScreenColorGuiVar, SpaConfig.ini, SystemColors, CaptureAreaOfScreenColorGuiVar, c0c0c0 
    Gui 60: font
  Gui 60: font, s10 c%CaptureAreaOfScreenColorGuiTextVar%, 
  loop 16
  GuiControl, 60: Font, button%A_Index%  
  Gui 60: color, %CaptureAreaOfScreenColorGuiVar%
 }
WinActivate, ahk_id %SystemColorsID%
Return
AboutScreenColors:
if AboutScreenColors = Test Colors
 {
  IfWinExist, ahk_id %AboutID%
   {
    WinGet, State,MinMax, ahk_id %AboutID%
    WinActivate, ahk_id %AboutID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize, ahk_id %AboutID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, About
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 5: destroy
    Return
   }
 }
ToolTip,%AboutScreenColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if AboutScreenColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, AboutColorGuiVar
if AboutScreenColors = Main Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, AboutColorGuiTextVar
IfWinExist, ahk_id %AboutID%
 {
  ;xxxx adding default values to inireads
  IniRead, AboutColorGuiTextVar, SpaConfig.ini, SystemColors, AboutColorGuiTextVar, 000000
  IniRead, AboutColorGuiVar, SpaConfig.ini, SystemColors, AboutColorGuiVar, c0c0c0
  Gui 5: font, s12 c%AboutColorGuiTextVar% 
  loop 4
   GuiControl, 5: Font, static%A_Index%
  GuiControl, 5: Font, syslink1
  Gui 5: color, %AboutColorGuiVar%  
 }
WinActivate, ahk_id %SystemColorsID%
Return
AdditionalSettingsMenuColors:
if AdditionalSettingsMenuColors = Test Colors
 {
  IfWinExist, ahk_id %ASMID%
   {
    WinGet, State,MinMax, ahk_id %ASMID%
    WinActivate, ahk_id %ASMID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,  ahk_id %ASMID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, AdditionalSettingsMenu
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 22: destroy
    Return
   }
 }
ToolTip,%AdditionalSettingsMenuColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2


if AdditionalSettingsMenuColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, AdditionalSettingsMenuColorGuiVar
if AdditionalSettingsMenuColors = Main Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, AdditionalSettingsMenuColorGuiTextVar 
  
IfWinExist, ahk_id %ASMID%
 {
  IniRead, AdditionalSettingsMenuColorGuiVar, SpaConfig.ini, SystemColors, AdditionalSettingsMenuColorGuiVar, c0c0c0
  IniRead, AdditionalSettingsMenuColorGuiTextVar, SpaConfig.ini, SystemColors, AdditionalSettingsMenuColorGuiTextVar, 000000 
  Gui 22: font,
  Gui 22: font, s10 bold c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 22: Font, button1
  GuiControl, 22: Font, button6
  GuiControl, 22: Font, button19
  GuiControl, 22: Font, button25
  GuiControl, 22: Font, button30
  GuiControl, 22: Font, button33
  
  Gui 22: font ;remove bold
  Gui 22: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%, MS sans serif
  Loop 38  ;20 22 23 24 
   {
    If ( a_index <> 1 and a_index <> 5 and a_index <> 6 and a_index <> 18 and a_index <> 19 and a_index <> 20 and a_index <> 21 and a_index <> 22 and a_index <> 23 and a_index <> 24 and a_index <> 25 and a_index <> 30 and a_index <> 33 and a_index <> 36 and a_index <> 39  )
    GuiControl, 22: Font, button%A_Index%
    n = %a_index%
   }
  Loop 3
   GuiControl, 22: Font, static%A_Index%
  Gui 22: font ;need 9 font for button21
  Gui 22: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%, MS sans serif
  GuiControl, 22: Font, button21
  Gui 22: color, %AdditionalSettingsMenuColorGuiVar%
  WinSet,redraw,, ahk_id %ASMID%
 }

IfWinExist, ahk_id %MoreInfoFilenamingConventionID%
 {
  Gui 30: font
  Gui 30: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 30: Font, static1
  
  Gui 30: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 30: Font, static2
  GuiControl, 30: Font, static3
  GuiControl, 30: Font, static4

  Gui 30: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
  Loop 3
   GuiControl, 30: Font, button%A_Index%

  Gui 30: color, %AdditionalSettingsMenuColorGuiVar%
 }

IfWinExist, ahk_id %MoreInfoDuplicatesID%
 {
  Gui 35: font
  Gui 35: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 35: Font, static1
  
  Gui 35: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
  Loop 20
   {
    if A_index > 1
     GuiControl, 35: Font, static%A_Index%
   }
  
  Gui 35: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
  Loop 6
   GuiControl, 35: Font, button%A_Index%

  Gui 35: color, %AdditionalSettingsMenuColorGuiVar%
 } 

IfWinExist, ahk_id %MoreInfoStartUpID%
 {
  Gui 31: font
  Gui 31: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 31: Font, static1
  
  Gui 31: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
  Loop 5
   {
    if A_index > 1
     GuiControl, 31: Font, static%A_Index%
   }
  
  Gui 31: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
  Loop 6
   GuiControl, 31: Font, button%A_Index%

  Gui 31: color, %AdditionalSettingsMenuColorGuiVar%
 } 
IfWinExist, ahk_id %MoreInfoConfirmationMessageID%
 {
  Gui 32: font
  Gui 32: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 32: Font, static1
  
  Gui 32: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 32: Font, static2
  GuiControl, 32: Font, static3
  
  Gui 32: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 32: Font, button1
  GuiControl, 32: Font, button2

  Gui 32: color, %AdditionalSettingsMenuColorGuiVar%
 } 
IfWinExist, ahk_id %MoreInfoHistoryID%
 {
  Gui 33: font
  Gui 33: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 33: Font, static1
  
  Gui 33: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
  Loop 15
   {
    if A_index > 1
     GuiControl, 33: Font, static%A_Index%
   }
  
  Gui 33: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
  Loop 5
   GuiControl, 33: Font, button%A_Index%

  Gui 33: color, %AdditionalSettingsMenuColorGuiVar%
} 
IfWinExist, ahk_id %MoreInfoErrorLoggingID%
 {
  Gui 34: font
  Gui 34: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 34: Font, static1
  
  Gui 34: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 34: Font, static2
  GuiControl, 34: Font, static3
  
  Gui 34: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 34: Font, button1
  GuiControl, 34: Font, button2

  Gui 34: color, %AdditionalSettingsMenuColorGuiVar%
 } 
IfWinExist, ahk_id %ELID%
 {
  Gui 23: font
  Gui 23: font, s12 c%AdditionalSettingsMenuColorGuiTextVar%,Courier New
  GuiControl, 23: Font, static1

  Gui 23: color, %AdditionalSettingsMenuColorGuiVar%
 }
IfWinExist, ahk_id %EELID%
 {
  Gui 2: font
  Gui 2: font, s12 c%AdditionalSettingsMenuColorGuiTextVar%
  loop 3
   GuiControl, 2: Font, static%A_Index%
  
  Gui 2: font, s11 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 2: Font, static4
  GuiControl, 2: Font, static5

  Gui 2: color, %AdditionalSettingsMenuColorGuiVar%
 }
IfWinExist, ahk_id %WFSPAWID%
 {
  Gui 29: font
  Gui 29: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
  GuiControl, 29: Font, static1
  GuiControl, 29: Font, static2
  
  Gui 29: color, %AdditionalSettingsMenuColorGuiVar%
 }
WinActivate, ahk_id %SystemColorsID%
Return

ChangeSystemTrayIconColors:
if ChangeSystemTrayIconColors = Test Colors
 {
  IfWinExist, ahk_id %ChangeSystemTrayIconID%
   {
    WinGet, State,MinMax,ahk_id %ChangeSystemTrayIconID%
    WinSet,AlwaysOnTop,off, ahk_id %ChangeSystemTrayIconID%
    WinActivate, ahk_id %ChangeSystemTrayIconID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,  ahk_id %ChangeSystemTrayIconID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, ChangeTrayIcon
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 49: destroy
    Return
   }
 }
ToolTip,%ChangeSystemTrayIconColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if ChangeSystemTrayIconColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, ChangeSystemTrayIconColorGuiVar
if ChangeSystemTrayIconColors = Main Window Text
IfWinExist, ahk_id %ChangeSystemTrayIconID%
 {
  IniRead, ChangeSystemTrayIconColorGuiTextVar, SpaConfig.ini, SystemColors, ChangeSystemTrayIconColorGuiTextVar, 000000
  IniRead, ChangeSystemTrayIconColorGuiVar, SpaConfig.ini, SystemColors, ChangeSystemTrayIconColorGuiVar, c0c0c0
  Gui 49: font, s11 c%ChangeSystemTrayIconColorGuiTextVar%
  GuiControl, 49: Font, static1
    
  Count = %NumberOfIcons%
  if Count =
   Count = 11
  else
   Count++
  Gui 49: font, s8 c%ChangeSystemTrayIconColorGuiTextVar%
  loop %Count%
   {
    if A_index > 1
    GuiControl, 49: Font, button%A_index%
   }
  Gui 49: font, s10 c%ChangeSystemTrayIconColorGuiTextVar%
  GuiControl, 49: Font, AddIconsText 
  Gui 49: color, %ChangeSystemTrayIconColorGuiVar%  
 }
WinActivate, ahk_id %SystemColorsID%
Return
CheckForUpdatesColors:
if CheckForUpdatesColors = Test Colors
 {
  FoundGuiExists = 0
  IfWinExist, ahk_id %SavePictureAsUpdateCheckGui11ID%
   {
    WinGet, State,MinMax,ahk_id %SavePictureAsUpdateCheckGui11ID%
    WinActivate, ahk_id %SavePictureAsUpdateCheckGui11ID%
    MsgBox,270336,Preview Colors,Click Ok to continue
    if State = -1
     WinMinimize, ahk_id %SavePictureAsUpdateCheckGui11ID%
    WinActivate, ahk_id %SystemColorsID%
    FoundGuiExists = 1
    Return
   }
 IfWinExist, ahk_id %SavePictureAsCheckForUpdatesGui12ID%
   {
    WinGet, State,MinMax,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
    WinActivate, ahk_id %SavePictureAsCheckForUpdatesGui12ID%
    MsgBox,270336,Preview Colors,Click Ok to continue
    if State = -1
     WinMinimize, ahk_id %SavePictureAsCheckForUpdatesGui12ID%
    WinActivate, ahk_id %SystemColorsID%
    FoundGuiExists = 1
    Return
   } 
   IfWinExist, ahk_id %UpdateCheckGui13ID%
   {
    WinGet, State,MinMax,ahk_id %UpdateCheckGui13ID%
    WinActivate, ahk_id %UpdateCheckGui13ID%
    MsgBox,270336,Preview Colors,Click Ok to continue
    if State = -1
     WinMinimize, ahk_id %UpdateCheckGui13ID%   
    WinActivate, ahk_id %SystemColorsID%
    FoundGuiExists = 1
    Return
   } 
  IfWinExist, ahk_id %UpdateCheckOutOfDateGui14ID%
   {
    WinGet, State,MinMax,ahk_id %UpdateCheckOutOfDateGui14ID%
    WinActivate, ahk_id %UpdateCheckOutOfDateGui14ID%
    MsgBox,270336,Preview Colors,Click Ok to continue
    if State = -1
     WinMinimize, ahk_id %UpdateCheckOutOfDateGui14ID%
    WinActivate, ahk_id %SystemColorsID%
    FoundGuiExists = 1
    Return
   } 
  IfWinExist, ahk_id %ManualDownloadGui40ID%
   {
    WinGet, State,MinMax,ahk_id %ManualDownloadGui40ID%
    WinActivate, ahk_id %ManualDownloadGui40ID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
        if State = -1
     WinMinimize,ahk_id %ManualDownloadGui40ID%
    WinActivate, ahk_id %SystemColorsID%
    FoundGuiExists = 1
    Return
   }   
  IfWinExist, ahk_id %ManualDownloadGui41ID%
   {
    WinGet, State,MinMax,ahk_id %ManualDownloadGui41ID%
    WinActivate, ahk_id %ManualDownloadGui41ID%
    MsgBox,270336,Preview Colors,Click Ok to continue
    if State = -1
     WinMinimize, ahk_id %ManualDownloadGui41ID%   
    WinActivate, ahk_id %SystemColorsID%
    FoundGuiExists = 1
    Return
   }  
  IfWinExist, ahk_id %CheckingForUpdatesGui42ID%
   {
    WinGet, State,MinMax,ahk_id %CheckingForUpdatesGui42ID%
    WinActivate, ahk_id %CheckingForUpdatesGui42ID%
    MsgBox,270336,Preview Colors,Click Ok to continue
    if State = -1
     WinMinimize, ahk_id %CheckingForUpdatesGui42ID% 
    WinActivate, ahk_id %SystemColorsID%
    FoundGuiExists = 1
    Return
   }
  IfWinExist, ahk_id %ErrorCheckingForUPdatesGui43ID%
   {
    WinGet, State,MinMax,ahk_id %ErrorCheckingForUPdatesGui43ID%
    WinActivate, ahk_id %ErrorCheckingForUPdatesGui43ID%
    MsgBox,270336,Preview Colors,Click Ok to continue
    if State = -1
     WinMinimize, ahk_id %ErrorCheckingForUPdatesGui43ID%   
    WinActivate, ahk_id %SystemColorsID%
    FoundGuiExists = 1
    Return
   }
  IfWinExist, ahk_id %ViewChangesGui46ID%
   {
    WinGet, State,MinMax,ahk_id %ViewChangesGui46ID%
    WinActivate, ahk_id %ViewChangesGui46ID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %ViewChangesGui46ID%
    WinActivate, ahk_id %SystemColorsID%
    FoundGuiExists = 1
    Return
   }
  If FoundGuiExists = 0
   {
    GoSub, CheckForUpdatesGui
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 12: destroy
    Return
   }
 }
ToolTip,%CheckForUpdatesColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if CheckForUpdatesColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, CheckForUpdatesColor

if CheckForUpdatesColors = Main Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, CheckForUpdatesTextColor

IniRead,CheckForUpdatesColor,SpaConfig.ini,SystemColors,CheckForUpdatesColor,c0c0c0
IniRead, CheckForUpdatesTextColor, SpaConfig.ini, SystemColors, CheckForUpdatesTextColor, 000000

IfWinExist, ahk_id %SavePictureAsUpdateCheckGui11ID%
 {
  Gui 11: font
  Gui 11: font, s12 c%CheckForUpdatesTextColor%
  GuiControl, 10: Font, static1
  
  Gui 11: font
  Gui 11: font, s10 c%CheckForUpdatesTextColor%
  GuiControl, 10: Font, static2
  
  Gui 11: font
  Gui 11: font, s9 c%CheckForUpdatesTextColor%
  Loop 5
   {
    if a_index > 3
     GuiControl, 10: Font, button%a_index%
   }
  Gui 11: color, %CheckForUpdatesColor%
 }

IfWinExist, ahk_id %SavePictureAsCheckForUpdatesGui12ID%
 {
  Gui 12: font
  Gui 12: font, s12 c%CheckForUpdatesTextColor%
  GuiControl, 12: Font, static1
  
  Gui 12: font
  Gui 12: font, s9 c%CheckForUpdatesTextColor%
  GuiControl, 12: Font, button2  
  Gui 12: color, %CheckForUpdatesColor%
 }

IfWinExist, ahk_id %UpdateCheckGui13ID%
 {
  Gui 13: font
  Gui 13: font, s12 c%CheckForUpdatesTextColor%
  GuiControl, 13: Font, static1  
  Gui 13: color, %CheckForUpdatesColor%
 }    
   
IfWinExist, ahk_id %UpdateCheckOutOfDateGui14ID%
 {
  Gui 14: font
  Gui 14: font, s10 c%CheckForUpdatesTextColor%
  GuiControl, 14: Font, static2  
  Gui 14: color, %CheckForUpdatesColor%
 } 
    
IfWinExist, ahk_id %ManualDownloadGui40ID%
 {
  Gui 40: font
  Gui 40: font, s10 c%CheckForUpdatesTextColor%
  GuiControl, 40: Font, static1
  GuiControl, 40: Font, static2
  Gui 40: color, %CheckForUpdatesColor%
 }  

IfWinExist, ahk_id %ManualDownloadGui41ID%
 {
  Gui 41: font
  Gui 41: font, s10 c%CheckForUpdatesTextColor%
  GuiControl, 41: Font, static1
  GuiControl, 41: Font, static2
  Gui 41: color, %CheckForUpdatesColor%
 }  
   
IfWinExist, ahk_id %CheckingForUpdatesGui42ID%
 {
  Gui 42: font
  Gui 42: font, s10 c%CheckForUpdatesTextColor%
  GuiControl, 42: Font, static1
  Gui 42: color, %CheckForUpdatesColor%
 }

IfWinExist, ahk_id %ErrorCheckingForUPdatesGui43ID%
 {
  Gui 43: font
  Gui 43: font, s10 c%CheckForUpdatesTextColor%
  GuiControl, 43: Font, static1
  GuiControl, 43: Font, static2
  GuiControl, 43: Font, static3
  Gui 43: color, %CheckForUpdatesColor%
 }

IfWinExist, ahk_id %ViewChangesGui46ID%
 {
  Gui 46: font
  Gui 46: font, s10 c%CheckForUpdatesTextColor%
  GuiControl, 46: Font, static1
  Gui 46: color, %CheckForUpdatesColor%
 }

WinActivate, ahk_id %SystemColorsID%
Return

CreditsScreenColors:
if CreditsScreenColors = Test Colors
 {
  IfWinExist, ahk_id %CreditsID%
   {
    WinGet, State,MinMax, ahk_id %CreditsID%
    WinActivate, ahk_id %CreditsID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %CreditsID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, Credits
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 54: destroy
    Return
   }
 }
ToolTip,%CreditsScreenColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if CreditsScreenColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, CreditsColorGuiVar
if CreditsScreenColors = Main Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, CreditsColorGuiTextVar
IfWinExist, ahk_id %CreditsID%
 {
  IniRead, CreditsColorGuiTextVar, SpaConfig.ini, SystemColors, CreditsColorGuiTextVar, 000000
  IniRead, CreditsColorGuiVar, SpaConfig.ini, SystemColors, CreditsColorGuiVar, c0c0c0
  Gui 54: font, s12 c%CreditsColorGuiTextVar%
  GuiControl, 54: Font, static1
  GuiControl, 54: Font, static2
  GuiControl, 54: Font, syslink1
  Gui 54: color, %CreditsColorGuiVar%
 }
WinActivate, ahk_id %SystemColorsID%
Return
CustomPictureNameOptionsColors:
if CustomPictureNameOptionsColors = Test Colors
 {
  IfWinExist,ahk_id %FNFID%
   {
    WinGet, State,MinMax,ahk_id %FNFID%
    WinActivate, ahk_id %FNFID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %FNFID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, FileNameFormat
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 10: destroy
    Return
   }
 }
ToolTip,%CustomPictureNameOptionsColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if CustomPictureNameOptionsColors = Main Window
 {
  iniwrite, %color%,SpaConfig.ini,SystemColors,FileNameFormatGuiColor

 }
if CustomPictureNameOptionsColors = Main Window Text
 {
  IniWrite, %color%, SpaConfig.ini, SystemColors, FileNameFormatGuiTextColor

 }
IfWinExist,ahk_id %FNFID%
 {
  iniread, FileNameFormatGuiTextColor,SpaConfig.ini,SystemColors,FileNameFormatGuiTextColor, 000000
  iniread, FileNameFormatGuiColor,SpaConfig.ini,SystemColors,FileNameFormatGuiColor, c0c0c0
  Gui 10: font, s10 c%FileNameFormatGuiTextColor%
  loop 4
   GuiControl, 10: Font, static%A_Index%
  Loop 9
   GuiControl, 10: Font, button%A_Index%
  Gui 10: color, %FileNameFormatGuiColor%
 }
WinActivate, ahk_id %SystemColorsID%
Return
DateAndTimeFormatScreensColors: 
GuiDoesExist = 0
if DateAndTimeFormatScreensColors = Test Colors
 {
  IfWinExist,ahk_id %DateAndTimeFormatForFilenamingConventionID%
   {
    WinGet, State,MinMax,ahk_id %DateAndTimeFormatForFilenamingConventionID%
    WinActivate, ahk_id %DateAndTimeFormatForFilenamingConventionID%
    MsgBox,270336,Preview Colors,Click Ok to continue
    if State = -1
     WinMinimize,ahk_id %DateAndTimeFormatForFilenamingConventionID%
    WinActivate, ahk_id %SystemColorsID%
    GuiDoesExist = 1
    Return
   }
  IfWinExist,ahk_id %DateAndTimeFormatForDuplicatesID% 
   {
    WinGet, State,MinMax,ahk_id %DateAndTimeFormatForDuplicatesID% 
    WinActivate, ahk_id %DateAndTimeFormatForDuplicatesID% 
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %DateAndTimeFormatForDuplicatesID% 
    WinActivate, ahk_id %SystemColorsID%
    GuiDoesExist = 1
    Return
   }
  if GuiDoesExist = 0
   {
    GoSub, DateFormat
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 37: destroy
    Return
   }
 }
ToolTip,%DateAndTimeFormatScreensColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if CustomPictureNameOptionsColors = Main Window
 iniwrite, %color%,SpaConfig.ini,SystemColors,DateAndTimeFormatScreensGuiColor
if CustomPictureNameOptionsColors = Main Window Text
 iniwrite, %color%,SpaConfig.ini,SystemColors,DateAndTimeFormatScreensGuiTextColor

IfWinExist,ahk_id %DateAndTimeFormatForFilenamingConventionID%
 {
  IniRead, DateAndTimeFormatScreensGuiTextColor, SpaConfig.ini, SystemColors,DateAndTimeFormatScreensGuiTextColor, 000000
  IniRead, DateAndTimeFormatScreensGuiColor, SpaConfig.ini, SystemColors,DateAndTimeFormatScreensGuiColor, c0c0c0
  Gui 37: font, s11 c%DateAndTimeFormatScreensGuiTextColor%
  GuiControl, 37: Font, static1
  Gui 37: font, s10 c%DateAndTimeFormatScreensGuiTextColor%
  loop 6
   GuiControl, 37: Font, button%A_Index%
  GuiControl, 37: Font, static2  
  GuiControl, 37: Font, Edit1
  Gui 37: color, %DateAndTimeFormatScreensGuiColor%
 }
IfWinExist,ahk_id %DateAndTimeFormatForDuplicatesID% 
 {
  IniRead, DateAndTimeFormatScreensGuiTextColor, SpaConfig.ini, SystemColors,DateAndTimeFormatScreensGuiTextColor, 000000
  IniRead, DateAndTimeFormatScreensGuiColor, SpaConfig.ini, SystemColors,DateAndTimeFormatScreensGuiColor, c0c0c0
  Gui 38: font, s11 c%DateAndTimeFormatScreensGuiTextColor%
  GuiControl, 38: Font, static1
  Gui 38: font, s10 c%DateAndTimeFormatScreensGuiTextColor%
  loop 6
   GuiControl, 38: Font, button%A_Index%
  GuiControl, 38: Font, static2
  GuiControl, 38: Font, Edit1
  Gui 38: color, %DateAndTimeFormatScreensGuiColor%
 } 

WinActivate, ahk_id %SystemColorsID%
Return
EnvironmentVariablesColors:
if EnvironmentVariablesColors = Test Colors
 {
  IfWinExist, ahk_id %EnvironmentVariablesID%
   {
    WinGet, State,MinMax,ahk_id %EnvironmentVariablesID%
    WinActivate, ahk_id %EnvironmentVariablesID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %EnvironmentVariablesID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, EnvironmentVariablesInfo
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 47: destroy
    Return
   }
 }
ToolTip,%EnvironmentVariablesColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if EnvironmentVariablesColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, EnvironmentVariablesColorGuiVar
if EnvironmentVariablesColors = Main Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, EnvironmentVariablesColorGuiTextVar
  
IfWinExist, ahk_id %EnvironmentVariablesID%
 {
  IniRead, EnvironmentVariablesColorGuiTextVar, SpaConfig.ini, SystemColors, EnvironmentVariablesColorGuiTextVar, 000000
  IniRead, EnvironmentVariablesColorGuiVar, SpaConfig.ini, SystemColors, EnvironmentVariablesColorGuiVar, c0c0c0
  Gui 47: font, s11 c%EnvironmentVariablesColorGuiTextVar%
  GuiControl, 47: Font, static1
  GuiControl, 47: Font, static2
  GuiControl, 47: Font, button1
  Gui 47: color, %EnvironmentVariablesColorGuiVar%
 }
 
IfWinExist,ahk_id %EnvironmentVariablesExamplesID%
 {
  IniRead, EnvironmentVariablesColorGuiTextVar, SpaConfig.ini, SystemColors, EnvironmentVariablesColorGuiTextVar, 000000
  IniRead, EnvironmentVariablesColorGuiVar, SpaConfig.ini, SystemColors, EnvironmentVariablesColorGuiVar, c0c0c0
  Gui 48: font, s11 c%EnvironmentVariablesColorGuiTextVar%
  loop 64
   GuiControl, 48: Font, static%A_Index%
  Gui 48: color, %EnvironmentVariablesColorGuiVar%
 }
WinActivate, ahk_id %SystemColorsID%
return
EULAColors:
if EulaColors = Test Colors 
 {
  IfWinExist,ahk_id %EULAid%
   {
    WinGet, State,MinMax,ahk_id %EULAid%
    WinActivate, ahk_id %EULAid%
    MsgBox,270336,Preview Colors,Click Ok to continue
    if State = -1
     WinMinimize,ahk_id %EULAid%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, EULA
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 57: destroy
    Return
   }
 }
ToolTip,%EulaColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if EULAColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, EULAColorGuiVar
if EULAColors = Interior Window 
 IniWrite, %color%, SpaConfig.ini, SystemColors, EULAColorListBoxVar
if EULAColors = Interior Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, EULAColorListBoxTextVar
IfWinExist,ahk_id %EulaID%
 {
  IniRead, EULAColorGuiVar,SpaConfig.ini, SystemColors, EULAColorGuiVar,FDD9D9
  IniRead, EULAColorListBoxTextVar, SpaConfig.ini, SystemColors, EULAColorListBoxTextVar, 000000
  IniRead, EULAColorListBoxVar, SpaConfig.ini, SystemColors, EULAColorListBoxVar, ffffff
  Gui 57: font, s12 c%EULAColorListBoxTextVar%, MS sans serif
  GuiControl, 57: Font, listbox1
  Gui 57: Color,  %EULAColorGuiVar%, %EULAColorListboxVar%
 }
WinActivate, ahk_id %SystemColorsID%
Return
SurveyColors: ;so survey colors like splashscreen
if SurveyColors = Test Colors 
 {
  IfWinExist,ahk_id %SurveyID%
   {
    Gui 56: +disabled
    WinActivate, ahk_id %SurveyID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 56: -disabled
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, Survey
    Gui 56: +disabled
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 56: destroy
    Return
   }
 }
ToolTip,%SurveyColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if SurveyColors = Main Window 
 IniWrite, %color%, SpaConfig.ini, SystemColors, SurveyColorGuiVar
if SurveyColors = Main Window Text 
 IniWrite, %color%, SpaConfig.ini, SystemColors, SurveyColorGuiTextVar
if SurveyColors = Interior Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, SurveyColorEditBoxVar
if SurveyColors = Interior Window Text 
  IniWrite, %color%, SpaConfig.ini, SystemColors, SurveyColorEditBoxTextVar
IfWinExist,ahk_id %SurveyID%
 {
  IniRead, SurveyColorGuiTextVar, SpaConfig.ini, SystemColors, SurveyColorGuiTextVar, 000000
  Gui 56: Font, S12 c%SurveyColorGuiTextVar%, Verdana
  GuiControl, 56: Font, Static1
  Gui 56: Font, S9 c%SurveyColorGuiTextVar%, Verdana
  GuiControl, 56: Font, syslink1
  GuiControl, 56: Font, syslink2
  GuiControl, 56: Font, syslink3
    
  IniRead, SurveyColorEditBoxVar, SpaConfig.ini, SystemColors, SurveyColorEditBoxVar, ffffff
  StringSplit,Array,SurveyColorEditBoxVar
  SurveyColorEditBoxVar := (Array5 Array6 array3 Array4 array1 Array2)
    
  IniRead, SurveyColorEditBoxTextVar, SpaConfig.ini, SystemColors, SurveyColorEditBoxTextVar, 000000
  StringSplit,Array,SurveyColorEditBoxTextVar
  SurveyColorEditBoxTextVar := (Array5 Array6 array3 Array4 array1 Array2)
    
  Gui 56: Default
  Gui 56: Font, S12 c%SurveyColorGuiTextVar%, Verdana
  Control_Colors("SurveyAssociatedVariable", "Set", "0x" SurveyColorEditBoxVar, "0x" SurveyColorEditBoxTextVar )
  WinSet,redraw,,ahk_id %SurveyID%
  IniRead, SurveyColorGuiVar, SpaConfig.ini, SystemColors, SurveyColorGuiVar, 7995B0
  Gui 56: Color,  %SurveyColorGuiVar%
 }
WinActivate, ahk_id %SystemColorsID%
return
ResetAllSettingsScreenColors:
if ResetAllSettingsScreenColors = Test Colors
 {
  IfWinExist, ahk_id %ResetAllDefaultsID%
   {
    WinGet, State,MinMax,ahk_id %ResetAllDefaultsID%
    WinActivate, ahk_id %ResetAllDefaultsID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    if State = -1
     WinMinimize,ahk_id %ResetAllDefaultsID%
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, ResetAllDefaults
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 16: destroy
    Return
   }
 }
ToolTip,%ResetAllSettingsScreenColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if ResetAllSettingsScreenColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, ResetAllDefaultsColorGuiVar
if ResetAllSettingsScreenColors = Main Window Text
 IniWrite, %color%, SpaConfig.ini, SystemColors, ResetAllDefaultsColorGuiTextVar
IfWinExist, ahk_id %ResetAllDefaultsID%
 {
  IniRead, ResetAllDefaultsColorGuiTextVar, SpaConfig.ini, SystemColors, ResetAllDefaultsColorGuiTextVar, 000000
  Gui 16: font, s11 c%ResetAllDefaultsColorGuiTextVar%
  GuiControl, 16: Font, static1
  IniRead, ResetAllDefaultsScreenColorGuiVar, SpaConfig.ini, SystemColors, ResetAllDefaultsColorGuiVar, c0c0c0
  Gui 16: color, %ResetAllDefaultsScreenColorGuiVar%
 }
WinActivate, ahk_id %SystemColorsID%
return
DuplicateExistsColors: 
if DuplicateExistsColors = Test Colors
 {
  IfWinExist, ahk_id %DuplicateExistsID%
   {
    WinActivate, ahk_id %DuplicateExistsID%
    MsgBox,270336,Preview Colors,Click Ok to continue 
    WinActivate, ahk_id %SystemColorsID%
    Return
   }
  Else
   {
    GoSub, DuplicateExistsTestScreen
    MsgBox,270336,Preview Colors,Click Ok to continue 
    Gui 58: destroy
    Return
   }
 }
ToolTip,%DuplicateExistsColors% Color
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
ToolTip
if CanceledDialog = 0
 Return
StringTrimLeft,Color, Color,  2
if DuplicateExistsColors = Main Window
 IniWrite, %color%, SpaConfig.ini, SystemColors, DuplicateExistsGuiColor
if DuplicateExistsColors = Main Window Text
  IniWrite, %color%, SpaConfig.ini, SystemColors, DuplicateExistsGuiTextColor
IfWinExist, ahk_id %DuplicateExistsID%
 {
  IniRead,DuplicateExistsGuiTextColor,spaconfig.ini,SystemColors,DuplicateExistsGuiTextColor,000000
  IniRead,DuplicateExistsGuiColor,spaconfig.ini,SystemColors,DuplicateExistsGuiColor,c0c0c0
  Gui 36: font, s11 c%DuplicateExistsGuiTextColor%
  GuiControl, 36: Font, static1
  GuiControl, 36: Font, static2
  
  Gui 36: font, s9 c%DuplicateExistsGuiTextColor%
  
  GuiControl, 36: Font, static9
  GuiControl, 36: Font, static10
  GuiControl, 36: Font, static14
  GuiControl, 36: Font, static15

  Loop 10
   GuiControl, 36: Font, button%A_Index%
  Gui 36: color, %DuplicateExistsGuiColor%
 }
WinActivate, ahk_id %SystemColorsID%
return
;============================+++++++============End Change System Colors Gui ======================================================

;==================================================================================================================================
;========================Begin change bar text window colors plus test Confirmation Message display=============================
ConfigureConfirmationMessage:
IfWinExist,ahk_id %CMCID%
 {
  WinRestore,ahk_id %CMCID%
  WinActivate,ahk_id %CMCID%
  return
 }
iniread, ConfigureConfirmationMessageColorGuiVar, SpaConfig.ini, SystemColors, ConfigureConfirmationMessageColorGuiVar, 7995B0
Gui 8: Add, Button, x50 y13 w65 h30 , Text
Gui 8: Add, Button, x165 y13 w65 h30 , Window
Gui 8: Add, Button, x280 y13 w65 h30 gEnableDisableConfirmationButton, 
Gui 8: Add, Button, x395 y13 w65 h30 , Set Position
Gui 8: Add, Button, x510 y13 w65 h30 , Delay
Gui 8:   +MinSize +MaxSize -MaximizeBox 
Gui 8: Show, h55 w625, SavePictureAs V%Version% (Confirmation Message Configuration)
WinGet,CMCID,id,SavePictureAs V%Version% (Confirmation Message Configuration)
IniRead, ConfirmationMessageValue, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageStatus, Enabled
if ConfirmationMessageValue = Enabled
 ControlSetText,button3,Disable,ahk_id %CMCID%
if ConfirmationMessageValue = Disabled
 ControlSetText,button3,Enable,ahk_id %CMCID%
Gui 8: Color, %ConfigureConfirmationMessageColorGuiVar%
gui 18:+owner8
IniRead, ConfirmationMessageDelay, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageDelay, 1000
IniRead, ConfirmationMessageTextColor, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageTextColor, 000000
IniRead, ConfirmationMessageWindowColor, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageWindowColor, 8b8b8b
;IniRead, ConfirmationMessageXPos,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageXpos, 410
;IniRead, ConfirmationMessageYPos,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageYpos, 215
;if ( ConfirmationMessageXPos < 0 or ConfirmationMessageXPos > A_ScreenWidth )
; ConfirmationMessageXPos := ((A_ScreenWidth / 2) - 100 ) 
;if ( ConfirmationMessageYPos < 0 or ConfirmationMessageYPos > A_ScreenHeight )
; ConfirmationMessageYPos := (( A_ScreenHeight / 2) - 100 )
;Gui 17: Show, x%ConfirmationMessageXpos% y%ConfirmationMessageYpos% , Confirmation Message
;WinSet, Region, 50-0 W100 H100 R100-100, Confirmation Message
winshow, ahk_id %CMID%
Return
8ButtonText:
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
if CanceledDialog = 0
 return
StringTrimLeft,color, Color,  2
IniWrite, %color%, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageTextColor
TextColor = %color%

Gui 17: font
Gui 17: font, s26 w700 , Times New Roman Bold italic
GuiControl, 17: Font, static1
Return
8ButtonWindow:
CanceledDialog := CmnDlg_Color( color := 0x808080 , hgui )
if CanceledDialog = 0
 return
StringTrimLeft,color, Color,  2
IniWrite, %color%, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageWindowColor
ConfirmationMessageWindowColor = %color%

Gui 17: Show, , Confirmation Message
Gui 17: Color, %ConfirmationMessageWindowColor%
Return
8ButtonSetPosition: 
MsgBox,262208, Set Position, Click and drag the Confirmation Message window where you want it on the screen. The position will automatically be saved.`n`nThis option is overridden by "Place Confirmation Message at mouse cursor" found on the Additional Settings Menu, under Settings.
Return
8ButtonDelay:
 IfWinExist,ahk_id %DMID%
  {
   WinRestore,ahk_id %DMID%
   WinActivate,ahk_id %DMID%
   return
  }
 Gui 18: 
 Gui 18: font, s12 , MS sans serif 
 Gui 18: add, text, w350 ,Enter in seconds the amount of time you want the Confirmation Message to remain on the screen
 Gui 18: font, s10 , MS sans serif 
 Gui 18: add, button, x34 y+20 w75 h25   +default -Wrap,Submit
 Gui 18: add, edit, x+57 yp w46 h25 vConfirmationMessageDelay Number Limit2
 Gui 18: add, button, x+55 yp w75 h25  -Wrap,Cancel
 Gui 18: Color,  %ConfigureConfirmationMessageColorGuiVar%
 Gui 18:   +MinSize +MaxSize -MaximizeBox 
 Gui 18: Show, h160, Delay Menu
 WinGet,DMID,ID, Delay Menu
 ControlClick, edit1, Delay Menu
 Return
 18ButtonSubmit: ;Delay Menu Submit button
 GuiControlGet, ConfirmationMessageDelay
 If ConfirmationMessageDelay=
  Return
 ConfirmationMessageDelay := (ConfirmationMessageDelay*1000)
 
 IniWrite, %ConfirmationMessageDelay%, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageDelay
 18ButtonCancel:
 18GuiClose:
 18GuiEscape:
 Gui 18: destroy
 Return
;**************************************************************************************************
;Begin ConfirmationMessage Enable Disable Check Section
;**************************************************************************************************
EnableDisableConfirmationButton:
ControlGetText,ControlText,button3,ahk_id %CMCID%
if ControlText = Enable
 {
  ControlSetText,button3,Disable,ahk_id %CMCID%
  IniWrite, ENABLED, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageStatus		      
  ToolTip, Confirmation Message is [Enabled]
  ConfirmationMessageValue = Enabled
 }
if ControlText = Disable
 {
  ControlSetText,button3,Enable,ahk_id %CMCID%
  IniWrite, DISABLED, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageStatus		      
  ToolTip, Confirmation Message is [Disabled]
  ConfirmationMessageValue = Disabled
 } 
SetTimer, RemoveToolTipE, 3000
IfWinExist, Additional Settings Menu
 {
  if ConfirmationMessageValue = Disabled
    ConfirmationMessageValue = 1
  if (  ConfirmationMessageValue = 1 )
   Control, Check , , Disable Confirmation Message, Additional Settings Menu
  else
   Control, UnCheck , , Disable Confirmation Message, Additional Settings Menu
  }

Return
RemoveToolTipE:
SetTimer, RemoveToolTipE, Off
ToolTip
Return
RemoveToolTipD:
SetTimer, RemoveToolTipD, Off
ToolTip
Return
8GuiEscape:
8Guiclose:
Gui 17: Hide
gui 8: destroy
Return
;==============================End Confirmation Message=========================================================
;==================================================================================================================================
#IfWinExist, GuiOutLine
rbutton::
Menu, SaveArea,Show
#IfWinExist
return
52GuiSize:
    GuiControl, Move, Border, X0 Y0 W%A_GuiWidth% H%A_GuiHeight%
return

~LButton::
IfWinActive, ahk_id %DuplicateExistsID%
 {                                       ;when edit box is clicked, this will check the corresponding radio button
  MouseGetPos,x,y,w,Control
  if (control = "edit1" or control = "edit2" or control = "edit3" or control = "edit4" )
   {
    StringTrimLeft,ControlNumber,Control,4
    if ControlNumber = 3 ;buttons for edit 3 and 4 are buttons 5 and 6
     ControlNumber = 5
    if ControlNumber = 4
     ControlNumber = 6
    GuiControl,36:,Button%ControlNumber%,1
   }
 }
CoordMode, Mouse
MouseGetPos, MouseStartX, MouseStartY, MouseWin
if MouseWin <> %CMID%
 Return
SetTimer, WatchMouse, 10
Return
WatchMouse:
CoordMode, Mouse
MouseGetPos, MouseX, MouseY
DeltaX = %MouseX%
DeltaX -= %MouseStartX%
DeltaY = %MouseY%
DeltaY -= %MouseStartY%
MouseStartX = %MouseX%  
MouseStartY = %MouseY%
WinGetPos, CMX, CMY,,, ahk_id %CMID%
CMX += %DeltaX%
CMY += %DeltaY%
SetWinDelay, -1   
WinMove, ahk_id %CMID%,, %CMX%, %CMY%
GetKeyState, LButtonState, LButton, P
if LButtonState = U  
 {
  
  IniWrite, %CMX%,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageXpos
  IniWrite, %CMY%,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageYpos
  ConfirmationMessageXpos = %CMX%
  ConfirmationMessageYpos = %CMY%
  SetTimer, WatchMouse, off
  Return
 }
Return

;=======================================Begin Reset All defaults ========================================================
ResetAllDefaults:
IfWinExist,ahk_id %ResetAllDefaultsID%
 {
  WinRestore,ahk_id %ResetAllDefaultsID%
  WinActivate,ahk_id %ResetAllDefaultsID%
  return
 }
iniread, ResetAllDefaultsColorGuiVar, SpaConfig.ini, SystemColors, ResetAllDefaultsColorGuiVar, c0c0c0
iniread, ResetAllDefaultsColorGuiTextVar, SpaConfig.ini, SystemColors,ResetAllDefaultsColorGuiTextVar, 000000
Gui 16: font, s11 c%ResetAllDefaultsColorGuiTextVar%, MS sans serif
Gui 16: Add, Text, w370 Center, This option will restore all user configurable settings back to their default settings. 
Gui 16: font, s10, MS sans serif
Gui 16: Add, Button,x91 y70 w70,Continue
Gui 16: Add, Button, x231 y70 w70,Cancel
Gui 16:   +MinSize +MaxSize 
Gui 16: Show, w390 h120,Reset All Settings
WinGet,ResetAllDefaultsID,id,Reset All Settings
Gui 16: Color, %ResetAllDefaultsColorGuiVar% 
Return  
16ButtonContinue:
FileDelete, %A_ScriptDir%\SpaConfig.ini
DoNotRunEntireQuitLabel = 1
Reload ;and use default configuration
sleep 5000 ;give Reload time to reload before Returning 
Return
16ButtonCancel:
16GuiClose:
16GuiEscape:
Gui 16: Destroy
Return
;====================================================Reset All Colors===============================================================
ResetAllColors:
MsgBox,4132,Reset?,Do you want to reset all colors to their default colors?
IfMsgBox, Yes
 {
  Loop, read, spaconfig.ini
   {
    MaxLines := a_index
    if A_LoopReadLine = [SystemColors]
     StartingLineNumber := (A_index + 1)
   }
  Loop %MaxLines%
   {
    FileReadLine,TempVar1,spaconfig.ini,%StartingLineNumber%
    TempVar2 := SubStr(TempVar1, 1, 1)
    if TempVar2 = [
     break
    else
     {
      StringSplit,TempArray,TempVar1,=
      IniDelete,SpaConfig.ini,SystemColors,%TempArray1%
     }
    if StartingLineNumber > %MaxLines%
     break
   }
  MsgBox,262208,SavePictureAs V%version%, All colors have been reset to the default settings.
 }
Return

CheckForUpdatesGui: 
if CheckForUpdatesDaily = 1
 SetTimer,CheckForUpdatesDaily, off

IfWinExist, ahk_id %SavePictureAsUpdateCheckGui11ID%
  {
  WinRestore, ahk_id %SavePictureAsUpdateCheckGui11ID%
  WinActivate,ahk_id %SavePictureAsUpdateCheckGui11ID%
  return
 }

IfWinExist, ahk_id %SavePictureAsCheckForUpdatesGui12ID%
 {
  WinRestore, ahk_id %SavePictureAsCheckForUpdatesGui12ID%
  WinActivate,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
  return
 }

IniRead,Value,SpaConfig.ini,CheckForUpdates,CheckForUpdates,1
if Value = 1
 Checked = Checked
else
 Checked =
IniRead,CheckForUpdatesColor,SpaConfig.ini,SystemColors,CheckForUpdatesColor,c0c0c0
IniRead,CheckForUpdatesTextColor,SpaConfig.ini,SystemColors,CheckForUpdatesTextColor, 000000
Gui 12: +ToolWindow  ;-sysmenu
Gui 12: font, s12 c%CheckForUpdatesTextColor%
Gui 12: Add, Text, y20 w340 h30 center , SavePictureAs current version: %version%
Gui 12: font, s10
Gui 12: Add, Button, x90 y70 w200 h25 , Check For Updates Now
Gui 12: font, s9 c%CheckForUpdatesTextColor%
Gui 12: Add, CheckBox, x5 y135 w340 h30 vCheckForUpdatesAtStartUp %Checked% hwndHWND_CheckForUpdatesAtProgramStartUpGui12ID , Check for updates at program start up
Gui 12: font, s12
Gui 12: Add, link,gRunInputBox x350 y135,<a id="1">?</a> 
Gui 12: Show, h160 w380, SavePictureAs (Check For Updates)
Gui 12: color, %CheckForUpdatesColor%
WinGet,SavePictureAsCheckForUpdatesGui12ID,ID,SavePictureAs (Check For Updates)
WinSet,AlwaysOnTop,On,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
Return
;xxxxx when gui12 is closed the timer is turned on, but there is currently a new version of savepictureas is available Gui being display.  title( update check) need to check for this gui before closing gui 12.
12GuiClose:
Gui 12: Submit
if CheckForUpdatesAtStartUp = 1
 Control, Check , , , ahk_id %HWND_CheckForUpdatesAtStartUPGui22ID%
else
 Control, unCheck , , , ahk_id %HWND_CheckForUpdatesAtStartUPGui22ID%
iniwrite, %CheckForUpdatesAtStartUp%, SpaConfig.ini,CheckForUpdates,CheckForUpdates
Gui 12: destroy
if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" )
 IfWinNotExist, ahk_id %UpdateCheckOutOfDateGui14ID%
  SetTimer,CheckForUpdatesDaily, on
return
RunInputBox:
WinSet,AlwaysOnTop,Off,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
Inputbox,var,Check For Updates (Alternate Method),Type or paste a valid url provided by tech support in the box below.
if Errorlevel = 1
 {
  WinSet,AlwaysOnTop,On,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
  return
 }
IniWrite,%var%,SpaConfig.ini,CheckForUpdates,NewLink
WinSet,AlwaysOnTop,On,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
12ButtonCheckForUpdatesNow:
ToolTip,Checking for updates in progress..Please Wait
UseBackUpUpdateLink =
NewestVersionNumber =
AhkFileSize =
ExeFileSize =
Changes =
Var =
AhkHashValue =
ExeHashValue =
Connected := Ping()

RetrieveUpdateInfo2:
if Connected <> 0 ;checking for internet connection because the timeout is quite long for URLDownloadToFile when there is no internet connection
 {
  Var =
  link0 = 0 ;only needed to determine which updatelink was used to check for updates
  link1 = 0
  link2 = 0
  link3 = 0
  link4 = 0
  link5 = 0
  
  IniRead,NewLink,SpaConfig.ini,CheckForUpdates,NewLink ;this is used if all else fails. The user puts an entry in the SpaConfig.ini under [CheckForUpdates]. The entry would be...
  ;NewLink = Http://[link to temp address for SavePictureAs_Info-3.txt]
  ;Doing it this way allows the automatic update to update to the latest version which will fix any update issues.
  if NewLink <> Error ;use one time link read from ini file
   {
    URLDownloadToFile, %NewLink%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    IniDelete,SpaConfig.ini,CheckForUpdates,NewLink
   }
  IfExist,C:\SpaTestingFolder ;this allows testing with a test SavePictureAs_Info.txt file
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, http://sourceforge.net/projects/savepictureas/files/SavePictureAs_Info-0.txt/download,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link0 = 1
   }
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, %UpdateLink1%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link1 = 1
   }
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, %UpdateLink2%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link2 = 1
   }
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, %UpdateLink3%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link3 = 1
   }
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, %UpdateLink4%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link4 = 1
   }
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, %UpdateLink5%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link5 = 1
   }
 }
   
   
Loop, Parse, Var ,`n,`r  
 {
  if a_index = 1
   {
    if a_loopfield <> SavePictureAs-By DataLife ;if line one is not equal to this then NewestVersionNumber will be blank - error message below catches that
     {
      UseBackUpUpdateLink++
      break
     }
   }
  if A_index = 2
   NewestVersionNumber = %A_LoopField%
  
  if A_index = 3
   {
    StringSplit,Tempvar,a_loopfield,%a_space%
    AhkFileSize = %Tempvar1%
    AhkHashValue = %Tempvar2%
   }
  
  if A_index = 4
   {
    StringSplit,Tempvar,a_loopfield,%a_space%
    ExeFileSize = %Tempvar1%
    ExeHashValue = %Tempvar2%
   }
  if A_index = 5
   AhkLink = %A_LoopField%
  if A_index = 6
   ExeLink = %A_LoopField%
 }

if UseBackUpUpdateLink <>
 {
  if UseBackUpUpdateLink < 3
   Goto RetrieveUpdateInfo2
 }
 
 ;find first line of Please note message
Loop, Parse, Var ,`n,`r 
 {
  StringLen,len,a_loopfield
  len := (len - 12)
  StringTrimRight,OutPutVar,a_loopfield, %len%
  if OutPutVar = Please Note:
   FirstLineForPleaseNoteMessage = %a_index%
 }
;find last line of Please note message
Loop, Parse, Var ,`n,`r  
 {
  StringLen,len,a_loopfield
  len := (len - 7)
  StringTrimRight,OutPutVar,a_loopfield,%len%
  if OutPutVar = version
   {
    LastLineForPleaseNoteMessage := ( a_index-1 )
    break
   }
  else
   LastLineForPleaseNoteMessage = 0
 }

PleaseNoteMessage =
Loop, Parse, Var ,`n,`r  
 {
  If  ( a_index > FirstLineForPleaseNoteMessage - 1 )
   PleaseNoteMessage = %PleaseNoteMessage%`n%A_LoopField%
  if ( a_index = LastLineForPleaseNoteMessage )
   break
 }
;find first line of "Changes"
Loop, Parse, Var ,`n,`r  
 {
  if ( A_index > LastLineForPleaseNoteMessage )
   {
    StringSplit,TempVarArray,a_loopfield,%a_space%
    if TempVarArray1 = version
     {
      StringSplit,Array,a_loopfield,%A_Space%
      if Array2 > %version%
       {
        ChangesLineStartsHere :=  ( a_index - 1 )
        break
       }
     }
   }
 } 
;Retrieve "Changes"
Loop, Parse, Var ,`n,`r  
 {
  if A_index > %ChangesLineStartsHere%
   Changes = %Changes%`n%A_LoopField% 
 }

if NewestVersionNumber = 
 {
    Tooltip
    WinSet,AlwaysOnTop,Off,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
    SplitPath,a_scriptname,,,ext
    Gui 43: font
    Gui 43: font, s10 c%CheckForUpdatesTextColor%
    Gui 43: add, text,hwndHWND_Gui43Static1,There was a problem checking for updates. Make sure you are connected to the internet and try again.
    Gui 43: add, text,, You can download the most recent version of SavePictureAs by clicking on one of the following links.
    if ext = exe
     {
      Gui 43: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.exe/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.exe/download</a>
      Gui 43: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.zip/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.zip/download</a>
     }
   else
     Gui 43: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.ahk/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.ahk/download</a>
    Gui 43: font
    Gui 43: font, s10 c%CheckForUpdatesTextColor%
    Gui 43: add, text, ,Save SavePictureAs.%ext% to a folder on your hard drive.`n`nExit SavePictureAs then overwrite SavePictureAs.%ext% with the new version.`n`nThen click on the new version. All your settings will still be the same.`n`nPlease email support@SavePictureAs.com with any issues.
	Gui 43: show, ,Error Checking for Updates
    Gui 43: color, c%CheckForUpdatesColor%
    WinGet,ErrorCheckingForUPdatesGui43ID,ID, Error Checking for Updates
    ControlFocus,,ahk_id %HWND_Gui43Static1%
	return
	
	43GuiClose:
    WinSet,AlwaysOnTop,On,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
	Gui 43: destroy
    IniRead,CheckForUpdatesDaily,spaconfig.ini,CheckForUpdates,CheckForUpdatesDaily,1
    if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" )
     SetTimer,CheckForUpdatesDaily,on
	return
 }
If (Version < NewestVersionNumber)
 {
  Tooltip
  IfWinExist, ahk_id %CheckForUpdatesNowID%
   {
    WinRestore, ahk_id %CheckForUpdatesNowID%
    WinActivate, ahk_id %CheckForUpdatesNowID%
    return
   }
  if changes =
   Changes = Not able to retrieve the necessary information.
  IniRead,CheckForUpdatesColor,SpaConfig.ini,SystemColors,CheckForUpdatesColor,c0c0c0
  WinSet,AlwaysOnTop,Off,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
  Gui 14: +toolWindow -sysmenu
  Gui 14: font, s12 italic underline cBlue,
  
  Gui 14: add, text, x30 y30 w300 gViewChanges,View Changes
  Gui 14: font
  Gui 14: font, s10 c%CheckForUpdatesTextColor%
  Gui 14: add, text,x30 y+15,A new version of SavePictureAs is available.`n`nCurrent version %Version%`nNewest version %newestversionnumber%`n`nWould you like to update to the newest version?
  Gui 14: add, button,   x20  y+25 w80 h25, No
  Gui 14: add, button,   x+20 yp-0 w80 h25, Yes
  Gui 14: add, button,   x+42 yp-0 h25 gHavingTrouble1, Having Trouble?
  Gui 14: add, GroupBox, x20 y15 w335 h165

  if ( LastLineForPleaseNoteMessage > 6 and Version > 8.9 )
   Gui 14: add, text, x30, %PleaseNoteMessage%
  Gui 14: show, ,Update Check
  Gui 14: color, %CheckForUpdatesColor%
  WinGet,UpdateCheckOutOfDateGui14ID,ID, Update Check
  WinSet,alwaysontop,on,ahk_id %UpdateCheckOutOfDateGui14ID%
  return
  
  HavingTrouble1:
  SplitPath,A_scriptname,,,ext
  WinSet,AlwaysOnTop,Off,ahk_id %SPACFUID%
  WinSet,AlwaysOnTop,Off,ahk_id %UpdateCheckOutOfDateGui14ID%
  WinSet,AlwaysOnTop,Off,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
  Gui 41: font
  Gui 41: font, s10 c%CheckForUpdatesTextColor%
  Gui 41: add, text,,%AddText%If the update process is not working correctly you can download the most recent version`nof SavePictureAs with either of the following links.
  if ext = exe
   {
    Gui 41: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.exe/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.exe/download</a>
    Gui 41: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.zip/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.zip/download</a>
   }
  else
    Gui 41: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.ahk/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.ahk</a>
    
  ;Gui 41: font
  Gui 41: add, text, ,Save SavePictureAs.%ext% to a folder on your hard drive.`n`nExit SavePictureAs then overwrite SavePictureAs.%ext% with the new version.`n`nThen click on the new version. All your settings will still be the same.`n`nPlease email support@SavePictureAs.com with any issues.`n`nYou can also check out the SavePictureAs forum post for the latest information on SavePictureAs and download it from there. 
  Gui 41: add, link,,<a href="http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/">http://http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/</a>
  
  Gui 41: show,,Manual Download Newest Version of SavePictureAs
  WinGet,ManualDownloadGui41ID,ID,Manual Download Newest Version of SavePictureAs
  Gui 41: color, %CheckForUpdatesColor%
  return

  41GuiClose:
  WinSet,AlwaysOnTop,On,ahk_id %UpdateCheckOutOfDateGui14ID%
  WinSet,AlwaysOnTop,On,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
  Gui 41: destroy
  IniRead,CheckForUpdatesDaily,spaconfig.ini,CheckForUpdates,CheckForUpdatesDaily,1
  if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" ) ;causes the timer to reset for the next day
   SetTimer,CheckForUpdatesDaily, %CheckForUpdatesDailyValue%
  return
  14GuiClose:
  14ButtonNo:
  WinSet,AlwaysOnTop,On,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
  Gui 14: destroy
  if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" )
   IfWinNotExist, ahk_id %SavePictureAsCheckForUpdatesGui12ID%
    SetTimer,CheckForUpdatesDaily, on
  return
   
  14ButtonYes:
  Gui 14: destroy
  SplitPath,A_scriptName,,,ext
  Counter = 0
  progress, B2 h80,,Downloading Update
  SetTimer,DownloadingUpdate,50
  if Ext = ahk
   UrlDownloadToFile, %ahkLink%, SavePictureAs.exx
  if Ext = Exe
   UrlDownloadToFile, %exeLink%, SavePictureAs.exx
  ;update section
  SetTimer,DownloadingUpdate,Off
  Progress,Off 
  
  FileRead,File,%A_ScriptDir%\SavePictureAs.exx
  FileGetSize,FileSize,%A_ScriptDir%\SavePictureAs.exx,k
  MD5ValueExx := Calc_MD5(&File,FileSize)
  
  if Ext = Ahk
   CorrectMd5Value := AhkHashValue
  else
   CorrectMd5Value := ExeHashValue
  
  if (( MD5ValueExx <> CorrectMd5Value ) and CorrectMD5Value <> "ByPass" )
   {
    MsgBox %MD5ValueExx%`n%CorrectMd5Value%
    WinSet,AlwaysOnTop,Off,ahk_id %SPACFUID%
    FileDelete,SavePictureAs.exx
    AddText = Not able to verify download.`n`n
    Gosub HavingTrouble1
    WinWaitClose, Manual Download Newest Version of SavePictureAs
    WinSet,AlwaysOnTop,On,ahk_id %SPACFUID%
    return
   }
  Else
   {
    If ( CorrectMD5Value <> "ByPass" )
     MsgBox,262208,Successful, Update successfully downloaded.`nSavePictureAs will now restart and use the updated version.`n`nThe downloaded update has been validated using the MD5 cryptographic hash function to verify its integrity.`n`n%CorrectMd5Value% (Expected hash value)`n%Md5ValueExx% (Actual hash value)
    else
     MsgBox,262208,Successful, Update successfully downloaded.`nSavePictureAs will now restart and use the updated version.
    FileAppend,
    (
ping -n 4 127.0.0.1
del SavePictureAs.%ext%
ping -n 4 127.0.0.1
ren SavePictureAs.exx SavePictureAs.%ext%
Start SavePictureAs.%ext%
ping 127.0.0.1
exit
    ),%A_ScriptDir%\SavePictureAs_Update.bat
    run SavePictureAs_Update.bat,,hide
    exitapp
   }
 } ;bracket for If (Version < NewestVersionNumber)
else
 {
  Tooltip
  IniRead,CheckForUpdatesColor,SpaConfig.ini,SystemColors,CheckForUpdatesColor,c0c0c0
  Gui 13: +toolwindow
  Gui 13: font, s12
  Gui 13: add, text, ,You are using the latest version of SavePictureAs (Version %Version%)
  Gui 13: show, autosize, Update Check
  WinGet,UpdateCheckGui13ID, id, Update Check
  WinSet,alwaysontop,on, ahk_id %UpdateCheckGui13ID%
  Gui 13: color, %CheckForUpdatesColor%
  return
  13ButtonOK:   
  13GuiClose:
  Gui 13: destroy
  IniRead,CheckForUpdatesDaily,spaconfig.ini,CheckForUpdates,CheckForUpdatesDaily,1
  if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" ) ;causes the timer to reset for the next day
   SetTimer,CheckForUpdatesDaily, %CheckForUpdatesDailyValue%
  return
 } ;else brace
return
;========================================================Error Logging==============================================================
EmailErrorLog:
IfWinExist,ahk_id %EELID%
 {
  WinRestore,ahk_id %EELID%
  WinActivate,ahk_id %EELID%
  return
 }
IniRead, AdditionalSettingsMenuColorGuiVar, SpaConfig.ini, SystemColors,AdditionalSettingsMenuColorGuiVar, c0c0c0
IniRead, AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini, SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000
Gui 2: font, s12 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 2: Add, Text, x22 y20 h30, Email: The following log file.
Gui 2: Add, Text, x22 y70 h30, %a_scriptdir%\LogFile.txt
Gui 2: Add, Text, x22 y120 h30, TO: support@SavePictureAs.com
Gui 2: font, s11
Gui 2: Add, Button, x22 y160 w60 h20 gEmailErrorLogOpenButton, Open
Gui 2: Add, Text, x97 y160, Open Log File Folder
Gui 2: Add, Button, x22 y190 w60 h20 gEmailErrorLogExitbutton, Exit
Gui 2: Add, Text, x97 y190, Close this window
Gui 2: Show, autosize, Email Log File
WinGet,EELID,id, Email Log File
Gui 2: color, %AdditionalSettingsMenuColorGuiVar%
Return
EmailErrorLogOpenButton:
Run, explorer %a_scriptdir%
return

EmailErrorLogExitbutton:
2GuiClose:
gui 2: destroy
return
;==================================================Fix Text Length for Traytip======================================================
FixControlTextLength: ;fixes text length for system tray icon tray tip
;later I need replace dllcall with function from here http://www.autohotkey.com/board/topic/53852-function-compressfilename/?hl=pathcompactpathexa#entry337549, 
VarSetCapacity( Shortp, 255 )
DllCall( "shlwapi.dll\PathCompactPathExA", Str,Shortp, Str,TextToControl, UInt,MaxChars )
TextToControl = %Shortp%
VarSetCapacity(Shortp, 0)
Return
ReloadSavePictureAs:
Reload
return
Quit:
loop, %a_scriptdir%\TempFolder\*.*
 {
  if A_LoopFilename <> DoNotUseThisFolder.txt
   FileDelete, %a_scriptdir%\TempFolder\%A_LoopFileName%
 }
if DoNotRunEntireQuitLabel = 1
 {
  exitapp
  Return
 }
IniRead,Eula,Spaconfig.ini,FirstRun,Eula
if Eula <> Accept
 IniWrite,Accept,Spaconfig.ini,FirstRun,Eula
IniRead,DeleteRecordOfTheLastSavedPictureOnExit,SpaConfig.ini,History,DeleteRecordOfTheLastSavedPictureOnExit,0
if DeleteRecordOfTheLastSavedPictureOnExit = 1
 IniWrite,%a_space%,SpaConfig.ini,History,LastSavedPicture
IniRead,ClearHistoryOnExit,SpaConfig.ini,History,ClearHistoryOnExit,0
if ClearHistoryOnExit = 1
 {
  loop %MaxHistoryMenuPicturesToList%
   IniWrite,%a_space% , SpaConfig.ini, History, History%A_Index%
 }

IfWinExist,Toolbar ;remember Gui posistion
 {
  WinGet, State,MinMax,ahk_id %ToolbarID% ;Don't save position if minimized 
  if State > -1
   {
    WinGetPos,x,y,,,Toolbar 
    IniWrite, %x%,SpaConfig.ini,ToolbarPos,ToolbarXpos
    IniWrite, %y%,SpaConfig.ini,ToolbarPos,ToolbarYpos
   }
 }
IfWinExist, ahk_id %HistoryID% ;remember Gui posistion
 {
   WinGet, State,MinMax,ahk_id %HistoryID%
   if State > -1
    {
     WinGetPos,x,y,,,ahk_id %HistoryID%
     IniWrite,%x%,SpaConfig.ini,HistoryMenuPos,XPos
     IniWrite,%y%,SpaConfig.ini,HistoryMenuPos,YPos
    }
 }    
exitapp
return
;=======================================================================================================================
CreateReadMeFirstTxt:
FileReadLine,LineContents,ReadMeFirst.Txt,3
if LineContents <> SavePictureAs Version V%Version%
 {
  FileDelete,%A_ScriptDir%\ReadMeFirst.txt
  FileAppend,
  (
   This program was written with AutoHotkey, a GPLed open source scripting language, and includes AutoHotkey code needed to execute the program. Source code for AutoHotkey can be found at: www.AhkScript.org/download

SavePictureAs Version V%Version%
SavePictureAs does not install anything on your computer. It runs from the folder you place SavePictureAs.exe in. The first time you run SavePictureAs.exe you will be asked some setup questions. 
   
Spaimage.jpg is displayed on the History Menu when any other image is not displayed. Spaimage.jpg can be replaced with a picture of your choice. Just rename your picture to spaimage.jpg and place in the same folder as %SavePictureAs%. To restore the original spaimage.jpg just delete the current spaimage.jpg in the same folder as %SavePictureAs% and then rerun %savepictureas%. It will replace the missing file.

SpaConfig.ini is the main configuration file. If you would like to run setup again you can delete SpaConfig.ini then run SavePictureAs again. Keep in mind all user settings will be lost.. I.E Location to save pictures, menu colors, Favorite Toolbar settings ETC...

Program operation:
 1. Place the mouse cursor over any picture on a webpage.
 2. Press the "ctrl and spacebar" or your chosen hotkey to save the picture to your hard drive.
 3. Use the system tray icon "Configure Hotkeys and Folders" or Favorites Toolbar to change the "Default Folder".
 4. You can configure the "Confirmation Message" and enable/disable the splash screen via the system tray menu items.
 5. Use the system tray menu item "History" to view, delete, copy and rename the last 30 (or user defined amount) saved pictures.
 6. Use the system tray icon to launch menu to change screen and text colors.
 7. Click on the system tray icon then "Settings" the "Additional Settings" for many more options.
 8. You can also set up hotkeys to Capture the entire screen, the active window, or an area of the screen.
 9. Exit the program by clicking the system tray icon.

SavePictureAs can save pictures using the following web browsers, and operating systems.
Internet Explorer
Firefox
Google Chrome
RockMelt
Maxthon
Opera
Safari
Avant
K-Meleon
Comodo Dragon
Yandex
Slim Browser

Windows WinXp
Windows Vista
Windows 7
Windows 8 (desktop mode)
Please report any suggestions, bugs or issues to support@SavePictureAs.com

End-User License Agreement (EULA)
-------------------------------------------------------

The following terms are used during the End-User License Agreement:

SOFTWARE = SavePictureAs
AUTHOR = Robert Jackson
USER = anyone who downloads, and/or runs (i.e. USES) the SOFTWARE

This is an agreement between the USER and the AUTHOR.
The SOFTWARE is protected by copyright laws and is the intellectual property of the AUTHOR.

All intellectual rights are reserved by the AUTHOR. The software is NOT the property of the USER, but only licensed
for use according to the terms of this EULA.

The SOFTWARE is freeware, which means that it can and should be distributed, copied, uploaded, downloaded and shared
freely by anyone, but only in its entirety, the original distribution. Any attempts to reverse-engineer, modify or
alter the executable binaries of the SOFTWARE in any way are strictly prohibited. Using parts of the SOFTWARE in any
other software product is strictly prohibited.

Distributing the whole SOFTWARE as part of another software product is bound to written permission of the AUTHOR,
except for free software collections. Such bundling must always be done with proper credit given. Selling, hiring,
lending, or making money in any way from any storage media (CD, DVD, floppy disk, hard disk, memory card, other) 
which admittedly contains the SOFTWARE is bound to prior written permission of the AUTHOR.

The SOFTWARE is provided by the AUTHOR in good faith but the AUTHOR does not make any representations or warranties
of any kind, express or implied, in relation to all or any part of the SOFTWARE, and all warranties and representations
are hereby excluded to the extent permitted by law.

Disclaimer: 

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
SOFTWARE.
  ),%A_ScriptDir%\ReadMeFirst.txt
}
Return
CreateProgramInfoAndCreditsTxt:
FileReadLine,LineContents,ProgramInfoAndCredits.txt,1
IfNotInString, LineContents, SavePictureAs Version %Version% by Robert Jackson
 {
  
  FileDelete,%a_scriptdir%\ProgramInfoAndCredits.txt
  FileAppend,
( 
SavePictureAs Version %Version% by Robert Jackson - download the most recent version here http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/ or use this link http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.zip

I created this program to easily save pictures from the web with Windows XP, Vista and Windows 7 using..
Internet Explorer    (tested on version 11.0.9600.16521CO) 
Google Chrome        (tested on version 33.0.1750.154 m)
Google Chrome Canary (tested on version 30.0.1578.3)
Cool Novo            (tested on version 2.0.9.11
Comodo Dragon        (tested on version 28.0.4.0)
Firefox              (tested on version 28.0)
K-Meleon             (tested on version 1.5.4)
Opera                (tested on version 20.0.1387.91 )
Maxthon              (tested on version 4.0.3.6000)
Safari               (tested on version 5.1.7 [7534.57.2])
RockMelt             (tested on version 0.16.91.483)
Yandex               (tested on version 1.7.1364.15751 [91e222f])
Avant                (tested on versoin 7.12.2013 build 110)
Slim Browser         (tested on version 7.0 Build 091)
Placing the mouse cursor over any picture on the webpage and pressing the "CTRL AND SPACEBAR" or user defined keys will save the picture to your hard drive.
----------------------------------------------------------------------------------------------------------------------------
This software is provided 'as-is', without any express or implied warranty.
In no event will the authors be held liable for any damages arising from the use of this software.
 
Credits: Thanks to the following people for the following code.
   (A) Lexikos - Scrollable Gui code from http://www.autohotkey.com/forum/viewtopic.php?t=28496
   (B) Lexikos - Resizable window border from http://www.autohotkey.com/board/topic/23969-resizable-window-border/#entry155480
   (C) tic - Gdip functions to get image dimensions from
       http://www.autohotkey.com/board/topic/29449-gdi-standard-library-145-by-tic/#entry187736
   (D) Sean - Get right click menu contents function GetMenu(hMenu) code from http://www.autohotkey.com/forum/viewtopic.php?t=21451
   (E) Sean - Retrieve AddressBar of Firefox through DDE Message code
       from http://www.autohotkey.com/board/topic/17633-retrieve-addressbar-of-firefox-through-dde-message/
   (F) Sean - Screen Capture from
       http://www.autohotkey.com/board/topic/16677-screen-capture-with-transparent-windows-and-mouse-cursor/#entry108113
   (G) Eddy & olfen - UrlDownloadToVar from 
       http://www.autohotkey.com/community/viewtopic.php?f=2&t=10466&hilit=urldownloadtovar&start=75
   (H) majkinetor - Common dialog for changing Gui & font colors from http://www.autohotkey.com/forum/viewtopic.php?t=17230
   (I) majkinetor - DockA found here http://www.autohotkey.com/board/topic/46225-function-docka-10/#entry287726
   (J) Huba  - Left click on system tray icon from http://www.autohotkey.com/forum/viewtopic.php?t=26720
   (K) jaco0646 - User-defined Dynamic Hotkeys from http://www.autohotkey.com/board/topic/47439-user-defined-dynamic-hotkeys/
   (L) derRaphael & JustMe for the Color Controls code from http://www.autohotkey.com/forum/topic33777.html and here 
       http://www.autohotkey.com/board/topic/90401-control-colors-by-derraphael/
   (M) heresy - run ahk scripts with less memory from 
       http://www.autohotkey.com/board/topic/30042-run-ahk-scripts-with-less-half-or-even-less-memory-usage/
   (N) Rseding91 - Calc_MD5 function posted by Rseding91 from http://www.autohotkey.com/board/topic/77408-md5-function-for-comparing-images/
   (O) shimanov and Laszlo = Hide System Cursor from  http://www.autohotkey.com/board/topic/5727-hiding-the-mouse-cursor/#entry35098 and
       http://www.autohotkey.com/board/topic/5727-hiding-the-mouse-cursor/#entry35221
   (P) nepter - Read text under mouse from here http://www.autohotkey.com/board/topic/94619-ahk-l-screen-reader-a-tool-to-get-text-anywhere/page-1#entry596215
   (Q) joedf - Check Internet Connection function found here http://www.ahkscript.org/boards/viewtopic.php?f=5&t=349#p3292
   (R) Chris Mallett for AutoHotkey and Lexikos for continuing to develop AutoHotkey_L
   (S) Sorry if I missed someone. If so, let me know and I will give credit where credit is due.

----------------------------------------------------------------------------------------------------------------------------
Please Note:
(1)  The configure hotkey routine was created by user jaco0646 at www.autohotkey.com/board. Not all hotkey conbinations are assignable using the Configure Hotkeys gui. If the hotkey combination you want is not possible using the gui then edit the hotkey entries in SpaConfig.ini. If the hotkeys you write to the ini file are valid the hotkey gui should display them properly. I know very little about jaco0646s hotkey routine. Please ask jaco0646 questions on how to modify the hotkey routine to assign the hotkey you need. Let me know of any alterations to the hotkey routine code that works on previously unassignable hotkeys and I will modify the source code for SavePictureAs.

(2) If you change the windows color and text color to the same color then the text is not visible. Choose "Reset All Colors" on the system tray to fix when this happens. Anyone know how to avoid this?

(3) Capture Active Window only captures the visible part of the active window.

(4) For Favorite Folder Hotkeys 1 thru 10, the Default Folder Hotkey, and Special Folder Hotkey requires the browser to be active. If you are trying to save a picture and the hotkey appears to not be working click anywhere on the browser to make it the active window.

(5) For SavePictureAs to work properly, the script needs to be able to right click, send the letter v or the letter s (depending on browser), then wait for the Save Image, Save Picture or Save As window (depending on browser) to open, it will then save the picture to a temp folder. After saving to a temp folder SavePictureAs will apply the user chosen "Filenaming Convention" and check if a file by that name already exists in your chosen folder. If it does then SavePictureAs will apply the "How to Handle Duplicate" rules. Then if enabled the Confirmation Message will be displayed.

(6) Requirements: If script is uncompiled Autohotkey 1.1.13.01 or later is required

(7) SavePictureAs does not install anything on your computer. It runs from the folder you place SavePictureAs.ahk in. The first time you run SavePictureAs.ahk you will be asked where to save downloaded pictures and display program documentation. 

(8) Running the program is as simple as choosing a default folder location on startup and placing the mouse cursor over a picture and pressing ctrl & the spacebar or user defined hotkeys. There are alot of other features in the system tray menu. 
   (A) Favorites Toolbar - Save up to 10 favorite locations to save pictures. When you see a picture on the web that you want to save you can quickly change your "Default Folder" using the Favorites  Toolbar then press your "Default Hotkey" to save the picture.
   (B) The Confirmation Message (DONE - with Saving Picture Hotkey operation), splash screen, saved picture location folders, system colors, Favorites Toolbar and more are configurable from the system tray icon.
   (C) Additional Settings menu - "Start with Windows", "Custom Filename" "Prompt For Filename", "How to Handle Duplicates" and many more options.

(9) Please read the Help and Program Documentation accessed from the system tray icon for more information.
 
(10) Please let me know of any issues and provide as many details as possible about what type of operating system and browser you are using by emailing Support@SavePictureAs.com
),%A_ScriptDir%\ProgramInfoAndCredits.txt
 }
return
SplashScreenTextVar:
SplitPath,A_ScriptName,,,TempVar
SplashScreenTextVar =
(
   
Thank you for choosing SavePictureAs V%Version%
   
Program Documentation can be accessed by clicking on the system tray icon.
  
I created this program to easily save pictures from the web with Windows XP, Vista, Windows 7 and Windows 8 using Internet Explorer, Firefox, Opera, Maxthon, Safari, RockMelt, Google Chrome, Avant, K-Meleon, Yandex, Slim Browser & Comodo Dragon.
  
Windows 8 must be in Desktop mode for SavePictureAs to work properly.

SavePictureAs.%TempVar% does not install anything on your computer.

It runs from the folder you place SavePictureAs.%TempVar% in.

The first time you run SavePictureAs.%TempVar% you will be asked to choose hotkeys and favorite folders to save your pictures in.

Run SavePictureAs.%TempVar% each time you want to start the program.

How To Use SavePictureAs:  
Place the mouse cursor over a picture on a webpage and press the "Default Hotkey" "CTRL & SPACEBAR" or user defined keys and your picture will be saved to your "Default Folder"
  
Once the program loads you can click on the tray icon to change your saved picture locations via "Configure Hotkeys & Folders".
   
Placing the mouse over the system tray icon will display a message that shows the "Default Folder" for saving pictures using your "Default Hotkey"
  
SavePictureAs features include...... 
1. All features and settings can be accessed by clicking the system tray icon.
  
2. Choose 1 of 10 ways to name your Saved Picture (Custom Picture Name)
  
3. Option to name each picture as you save it. (Prompt for Picture Name)
  
4. Choose 1 of 5 ways to rename a picture if a duplicate filename is found in your "Save To" folder
  
5. History Menu - View, Delete, Move, Copy & Rename last 30 (or user defined amount) pictures saved.
  
6. Favorites Toolbar - 10 configurable buttons for changing the "Default Folder" to save pictures to.
  
7. Change screen and text colors
  
8. Saved picture successfully configurable Confirmation Message.
  
9. User configurable hotkeys for 10 Favorite Folders, 1 Default Folder, 1 Special Folder & Rename Last Saved Picture
  
10. Make SavePictureAs Completely Portable

    Create a "Special Folder" on your flash drive and give it a unique name

    Put SavePictureAs anywhere on the same flash drive.

    Start SavePictureAs from your flash drive. 

    On the "Configure Hotkeys and Folders" menu choose a "Special Folder" hotkey and assign the flash drive "Special Folder" to this hotkey.

    Each time you save a picture using your "Special Folder" hotkey your picture will be saved to your flash drive.

11. See "Additional Settings" menu found by clicking on "Settings" on the system tray icon for more features.
  
12. Exit the program by clicking the system tray icon.
  
  
email support@SavePictureAs.com with any questions
  
If you would like you can donate to donate@SavePictureAs.com using PayPal.   (Maybe my wife will see some benefit in me spending so many hours programming SavePictureAs)
  )
;===================================================================================================================================
return
CheckWindowContents:
sleep 200
NotInRightClickMenu = 0
SetBatchLines, -1
WinWait, ahk_class #32768, ,  5 
SendMessage, 0x1E1, 0, 0      ; MN_GETHMENU
hMenu := ErrorLevel
sContents := GetMenu(hMenu)
;need to change code to If sContents not in Save Picture As, Sa&ve Image As  //then test 
IfInString,sContents,Save Picture As ;IE 
 NotInRightClickMenu = 1
IfInString,sContents, Sa&ve Image As 
 NotInRightClickMenu = 1
IfInString, sContents, &Save Image As... ;K-Meleon & Avant
 NotInRightClickMenu = 1
IfInString, sContents, I&mage ;K-Meleon
 NotInRightClickMenu = 1
If NotInRightClickMenu = 0
 {
  if ErrorLogging = 1
   {
    FormatTime, SavedTime ,   , MM\dd\yy HH:mm:ss
    FileAppend,
     (
`nTime:                 %SavedTime%
LogIndex:             8
SPA Version:          %Version%
Browser Class:        %Class%
OS:                   %A_OsVersion%
Url:                  %url%
Language:             %A_Language%
Admin:                %A_IsAdmin%
32BitOR64BitOS:       %A_Is64bitOS%
%AddAutoHotkeyVersionIfCompiled%
Error-SEL:            Right Click Menu does not contain Save %PictureImage%
Notes1:               Most likey you are trying to save a picture that is not savable.
Possible Fix1:        You must be able to right click and choose Save %PictureImage% or SavePictureAs will not be
                      able to do the same.
Notes2:               You may also encounter this error if your PC in running slow due to issues like an Antivirus
                      program running a scan in the background.
Possible Fix2:        Select Settings, Additional Settings then Trouble Shooting under the system tray icon and change the time out period longer than 5 seconds for the WaitForSavePictureAsWindow value
     ),LogFile.txt
   } ;ending brace if ErrorLogging = 1

 MsgBox,4112,SavePictureAs V%Version% Error Message,This may not be a savable picture. If you are sure this is a savable picture, try to save it again. Some pictures are protected from download by the website creator.`n`nYou can also save an area of the screen using your "Capture Area of Screen" hotkey.
  gosub TrimErrorLog
 }
Return

CheckForUpdates:
IfWinExist, ahk_id %SavePictureAsUpdateCheckGui11ID%
 {
  WinRestore, ahk_id %SavePictureAsUpdateCheckGui11ID%
  WinActivate, ahk_id %SavePictureAsUpdateCheckGui11ID%
  return
 }
IniRead, CheckForUpdatesColor,SpaConfig.ini,SystemColors,CheckForUpdatesColor,c0c0c0
IniRead, CheckForUpdatesTextColor, SpaConfig.ini, SystemColors, CheckForUpdatesTextColor, 000000
SysGet,mwa,MonitorWorkArea
xpos := (MWARight - 280)
Ypos := (MWABottom - 50)
Gui 62: font, cwhite
Gui 62: add, text, center ,SavePictureAs is checking for updates!
Gui 62:  +ToolWindow +Resize +AlwaysOnTop -sysmenu
Gui 62: show, X%xpos% Y%ypos% h7 w253,GuiUpdates
Gui 62: color, 0x333333
winset,AlwaysOnTop,on
winset, disable,,A
WinSet, Style, -0xC00000, A
WinGet,GuiUpdatesID,ID,GuiUpdates
sleep 1000 ; needed because sometimes the white text is not visible

SetTimer,CheckForUpdatesDaily, off
NewestVersionNumber =
AhkFileSize =
ExeFileSize =
Changes =
var =
AhkHashValue =
ExeHashValue =
Connected := Ping()

RetrieveUpdateInfo:
if Connected <> 0 ;checking for internet connection because the timeout is quite long for URLDownloadToFile when there is no internet connection
 {
  Var =
  link0 = 0 ;only needed to determine which updatelink was used to check for updates
  link1 = 0
  link2 = 0
  link3 = 0
  link4 = 0
  link5 = 0
  
  IniRead,NewLink,SpaConfig.ini,CheckForUpdates,NewLink ;this is used if all else fails. The user puts an entry in the SpaConfig.ini under [CheckForUpdates]. The entry would be...
  ;NewLink = Http://[link to temp address for SavePictureAs_Info-3.txt]
  ;Doing it this way allows the automatic update to update to the latest version which will fix any update issues.
  if NewLink <> Error ;use one time link read from ini file
   {
    URLDownloadToFile, %NewLink%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    IniDelete,SpaConfig.ini,CheckForUpdates,NewLink
   }
  IfExist,C:\SpaTestingFolder ;this allows testing with a test SavePictureAs_Info.txt file
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, http://sourceforge.net/projects/savepictureas/files/SavePictureAs_Info-0.txt/download,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link0 = 1
   }
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, %UpdateLink1%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link1 = 1
   }
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, %UpdateLink2%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link2 = 1
   }
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, %UpdateLink3%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link3 = 1
   }
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, %UpdateLink4%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link4 = 1
   }
  IfNotInString,Var,SavePictureAs-By DataLife
   {
    URLDownloadToFile, %UpdateLink5%,Temp.txt
    FileRead,var,Temp.txt
    FileDelete,temp.txt
    link5 = 1
   }
 }
   
Loop, Parse, Var ,`n,`r  
 {
  if A_index = 2
   NewestVersionNumber = %A_LoopField%
  if A_index = 3
   {
    StringSplit,Tempvar,a_loopfield,%a_space%
    AhkFileSize = %Tempvar1%
    AhkHashValue = %Tempvar2%
   }
  if A_index = 4
   {
    StringSplit,Tempvar,a_loopfield,%a_space%
    ExeFileSize = %Tempvar1%
    ExeHashValue = %Tempvar2%
   }
  if A_index = 5
   AhkLink = %A_LoopField%
  if A_index = 6
   ExeLink = %A_LoopField%
 }

Loop, Parse, Var ,`n,`r 
 {
  StringLen,len,a_loopfield
  len := (len - 12)
  StringTrimRight,OutPutVar,a_loopfield, %len%
  if OutPutVar = Please Note:
   FirstLineForPleaseNoteMessage = %a_index%
 }

Loop, Parse, Var ,`n,`r  
 {
  StringLen,len,a_loopfield
  len := (len - 7)
  StringTrimRight,OutPutVar,a_loopfield,%len%
  if OutPutVar = version
   {
    LastLineForPleaseNoteMessage := ( a_index-1 )
    break
   }
  else
   LastLineForPleaseNoteMessage = 0
 }
PleaseNoteMessage =
Loop, Parse, Var ,`n,`r  
 {
  If  ( a_index > FirstLineForPleaseNoteMessage - 1 )
   PleaseNoteMessage = %PleaseNoteMessage%`n%A_LoopField%
  if ( a_index = LastLineForPleaseNoteMessage)
   break
 }

Loop, Parse, Var ,`n,`r  
 {
  if ( A_index > LastLineForPleaseNoteMessage )
   {
    StringSplit,OutPutArray,a_loopfield,%a_space%
    if OutPutArray1 = version
     {
      StringSplit,Array,a_loopfield,%A_Space%
      if Array2 > %version%
       {
        ChangesLineStartsHere :=  ( a_index - 1 )
        break
       }
      else                            ;This was put here as a precaution. While testing and changing version numbers the current testing version number did not have a entry in
       ChangesLineStartsHere = %LastLineForPleaseNoteMessage% ; "View Changes" which caused the entire change log to be shown instead of only the changes since the last version.
     }
   }
 } 
Changes =
Loop, Parse, Var ,`n,`r  
 {
  if A_index > %ChangesLineStartsHere%
   Changes = %Changes%`n%A_LoopField% 
 }
Gui 62: destroy

if ActivatingCheckForUpdatesDaily = 0
 {
  if NewestVersionNumber = 
   {
      Gui 42: font
      Gui 42: font, s10 c%CheckForUpdatesTextColor%
      SplitPath,a_scriptname,,,ext
      Gui 42: add, text,hwndHWND_Gui42Static1,%addtext%There was a problem checking for updates. Make sure you are connected to the internet and try again.
      Gui 42: add, text,, You can download the most recent version of SavePictureAs by clicking on one of the following links.
      if ext = exe
       {
      Gui 42: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.exe/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.exe/download</a>
      Gui 42: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.zip/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.zip/download</a>
       }
      else
       Gui 42: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.ahk/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.ahk/download</a>
      Gui 42: add, text, ,Save SavePictureAs.%ext% to a folder on your hard drive.`n`nExit SavePictureAs then overwrite SavePictureAs.%ext% with the new version.`n`nThen click on the new version. All your settings will still be the same.`n`nPlease email support@SavePictureAs.com with any issues.`n`nYou can also check out the SavePictureAs forum post for the latest information on SavePictureAs and`ndownload it from there. 
      Gui 42: add, link,,<a href="http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/">http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/</a>
	  Gui 42: show, ,Error Checking for Updates
      Gui 42: color, %CheckForUpdatesColor%
      WinGet,CheckingForUpdatesGui42ID,ID,Checking for Updates
      ControlFocus,,ahk_id %HWND_Gui42Static1%
	  return
      42GuiClose:
	  Gui 42: destroy
      if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" )
       SetTimer,CheckForUpdatesDaily, %CheckForUpdatesDailyValue%
	  return
   }
 }

If (Version < NewestVersionNumber)
 {
  Iniread,DontRemindUntilNextUpdate,spaconfig.ini,CheckForUpdates,DontRemindUntilNextUpdate
  if DontRemindUntilNextUpdate = %NewestVersionNumber%
   {
    if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" )
     SetTimer,CheckForUpdatesDaily, %CheckForUpdatesDailyValue%
    ActivatingCheckForUpdatesDaily = 0
    return
   }
   else
    Iniwrite,%a_space%,spaconfig.ini,CheckForUpdates,DontRemindUntilNextUpdate
   if changes =
    Changes = Not able to retrieve the necessary information.
   Gui 11: +Toolwindow -sysmenu
   Gui 11: font, s12 italic underline cBlue,    
   Gui 11: add, text, x30 y30 w300 gViewChanges,View Changes
   Gui 11: font
   Gui 11: font, s10 c%CheckForUpdatesTextColor%
   Gui 11: add, text,x30 y65,A new version of SavePictureAs is available.`n`nCurrent version %Version%`nNewest version %newestversionnumber%`n`nWould you like to update to the newest version?
   Gui 11: add, button,   x30  y170 w80 h25, No
   Gui 11: add, button,   x+20 y170 w80 h25, Yes
   Gui 11: add, button,   x+20 y170 h25 w110 gHavingTrouble, Having Trouble?
   Gui 11: add, GroupBox, x20 y15 w335 h185
   
   Gui 11: font, s9
   if ActivatingCheckForUpdatesDaily = 0
    Gui 11: add, checkbox , x20  y210 vUpdateChoice gUpdateChoice,Do not check for updates when program starts   
    
   if ( CurrentlyStartingUp <> "Loading...Please Wait" )
    {
     Gui 11: font, s9 c%CheckForUpdatesTextColor%
     Gui 11: add, radio, x20  y210 vRemindMeIn5Minutes , Remind me in 5 minutes
     Gui 11: add, radio, x20  y230 vRemindMeIn30Minutes, Remind me in 30 minutes
     Gui 11: add, radio, x20  y250 vRemindMeIn1Hour, Remind me in 1 hour
     Gui 11: add, radio, x20  y270 vDontRemindUntilNextUpdate, Don't remind me until next update
     Gui 11: add, button,x277 w80 yp-10 gRemindMeLaterToUpdate, Submit
    }
    
   if ( LastLineForPleaseNoteMessage > 6 and Version > 8.9 )
    Gui 11: add, text,x20 y+20, %PleaseNoteMessage%
 		
   Gui 11: show, ,SavePictureAs (Update Check) 
   Gui 11: color, %CheckForUpdatesColor%
   WinGet,SavePictureAsUpdateCheckGui11ID,id,SavePictureAs (Update Check) 
   WinSet,AlwaysOnTop,On,ahk_id %SavePictureAsUpdateCheckGui11ID%
   return
   UpdateChoice:
   Gui 11: Submit, nohide
   if UpdateChoice <>
    {
     UpdateChoice := !UpdateChoice
     IfExist, SpaConfig.ini
      iniwrite, %UpdateChoice%, SpaConfig.ini,CheckForUpdates,CheckForUpdates
     else
      iniwrite, %UpdateChoice%, spaconfig2.ini,CheckForUpdates,CheckForUpdates
    }
   return
   HavingTrouble:
   SplitPath,A_scriptname,,,ext
   WinSet,AlwaysOnTop,Off,ahk_id %SavePictureAsUpdateCheckGui11ID%
   Gui 40: font
   Gui 40: font, s10 c%CheckForUpdatesTextColor%
   Gui 40: add, text,hwndHWND_Gui40Static1,%addtext%If the update process is not working correctly you can download the most recent version`nof SavePictureAs using one of the following links.
   if ext = exe
    {
     Gui 40: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.exe/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.exe/download</a>
     Gui 40: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.zip/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.zip/download</a>
    }
   else
    Gui 40: add, link,,<a href="http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.ahk/download">http://sourceforge.net/projects/savepictureas/files/PublicLinks/SavePictureAs.ahk/download</a>
   Gui 40: add, text, ,Save SavePictureAs.%ext% to a folder on your hard drive.`n`nExit SavePictureAs then overwrite SavePictureAs.%ext% with the new version.`n`nThen click on the new version. All your settings will still be the same.`n`nPlease email support@SavePictureAs.com with any issues.`n`nYou can also check out the SavePictureAs forum post for the latest information on SavePictureAs and download it from there. 
   Gui 40: add, link,,<a href="http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/">http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/</a>
  
   Gui 40: show, ,Manual Download Newest Version of SavePictureAs
   WinGet,ManualDownloadGui40ID,ID, Manual Download Newest Version of SavePictureAs
   ControlFocus,,ahk_id %HWND_Gui40Static1%
   Gui 40: color, %CheckForUpdatesColor%
   ActivatingCheckForUpdatesDaily = 0
   return
   40GuiClose:
   WinSet,AlwaysOnTop,On,ahk_id %SavePictureAsUpdateCheckGui11ID%
   Gui 40: destroy
   if CheckForDailyUpdates = 1
    SetTimer,CheckForUpdatesDaily,%CheckForUpdatesDailyValue%
   ActivatingCheckForUpdatesDaily = 0
   return
   ViewChanges:
   IfWinExist,ahk_id %ViewChangesGui46ID%
    {
     WinRestore, ahk_id %ViewChangesGui46ID%
     WinActivate, ahk_id %ViewChangesGui46ID%
     return
    }
   WinSet,AlwaysOnTop,Off,ahk_id %SavePictureAsUpdateCheckGui11ID% ;this View Changes gui can be called from gui 11 and gui 14
   WinSet,AlwaysOnTop,Off,ahk_id %UpdateCheckOutOfDateGui14ID%
   WinSet,AlwaysOnTop,Off,ahk_id %SavePictureAsCheckForUpdatesGui12ID% ;this gui can be present and need not to be always on top when view changes gui 46 is shown.
   Gui 46: font
   Gui 46: font, s10 c%CheckForUpdatesTextColor%
   Gui 46: +Resize +0x300000
   Gui 46: add, text,,%Changes%
   Gui 46: show,,SavePictureAs V%version%
   WinGet,ViewChangesGui46ID,ID, SavePictureAs V%version%
   WinSet,AlwaysOnTop,On,ahk_id %ViewChangesGui46ID%
   Gui 46: color, %CheckForUpdatesColor%
   Gui 46: +LastFound
   GroupAdd, MyGui, % "ahk_id " . WinExist()
   return
   46GuiClose:
   IfWinExist, ahk_id %SavePictureAsUpdateCheckGui11ID%
    WinSet,AlwaysOnTop,On,ahk_id %SavePictureAsUpdateCheckGui11ID%
   IfWinExist, ahk_id %UpdateCheckOutOfDateGui14ID%
    WinSet,AlwaysOnTop,On,ahk_id %UpdateCheckOutOfDateGui14ID%
   Gui 46: destroy
   ActivatingCheckForUpdatesDaily = 0
   return
   RemindMeLaterToUpdate:
   WinSet,AlwaysOnTop,Off,ahk_id %SavePictureAsUpdateCheckGui11ID%
   Gui 11: Submit, NoHide
   if (RemindMeIn5Minutes = 1 or RemindMeIn30Minutes = 1 or RemindMeIn1Hour = 1 or DontRemindUntilNextUpdate = 1)
    {
     if RemindMeIn5Minutes = 1
      SetTimer,CheckForUpdatesDaily, 300000
     if RemindMeIn30Minutes = 1
      SetTimer,CheckForUpdatesDaily, 1800000 
     if RemindMeIn1Hour = 1
      SetTimer,CheckForUpdatesDaily, 3600000
     if DontRemindUntilNextUpdate = 1
      {
       IniWrite,%NewestVersionNumber%,spaconfig.ini,CheckForUpdates,DontRemindUntilNextUpdate
       Gui 11: destroy
       SetTimer,CheckForUpdatesDaily,%CheckForUpdatesDailyValue%
       ActivatingCheckForUpdatesDaily = 0
       return
      }
    }
   else
    {
     MsgBox Please select one of the following`n`nNo`nYes`n`nRemind me in 5 minutes`nRemind me in 30 minutes`nRemind me in 1 hour`nDon't remind me until next update
     WinSet,AlwaysOnTop,On,ahk_id %SavePictureAsUpdateCheckGui11ID%
     return
    }
   Gui 11: destroy
   ActivatingCheckForUpdatesDaily = 0
   return
   11ButtonNo:
   StillSleeping = 0
   Gui 11: destroy
   if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" )
    SetTimer,CheckForUpdatesDaily, %CheckForUpdatesDailyValue%
   ActivatingCheckForUpdatesDaily = 0
   return      
   11ButtonYes:
   StillSleeping = 0
   ActivatingCheckForUpdatesDaily = 0
   Gui 11: destroy
   SplitPath,A_scriptName,,,ext
   Counter = 0
   progress, B2 h80,,Downloading Update
   SetTimer,DownloadingUpdate,50
   if Ext = ahk
    UrlDownloadToFile, %ahkLink%, SavePictureAs.exx
   if Ext = exe
    UrlDownloadToFile, %exeLink%, SavePictureAs.exx

   ;update section
   SetTimer,DownloadingUpdate,Off
   Progress,Off
     
   FileRead,File,%A_ScriptDir%\SavePictureAs.exx
   FileGetSize,FileSize,%A_ScriptDir%\SavePictureAs.exx,k
   MD5ValueExx := Calc_MD5(&File,FileSize)
     
   if Ext = Ahk
    CorrectMd5Value := AhkHashValue
   else
    CorrectMd5Value := ExeHashValue
  
   if (( MD5ValueExx <> CorrectMd5Value ) and CorrectMD5Value <> "ByPass" )
    {
     WinSet,AlwaysOnTop,Off,ahk_id %SPACFUID%
     FileDelete,SavePictureAs.exx
     AddText = Not able to verify download.`n`n
     Gosub HavingTrouble
     WinWaitClose, Manual Download Newest Version of SavePictureAs
     WinSet,AlwaysOnTop,On,ahk_id %SPACFUID%
     return
    }
   Else
    {
     If ( CorrectMD5Value <> "ByPass" )
      MsgBox,262208,Successful, Update successfully downloaded.`nSavePictureAs will now restart and use the updated version.`n`nThe downloaded update has been validated using the MD5 cryptographic hash function to verify it integrity.`n`n%CorrectMd5Value% (Expected hash Value)`n%Md5ValueExx% (Actual hash Value)
     else
      MsgBox,262208,Successful, Update successfully downloaded.`nSavePictureAs will now restart and use the updated version.
     FileAppend,
     (
ping -n 4 127.0.0.1
del SavePictureAs.%ext%
ping -n 4 127.0.0.1
ren SavePictureAs.exx SavePictureAs.%ext%
Start SavePictureAs.%ext%
ping 127.0.0.1
exit
     ),%A_ScriptDir%\SavePictureAs_Update.bat
     run SavePictureAs_Update.bat,,hide
     exitapp
    }
 } ;bracket for If (Version < NewestVersionNumber)
else
 {
  if ActivatingCheckForUpdatesDaily = 0
   {
    TrayTip,SavePictureAs V%version%,You are using the latest version,5,17
    SetTimer,CloseToolTip,250
   }
 }
if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" )
 SetTimer,CheckForUpdatesDaily, %CheckForUpdatesDailyValue%
ActivatingCheckForUpdatesDaily = 0
return
CloseToolTip:
Sleep 3000
Traytip
SetTimer,CloseToolTip,off
return
DownloadingUpdate: ;progress bar only
Counter++
FileReadLine OutputVar, SavePictureAs.exx, 1 ;this causes the filesize to update in windows explorer
FileGetSize,Size,SavePictureAs.exx,k
if A_IsCompiled
 filesize = %ExeFileSize%
else
 filesize = %AhkFileSize%
progress,%Counter%,%Size%K of %FileSize%K ,Downloading Update
if counter > 100
 counter = 0
Return

AdditionalSettingsMenu:
IfWinExist,ahk_id %ASMID%
 {
  WinRestore,ahk_id %ASMID%
  WinActivate,ahk_id %ASMID%
  return
 }
 
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000
IniRead,CheckForUpdates,SpaConfig.ini,CheckForUpdates,CheckForUpdates,1
IniRead,CheckForUpdatesDaily,SpaConfig.ini,CheckForUpdates,CheckForUpdatesDaily,1
IniRead,ShowSplashScreen, SpaConfig.ini, SplashScreenStatus, ShowSplashScreen,1
IniRead,StartSavePictureAsWhenWindowsStarts,SpaConfig.ini,StartWithWindows,StartWithWindows,0

IniRead,AskHowToHandleDuplicates,SpaConfig.ini,DuplicateFileNames,AskHowToHandleDuplicates,1

IniRead,DoNotSaveDuplicates,SpaConfig.ini,DuplicateFileNames,DoNotSaveDuplicates,0 
IniRead,AlwaysOverWrite,SpaConfig.ini,DuplicateFileNames,AlwaysOverWrite,0
IniRead,SaveDuplicatesWithRandomNumber,SpaConfig.ini,DuplicateFileNames,SaveDuplicatesWithRandomNumber,0
IniRead,AddDateAndTimeWhenDuplicateIsFound,SpaConfig.ini,DuplicateFileNames,AddDateAndTimeWhenDuplicateIsFound,0
IniRead, CheckForIdenticalHashValues,SpaConfig.ini,DuplicateFileNames,CheckForIdenticalHashValues,0

IniRead, DoNotSaveDuplicatesAndNotifyMe,SpaConfig.ini,DuplicateFileNames,DoNotSaveDuplicatesAndNotifyMe,1
IniRead, AlwaysOverWriteAndNotifyMe,SpaConfig.ini,DuplicateFileNames,AlwaysOverWriteAndNotifyMe,1
IniRead, SaveDuplicatesWithRandomNumberAndNotifyMe,SpaConfig.ini,DuplicateFileNames,SaveDuplicatesWithRandomNumberAndNotifyMe,1
IniRead, AddDateAndTimeWhenDuplicateIsFoundAndNotifyMe,SpaConfig.ini,DuplicateFileNames,AddDateAndTimeWhenDuplicateIsFoundAndNotifyMe,1
IniRead, CheckForIdenticalHashValuesAndNotifyMe,SpaConfig.ini,DuplicateFileNames,CheckForIdenticalHashValuesAndNotifyMe,1

IniRead,PlaceConfirmationMessageAtMousePosition,SpaConfig.ini,ConfirmationMessage,PlaceConfirmationMessageAtMousePosition,0
IniRead,TurnOffRecordingOfTheLastSavedPicture,SpaConfig.ini,History,TurnOffRecordingOfTheLastSavedPicture,0
IniRead,DeleteRecordOfTheLastSavedPictureOnExit,SpaConfig.ini,History,DeleteRecordOfTheLastSavedPictureOnExit,0
IniRead,ClearHistoryOnExit,SpaConfig.ini,History,ClearHistoryOnExit,0
IniRead,DisableConfirmationMessage, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageStatus, Enabled
if DisableConfirmationMessage = Disabled
 DisableConfirmationMessage = 1
else
 DisableConfirmationMessage = 0
IniRead,History,SpaConfig.ini,History,HistoryValue,Enabled
if History = Disabled
 HistoryCheckmark = 1
else
 HistoryCheckmark = 0
IniRead, ErrorLogging,SpaConfig.ini,ErrorLog,ErrorLogging,0
IniRead, PromptForFileName,SpaConfig.ini,NamingConvention,PromptForFileName,0
IniRead, CustomFileNameFormat,SpaConfig.ini,NamingConvention,CustomFileNameFormat,0
IniRead, OriginalFilenameFormat,SpaConfig.ini,NamingConvention,OriginalFilenameFormat,1
SysGet, MWA, MonitorWorkArea

TempvarGuiWidth = 900
GroupBoxWidth := ( TempvarGuiWidth - 430 )
TempVarTextWidth := ( GroupBoxWidth - 430 )

MoreTempvarGuiWidth = 595 ;for MoreInfo guis
MoreInfoGroupboxWidth := 565 ;for MoreInfo guis
MoreInfoTextWidth := 545 ;for MoreInfo guis
MoreInfoXPOS := ( GroupBoxWidth - 70 ) ;positioning for the text More Info on the Additional Settings Menu

;Filenaming Convention Groupbox---------------------------------------------------------------------------------------------------
Gui 22: font, s10 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add, GroupBox, x10 y15 w%GroupBoxWidth% h90  , Filenaming Convention

Gui 22: font
Gui 22: font, s10 c0000FF, MS sans serif 
Gui 22: add,Link,x%MoreInfoXPOS% y17 gMoreInfoGroupBoxForFileNamingConvention, <a id="1">More Info</a>

Gui 22: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add, radio,x20 y40 h16 vPromptForFileName  checked%PromptForFileName% ,Prompt For Picture Name
Gui 22: add, radio,x20 y60 h16 vCustomFileNameFormat  checked%CustomFileNameFormat% hwndHWND_CustomPictureNameText,Custom Picture Name ;only lines with a second element needs a hwnd so it can be positioned horizontally
Gui 22: add, radio,x20 y80 h16 vOriginalFilenameFormat  checked%OriginalFilenameFormat% ,Original Picture Name

Gui 22: font
Gui 22: font, s9 
Gui 22: add,Button,x154 y60 w80 h17 gFileNameFormat hwndHWND_FileNameFormatButton,Configure
;---------------------------------------------------------------------------------------------------------------------------------

;Duplicates Groupbox---------------------------------------------------------------------------------------------------------------
Gui 22: font, s10 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add, GroupBox, x10 y110 w%GroupBoxWidth% h200 , How To Handle Duplicate Filenames

Gui 22: font
Gui 22: font, s10 c0000FF , MS sans serif
Gui 22: add,link,x%MoreInfoXPOS% y112 gMoreInfoGroupBoxForDuplicates, <a id="1">More Info</a>

Gui 22: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add, Radio,x20 y135 vAskHowToHandleDuplicates  Checked%AskHowToHandleDuplicates%,Ask what to do when duplicate filenames are found
Gui 22: add, Radio,x20 y160 vDoNotSaveDuplicates   Checked%DoNotSaveDuplicates% hwndHWND_DoNotSaveDuplicatesText, Do not save duplicates
Gui 22: add, Radio,x20 y185 vAlwaysOverWrite   Checked%AlwaysOverWrite% hwndHWND_AlwaysOverWriteText, Always Overwrite
Gui 22: add, Radio,x20 y210 vSaveDuplicatesWithRandomNumber   Checked%SaveDuplicatesWithRandomNumber% hwndHWND_SaveDulicatesWithRandomNumberText, Save duplicates by adding Random Number to filename
Gui 22: add, Radio,x20 y235 vAddDateAndTimeWhenDuplicateIsFound   Checked%AddDateAndTimeWhenDuplicateIsFound% hwndHWND_AddDateAndTimeWhenDuplicateIsFoundText, Save duplicates by adding Date && Time to filename

Gui 22: add, checkbox, x20 y260 vCheckForIdenticalHashValues Checked%CheckForIdenticalHashValues% hwndHWND_CheckForIdenticalHashValuesText, Check for Identical Picture using MD5 algorithm 

Gui 22: add, checkbox, x200 y160 vDoNotSaveDuplicatesAndNotifyMe  Checked%DoNotSaveDuplicatesAndNotifyMe% hwndHWND_DoNotSaveDuplicatesAndNotifyMeCheckbox, && notify me
Gui 22: add, checkbox, x200 y185 vAlwaysOverWriteAndNotifyMe  Checked%AlwaysOverWriteAndNotifyMe% hwndHWND_AlwaysOverWriteAndNotifyMeCheckbox, && notify me
Gui 22: add, checkbox, x380 y210 vSaveDuplicatesWithRandomNumberAndNotifyMe  Checked%SaveDuplicatesWithRandomNumberAndNotifyMe% hwndHWND_SaveDuplicatesWithRandomNumberAndNotifyMeCheckbox, && notify me
Gui 22: add, checkbox, x380 y235 vAddDateAndTimeWhenDuplicateIsFoundAndNotifyMe  Checked%AddDateAndTimeWhenDuplicateIsFoundAndNotifyMe% hwndHWND_AddDateAndTimeWhenDuplicateIsFoundAndNotifyMeCheckbox, && notify me

Gui 22: add, checkbox, x380 y235 vCheckForIdenticalHashValuesAndNotifyMe  Checked%CheckForIdenticalHashValuesAndNotifyMe% hwndHWND_CheckForIdenticalHashValuesAndNotifyMeCheckbox, && notify me

Gui 22: add, text, x20 y285 hwndHWND_ConfigureDateAndTimeForRenamingDuplicateFilenamesText , Configure Date && Time for renaming duplicate filenames 
Gui 22: font
Gui 22: font, s9 
Gui 22: add, button, x+5 y290 gDateFormatForDuplicates w80 h17 hwndHWND_ConfigureDateAndTimeForRenamingDuplicateFilenamesButton, Configure

;TroubleShooting Groupbox-------------------------------------------------------------------------------------------------------

Gui 22: font
Gui 22: font, s10 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add, GroupBox, x10 y315 w%GroupBoxWidth% h80 , Trouble Shooting

Gui 22: font
Gui 22: font, s10 c0000FF , MS sans serif
Gui 22: add,link,x%MoreInfoXPOS% y317 gMoreInfoGroupBoxForTroubleShooting, <a id="1">More Info</a>

Gui 22: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add,text,x20 y340 hwndHWND_WaitForSavePictureWindowTimeoutText,Wait for Save Picture window timeout

Gui 22: font, s9, MS sans serif
Gui 22: add,Button,x260 y340 w80 h17 gWaitForSavePictureWindowTimeout hwndHWND_WaitForSavePictureWindowTimeOutButton,Configure

Gui 22: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%, MS sans serif
Gui 22: add,Checkbox,x357 y340 vErrorLogging checked%ErrorLogging%,Enable Log File

Gui 22: font, s9 
Gui 22: add,Button,x60  y370 w100 h18 gViewErrorLog,View Log File
Gui 22: add,Button,x+35 y370 w100 h18 gClearErrorLog,Clear Log File
Gui 22: add,Button,x+35 y370 w100 h18 gEmailErrorLog,Email Log File
ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_WaitForSavePictureWindowTimeoutText%
ControlMove,,% TempvarWpos + 35,% TempvarYpos + 0,,,ahk_id %HWND_WaitForSavePictureWindowTimeOutButton%

;Start Up Groupbox------------------------------------------------------------------------------------------------------------------
Gui 22: font
Gui 22: font, s10 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add, GroupBox, x495 y15 w390 h130, Start Up && Updates
Gui 22: font
Gui 22: font, s10 c0000FF , MS sans serif
Gui 22: add,link,x810 y17 gMoreInfoGroupBoxForStartUp, <a id="1">More Info</a>

Gui 22: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add,Checkbox,x505 y40 vCheckForUpdatesAtStartUp   Checked%CheckForUpdates% hwndHWND_CheckForUpdatesAtStartUPGui22ID ,Check For Updates at Start Up

Gui 22: add,Checkbox,x505 y65 vCheckForUpdatesDaily   Checked%CheckForUpdatesDaily% ,Check For Updates Daily

Gui 22: add,Checkbox,x505 y90 vShowSplashScreen  Checked%ShowSplashScreen%,Show Splash Screen at Start Up
Gui 22: add,Checkbox,x505 y115 gNotAvailableOnFlashDrives vStartSavePictureAsWhenWindowsStarts  Checked%StartSavePictureAsWhenWindowsStarts% hwndHWND_StartSavePictureAsWhenWindowsStarts,Start SavePictureAs when windows starts

;Confirmation Message Groupbox-----------------------------------------------------------------------------------------------------
Gui 22: font
Gui 22: font, s10 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add, GroupBox, x495 y150 w390 h75 , Confirmation Message
Gui 22: font
Gui 22: font, s10 c0000FF, MS sans serif
Gui 22: add,link,x810 y152 gMoreInfoGroupBoxForConfirmationMessage, <a id="1">More Info</a>

Gui 22: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add,Checkbox,x505 y175 vDisableConfirmationMessage checked%DisableConfirmationMessage%,Disable Confirmation Message
Gui 22: add,Checkbox,x505 y200 vPlaceConfirmationMessageAtMousePosition  checked%PlaceConfirmationMessageAtMousePosition%,Place Confirmation Message at mouse position

;=============================================================================================================================================
;History Groupbox------------------------------------------------------------------------------------------------------------------
IniRead, MaxHistoryMenuPicturesToList,SpaConfig.ini,History,MaxHistoryMenuPicturesToList,30
;determine max random number for listing History Menu items
SplitPath,A_AhkPath,,,,,Drive
DriveGet, FileSystem, FileSystem , %Drive%
if ErrorLevel = 1
 HistoryLimit = 512
if FileSystem = Fat
 HistoryLimit  = 512
if FileSystem = Fat32
 HistoryLimit  = 65534 
if FileSystem = NTFS          
 HistoryLimit  = 2147483647   
;================================================================================================================================================

Gui 22: font
Gui 22: font, s10 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add, GroupBox, x495 y230 w390 h164 , History

Gui 22: font
Gui 22: font, s10 c0000FF , MS sans serif
Gui 22: add,link,x810 y232 gMoreInfoGroupBoxForHistory, <a id="1">More Info</a>

Gui 22: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add,Checkbox,x505 y255 vHistoryCheckmark  checked%HistoryCheckmark%,Do not keep history of pictures saved
Gui 22: add,Checkbox,x505 y280 vClearHistoryOnExit  checked%ClearHistoryOnExit% hwndHWND_ClearHistoryOnExitText, Clear History on Exit
Gui 22: font, s9 c000000


Gui 22: add,Button,x+10 y280 w70 h17 gClearHistory hwndHWND_ClearNowButton,Clear Now

Gui 22: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: add,Checkbox,x505 y305 vTurnOffRecordingOfTheLastSavedPicture  checked%TurnOffRecordingOfTheLastSavedPicture%,Turn off recording of the Last Saved Picture

Gui 22: add,Checkbox,x505 y330 vDeleteRecordOfTheLastSavedPictureOnExit  checked%DeleteRecordOfTheLastSavedPictureOnExit% hwndHWND_DeleteRecordOfLastSavedPictureOnExitText,Delete record of the Last Saved Picture On Exit
Gui 22: font, s9 c000000

Gui 22: add,Button,x+10 y330 w65 h17 gDeleteNow hwndHWND_DeleteNowButton, Delete Now

Gui 22: font, s10 c000000
Gui 22: add, edit,r1 x505 y357 w50 h15  vMaxHistoryMenuPicturesToList  Number center,
Gui 22: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 22: Add, UpDown,  Range1-%HistoryLimit% left 0x80, %MaxHistoryMenuPicturesToList%

Gui 22: add, text, x560 y360,Maximum Pictures to be Listed in the History Menu

;-------------------------End History Groupbox------------------------------------------------------------------------------------------------------
 TempVarButtonHeight = 22
 TempVarButtonYpos = 399

Gui 22: add, button, x677 y%TempVarButtonYpos% h%TempVarButtonHeight% w100 gApplyAndExitAdditionalSettingsMenu  ,Apply && Close
Gui 22: add, button, x+10 y%TempVarButtonYpos% h%TempVarButtonHeight% w100 gCancelAdditionalSettingsMenu       ,Close
Gui 22: show, hide w%TempvarGuiWidth% h425 ,Additional Settings Menu
Gui 22: color, %AdditionalSettingsMenuColorGuiVar%
;===================================================================================================================================================
ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_CustomPictureNameText%
ControlMove,,% TempvarWpos + 30,% TempvarYpos +0,,,ahk_id %HWND_FileNameFormatButton% ;(this is the configure button for Custom filename Format)

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_DoNotSaveDuplicatesText%
ControlMove,,% TempvarWpos + 25,%TempvarYpos%,,,ahk_id %HWND_DoNotSaveDuplicatesAndNotifyMeCheckBox%

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_AlwaysOverWriteText%
ControlMove,,% TempvarWpos + 25,%TempvarYpos%,,,ahk_id %HWND_AlwaysOverWriteAndNotifyMeCheckBox%

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_SaveDulicatesWithRandomNumberText%
ControlMove,,% TempvarWpos + 25,%TempvarYpos%,,,ahk_id %HWND_SaveDuplicatesWithRandomNumberAndNotifyMeCheckBox%

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_AddDateAndTimeWhenDuplicateIsFoundText%
ControlMove,,% TempvarWpos + 25,%TempvarYpos%,,,ahk_id %HWND_AddDateAndTimeWhenDuplicateIsFoundAndNotifyMeCheckBox%

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_CheckForIdenticalHashValuesText%
ControlMove,,% TempvarWpos + 25,%TempvarYpos%,,,ahk_id %HWND_CheckForIdenticalHashValuesAndNotifyMeCheckBox%

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_ConfigureDateAndTimeForRenamingDuplicateFilenamesText%
ControlMove,,% TempvarWpos + 35,% TempvarYpos + 2,,,ahk_id %HWND_ConfigureDateAndTimeForRenamingDuplicateFilenamesButton%

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_ClearHistoryOnExitText%
ControlMove,,% TempvarWpos + 640,% TempvarYpos ,,,ahk_id %HWND_ClearNowButton%

ControlGetPos,,TempvarYpos,TempvarWpos,TempvarHpos,,ahk_id %HWND_DeleteRecordOfLastSavedPictureOnExitText%
ControlMove,,% TempvarWpos + 640,% TempvarYpos ,,,ahk_id %HWND_DeleteNowButton%
;===================================================================================================================================================

WinGet,ASMID,ID, Additional Settings Menu

WinShow, ahk_id %asmid%
ControlFocus,Apply & Exit,ahk_id %ASMID%
return
NotAvailableOnFlashDrives:
SplitPath,a_scriptdir,,,,,DriveLetter
DriveGet,DriveType,Type,%DriveLetter%
if  DriveType <> Fixed 
 {
  Control, UnCheck , , , ahk_id %HWND_StartSavePictureAsWhenWindowsStarts%
  MsgBox This feature is not available when SavePictureAs is started from a flash drive
 }
return

WaitForSavePictureWindowTimeout:
IfWinExist,ahk_id %WFSPAWID%
 {
  WinRestore,ahk_id %WFSPAWID%
  WinActivate,ahk_id %WFSPAWID%
  return
 }
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000
Gui 29: font
Gui 29: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 29: add, text, x15 w480,
(
 SavePictureAs waits for the "Save Picture", "Save Image" or "Save As" window
 (depending on browser) to become active before it can save the picture.
 
 The minimum setting for this is 5 seconds. If the window does not appear after 5 seconds then
 SavePictureAs will timeout and a message will be displayed indicating the picture you are trying to
 save may not be a savable picture.
 
 This timeout can be changed if for some reason your computer is taking longer then 5 seconds
 waiting for the "Save Picture", "Save Image" or "Save As" window to become active. The maximum
 is set at 60 seconds.
 
 Some reasons that your computer may take longer then 5 seconds for this window to become active:
 Antivirus program running a scan
 Available memory may be low
 Too many programs running in the background
 The mouse or keyboard interrupted the SavePictureAs process
)

IniRead,Timeout,spaconfig.ini,WaitforSavePictureAsWindow,Timeout,5
Gui 29: add, text, x15 y+25,Current Timeout:
Gui 29: add, edit,r1 x110 yp-4 w40 Number center,
Gui 29: Add, UpDown,  Range5-60 left vTimeout, %Timeout%
Gui 29: add, button,x155 w50 h22 yp-0 gApply, Apply
Gui 29: add, button,x430 w50 h22 yp-0 g29GuiClose, Cancel
Gui 29: show, w500,Wait For Save Picture As Window
WinGet,WFSPAWID,id,Wait For Save Picture As Window
Gui 29: color, %AdditionalSettingsMenuColorGuiVar%
return

Apply:
Gui 29: submit
IniWrite,%Timeout%,SpaConfig.ini,WaitforSavePictureAsWindow,Timeout
29GuiEscape:
29GuiClose:
Gui 29: destroy
return
39GuiClose:
Gui 39: submit
IniWrite,%ErrorLogging%,SpaConfig.ini,ErrorLog,ErrorLogging
Gui 39: destroy
return
DateFormatForDuplicates:
IfWinExist,ahk_id %DateAndTimeFormatForDuplicatesID%
 {
  WinRestore,ahk_id %DateAndTimeFormatForDuplicatesID%
  WinActivate,ahk_id %DateAndTimeFormatForDuplicatesID%
  return
 }
IniRead,DateAndTimeFormatScreensGuiColor,SpaConfig.ini,SystemColors,DateAndTimeFormatScreensGuiColor,c0c0c0

IniRead,DateAndTimeFormatScreensGuiTextColor,SpaConfig.ini,SystemColors,DateAndTimeFormatScreensGuiTextColor,000000
IniRead,SeparatorOptionDuplicates,spaconfig.ini,DateTimeFormat,SeparatorOptionDuplicates,%a_space%
IniRead,SeparatorCharDuplicates,SpaConfig.ini,DatetimeFormat,SeparatorCharDuplicates,-
DateTimeFormats = 7
DateTimeFormat1 = dddd MMMM d, yyyy hh mm ss tt
DateTimeFormat2 = 'Date' MM dd yy 'Time' hh mm ss tt
DateTimeFormat3 = h mm ss
DateTimeFormat4 = HH mm ss
DateTimeFormat5 = MM dd yy - HH mm ss
DateTimeFormat6 = yyyyMMddhhmmss
DateTimeFormat7a = yyyyMMdd ;7a and 7b and SeparatorCharDuplicates equal DateTimeFormat7
DateTimeFormat7b = hhmmss   ;7a and 7b and SeparatorCharDuplicates equal DateTimeFormat7

FormatTime, DateTimeFormatDuplicates1, ,%DateTimeFormat1%
FormatTime, DateTimeFormatDuplicates2, ,%DateTimeFormat2%
FormatTime, DateTimeFormatDuplicates3, ,%DateTimeFormat3%
FormatTime, DateTimeFormatDuplicates4, ,%DateTimeFormat4%
FormatTime, DateTimeFormatDuplicates5, ,%DateTimeFormat5%
FormatTime, DateTimeFormatDuplicates6, ,%DateTimeFormat6%
FormatTime, DateTimeFormatFilenamingConvention7a,, %DateTimeFormat7a%
FormatTime, DateTimeFormatFilenamingConvention7b,, %DateTimeFormat7b%

Loop %DateTimeFormats%
 StringReplace,DateTimeFormatDuplicates%a_index%,DateTimeFormatDuplicates%a_index%,:,%a_space%

Gui 38: Default
Gui 38: font, s11 c%DateAndTimeFormatScreensGuiTextColor%
Gui 38: add, text,,Choose how you want the "Date and Time" formatted when it is added to the filename.

IniRead,OriginalSetting,spaconfig.ini,DateTimeFormat,Duplicates,MM dd yy - HH mm ss
Loop %DateTimeFormats%
 {
  if OriginalSetting = % DateTimeFormat%a_index%
   {
   Checked%a_index% = 1 ;to start radio button off checked
   DuplicatesRadioCheckMark = %a_index% ;used to determine if anything changed with clicking the X close button and editbox
   FormatTime,DisplayTime,,% DateTimeFormat%a_index% ;for options 1,2 and 5 editbox display
   FormatTime,Tempvar,, mm ss ;for options 3 and 4 editbox display
   ;break
   }
  else
   {
    if SeparatorOptionDuplicates = SeparatorOptionDuplicates
     {
      Checked7 = 1
      DuplicatesRadioCheckMark = 7
     }
    else
     Checked%a_index% = 0
   }
 }

Gui 38: font
Gui 38: font, s10 c%DateAndTimeFormatScreensGuiTextColor%
Gui 38: add, radio,x15 y45   vFormatDateAndTimeDuplicates1 gRadioButtonDateTimeDuplicates Checked%checked1%, %DateTimeFormatDuplicates1%
Gui 38: add, radio,x15 y65  vFormatDateAndTimeDuplicates2 gRadioButtonDateTimeDuplicates checked%checked2%, %DateTimeFormatDuplicates2%
Gui 38: add, radio,x15 y85  vFormatDateAndTimeDuplicates3 gRadioButtonDateTimeDuplicates checked%checked3%, 9%a_space%%Tempvar%
Gui 38: add, radio,x15 y105 vFormatDateAndTimeDuplicates4 gRadioButtonDateTimeDuplicates checked%checked4%, 09%a_space%%tempvar%

Gui 38: add, radio,x15 y125  vFormatDateAndTimeDuplicates5 gRadioButtonDateTimeDuplicates checked%checked5%, %DateTimeFormatDuplicates5%

Gui 38: add, radio,x15 y145  vFormatDateAndTimeDuplicates6 gRadioButtonDateTimeDuplicates checked%checked6%, %DateTimeFormatDuplicates6%

Gui 38: add, radio,x15 y165  vFormatDateAndTimeDuplicates7 gRadioButtonDateTimeDuplicates checked%checked7%, %DateTimeFormatFilenamingConvention7a%

Gui 38: add, text, x15 y195,Example:
if ( DuplicatesRadioCheckMark = 1 or DuplicatesRadioCheckMark = 2 or DuplicatesRadioCheckMark = 5 or DuplicatesRadioCheckMark = 6 )
 Gui 38: add, edit, x90 y190 w500 ReadOnly center hwndHWND_ExampleEditBoxForDuplicatesEditBox1, Filename - %displaytime%.jpg
if DuplicatesRadioCheckMark = 3
 Gui 38: add, edit, x90 y190 w500 ReadOnly center hwndHWND_ExampleEditBoxForDuplicatesEditBox3, Filename - 9%a_space%%tempvar%.jpg
if DuplicatesRadioCheckMark = 4
 Gui 38: add, edit, x90 y190 w500 ReadOnly center hwndHWND_ExampleEditBoxForDuplicatesEditBox4, Filename - 09%a_space%%tempvar%.jpg

if DuplicatesRadioCheckMark = 7
 Gui 38: add, edit, x90 y190 w500 ReadOnly center hwndHWND_ExampleEditBoxForDuplicatesEditBox7, Filename - %DateTimeFormatFilenamingConvention7a%%SeparatorCharDuplicates%%DateTimeFormatFilenamingConvention7b%

Gui 38: add, button,x600 y190 h25 gApplyDateTimeFormatDuplicates w120 hwndHWND_ApplyAndExitButton,Apply && Close
Gui 38: font
Gui 38: font, s9
Gui 38: add, edit, x0 y235 w730 h20 vEditbox1 ReadOnly center,Email:  support@SavePictureAs.com to suggest more Date & Time options
Control_Colors("Editbox1", "Set", "0xd8d8d8", "0x000000")

Gui 38: font, s9
Gui 38: add, edit, x95 y165 w40 h15 center vFormatDateAndTimeDuplicates7Separator gRadioButtonDateTimeDuplicatesSeparator, %SeparatorCharDuplicates%
Gui 38: font, s10
Gui 38: add, text,x140 y165 gClickRadioButtonDuplicates , %DateTimeFormatFilenamingConvention7b%

Gui 38: font, s9
Gui 38: add, link,x670 y25 gMoreInfoForDuplicatesDateTimeOptions, <a id="1">More Info</a>


Gui 38: show, w730 h255,Date and Time Format for Duplicates

if ( DuplicatesRadioCheckMark = 1 or DuplicatesRadioCheckMark = 2 or DuplicatesRadioCheckMark = 5 or DuplicatesRadioCheckMark = 6 or DuplicatesRadioCheckMark = 7 )
 ControlGetPos,,TempvarYpos,,,,ahk_id %HWND_ExampleEditBoxForDuplicatesEditBox1256%
if DuplicatesRadioCheckMark = 3
 ControlGetPos,,TempvarYpos,,,,ahk_id %HWND_ExampleEditBoxForDuplicatesEditBox3%
if DuplicatesRadioCheckMark = 4
 ControlGetPos,,TempvarYpos,,,,ahk_id %HWND_ExampleEditBoxForDuplicatesEditBox4%
ControlMove,,,% TempvarYpos,,,ahk_id %HWND_ApplyAndExitButton% 
Gui 38: color, %DateAndTimeFormatScreensGuiColor%
WinGet,DateAndTimeFormatForDuplicatesID,ID,Date and Time Format for Duplicates
return

MoreInfoForDuplicatesDateTimeOptions:
IfWinExist,ahk_id %MoreInfoForDuplicatesDateTimeOptions%
 {
  WinRestore,ahk_id %MoreInfoForDuplicatesDateTimeOptions%
  WinActivate,ahk_id %MoreInfoForDuplicatesDateTimeOptions%
  return
 }
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000

Gui 63: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 63: add, text, x15 y15 w580,There are 7 options to choose from in this section.

Gui 63: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 63: add, groupbox,x15 y35 w600 h180,Date and Time Options
Gui 63: font,
Gui 63: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 63: add, text, x25  y55  w580,(1)  %DateTimeFormatDuplicates1% (Day of Week, Month, Day, Year, Hour, Minutes, Seconds, AM/PM )
Gui 63: add, text, x25  y75  w580,(2)  %DateTimeFormatDuplicates2% ("Date" Month, Day, Year, "Time" Hour, Minutes, Seconds, AM/PM)
Gui 63: add, text, x25  y95  w580,(3)  9%a_space%%Tempvar% (Hour, Minutes, Seconds)
Gui 63: add, text, x25  y115 w580,(4)  09%a_space%%tempvar% (Hour, Minutes, Seconds)
Gui 63: add, text, x25  y135 w580,(5)  %DateTimeFormatDuplicates5% (Month, Day, Year, - , Hour, Minutes, Seconds)
Gui 63: add, text, x25  y155 w580,(6)  %DateTimeFormatDuplicates6% (Year Month Day Hour Minutes Seconds)
Gui 63: add, text, x25  y175 w580,(7)  %DateTimeFormatFilenamingConvention7a% 
Gui 63: add, edit, x95  y175 w40 h15 center Disabled, %SeparatorCharDuplicates%
Gui 63: add, text, x140 y175, %DateTimeFormatFilenamingConvention7b% (Year Month Day [user chosen separator] Hour Minutes Seconds) 

Gui 63: add, button,x565 y220 w50 h22 g63GuiClose, Close
Gui 63: show,  w630 h250,More Info (Date and Time Options)
WinGet,MoreInfoForDuplicatesDateTimeOptions,id,More Info (Date and Time Options)
Gui 63: color, %AdditionalSettingsMenuColorGuiVar%
return
63GuiEscape:
63GuiClose:
Gui 63: destroy
return

ClickRadioButtonDuplicates:
GuiControl,38:,button7,1
return
RadioButtonDateTimeDuplicatesSeparator:
GuiControl,38:,button7,1
Gui 38: submit, nohide
StringSplit,SeparatorCharArray, FormatDateAndTimeDuplicates7Separator
Loop %SeparatorCharArray0%
 {
  if SeparatorCharArray%a_index% in \,/,:,*,?,",<,>,|,.                                                   
   {
    FoundInvalidChar = 1
    InvalidCharIS := ( SeparatorCharArray%a_index% )
    break
   }
 }
if FoundInvalidChar = 1
 {
  MsgBox,4160,Invalid Character, ( %InvalidCharIS% ) is an invalid filename character.`nPlease try again. 
  Send,{BS}
  FoundInvalidChar = 
  return
 }
GuiControl,38:,edit1,Filename - %DateTimeFormatFilenamingConvention7a%%FormatDateAndTimeDuplicates7Separator%%DateTimeFormatFilenamingConvention7b%.jpg
FoundInvalidChar = 0
return

RadioButtonDateTimeDuplicates:
Gui 38: submit, nohide
Loop %DateTimeFormats%
 {
  if FormatDateAndTimeDuplicates%a_index% = 1   
  {
   tempvar2 = % DateTimeFormatDuplicates%a_index%
   if ( A_index = 1 or A_index = 2 or A_index = 5 or A_index = 6 )
   GuiControl,38:,edit1,Filename - %tempvar2%.jpg
   if A_index = 3
    GuiControl,38:,edit1,Filename - 9%A_Space%%tempvar%.jpg
   if A_index = 4
    GuiControl,38:,edit1,Filename - 09%a_space%%tempvar%.jpg
   InvalidFileNameCharacters = \/:*?"<>|.
   if A_index = 7
    {
     IfInString, InvalidFileNameCharacters, %FormatDateAndTimeDuplicates7Separator%
      return
     GuiControl,38:,edit1,Filename - %DateTimeFormatFilenamingConvention7a%%FormatDateAndTimeDuplicates7Separator%%DateTimeFormatFilenamingConvention7b%.jpg
    }
  }
 }
return

38GuiClose:
ChangesHaveBeenMade = 0
Gui 38: submit, NoHide 
Loop %DateTimeFormats%
 {
  if FormatDateAndTimeDuplicates%a_index% = 1
   NewSetting = %a_index%
 }
if FormatDateAndTimeDuplicates7 = 1
 if FormatDateAndTimeDuplicates7Separator <> %SeparatorCharDuplicates%
  ChangesHaveBeenMade = 1
 
if DuplicatesRadioCheckMark <> %NewSetting%
 ChangesHaveBeenMade = 1

if ChangesHaveBeenMade = 1
 MsgBox,4131,Confirm,Do you want to save your changes?
IfMsgBox,no
 Gui 38: destroy
IfMsgBox,yes
 goto ApplyDateTimeFormatDuplicates
IfMsgBox,cancel
 return
Gui 38: destroy
return

ApplyDateTimeFormatDuplicates:
Gui 38: submit
Loop %DateTimeFormats%
 {
  if FormatDateAndTimeDuplicates%a_index% = 1
   {
    DateTimeFormatDuplicates = % DateTimeFormat%a_index%
    DuplicatesRadioCheckMark = %A_Index%
    if DuplicatesRadioCheckMark = 7
     {
      IniWrite,%FormatDateAndTimeDuplicates7Separator%,SpaConfig.ini, DatetimeFormat,SeparatorCharDuplicates
      IniWrite,SeparatorOptionDuplicates,spaconfig.ini,DateTimeFormat,SeparatorOptionDuplicates
     }
    else
     {
      IniWrite,%DateTimeFormatDuplicates%,spaconfig.ini,DateTimeFormat,Duplicates
      IniWrite,%a_space%,spaconfig.ini,DateTimeFormat,SeparatorOptionDuplicates
     }
   }
 }
Gui 38: destroy
return
22GuiClose:
CancelAdditionalSettingsMenu:
Gui 22: destroy
return
ApplyAndExitAdditionalSettingsMenu:
Gui 22: submit, nohide
IniWrite,%MaxHistoryMenuPicturesToList%,spaconfig.ini,history,MaxHistoryMenuPicturesToList

IniWrite,%PromptForFileName%,SpaConfig.ini,NamingConvention,PromptForFileName
IniWrite,%CustomFileNameFormat%,SpaConfig.ini,NamingConvention,CustomFileNameFormat
IniWrite,%OriginalFileNameFormat%,SpaConfig.ini,NamingConvention,OriginalFileNameFormat

IniWrite,%CheckForUpdatesAtStartUp%,SpaConfig.ini,CheckForUpdates,CheckForUpdates
IniWrite,%CheckForUpdatesDaily%,SpaConfig.ini,CheckForUpdates,CheckForUpdatesDaily
if CheckForUpdatesDaily = 1
 SetTimer,CheckForUpdatesDaily, %CheckForUpdatesDailyValue%
else
 SetTimer,CheckForUpdatesDaily, off

IfWinExist,ahk_id %SavePictureAsCheckForUpdatesGui12ID%
 {
  if CheckForUpdatesAtStartUp = 1 
   Control, Check , , , ahk_id %HWND_CheckForUpdatesAtProgramStartUpGui12ID%
  else
   Control, UnCheck , , , ahk_id %HWND_CheckForUpdatesAtProgramStartUpGui12ID%
  }

IniWrite,%ShowSplashScreen%,SpaConfig.ini,SplashScreenStatus,ShowSplashScreen
IfWinExist,ahk_id %SplashScreenID% 
 {
  If ShowSplashScreen = 1
   {
    IniWrite,1, SpaConfig.ini, SplashScreenStatus, ShowSplashScreen      
    ControlSetText,button1,Disable Splash Screen,ahk_id %SplashScreenID%
   }
  else
   {
    IniWrite,0, SpaConfig.ini, SplashScreenStatus, ShowSplashScreen      
    ControlSetText,button1,Enable Splash Screen,ahk_id %SplashScreenID%
   }
 }
IniWrite,%StartSavePictureAsWhenWindowsStarts%,SpaConfig.ini,StartWithWindows,StartWithWindows
if StartSavePictureAsWhenWindowsStarts = 1
 {
  IfExist,%A_ScriptDir%\SpaTrayIcon.ico
   iconfile :=  ( A_ScriptDir "\SpaTrayIcon.ico" )
  else
   iconfile := A_AhkPath ;use autohotkey green H icon
  
  FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\SavePictureAs.lnk , %A_ScriptDir% , , Save Pictures from your Web Browser, %iconfile%
 }
else
 FileDelete,%A_Startup%\SavePictureAs.lnk
IniWrite,%AskHowToHandleDuplicates%,SpaConfig.ini,DuplicateFilenames,AskHowToHandleDuplicates
IniWrite,%DoNotSaveDuplicates%,SpaConfig.ini,DuplicateFilenames,DoNotSaveDuplicates
IniWrite,%DoNotSaveDuplicatesAndNotifyMe%,SpaConfig.ini,DuplicateFilenames,DoNotSaveDuplicatesAndNotifyMe
IniWrite,%AlwaysOverwrite%,SpaConfig.ini,DuplicateFilenames,AlwaysOverwrite
IniWrite,%AlwaysOverwriteAndNotifyMe%,SpaConfig.ini,DuplicateFilenames,AlwaysOverwriteAndNotifyMe
IniWrite,%SaveDuplicatesWithRandomNumber%,SpaConfig.ini,DuplicateFilenames,SaveDuplicatesWithRandomNumber 
IniWrite,%SaveDuplicatesWithRandomNumberAndNotifyMe%,SpaConfig.ini,DuplicateFilenames,SaveDuplicatesWithRandomNumberAndNotifyMe
IniWrite,%AddDateAndTimeWhenDuplicateIsFound%,SpaConfig.ini,DuplicateFilenames,AddDateAndTimeWhenDuplicateIsFound
IniWrite,%AddDateAndTimeWhenDuplicateIsFoundAndNotifyMe%,SpaConfig.ini,DuplicateFilenames,AddDateAndTimeWhenDuplicateIsFoundAndNotifyMe
IniWrite,%CheckForIdenticalHashValues%,SpaConfig.ini,DuplicateFileNames,CheckForIdenticalHashValues
IniWrite,%CheckForIdenticalHashValuesAndNotifyMe%,SpaConfig.ini,DuplicateFileNames,CheckForIdenticalHashValuesAndNotifyMe

if DisableConfirmationMessage = 1
 {
  IniWrite,Disabled,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageStatus
  ConfirmationMessageValue = Disabled
 }
else
 {
  IniWrite,Enabled,SpaConfig.ini,ConfirmationMessage,ConfirmationMessageStatus
  ConfirmationMessageValue = Enabled
 }
IfWinExist, SavePictureAs V%Version% (Confirmation Message Configuration)
 {
  IniRead, ConfirmationMessageValue, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageStatus, Enabled
  if ConfirmationMessageValue = Enabled
   {
    ControlSetText,button3,Disable,ahk_id %CMCID%
    IniWrite, ENABLED, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageStatus		      
    ConfirmationMessageValue = Enabled
   } 
  if ConfirmationMessageValue = Disabled
   {
    ControlSetText,button3,Enable,ahk_id %CMCID%
    IniWrite, DISABLED, SpaConfig.ini, ConfirmationMessage, ConfirmationMessageStatus		      
    ConfirmationMessageValue = Disabled
   }
 }

IniWrite,%PlaceConfirmationMessageAtMousePosition%,SpaConfig.ini,ConfirmationMessage,PlaceConfirmationMessageAtMousePosition
if HistoryCheckmark = 1
 {
  HistoryValue = Disabled
  IfWinExist, ahk_id %HistoryID%
   {
    ControlSetText,button1,Enable History,ahk_id %HistoryID%
    Guicontrol, 3:,static1, Newest Entries on Top        History is Disabled
   }
 }
else
 {
  HistoryValue = Enabled
  IfWinExist, ahk_id %HistoryID%
   {
    ControlSetText,button1,Disable History,ahk_id %HistoryID%
    Guicontrol, 3:,static1, Newest Entries on Top        History is Enabled
   }
 }
IniWrite,%HistoryValue%,SpaConfig.ini,History,HistoryValue
IniWrite,%TurnOffRecordingOfTheLastSavedPicture%,SpaConfig.ini,History,TurnOffRecordingOfTheLastSavedPicture
IniWrite,%a_space%,SpaConfig.ini,History,LastSavedPicture
IniWrite,%DeleteRecordOfTheLastSavedPictureOnExit%,SpaConfig.ini,History,DeleteRecordOfTheLastSavedPictureOnExit
IniWrite,%ClearHistoryOnExit%,SpaConfig.ini,History,ClearHistoryOnExit
Gui 22: destroy
return
DeleteNow:
IniWrite,%a_space%,SpaConfig.ini,History,LastSavedPicture
MsgBox,4160,SavePictureAs V%version% (Information),Record of last saved picture has been deleted
return

GetAdditionalSettingsMenuXpos:
WinGetPos,AdditionalSettingsMenuXpos,,,,ahk_id %ASMID%
if AdditionalSettingsMenuXpos < 0
 AdditionalSettingsMenuXpos = 0
return
MoreInfoGroupBoxForFileNamingConvention:
IfWinExist,ahk_id %MoreInfoFilenamingConventionID%
 {
  WinRestore,ahk_id %MoreInfoFilenamingConventionID%
  WinActivate,ahk_id %MoreInfoFilenamingConventionID%
  return
 }
Gosub GetAdditionalSettingsMenuXpos
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000
Gui 30: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 30: add, text, x15 y15 w%MoreInfoTextWidth% , There are 3 options to choose from in this section.

Gui 30: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 30: add, groupbox,x15 y35  w%MoreInfoGroupBoxWidth% h80,Prompt For Picture Name
Gui 30: add, groupbox,x15 y127 w%MoreInfoGroupBoxWidth% h250,Custom Picture Name
Gui 30: add, groupbox,x15 y392 w%MoreInfoGroupBoxWidth% h80,Original Picture Name

Gui 30: font
Gui 30: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 30: add, text, x25 y55 w%MoreInfoTextWidth%,
(
Each time you save a picture you will be prompted to enter a filename. If SavePictureAs detects a file with the same name in your chosen "Save To" folder then SavePictureAs will use one of the "Duplicates" options to change the filename of your saved picture.
)

Gui 30: add, text, x25 y147 w%MoreInfoTextWidth%,
(
Custom Filename has 10 options on how your saved pictures can be named. With each of the 10 options you can also add a prefix and/or a suffix to the filename. If SavePictureAs detects a file with the same name in your chosen "Save To" folder then SavePictureAs will use one of the "Duplicates" options to change the filename of your saved picture.
 
The 10 naming options are:

Date && Time
Date && Time and Filename
FileName-Date && Time 
FileName-Sequential Number
FileName-Random Number
Sequential Number
Sequential Number-Filename
Random Number
Original Filename 
[UserInput1] Date && Time [UserInput2] Original Filename (When saving a picture you will be prompted for UserInput)
)

Gui 30: add, text, x25 y412 w%MoreInfoTextWidth%,
(
Each time you save a picture the original filename will be used. If SavePictureAs detects a file with the same name in your chosen "Save To" folder then SavePictureAs will use one of the "Duplicates" options to change the filename of your saved picture.
)

Gui 30: add, button,x530 y480 w50 h22 g30GuiClose, Close
Gui 30: show,  w%MoreTempvarGuiWidth%,More Info (Filenaming Convention)
WinGet,MoreInfoFilenamingConventionID,id,More Info (Filenaming Convention)
Gui 30: color, %AdditionalSettingsMenuColorGuiVar%
return
30GuiEscape:
30GuiClose:
Gui 30: destroy
return

MoreInfoGroupBoxForDuplicates: ;GroupBox
IfWinExist,ahk_id %MoreInfoDuplicatesID%
 {
  WinRestore,ahk_id %MoreInfoDuplicatesID%
  WinActivate,ahk_id %MoreInfoDuplicatesID%
  return
 }
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000
Gui 35: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 35: add, text,    x15 y15 w455    ,There are 6 options to choose from in this section.

Gui 35: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 35: add, groupbox,x15 y35   w470 h165 ,Ask What To Do When Duplicates Are Found
Gui 35: add, groupbox,x15 y210 w470 h65,Do Not Save Duplicates
Gui 35: add, groupbox,x15 y285 w470 h65,Always Overwrite
Gui 35: add, groupbox,x500 y35 w470 h65,Save Duplicate By Adding Random Number To Filename
Gui 35: add, groupbox,x500 y110 w470 h90,Save Duplicate By Adding Date && Time To Filename
Gui 35: add, groupbox,x500 y210 w470 h140,Check For Identical Pictures


Gui 35: font,
Gui 35: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%

Gui 35: add, text,    x25 y55   w455   ,If a duplicate filename is found in your "Save To" folder then this option will open a window
Gui 35: add, text,    x25 y75   w455   ,and display both images. You then will have the following options:
Gui 35: add, text,    x25 y95   w455   ,Add Date && Time to filename
Gui 35: add, text,    x25 y115  w455   ,Rename one or both 
Gui 35: add, text,    x25 y135  w455   ,Delete one or both 
Gui 35: add, text,    x25 y155  w455   ,Overwrite existing picture
Gui 35: add, text,    x25 y175  w455   ,Do not save new picture

Gui 35: add, text,    x25 y230  w455   ,When a duplicate is found the new picture will not be saved
Gui 35: add, text,    x25 y250  w455   ,You have the option to be notified when this happens

Gui 35: add, text,    x25 y305  w455   ,When a duplicate is found it will always be overwritten
Gui 35: add, text,    x25 y325  w455   ,You have the option to be notified when this happens

Gui 35: add, text,    x510 y55 w455    ,When a duplicate is found a random number will be added to the new picture name
Gui 35: add, text,    x510 y75  w455   ,You have the option to be notified when this happens

Gui 35: add, text,    x510 y130 w455   ,When a duplicate is found Date && Time will be added to the new picture name
Gui 35: add, text,    x510 y150  w455  ,You have the option to be notified when this happens
Gui 35: add, text,    x510 y170 w455   ,The format of Date && Time is configurable

Gui 35: add, text,    x510 y230 w455   ,When a duplicate filename is found in your save to folder this option will compare the MD5 Checksum values of both pictures to see if they are identical. If they are identical the duplicate filename will not be saved.
Gui 35: add, text,    x510 y255  w455  ,If this option is enabled and a duplicate filename is found but does not have an identical MD5 Checksum value to the original then the normal "How To Handle Duplicate Filenames" options will be applied. If the MD5 values are identical the duplicate picture will not be saved and all the other "How To Handle Duplicate Filenames" options will not be applied.`n`nYou have the option to be notified when this happens

Gui 35: add, button,x920 w50 h22 g35GuiClose, Close
Gui 35: show,  w1000,More Info (How To Handle Duplicates)
WinGet,MoreInfoDuplicatesID,id,More Info (How To Handle Duplicates)
Gui 35: color, %AdditionalSettingsMenuColorGuiVar%
return
35GuiEscape:
35GuiClose:
Gui 35: destroy
return

MoreInfoGroupBoxForStartUp:
IfWinExist,ahk_id %MoreInfoStartUpID%
 {
  WinRestore,ahk_id %MoreInfoStartUpID%
  WinActivate,ahk_id %MoreInfoStartUpID%
  return
 }
Gosub GetAdditionalSettingsMenuXpos
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000

Gui 31: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 31: add, text, x15 y15 w%MoreInfoTextWidth%,There are 4 options to choose from in this section.

Gui 31: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 31: add, groupbox,x15 y35  w%MoreInfoGroupBoxWidth% h75,Check for Updates at Start Up
Gui 31: add, groupbox,x15 y120  w%MoreInfoGroupBoxWidth% h95,Check for Updates Daily
Gui 31: add, groupbox,x15 y225 w%MoreInfoGroupBoxWidth% h110,Show Splash Screen on Start Up
Gui 31: add, groupbox,x15 y345 w%MoreInfoGroupBoxWidth% h75, Start SavePictureAs When Windows Starts

Gui 31: font
Gui 31: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 31: add, text,  x25 y55 w%MoreInfoTextWidth%, 
(
When SavePictureAs starts it will check to see if an update is available.
If an update is available you will have the options to view the changes in the new version and update SavePictureAs to the newest version. 
)

Gui 31: add, text,  x25 y140 w%MoreInfoTextWidth%, 
(
SavePictureAs will check for updates once every 24 hours. You will only be notified if an update is available.
If an update is available you will have the options to view the changes in the new version and update SavePictureAs to the newest version. 
)

Gui 31: add, text,    x25 y245 w%MoreInfoTextWidth%,
(
If enabled the SavePictureAs Splash Screen will be displayed each time SavePictureAs starts.
The Splash Screen has general information on how to save pictures with SavePictureAs.
Also, the Splash Screen lists some SavePictureAs features and the SavePictureAs support email address.
)  

Gui 31: add, text,    x25 y365 w%MoreInfoTextWidth%,
(
A SavePictureAs shortcut will be placed in %A_Startup%. 
Everytime windows starts SavePictureAs will also start. 
)

Gui 31: add, button,x530 y425 w50 h22 g31GuiClose, Close
Gui 31: show,  w%MoreTempvarGuiWidth%,More Info (Start Up & Updates)
WinGet,MoreInfoStartUpID,id,More Info (Start Up & Updates)
Gui 31: color, %AdditionalSettingsMenuColorGuiVar%
return
31GuiEscape:
31GuiClose:
Gui 31: destroy
return

MoreInfoGroupBoxForConfirmationMessage: ;GroupBox
IfWinExist,ahk_id %MoreInfoConfirmationMessageID%
 {
  WinRestore,ahk_id %MoreInfoConfirmationMessageID%
  WinActivate,ahk_id %MoreInfoConfirmationMessageID%
  return
 }
Gosub GetAdditionalSettingsMenuXpos
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000
Gui 32: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 32: add, text, x15 y15 w480,There are 2 options to choose from in this section.
 
Gui 32: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 32: add, groupbox,x15 y35  w%MoreInfoGroupBoxWidth% h90,Disable Confirmation Message 
Gui 32: add, groupbox,x15 y135 w%MoreInfoGroupBoxWidth% h110,Place Confirmation Message at Mouse Position

Gui 32: font
Gui 32: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 32: add, text,    x25 y55 w%MoreInfoTextWidth%,
(
When you save a picture you will not be notified that it was saved successfully. You will still be notified if saving your picture failed.
If a duplicate filename is found and depending on your choice on how to handle duplicates you may see a prompt on dealing with duplicate picture names. 
)

Gui 32: add, text,    x25 y155 w%MoreInfoTextWidth%,
(
When you save a picture you will receive a visual confirmation at the current mouse position that your picture was saved successfully.
As an alternative, you can configure SavePictureAs to position the confirmation message anywhere on the screen you like via the System tray icon, Settings, then "Confirmation Message".
)

Gui 32: add, button,x530 y250 w50 h22 g32GuiClose, Close
Gui 32: show,  w%MoreTempvarGuiWidth%,More Info (Confirmation Message)
WinGet,MoreInfoConfirmationMessageID,id,More Info (Confirmation Message)
Gui 32: color, %AdditionalSettingsMenuColorGuiVar%
return
32GuiEscape:
32GuiClose:
Gui 32: destroy
return

MoreInfoGroupBoxForHistory: ;;GroupBox
IfWinExist,ahk_id %MoreInfoHistoryID%
 {
  WinRestore,ahk_id %MoreInfoHistoryID%
  WinActivate,ahk_id %MoreInfoHistoryID%
  return
 }
Gosub GetAdditionalSettingsMenuXpos
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000
Gui 33: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 33: add, text,    x15 y15 w%MoreInfoTextWidth%    ,There are 5 options to choose from in this section.

Gui 33: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 33: add, groupbox,x15  y35 w%MoreInfoGroupBoxWidth% h60,Do Not Keep History of Pictures Saved
Gui 33: add, groupbox,x15 y110 w%MoreInfoGroupBoxWidth% h60,Clear History on Exit
Gui 33: add, groupbox,x15 y185 w%MoreInfoGroupBoxWidth% h120,Turn off recording of Last Saved Picture
Gui 33: add, groupbox,x15 y320 w%MoreInfoGroupBoxWidth% h60,Delete Record of Last Saved Picture on Exit
Gui 33: add, groupbox,x15 y395 w%MoreInfoGroupBoxWidth% h80,Maximum items to be displayed in the History Menu

Gui 33: font
Gui 33: font,  s9 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 33: add, text,    x25 y55 w%MoreInfoTextWidth%    ,This only affects the History Menu. 
Gui 33: add, text,    x25 y75 w%MoreInfoTextWidth%    ,The options below deal with the Last Saved Picture.

Gui 33: add, text,    x25 y130  w%MoreInfoTextWidth%   ,When SavePictureAs exits the History Menu records will be cleared. 
Gui 33: add, text,    x25 y150  w%MoreInfoTextWidth%   ,The options below deal with the Last Saved Picture.

Gui 33: add, text,    x25 y205  w%MoreInfoTextWidth%   ,Remembering the Last Saved Picture is completely independent of the History Menu.
Gui 33: add, text,    x25 y225  w%MoreInfoTextWidth%   ,SavePictureAs allows a hotkey to be assigned to rename the Last Saved Picture.
Gui 33: add, text,    x25 y245  w%MoreInfoTextWidth%   ,You may save a picture and then need to immediately rename it to a name of your choosing.
Gui 33: add, text,    x25 y265  w%MoreInfoTextWidth%   ,If you do not want SavePictureAs to remember the Last Saved Picture then turn this option off.
Gui 33: add, text,    x25 y285  w%MoreInfoTextWidth%   ,Remember this option does not affect the History Menu.

Gui 33: add, text,    x25 y340 w%MoreInfoTextWidth%    ,Choose this option if you want the record of the Last Saved Picture to be deleted when SavePictureAs exits.

Gui 33: add, text,    x25 y415 w%MoreInfoTextWidth%    ,The default is 30
Gui 33: add, text,    x25 y435 w%MoreInfoTextWidth%    ,The minimum is 1 
Gui 33: add, text,    x25 y455 w%MoreInfoTextWidth%    ,The maximum  is %HistoryLimit%

Gui 33: add, button,x530 y480 w50 h22 g33GuiClose, Close
Gui 33: show,  w%MoreTempvarGuiWidth%,More Info (History)
WinGet,MoreInfoHistoryID,id,More Info (History)
Gui 33: color, %AdditionalSettingsMenuColorGuiVar%
return
33GuiEscape:
33GuiClose:
Gui 33: destroy
return

MoreInfoGroupBoxForTroubleShooting:
IfWinExist,ahk_id %MoreInfoErrorLoggingID%
 {
  WinRestore,ahk_id %MoreInfoErrorLoggingID%
  WinActivate,ahk_id %MoreInfoErrorLoggingID%
  return
 }
Gosub GetAdditionalSettingsMenuXpos
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000

Gui 34: font, s10 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 34: add, text, x15 y15 w480,There are 2 options to choose from in this section.

Gui 34: font, s11 bold c%AdditionalSettingsMenuColorGuiTextVar%
Gui 34: add, groupbox,x15 y35 w%MoreInfoGroupBoxWidth% h300,Wait for Save Picture window timeout
Gui 34: add, groupbox,x15 y350 w%MoreInfoGroupBoxWidth% h265,Enable Log File

Gui 34: font,
Gui 34: font, s9 c%AdditionalSettingsMenuColorGuiTextVar%
Gui 34: add, text, x25 y55 w%MoreInfoTextWidth%,SavePictureAs waits for the "Save Picture", "Save Image" or "Save As" window (depending on browser) to become active before it can save the picture.`n`nThe minimum setting for this is 5 seconds. If the window does not appear after 5 seconds then SavePictureAs will timeout and a message will be displayed indicating the picture you are trying to save may not be a savable picture.`n`nThis timeout can be changed if for some reason your computer is taking longer then 5 seconds waiting for the "Save Picture", "Save Image" or "Save As" window to become active.`n`nThe maximum is set at 60 seconds.`n`nSome reasons it may take longer then 5 seconds for this window to become active:`nAntivirus program running a scan`nAvailable memory may be low`nToo many programs running in the background`nThe mouse or keyboard interrupted the SavePictureAs process
 
Gui 34: add, text, x25 y370    w%MoreInfoTextWidth%,When enabled saves errors to Logfile.txt located in SavePictureAs folder.`n`nThe Log File collects information such as..`nDate and time of error`nStatus of "Prompt For Picture Name"`nStatus of "Confirmation Message"`nStatus of "ErrorLogging" recording`nWait for Save Picture window timeout period in seconds`nSavePictureAs version`nWindows operating system type`nAutohotkey version (if installed)`nType of error`nWhich browswer was being used`nUrl of picture during error`n`nThis information is viewable before emailing to support@SavePictureAs.com

Gui 34: add, button,x530 y620 w50 h22 g34GuiClose, Close
Gui 34: show,  w%MoreTempvarGuiWidth% h648,More Info (Trouble Shooting)
WinGet,MoreInfoErrorLoggingID,id,More Info (Trouble Shooting)
Gui 34: color, %AdditionalSettingsMenuColorGuiVar%
return
34GuiEscape:
34GuiClose:
Gui 34: destroy
return
ViewErrorLog:
IfWinExist,ahk_id %ELID%
 {
  WinRestore,ahk_id %ELID%
  WinActivate,ahk_id %ELID%
  return
 }
IniRead,AdditionalSettingsMenuColorGuiVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiVar,c0c0c0
IniRead,AdditionalSettingsMenuColorGuiTextVar,SpaConfig.ini,SystemColors,AdditionalSettingsMenuColorGuiTextVar,000000
SysGet,MWA,MonitorWorkArea
FileRead,tempvar,LogFile.txt
if tempvar =
  FileContents = Log file is empty
else
  FileContents = %tempvar%
Gui 23: font,s12 c%AdditionalSettingsMenuColorGuiTextVar% ,Courier New
Gui 23: add,text,,%FileContents%
Width := MWARight - 100
Height := MWABottom - 100
if tempvar <>
 Gui 23: show, w%width% h%height% ,Log File
else
 Gui 23: show, ,Log File
WinGet,ELID,ID,Log File
Gui 23: +LastFound
GroupAdd, MyGui, % "ahk_id " . WinExist()
Gui 23: color, %AdditionalSettingsMenuColorGuiVar%
return

ClearErrorLog:
MsgBox,4132,Confirm,Clear Log File now?
IfMsgBox, yes
 {
  IfWinExist, ahk_id %ELID%
   WinClose, ahk_id %ELID%
  FileDelete,LogFile.txt
  MsgBox,4160,SavePictureAs V%version%, Log File has been cleared.
 }
return

23GuiEscape:
23GuiClose:
Gui 23: destroy
return
6GuiSize:
23GuiSize: ;View Log File Gui
46GuiSize: ;ViewChanges (View update changes)
47GuiSize: ;EnvironmentVariablesInfo gui
48GuiSize: ;EnvironmentVariablesInfo gui examples
UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight)
return
EnableDisable: ;splashscreen enable disable buttons
MouseGetPos,,,,Control 
ControlGetText,ControlText,%Control%,ahk_id %SplashScreenID%
IfInString,ControlText,Enable
 {
  IniWrite,1, SpaConfig.ini, SplashScreenStatus, ShowSplashScreen      
  ToolTip, Splash Screen is [Enabled]
  ControlSetText,%Control%,Disable Splash Screen,ahk_id %SplashScreenID%
 }
else
 {
  IniWrite,0, SpaConfig.ini, SplashScreenStatus, ShowSplashScreen      
  ToolTip, Splash Screen is [Disabled]
  ControlSetText,%Control%,Enable Splash Screen,ahk_id %SplashScreenID%
 }
SetTimer, RemoveToolTipSE, 3000
Return
RemoveToolTipSE:                    ;for splashscreen enable disable buttons
SetTimer, RemoveToolTipSE, Off
ToolTip
Return
RemoveToolTipSD:                           ;for splashscreen enable disable buttons
SetTimer, RemoveToolTipSD, Off
ToolTip
Return
50ButtonCloseWindow:                          ;splashscreen
50GuiClose:
tooltip
WinHide, ahk_id %SplashScreenID%
Gui 50: destroy
return

ChangeTrayIcon:
IfWinExist,ahk_id %ChangeSystemTrayIconID%
 {
  WinActivate,ahk_id %ChangeSystemTrayIconID%
  WinRestore,ahk_id %ChangeSystemTrayIconID%
  return
 }

IniRead, ChangeSystemTrayIconColorGuiVar, SpaConfig.ini, SystemColors, ChangeSystemTrayIconColorGuiVar, c0c0c0
IniRead, ChangeSystemTrayIconColorGuiTextVar, SpaConfig.ini, SystemColors, ChangeSystemTrayIconColorGuiTextVar, 000000

NumberOfIcons = 0
IconList =
ClosedGui = 0
ChosenIcon =

IniRead,ChosenIconName,SpaConfig.ini,TrayIconChoice,Name,OriginalSpaTrayIcon.ico
Loop %a_scriptdir%\*.ico
 {
  if ( A_LoopFileName <> "SpaTrayIcon.ico" and A_LoopFileName <> "TransParent_Square.ico" )
   {
    IconList = %IconList%%A_LoopFileName%`n
    NumberOfIcons++
   }
 }
 
if NumberOfIcons < 46
 {
  NumberOfIconsPerRow = 5 
  IconGuiWidth = 500
  ypos = 125
  ypos2 = 117
 }
If ( NumberOfIcons > 45 ) 
 {
  NumberOfIconsPerRow = 10
  IconGuiWidth = 900
  ypos = 90
  Ypos2 = 82
 } 
 
Gui 49: font, s11 c%ChangeSystemTrayIconColorGuiTextVar%
TextWidth1 := (IconGuiWidth - 20)
Gui 49: add, text, w%TextWidth1%, Please choose an icon to be used for the system tray icon. This can be changed later by clicking on the system tray icon then Change Tray Icon
Gui 49: font, s8
xval = 60

IdentifiedIcon = 0
Checked =
Loop, parse, IconList, `n
 {
  if a_loopfield = %ChosenIconName%
   {
    IdentifiedIcon = 1
    RadioNumberToCheck = %a_index%
    break
   }
 }

Loop % NumberOfIcons
 {
  if IdentifiedIcon = 1 ;this is needed if the last icon chosen to be the system tray icon no longer exists in the script folder
   {
    if A_index = %RadioNumberToCheck%
     Checked = checked1
    else
     Checked =
   }
  Gui 49: add, radio, vIcon%a_index% x%xval% %Checked% y%ypos%  w34 gChangeIconNow,%A_Index%
  if !Mod(A_Index, NumberOfIconsPerRow) ;limit rows to 5
   {
    Xval = 60
    Ypos := (ypos + 60)  
   }
  else
   xval := (xval + 80)
  if a_index > 98
   break
 }

xval = 94
xval2 = 50

Loop, parse, IconList, `n
 {
  Gui 49: add, picture,x%xval% y%ypos2% w32 h32 gAllowClickOnPicture,%a_loopField%
  if !Mod(A_Index, NumberOfIconsPerRow) 
   {
    Xval = 94
    Ypos2 := (ypos2 + 60)  
   }
  else
   xval := (xval + 80)
  
  if a_loopfield <>
   {
    Gui 49: add, groupbox, x%xval2% yp-15 w80 h54 
    if !Mod(A_Index, NumberOfIconsPerRow) 
     Xval2 = 50
    else
     xval2 := (xval2+80) 
   }
  if a_index > 98
   break
 }
Gui 49: font, s10 c%ChangeSystemTrayIconColorGuiTextVar%
if ( CurrentlyInSetup = "yes" )
 ChangeIconbuttonText = Next
else
 ChangeIconbuttonText = Close

if a_screendpi = 120
 TempVarButtonXpos = 330
else
 TempVarButtonXpos = 370
 Gui 49: add, button,x%TempVarButtonXpos% yp-55 Default gDoneChoosingIcon hwndHWND_CloseChangeIconGui w80 h25, %ChangeIconButtonText%

TextWidth2 := (IconGuiWidth - 130)
Gui 49: add, text,x20  w%TextWidth2% vAddIconsText ,Add icons to this list by placing icons in the same folder as SavePictureAs.
Gui 49:show, %TempVarX% %TempVarY% hide w%IconGuiWidth%,SavePictureAs (Change System Tray Icon)
Gui 49: color, %ChangeSystemTrayIconColorGuiVar%
WinGet,ChangeSystemTrayIconID,ID,SavePictureAs (Change System Tray Icon)
winset,alwaysontop,on,ahk_id %ChangesystemTrayIconID%

WinGetPos,,,TempVarWidth,TempVarHeight,ahk_id %ChangeSystemTrayIconID%
ControlMove,,% TempVarWidth - 110,% TempVarHeight - 35,,,ahk_id %HWND_CloseChangeIconGui%
ControlFocus,Close,ahk_id %ChangeSystemTrayIconID%
IconNumber = 0
WinShow, ahk_id %ChangeSystemTrayIconID%
SetTimer,WatchFolder,on
return

AllowClickOnPicture: ;ChangeTrayIcon gui
MouseGetPos,x,y,win,Control
StringTrimLeft,control,control,6
control--
ControlClick,button%control%,ahk_id %ChangeSystemTrayIconID%
return

DoneChoosingIcon: ;ChangeTrayIcon gui Close and X buttons
49GuiClose:
Gui 49: submit, nohide
SetTimer,WatchFolder,off
Gui 49: destroy
ClosedGui = 1
traytip
ChangeIconNow: ;ChangeTrayIcon gui glabel
Gui 49: submit, nohide
loop %NumberOfIcons%
 {
  if icon%a_index% = 1
   ChosenIcon = %a_index%
 }
if ChosenIcon =
 return
Loop, parse, IconList, `n
 {
  if A_index = %ChosenIcon%
   {
    Icon = %A_LoopField%
    IniWrite,%a_LoopField%,SpaConfig.ini,TrayIconChoice,Name
    If ClosedGui = 0
     traytip,Icon changed to,%a_loopfield%,3
    break
   }
 }
FileCopy,%a_scriptdir%\%Icon%,%a_scriptdir%\SpaTrayIcon.ico,1
Menu, TRAY, Icon, Spatrayicon.ico ;refresh icon
return
WatchFolder: ;ChangeTrayIcon gui watch script folder to see if icons were added or deleted from folder
NumberOfIcons1 = 0
Loop %a_scriptdir%\*.ico
 {                                                     
    if ( A_LoopFileName <> "SpaTrayIcon.ico" and A_LoopFileName <> "TransParent_Square.ico" )
   {
    IconList = %IconList%%A_LoopFileName%`n
    NumberOfIcons1++
   }
 }
 if NumberOfIcons <> %NumberOfIcons1%
  {
   if ( NumberOfIcons < 99 or NumberOfIcons1 < NumberOfIcons ) ;only refresh gui if 98 or less icons are currently being shown
    {
     WinGetPos,x,y,w,h,ahk_id %ChangeSystemTrayIconID%
     TempVarX := ( "x" x )
     TempVarY := ( "y" y )
     Gui 49: destroy
     SetTimer,WatchFolder,off
     goto ChangeTrayIcon
    }
  }
return

GetEnvironmentVariables:
EnvGet, UserProfile, UserProfile
EnvGet, AllUsersProfile,AllUsersProfile
EnvGet, AppData,AppData
EnvGet, CommonProgramFiles,CommonProgramFiles
EnvGet, CommonProgramW6432,CommonProgramW6432
EnvGet, HomeDrive,HomeDrive
EnvGet, HomePath,HomePath
EnvGet, LocalAppData,LocalAppData
EnvGet, ProgramData,ProgramData
EnvGet, ProgramW6432,ProgramW6432
EnvGet, Public,Public
EnvGet, SystemDrive,SystemDrive
EnvGet, SystemRoot,SystemRoot
EnvGet, Temp,Temp
EnvGet, TMP,TMP
EnvGet, Windir,Windir
EnvGet, HomeShare,HomeShare
return
CheckForEnvironmentVariablesAndBuiltInVariables:
IfInString,CurrentPath,`%UserProfile`%
  StringReplace,CurrentPath,CurrentPath,`%UserProfile`%,%UserProfile%,All
IfInString,CurrentPath,`%AllUsersProfile`%
  StringReplace,CurrentPath,CurrentPath,`%AllUsersProfile`%,%AllUsersProfile%,All
IfInString,CurrentPath,`%AppData`%
  StringReplace,CurrentPath,CurrentPath,`%AppData`%,%AppData%,All
IfInString,CurrentPath,`%CommonProgramFiles`%
  StringReplace,CurrentPath,CurrentPath,`%CommonProgramFiles`%,%CommonProgramFiles%,All
IfInString,CurrentPath,`%CommonProgramW6432`%
  StringReplace,CurrentPath,CurrentPath,`%CommonProgramW6432`%,%CommonProgramW6432%,All
IfInString,CurrentPath,`%HomeDrive`%
  StringReplace,CurrentPath,CurrentPath,`%HomeDrive`%,%HomeDrive%,All
IfInString,CurrentPath,`%HomePath`%
  StringReplace,CurrentPath,CurrentPath,`%HomePath`%,%HomePath%,All
IfInString,CurrentPath,`%LocalAppData`%
  StringReplace,CurrentPath,CurrentPath,`%LocalAppData`%,%LocalAppData%,All
IfInString,CurrentPath,`%ProgramData`%
  StringReplace,CurrentPath,CurrentPath,`%ProgramData`%,%ProgramData%,All
IfInString,CurrentPath,`%ProgramW6432`%
  StringReplace,CurrentPath,CurrentPath,`%ProgramW6432`%,%ProgramW6432%,All
IfInString,CurrentPath,`%Public`%
  StringReplace,CurrentPath,CurrentPath,`%Public`%,%Public%,All
IfInString,CurrentPath,`%SystemDrive`%
  StringReplace,CurrentPath,CurrentPath,`%SystemDrive`%,%SystemRoot%,All
IfInString,CurrentPath,`%Temp`%
  StringReplace,CurrentPath,CurrentPath,`%Temp`%,%Temp%,All
IfInString,CurrentPath,`%Tmp`%
  StringReplace,CurrentPath,CurrentPath,`%Tmp`%,%Tmp%,All
IfInString,CurrentPath,`%Windir`%
  StringReplace,CurrentPath,CurrentPath,`%Windir`%,%Windir%,All
IfInString,CurrentPath,`%HomeShare`%
  StringReplace,CurrentPath,CurrentPath,`%HomeShare`%,%HomeShare%,All
IfInString,CurrentPath,`%A_WorkingDir`%
  StringReplace,CurrentPath,CurrentPath,`%A_WorkingDir`%,%A_WorkingDir%,All
IfInString,CurrentPath,`%A_ScriptDir`%
  StringReplace,CurrentPath,CurrentPath,`%A_ScriptDir`%,%A_ScriptDir%,All
IfInString,CurrentPath,`%A_ScriptFullPath`%
  StringReplace,CurrentPath,CurrentPath,`%A_ScriptFullPath`%,%A_ScriptFullPath%,All
IfInString,CurrentPath,`%A_AhkPath`%
  StringReplace,CurrentPath,CurrentPath,`%A_AhkPath`%,%A_AhkPath%,All
IfInString,CurrentPath,`%A_AppData`%
  StringReplace,CurrentPath,CurrentPath,`%A_AppData`%,%A_AppData%,All
IfInString,CurrentPath,`%A_AppDataCommon`%
  StringReplace,CurrentPath,CurrentPath,`%A_AppDataCommon`%,%A_AppDataCommon%,All
IfInString,CurrentPath,`%A_Desktop`%
  StringReplace,CurrentPath,CurrentPath,`%A_Desktop`%,%A_Desktop%,All
IfInString,CurrentPath,`%A_DesktopCommon`%
  StringReplace,CurrentPath,CurrentPath,`%A_DesktopCommon`%,%A_DesktopCommon%,All
IfInString,CurrentPath,`%A_StartMenu`%
  StringReplace,CurrentPath,CurrentPath,`%A_StartMenu`%,%A_StartMenu%,All
IfInString,CurrentPath,`%A_StartMenuCommon`%
  StringReplace,CurrentPath,CurrentPath,`%A_StartMenuCommon`%,%A_StartMenuCommon%,All
IfInString,CurrentPath,`%A_Programs`%
  StringReplace,CurrentPath,CurrentPath,`%A_Programs`%,%A_Programs%,All
IfInString,CurrentPath,`%A_ProgramsCommon`%
  StringReplace,CurrentPath,CurrentPath,`%A_ProgramsCommon`%,%A_ProgramsCommon%,All
IfInString,CurrentPath,`%A_StartUpCommon`%
  StringReplace,CurrentPath,CurrentPath,`%A_StartUp`%,%A_StartUp%,All
IfInString,CurrentPath,`%A_StartUp`%
  StringReplace,CurrentPath,CurrentPath,`%A_StartUpCommon`%,%A_StartUpCommon%,All
IfInString,CurrentPath,`%A_MyDocuments`%
  StringReplace,CurrentPath,CurrentPath,`%A_MyDocuments`%,%A_MyDocuments%,All
return

SplashScreen:
IfWinExist, ahk_id %SplashScreenID%
 {
  WinRestore,ahk_id %SplashScreenID%
  Sleep 10
  ControlFocus,edit1,ahk_id %SplashScreenID% ;trying to prevent the text in the edit box from being highlighted when first loaded.
  ControlClick,edit1,ahk_id %SplashScreenID%
  return
 } 
iniread, SplashScreenColorGuiVar, SpaConfig.ini, SystemColors, SplashScreenColorGuiVar, d9d9fd

iniread, SplashScreenColorEditBoxVar, SpaConfig.ini, SystemColors, SplashScreenColorEditBoxVar, c0c0c0
StringSplit,Digit,SplashScreenColorEditBoxVar
SplashScreenColorEditBoxVar := ( Digit5 Digit6 Digit3 Digit4 Digit1 Digit2 ) ;convert for Control_Colors function

iniread, SplashScreenColorEditBoxTextVar, SpaConfig.ini, SystemColors, SplashScreenColorEditBoxTextVar, 000000
StringSplit,Digit,SplashScreenColorEditBoxTextVar
SplashScreenColorEditBoxTextVar := ( Digit5 Digit6 Digit3 Digit4 Digit1 Digit2 ) ;convert for Control_Colors function

IniRead, ShowSplashScreen, SpaConfig.ini, SplashScreenStatus, ShowSplashScreen, 1
if ShowSplashScreen = 0
 ButtonText = Enable Splash Screen
else
 ButtonText = Disable Splash Screen

Gui 50: default
Gui 50: font
Gui 50: font, s11, MS sans serif
Gui 50: add, edit, w740 h600 vSplashScreenEditBox ReadOnly  , %SplashScreenTextVar%

Control_Colors("SplashScreenEditBox", "Set", "0x" SplashScreenColorEditBoxVar, "0x" SplashScreenColorEditBoxTextVar)
Gui 50: font, s10, MS sans serif
Gui 50: Add, Button, x185  y625 w120 h40 gEnableDisable     , %ButtonText%
Gui 50: Add, Button, x465  y625 w120 h40 , Close Window
Gui 50: Color, %SplashScreenColorGuiVar% 
Gui 50:  +MinSize +MaxSize
if TestingColors = 1
 Gui 50: Show, x%Tempx% y%Tempy% w765 h680 ,SavePictureAs V%Version% (SplashScreen)
else
 Gui 50: Show, w765 h680 ,SavePictureAs V%Version% (SplashScreen)
WinGet,SplashScreenID,ID, SavePictureAs V%Version% (SplashScreen)
gui 1: default                       ;for some reason unknown to me, winshow will not unhide this gui until it is not the default
sleep 10 ;allows the focus and click to work as intended
ControlFocus,edit1,ahk_id %SplashScreenID% ;trying to prevent the text in the edit box from being highlighted when first loaded.
ControlClick,edit1,ahk_id %SplashScreenID%
Return

Survey:
IfWinNotExist, ahk_id %SystemColorsID% ;don't wait for the splashscreen to close before showing Survey if the systemColors window exist
 WinWaitClose, ahk_id %SplashScreenID%
IfWinExist, ahk_id %SurveyID%
 {
  WinRestore, ahk_id %SurveyID%
  WinActivate, ahk_id %SurveyID%
  return
 }
IniRead, SurveyColorGuiVar, SpaConfig.ini, SystemColors, SurveyColorGuiVar, d9d9fd
IniRead, SurveyColorGuiTextVar, SpaConfig.ini, SystemColors, SurveyColorGuiTextVar, 000000
IniRead, SurveyColorEditBoxVar, SpaConfig.ini, SystemColors, SurveyColorEditBoxVar, ffffff
StringSplit,Array,SurveyColorEditBoxVar
SurveyColorEditBoxVar := (Array5 Array6 array3 Array4 array1 Array2)
IniRead, SurveyColorEditBoxTextVar, SpaConfig.ini, SystemColors, SurveyColorEditBoxTextVar, 000000
StringSplit,Array,SurveyColorEditBoxTextVar
SurveyColorEditBoxTextVar := (Array5 Array6 array3 Array4 array1 Array2)

IniRead,ShowSurveyOnlyOnce,Spaconfig.ini,ShowOnlyOnceMessages,Survey,0
if ShowSurveyOnlyOnce = 0 ;if ShowSurveyOnlyOnce = 0 then this means the Survey Gui is being shown during startup. The below message is not needed if the Survey gui is being shown by clicking on the system tray icon then selecting "About"
 SurveyAddText = `n`nThis message can be shown again by clicking on the system tray icon then selecting "About"
Gui 56: Default
Gui 56: Font, s12 C%SurveyColorGuiTextVar%, Verdana
Gui 56: -MinimizeBox
Gui 56: Add, Text, x32 y10 w960 h30 , Please provide user feedback for SavePictureAs

Gui 56: Add, edit, x22 y50 w970 h320 vSurveyAssociatedVariable readonly , `nI began programming SavePictureAs in 2008. In 2011 I released SavePictureAs on the Autohotkey.com user forum. In January 2013 SavePictureAs began showing up on many websites for download and reviews. Since January 2013 I have released 2 major updates to add many new features and several minor updates to fix bugs. I have spent literally 100's of hours since 2008 programming SavePictureAs. SavePictureAs will always remain free.`n`nPlease take the time to provide feedback.`nI have created a 1 question survey with a comment section.`nPlease take the survey or send an email.`nIn the email just let me know whether or not you use SavePictureAs.`nI am also curious where you downloaded SavePictureAs from.%SurveyAddText%`n`nThanks`nSavePictureAs author Robert Jackson

Control_Colors("SurveyAssociatedVariable", "Set", "0x" SurveyColorEditBoxVar, "0x" SurveyColorEditBoxTextVar )

Gui 56: Font, S9 C%SurveyColorGuiTextVar%, Verdana
Gui 56: add, link, x15 y390 gSupportEmailLink,Email: <a href="Support@SavePictureAs.com">Support@SavePictureAs.com</a>
Gui 56: add, link, x15 y+10, Survey Link: <a href="http://www.surveymonkey.com/s/5BXFBTL">http://www.surveymonkey.com/s/5BXFBTL</a>
Gui 56: add, link, x15 y+10, Autohotkey Forum SavePictureAs post: <a href="http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/">http://www.autohotkey.com/board/topic/63251-savepictureas-save-imagepicture/</a>

Gui 56: Font, S8 CDefault, Verdana
Gui 56: Add, Button, x42 y+20 w230 h30 gRunSurveyInWebBrowser , Open web browser and take survey
Gui 56: Add, Button, x302 yp+0 w240 h30 gCopyEmailAddressToClipboard , Copy Email Address to Clipboard
Gui 56: Add, Button, x572 yp+0 w220 h30 gCopySurveyLinkToClipboard, Copy Survey Link to Clipboard
Gui 56: Add, Button, x822 yp+0 w150 h30 gCloseSurveyWindow, Close this window
Gui 56: Show, w1018 h520, SavePictureAs Survey Feedback
WinGet,SurveyID,ID, SavePictureAs Survey Feedback
Gui 56: color, %SurveyColorGuiVar% 
ControlFocus,button4, ahk_id %SurveyID%  ; SavePictureAs Survey Feedback
SurveyAddText =
return
SupportEmailLink:
send {Launch_Mail}
return
RunSurveyInWebBrowser:
run http://www.surveymonkey.com/s/5BXFBTL
return
CopyEmailAddressToClipboard:
counter = 0
Clipboard = Support@SavePictureAs.com
tooltip,Copy to clipboard successful
SetTimer,TurnToolTipOff,100
return
CopySurveyLinkToClipboard:
counter = 0
Clipboard = http://www.surveymonkey.com/s/5BXFBTL
tooltip,Copy to clipboard successful
SetTimer,TurnToolTipOff,100
return
TurnToolTipOff:
counter++
if counter = 15
 {
  SetTimer,TurnToolTipOff,off
  ToolTip
 }
return
56GuiClose:
CloseSurveyWindow:
gui 56: destroy
return

Eula:
IfWinExist, ahk_id %EulaID%
 {
  WinRestore, ahk_id %EulaID%
  WinActivate, ahk_id %EulaID%
  return
 }
IniRead, EULAColorGuiVar, SpaConfig.ini, SystemColors, EULAColorGuiVar, d9d9fd
IniRead, EULAColorListBoxVar, SpaConfig.ini, SystemColors, EULAColorListBoxVar, ffffff
IniRead, EULAColorListBoxTextVar, SpaConfig.ini, SystemColors, EULAColorListBoxTextVar, 000000

Gui 57: font, s12 , MS sans serif
colon = :
Gui 57: Add, ListBox, w920 h550  vscroll 0x100 choose1 c%EULAColorListboxTextVar% , 
|End-User License Agreement (EULA)
|-------------------------------------------------------
|
|The following terms are used during the End-User License Agreement%colon% 
|
|SOFTWARE = SavePictureAs
|AUTHOR = Robert Jackson
|USER = anyone who downloads, and/or runs (i.e. USES) the SOFTWARE
|
|This is an agreement between the USER and the AUTHOR.
|The SOFTWARE is protected by copyright laws and is the intellectual property of the AUTHOR.
|
|All intellectual rights are reserved by the AUTHOR. The software is NOT the property of the USER, but only licensed
|for use according to the terms of this EULA.
|
|The SOFTWARE is freeware, which means that it can and should be distributed, copied, uploaded, downloaded and shared
|freely by anyone, but only in its entirety, the original distribution. Any attempts to reverse-engineer, modify or
|alter the executable binaries of the SOFTWARE in any way are strictly prohibited. Using parts of the SOFTWARE in any
|other software product is strictly prohibited.
|
|Distributing the whole SOFTWARE as part of another software product is bound to written permission of the AUTHOR,
|except for free software collections. Such bundling must always be done with proper credit given. Selling, hiring,
|lending, or making money in any way from any storage media (CD, DVD, floppy disk, hard disk, memory card, other) 
|which admittedly contains the SOFTWARE is bound to prior written permission of the AUTHOR.
|
|The SOFTWARE is provided by the AUTHOR in good faith but the AUTHOR does not make any representations or warranties
|of any kind, express or implied, in relation to all or any part of the SOFTWARE, and all warranties and representations
|are hereby excluded to the extent permitted by law.
|
|Disclaimer%colon% 
|
|THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
|BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
|NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
|DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
|SOFTWARE.
|
|
Gui 57: add, button,w80 h25 x850 y570 gCloseEula, Close
Gui 57: Show, w950 H605 ,SavePictureAs V%Version% (End-User License Agreement (EULA))
Gui 57: Color, %EULAColorGuiVar% , %EULAColorListboxVar%
WinGet, EULAid, id, SavePictureAs V%Version% (End-User License Agreement (EULA))
Return
57GuiClose:
CloseEula:
Gui 57: destroy
return

CreateSpaImage:
ifnotexist, %A_ScriptDir%\spaimage.jpg
{
ImageData1 =
(join
FFD8FFE000104A46494600010101006000600000FFE1001645786966000049492A0008000000000000000000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC000110801B8020703012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA28A2800A28A2800AAD3DE416FC3B65BFBABC9AA379A8924C703600E0B8EFF4FF001ACDA5733954B6C68BEAF21C6C8957D771CFF8537FB5EE3FBB17E47FC6A851419F3C8D04D5E507E78D187FB391FE35762D46DE538DE50FA38C7EBD2B0A8A2E35368EA68CD73F6F7F3C1819DE83F85BFA56D433C73A6E4607D4771F5A66B19264D451450514B5199E1815A26DAC5F19C67B1A34E99E7819A46DCC1C8CE31D8541ABB911C49C60927F2FFF005D3F49FF008F57FF007CFF0021488BFBD63468A28A6585149505DCAD0DB3C8A0165C633D3AD027A13D158BFDAD71FDD8BF23FE347F6B5C7F762FC8FF008D2B93CE8DAA2B17FB5AE3FBB17E47FC68FED6B8FEEC5F91FF001A2E1CE8DAA2B17FB5AE3FBB17E47FC68FED6B8FEEC5F91FF1A2E1CE8DAA2B17FB5AE3FBB17E47FC68FED6B8FEEC5F91FF001A2E1CE8DBA2B13FB5AE3FBB17E47FC6A45D5D828DD102DDC86C0A2E1CF135B3466B2FFB63FE987FE3FF00FD6A9535585880C1D33D4919029DC7CF13428A822BA826E239549F4E87F2A9E82828A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00AB7B2B4368EEA407E00FCEA1D3AE9EE37ACAC0B0C11C60D33577C471A63AB139FA7FFAEAAE98FB6F40C677A91F4EFF00D2919B97BE6ED14514CD028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A002B2351BD2C5A18890070E7D7DAACDFDD79116C523CC6E073C81EB58949994E5D105145148C828AB9069B34DCBFEED7FDA1CFE5563FB1FFE9BFF00E39FFD7A65283665D15A4FA4385F925563FED0C7F8D519619616DB22153DB3D0D20716B723A92295E1903A1C11F91F6A8E8A09376D2ED6E93B2C83EF2FF5156EB9804A9041208E41153B5FDCBA95331C1F4001FD29DCD554D3524D4E5125CED0490831D78CF7FF003ED57749FF008F57FF007CFF002158D5B3A4FF00C7ABFF00BE7F90A0507795CD0A28A299B0554BF567B3915549638C00327A8AB545026AE8E6DA09914B344EAA3A92A40A8EBA8E29924492A6D750CBE86958CFD99CD51576FAC4DB9F32304C67FF001DAA548CDAB68C28A28A04145145001451450014514500156A1BFB889865CBAE7255B9CFE35568A069B5B1D05BDE4572BF29C38192A7A8AB35CB82548209047208AD9B2BE138F2E420483F5A77358CEFA32FD14514CD028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00C3D524DF77B32708A060F4CF5FF000AAD6EFE5DCC6E58A80C3247A77A75CBF99732B6E0DF31C11E9DAA1A939DBD6E75345470B17823738CB28271F4A92A8E80A28A2800A28A2800A28A2800A28A2800AE5F44F177DBEEBECB79673C4CFA85DD8C37222DB0C8F0CB2ED8C65B716F2A22C580D990C3706F947515CBE9DE13B8B3D460967D57ED1676FA85D6A5041F6708E92CC66CAEF0798C2CEDC11B8B73B82E1000751451450014D2428249000E4934B547529FC9B7D83EF49C7E1DFF00CFBD026ECAE64DC4A6699E424904FCB9EC3B0A8E8A2A4E70ADBB2B2100F32400C87F4AA7A65BF992F9CC06C4E9F5ADAA68D211EAC28A28A66A14C745910A3A8653D41A7D1401877D626DCF99182633FF008ED52AE9C80C0820107820D61DF5A7D9E5CA03E53743E87D293319C2DAA2A5145148CC2B6749FF008F57FF007CFF002158D5B3A4FF00C7ABFF00BE7F90A68BA7B9A1451453370A28A2800A28A28023963596268D87CAC306B9C910C72321C65490715D3D606A000BE94000743C7D052667516972AD145148C428A2B76CEDA18E28E4541BD9412C7AF4FD299518F31931D9DC489B9223B4F424819FCEA7FEC9B8FEF47F99FF000ADBA28B1A7B3460C9A6DCC63202BFAED355482A4820823820D75155AE6CE2B95F9861C0C061D451613A7D8E7E8A92589E190C720C11F91F7A8E91905282548209047208A4A280376CAED6E23009FDE28F981FE7572B9BB79DADE659179C7519EA2BA2470EA194E4119069A3784AE87514514CB0A28A2800A28A2800A28A2800A28A28012A3998C7048E319552467E952D52D4DC2D9B03FC4401FCFF00A5026EC8C3A28A2A4E63734C70D66A07F0920FF3FEB570565690FCCB1963D980FE7FD2B56A8E883BA168A28A0A0A28A2800A28A2800A28A2800AE7F44F13FF006D5D416C967E5CCB68D2DFAF9B9FB24C25317959C0DFF3C770372F1FB9CF47535D0563E8BA37F66DE6AD76E902497D76655588711C6000173819CB7992918C0799FA9CB3006C51451400560EA32996E9941CAA7CA3FAFEB5B72388E36739C2824E2B9A662EECCC72CC724D266751E96129402C40009278005255AD3A3F32ED738C27CC7FA7EB8A46495DD8D8B5805BC0B18C6472C7D4D4F4515474894515E59F10FE23A58C93685A35D2ADDE0ADC5D06C791EA8A7FBFEA7F87EBF7665251444E6A0AECEAFC4BE3AD07C2F1B7DBEEB7CEB8CDBC237C8338EA3A2F073F311919C66BCC6FBE3AEAD2C8ADA76916714780ACB70ED236EE4E72A578C638C67AD700ED05D3110058FCC40247EA3800E47A7FF5AA8DDDAC2252C1E50AD82848C9E33D3D793593949F538E55A527BD8EAE7F8BDE35695E55BC8E18DD8948D6DE321475C0241381D3939AE9749F8DB757B72D67AA69503ACACAAA6D5CA95EB9E189DC78181951C7279E3CC44A96D1246EABC9C062091F4CFD08AB560F02B79F0C07CD571CC582473D0E7B1F51CD2D7A327DA496CD9EF1A278974DD7D5859CAC2655DCD0C830EA338CFA1FC09C646715AF5F36DD25EE9D7A1D66D8D17FAA9E238FBA460FAE411D7AD7A27833E265BCA90E97ADCE4CE0848EF08F958738F30F63C019EF9E71C9AA53B7C438547F68F4EAD8D27FE3D1CFFB67F90AC7AB66FBFB33C3F7F7DE5F99F668E49B66EC6EDA99C67B6715A5EDAB3A60D2D59E7DE19F1BEB1AC7C485B1FED11369325C5C08A3F215498C233273B4374C7BF1CD7AF57CE5F0C7CB3F11F4B68E4DCA566F97A107CB7CF1F8D7D1B59D26ECEFFD6C4E15C9C5F377168A28AD8E9133474AF15F1D78E7C4FA2F8B750B3D3AFC476D088F647E4236331AB1E4A9EE4F7AE4EDBE2A78EEEC958B514E0F2C6DA3C28F7F92B2F6BE473BAE936ACFF0FF0033E96AC5D5BFE3ED3FDC1FCCD78349F167C5A8CF12EAFE6C83A15B6842FF00E83CD4517C4BF165E4BBAE754897030098221EA7FBB47B5F2FCBFCC89E21356B3FC0F70A2BC5878FFC4133208754C0C7CCCD0C6474CFF76A39FE20F88E27F9753211BEEE6DA324FF00E3BCF34BDA797E465ED9767F87F99EDB5D15B7FC7AC3FEE2FF002AF9A9FE23789A20824D4802C70185BC7B7D7AEDF422B42D3E27F8AA48005D4DD82E1311C109DBE99CA53553C8B8E214774FF0FF0033E8BA2BE73BDF893E38B29DD1F5788A0DDB6416D160E0E3FBBF5AB56BF1CF5C89EDE29ACEC6E9136899D55919C0FBDCE7018FD31CF4A3DAF91AAC445F467D0545796693F1AF4ABA942EA36135986650AF1C8250013C96185200E3A03DFF001F44D3754B1D5ECD6EEC2EE2B885B1F3C6D9C1C03823A8382383C8CD5A927B1A42A427F0B24BDB45B88C903F78A3E53FD2B0C82A4820823820D74F58FA9DB88E5F397EEB9C30F43FFD7A6C2A47A99F451452310AD5D266255E227A7CCA3F9FF4FCEB2AA482530CC8EBD54F4F5A6545D9DCE968A68218020820F208A7533A028A28A0028A28A00C0F17EAEDA0F85752D490BAC914388D91431576F954E0F0406209F61DFA579D7C38F881ABEB5E294B0D5AF1A64B88DD638BCB8D4ABAFCDB8E154E36AB0EFC91F86BFC67D53EC7E108AC62B8F2E5BD9C6E5D99DD1A0C9E71C61BCBF7FD6BC6BC17AA9D37C75A3DCA5DA22ACEB1CB2BE02AC6C76B649E07CA4F358CE4F9AFD8E4A936AA68F4563EB2A281D28AD8EB12B2B577E628C37AB11FCBFAD6B560EA4FBEF186410A028C7F9F53499137A1528A28A4605BD31CADE2818F98107F9FF4ADDAE6A1711CF1B9CE158138FAD74D4D1B537A0514514CD028A28A0028A28A0028A28A0028A28A0028A28A00A5A9C9B2D0819F9885041FC7FA561D6A6AEDCC481BD4919FCBFAD65D266137A856BE90804323F392D8FC87FF005EB22BA0B14D9671038E99E3DF9A10E9AD4B3451487A533638CF88DE2D3E13F0BCB3DBC8AB7F31F2ADB700D83DDF693C803EBC95C8C1AF99A23E696392DCE49E832739AECBC77AB378ABC537176D215B31B61B4E393182791F283F3125B07919C5724B68EB752C2E7073B76A9E41AE76F99DCE09D4E76CD6D355469D7619537CC0471E73D3183FAD67F9CC4295566DABB531921707D3AF5AECFC19E05B8F153C31485A3D360E27B91C3673931A7FB47AE7B03F407DBBC3FE10D17C2F6CB1E976491BEDDAD337CD2BF033963CF3B41C0C0CF6A69396C285273D51F3947E15F15C5E5B37872FE5DB95DA6D1FA71DF1F5AA88A600D2829B8B12017C1C1E8064F6FA57D71B47A566EA7A1E99AD43E56A56305CA05655F36304A86183B4F553D39183C0A7ECDF7349619F467CBBAACF6F71104DDB4A2E412A4F60304FAF158D06D8C895F0DBB950986FFF00557A7F8E3E13CDA25A9D4F46964BAB487FD6C3201E64498E5B23EF0CE49E06063A8048F316852323CA05988FBE38A9F531E571D19E8DE1FF00881368A905ADDB35DD9F9636A6E1BE15079C37F171FC27D0608152F8ABE204FE20D24E95A55BF95653B876925C33CA06D2171D14061EA49C0E9C83E67E7E22557DCF28E1324657DEA4B3B978E74765F97A9017A7F9E69797412E64AD7D0EE7E1647347F11F4D499363A0983023193E53F38AFA42BC03E1E4D05F78EF47BD862600F9C85F3907F74FC7D6BDFEB4A5D7D7F447561BE17EBFA2168A28AD4E93CDBC57F0B3FE127D62EEF8EB1F665B96426316DBC8DA8AB8CEF1FDDCF4AE6EE7E0CEA9A5DB31D27558AECEC72D14E9E5E4F180A3254938C7381D3DEBDB28ACFD9C4C5D183D4F8FB5AD36E347BF7B3BAB416D3C0764B19CF07AF1EA30460F7EB54E001970B9207E001FF38AFA03E30F8622D4F408F554C25C59BAABB0032F1BB018E849218820640E5BB9AF055B475BA96173839DBB54F20D66D59D99CB38F2BE566B69AAA34EBB0CA9BE60238F39E98C1FD6B35AE70AADCE146D8CF385C1F4FAD589100B786D002EC14E593AA0DD9E7D391D6B30DB4D0C8485DA85B0A77647D01A0849162192E1423794936C07E523B71DFF003F7ABB1E22DD2ABC65B7138DFCE0F4039EDF4ACC86E64B794F970FCEB2725867B0C0F5CFF8D6ED97837C57AD35B08348BC292FEF239648B646C31B81DCD81C8E993CF14AE81AE845AACF6F71104DDB4A2E412A4F60304FAF158D06D8C895F0DBB950986FFF005575DA87C36F15D94114CFA34CFF003ECC42CB29E72790849C75E7A74AE4A4B7585804562E472D8C51708AB68CD564B350A43B2965DF856C81EB9FF0AB7A36ABA96897315CE8975E54A432ACA1437980F62A7823D88EA01F4AE7BCFC44AAFB9E51C2648CAFBD496772F1CE8ECBF2F5202F4FF3CD3B0946DA9F497837E20D9F895D6C2EA36B3D61133240FC24846726339E78E707900F7C135D85D4427B674C65B195FAF6AF95AFEF83C16DABD924F1CB1382B3C279423BE7B115EEDF0E7C709E2CD28C573342754B7E2554E0C89C6240318EA7071C03E9902AE32E8CEBA556FEEC8D2A2A7BC8FCABA9140C29391C6060D41560D5828A28A046EE9B2F9968B9EABF29FE9FA62AD8AC6D2A5D970D19C7CE38FA8FF26B66A8E883BA168A28A0A0A28A0F4A00F0CF8E177E6EAD6162EC82286D8CC8704925D88209CF4F9171F8D7925BED89966721B71DCBB307FF00D55D6FC47BA8352F887A93C0AC1D251110C319F2D421E87A654E3DAB936852323CA05988FBE38AE6DEFE679F27772BF53EBED26FBFB4B46B2BEF2FCB37304736CCE76EE50719EF8CD5EAE1FE14EA1F6FF87F601AE1E696DF7C1217249521890B93D70A57A718E3B57715BC5DE299DB4E5CD14C5AE6657F32577C6373138F4CD6F5DC9E55AC8D920EDC023A827815CF5364D47D028A28A46415D1DBB992DE362C18951923D7BD7395B7A5B96B4C1C7CAC40FE7FD69A34A6F52F514514CD828A28A0028A28A0028A28A002BC7CE8FE669F7B3FFC237A1C6D7BADDEDA26BE64FF004CB4924BC9638E6DA21CEE5728ABB64CE76925064AFB055736166D673599B480DACDBFCD84C63649BC92FB97A1DC5989CF5C9CF5A00B14514500616A8E1AEF033F2A807F9FF5AA7562F5C3DE4A467AE39F6E2ABD49CF2DC2BA2B5FF8F587FDC1FCAB9DAE8EDCE6DA22001F28E076E29A2A9EE4B5C1FC53D7CE8BE10921496349AF9BECF966195423E76DB83918F94FA6F073D2BBBCD7CE7F18F589352F1635AC32EEB7D3D04442C9BD4B9F998E3A29E4291FEC7E0226F4B770AD2B46DDCE48EA888E622FBD132C17247CDEA08E7823F4AB3A3692DAC6A56F656C647BC9D82A13C85248C938C9DA01249C1C05AE7613BDD9981C05C000706BD77E0AE8E2E35AB9D424418B28B0AA5CE4492640200E0FCA1C1CFA8FC32DF438D42ED45753D8742D0ECBC3BA645A7D847B214E4B1E59DBBB31EE4FFF005860002B568A2BA12B688F45249590B45145318D3822BE76F8AFE037D1B5B8B51D36344D3EED8FEE6352A21931C8CF400F2C00C7F100302BE8A238ACCD6B4B8358D22E2C6E558C72AE3E5382181CA91F4201E78E39C8A89C6EB4DCCAAC39A3A6E7C83F63B812EC2A3764AA9FEB9FC7B7A55EB4B55237C906F0B8CC9BBAE3D00FE66B735EB33A6EA12D9DE440DCC0DF308D8618150411EDCE7D79E6B363D4D21DB22ED51B703CB18DD9CF247E98AC93B9C2A4D9DEFC368D21F16E931A0644F365658D9C1DB9864F7FA76FC6BDF2BE76F86572F37C42D290FDDFDF30F9B207EE5857D13574BAFAFE88E9C2FC2FD7F442D14515A9D41451450066EB766FA8683A859425049716D24285FEE82CA40CE3B735F2AA456EA4B4B2BF9A013B89E87D33D7A7F2AFAE9FEE9AF90DE478629BCB60A776E60C73DFB0FC2B1A9BA38F12B545989ADCC9E68048009DA0B658019C8E3AE3A8C7D0D54995A36169108F7945DEC492C1B8E403F8F5E7F0C540B34EF703ED0EB87CE0EC5DADD4E768153695748B2812AE13079DA0E09FF3DEA4E748F70F0A786347B4D22CAF96C6292EE78629DE6954336EC6E0467EEE33C631D06735E956C3FD161FF717F95719E1FF00F916F4BFFAF38BFF004015D9DB7FC7AC3FEE2FF2AD29A4A28EBC3A4A3A1371E95C4F8E7E1EE9DE2EB1791638EDF535CB4574AB82C718DB211CB0C003B91818EE0F6F495728A92B33794549599F1BDFE89A8E97A94DA7DEC061B989CC651BA8E9CE7D390411D6A5B4B55237C906F0B8CC9BBAE3D00FE66BE88F891E0F8FC45A40BBB7854EA366A5D4AA92F34601CC5C72724E4707918E37135E029A92DB90E02A6010020233D7391FA63DAB06ACECCE1A91945F2B36ECE0B74D35E2937C7003BFCB2F9C027A75C9E3DAA2D2F513E12D76DB52B744628FBC2700ECFE35CF38CAEE19238E78CE2B3A2BC91E68D31B94B676824E4600231F41F97BD5CBD4925B6920BCDE4A8DD08C0DDD7903D7807D79E31D28314CFA10DFDB6AF6165A95A3EE86E22DCB92091EC719E4124119E08A8EBCDBE1578849B497C3B72D8319F3AD03364818C488327D7E60001FC46BD26B48CAE8EB8CF995C28A28AA192DAC9E55D44F918DD824F400F06BA4AE5ABA489FCC895F18DCA0E3D334D1AD37D0968A28A66A2556BBBA86C6CA7BBB87D90C31B4923609DAAA324E073D0559AE4FE216A0DA778235178DA3F3A78FECF1A487EF973B481C8C9DA58FE19E82A64ED16C99CB962D9F30CB797371A8CD334AF2493C8CCF2487733939E493CE7A534D9C97253C92491C95CE0E2AFA58EE0B1CCC54A91F3003F13915D3DADBD8D9C2C55A3996319550413D3D6B04ACAC79D7B68767F026EE68ED757D2EE274C47224B14271BB9043B7A91C20F41C7AD7B11AF09F865A9450F8E618922CB5D432C3927054001F3C0E798C8FF817B62BDDC56B49E963AF0F2BC2DD9943557DB6A14301B98647A8FF0038AC6AD1D5DF32C498E8A4E7EBFF00EAACEAB639BF7828A28FF3D691015A5A438124A9CE4807F2FF00F5D66D5AD39F65E27CC006CA9CF7FF002714CA8BB337E8A28A6740514514005145140051451400579FE99A83BF8A2D106A33C9ABBEAB7916A1646E99BCAB25171E4B1B7276C4A76DAE240AA5B72F27CC3BBD02ABD9DF5BEA1034D6B27991ACB2424ED230F1BB46E39F46561EF8E38A00B1451450073771FF001F537FBEDFCEA2A92E086B99482082E4823EB51D49CCF70AE8AD4836B0E083F20E9F4AE76B734C70D66A067E5241FE7FD69A2E9EE3AF2EA1B2B29EEE77D90C31B4923609DAAA324E073D057C9B777935D6A7737B7ACD235C48CD2B1E016639DC00C01D6BE91F88D77258F803569E37D87CB5463807E4675561F8A923F1AF99A5DC50346C8AA070A7B83F5EFC71594FE231C43F7D2F218D172DE59FDD1E983DFB57D2FF000E348FEC8F04582EC4F36E53ED3294624317E475E876ED1C7191F8D7CE70A160265DBB3214F61B87A7BF4AFACECED61B1B282D204D90C31AC71AE49DAAA30064F3D05105790B0EAF36FB16A8A28AD8ED0A28A2800A28A2803C6BE28684B20B6D4914B4B049F6790842D9424907AE179E3A73BC7B578FA5A09AF1B292321620063B593EBEB5F4D7886C135286FAC9B6A89A3DA18AEEDAC470D8F50707EA2BE6F9BED366ED0C8AA25590A88E452086EE39E463DEB092B48F3AA2E59BF33B1F860862F881A6A07DC999718E87F72F5F44D7CF3F0BD276F19E9334D12C796954632377EE64E7079AFA1AAA975F5FD11BE17E17EBFA2168A28AD4EA0A28A2801A6BE4DF1447159F8D35A48E348E38EEE6558D176AAA8738031D38CD7D646BE4CF1A9917C6DAD94DB837D3641EF876FF00135954E872E23A19CF1974936215520157240DBEBD7B75EF55E4B5316092B83B72060FFF00AC71EF4D967FDC463632BE09049F53D3E94EB59EE06C4B71217639509CE4F6F6EBEBE95073B47D29E1FF00F916F4BFFAF38BFF004015D9DAFF00C7AC3FEE0FE55C6787FF00E45BD2FF00EBCE2FFD0057676BFF001EB0FF00B83F956B4FE147550F857A13D145156740DC57CD9F11BC20344F19C9E4C07EC17BFBF876FCAB19CFCCA3000E0FF08CE015F5AFA5335E73F17B4A6BAF09A6A5124467B1943032311F2390A40C719DDB0F3E879F5CEA2D2FD8C2BC6F0BF63C382B42ACA1F72EE18F9B00FE55A16D131B4F32574009CC4D9F9BAE4F191C0254E73C11D0D57B58679ED15E681537B6D1B78DFD79E7DEB56792382CEDB7A105584880755E4E31599C3629D96A09A1EAF6D3C4A1658660E62572A4A2F519E8015F4CF04FD2BDF239126892589D5E37019594E4303D083DC57CFD777116A090C52C4B246ADB483FC19CE0E7B723F9FBE7D77C07A83DF7852DD256669AD18DB3B10003B718C63B052A3F034E2ED2F534A6FDEB1D3514515A9B8574162FBECE2271D31C7B715CFD6DE96E5AD3071F2B103F9FF5A68D29EE5EA28A299B095E53F1C356165A2E9966D1161713BB970DF776A6DC631CE7CCFD2BD5ABE7AF8DD7DF6BF17DA5AC7705A3B481449136EDA92312D903A64A94E47B7A567536B18D67EEDBB9E75E75BAFF00ABB890A13820FBF4C8FAD4E67B76B70CA3ECAD190A4A296DF9EA7D072A7F3AA4BE4EF2A870C060AB743DF834B164C996F940CE4E38F53FE3F856671B4753E1CBD874EF146977D1DD18E14B84796452C76A6417031CE0AEEC8EE38AFA957EE8AF8E16F679D19D1C0190CA846338246D18EDD7F3AFAD746BF7BDF0F58EA1384579EDA399C203B41650C71D4E39AAA7BB36C368DA652BD70F792919EB8E7DB8A8154BBAAA8CB31C0143317766639663926A7B18FCCBC418380771C76C7FF5EB42F7647711F9370E98C00C7033DBB7E951D5CD5102DDE467E6504FF2FE954E8092B30A7C4FE5CA8F8CED6071EB8A651408EA474A4A82D24F36D626C9276E093D491C1A9EA8E942D145140C28A28A0028A28A002BCDF40D35E2F10DB3C7A4DF5B5FAEB7A8CD7775342C165B267B9D81643C79664689845904B0F33660EF3E9154E3D5B4D9B549B4B8B50B47D4214DF2DA2CCA6545E3964CE40F997923B8F5A00B9451450073771FF1F537FBEDFCEA2A96E3FE3EA6FF007DBF9D4552733DC2B4349936CEE991865CF3D723FF00D66B3EA5B793C9B88DF3801B938EDDFF004A071766725F1B2EE08BC35616AEC3CD96EC3A4641F995518373FF00021F9D786B4B01876A29DE80FCA7F89BB904FF009F4AF5FF008F0CAB0E8458E39B800FA711D78BC1019C932B21873977CF7EB8AC5FC4FF00AE86157E36749E1BB7B793C4FA2433
)
ImageData2 =
(join
C4AD1CD7910689C0656F9C0208E9D3AFFF005EBEA715F2AF87E68EDBC63A2BCCF12225DC52190BF089BC1249E9D0724F615F550ABA7D4D30DD7E42D14515A9D6145145001451450062EAFF00F1F69FEE0FE66BE7BF89364D69E309218E128B7389A1E410777DE6F5FBFBB39FC2BE89D63AC3FF0002FE95E43F15E08219748BE5555BB759A11231382176151E83EF373FFD6ACAA7738F10BA943E1CB4ADE3DD256598CAF1F9A849E0FF00A97EDFE7AFE7F40D7CF1F0C5B678FB4D87CD6762D2BBFCF95CF92FD2BE87A2975F5FD11584F85FAFE885A28A2B53A828A28A00435F31EB9A5417DE37D659AE1722FA72F1E3903CC3FD2BE9C35F2B789EE644F1BEBC918008BE979638046F6E38ACAA7439711D3E657D4F4ED222B9447B928307F751919F6EBF8D312486D249FEC2DB18C412338CEDC919E0F24F1DEAADCDBACA5AE65B88503825C30CFCDF4E959E5E1886C4CB2F1866195E7AB7AE4541CCB63E95F0FF00FC8B7A5FFD79C5FF00A00AECED7FE3D61FF707F2AE33C3FF00F22DE97FF5E717FE802BB3B5FF008F587FDC1FCAB5A7F0A3AE87C2BD09E8A28AB3A04AC7F12E9C753F0D6A564902CF24D6D22C71B8182F83B7AF00EEC107B1E6B6290F4349ABAB132574D33E542F70F1A1FB4798F16D04950720723E53DBFCFD597934973A81695880E06368E547AFEBD3DBF0A76AF0C7A45FDFE9CD33CAB6F74F1B31380DB58AE42F3DB2719A86501A250ABB4202141538C01C719CE7B573A77573CA4DF5229EF0298FEC618230DC1CE577F3DC67DBF4AEFBE13DD2C77DA9583A49E73C51CBBC8F94ED241C64FF00B6381C715E6D71309CA988C68E1F67981428E78036FE24E7F3AEC3E1ECD38F18D86646412248A5039F997631E47A6E19FAFE146CD32D68D33DAE8A28ADCEA0AD9D27FE3D5FFDF3FC856356CE93FF001EAFFEF9FE429A2E9EE68514514CDC46E86BE56F1CDFBEA7E2AD52F56E16E36DCC8B1BC646D31A9DAA72BD7E50067E87D6BE9BD5EF7FB3746BDBEF2FCC36D04936CCE376D52719ED9C57C8CD2C81DC08B729CB1209E01FFEB6783C7E758D4DD239712F54812C2592C9A60B1B431ED7241FBC0939C77F4A8A1711CBF3E640CD805800A3EB533CCE6D1521216352DD48F419CFAF35477EC2C581761F3103A638E7F9D49CEBC8D4436B6CACBE5387078DDD49F6AF7DF867A9C775F0DE25890ABDBC924126471B8BEEE39E9871F8835F3C2DFB4B1AACA632C46DF308E54E4F039EB8C76F4AF5EF84D35C5B69FA8699712288CBA5CC11F00E086576E8091C2FB0E3D684ED245C25CB33D12B47484CCB2BE7A2818FAFFF00AAB3AB674B8F6DAEFC0CB3139EF8E9FE35BA3A20B523D5D0948DF8C0247E7FFEAACAADDD453CCB37C0C95F9873D31D7F4CD6150C2A2D428A28A441B3A53EEB52A581DAC703D07F9CD5FAC8D21F12C898EAA0E7E9FF00EBAD7AA47441DD0B4514505051451400514514005707A4787755B7F12C22ECEA4F6969A9DE6A11132DB0B41E719B6EC014CECF89F043ED507790C4050DDE567E9BADE9DAC4B771D85C79ED692B413908C04722B32B212463702A723AE0A9E8CA4806851451401CF5EA04BC940CF5CF3EFCD57AB9AA205BBC8CFCCA09FE5FD2A9D49CF2DC28A28A093CAFE2A6750F11E9F693B9304767B82B39DAA77B0242FA90147E0335E753A5B2CCA34FB7242B85DA412C7A9E9CE475FF00F5D775F15148F1658CC595238ECC16729BB1F3B63E9D3FCF51E7B6AEB0DCB5C6E48990EE8F3920639FE9F99AC3B983DD975C4A26B55585A25F2F277821BB03FE7A726BEBB1C8AF8E2E08678A48C8C633903A1E98FC8038F7AFA7BE1EEAB1EADE06D2A78C2868A1581D03862AC836F3E84801B1FED0FAD5C3466B877EF35DFF0043ABA28A2B63B028A28A0028A28A00CDD5D018637E721B1F98FF00EB5703F126D24BAF018654468A1BE492667E8A854AE71D4FCCCA303D7D335E81ABFF00C7AA7FBE3F91AE57C6104F71F0E75716CBBE54C4B8C81C2323B1E78E0293F85673F859CF555D4BD0F2EF86400F88B60AB9091B4C83200E9138CFE87F4AFA2ABE74F85ECC7E2069A180DD893963F37FAA9383FAF6AFA2E952EBEBFA2270BF0BF5FD10B451456A750514514009D8D7CB5E2BF2478BF5B6690B482F27FDD2801B6F98DC83DF1D71FE47D4BD8D7CABE2D9157C71AC2BDBACAA2FA73839C9F9CF00F6EDD2B2A9BA39711D0E659595CA3B02090C8792181EB91EB52623527707CF1820601CFD7B54B3A8864729336D9149076F207F8D40D7D3860AC15988015F19651F5F4E0D41CFB9F4AF87FF00E45BD2FF00EBCE2FFD0057676BFF001EB0FF00B83F95719E1FFF00916F4BFF00AF38BFF4015D9DAFFC7AC3FEE0FE55AD3F851D543E15E84F4514559D0145145007CD7F122DE0B3F1CEAD122848DE4462A493977456247B9624FA76E95CAB5D3E0462DC398F09E5489EFCF3F5C1CFBD76BF13E175F1F6A4D24610482178E4910FCC04617E5EC464373EA0D72368C820D8F74CE39248039503DFD00CFE3CE3AD731E5CAC9BF57F98C8ADE35918A2657215418F395C763F4CF4F4AB5E1A8C0F17E97B989617B1B0DC08246E03E9E9C553BB964B6DA832FBD4A8DFF294CE320670318E3344370D69A8C32C13C6B736F22C91819DC1830E4EEF94F7E99A4FE164F467D2745145741D815B3A4FFC7ABFFBE7F90AC6AD9D27FE3D5FFDF3FC85345D3DCD0A28A299B9C37C53D40D8F81AED55E6496E99604688E31FC4D9F62AAC3BE738E84D7CEA97077C103C51B346E724704A9E7071D6BDAFE32EA66DE0D3ED0481942CB3C90AED2C0801518E79C7320F43CFA71E1323CAB71954DA18FCB85C9AC24FDE670D5779BF23A9D5BC392DAFC38D23527862F2E6BC9C34A98DE01DAA88DDFAC721E3207E35C7E58904AEC07D7827DABE82F15680A3E0B5BC6B6D70B3D94315D984292DE61E64DC08240F9DC91C631D80AF0B8AD8DC3F9CA85A3660C410582AF7E9C8FC3D2A52B1125C9A7A32C2DBA79366428F20C7B9E239E1B2DC83D4FD7D702BB1F86772D6DE28863DAD30BB8648CCA70BB70038E3FE00476AE46E6398B456A481E5FC9B7230DCF03E839FF0022AE697729A7EB3A75DC916D82DEE11D822A82D86EA39E4E063AF6F7CD12D15CCDCBA9F43D7436A9E5DB46BB769DA320FAF7AC1850493C687386600E3EB5D357423D0A6BA91C88248D90F46041C57355D4D73B76852EE6071F789E3DF9A18545D4828A28A46459B07F2EF23CB100FCA7DF3D3F5C56FD7331B98E45718CA90466BA7A68DA9BD028A28A66814514500145145001597A069B3695A74B6F3B46CEF7B77700A1246D96E2495472073B5C03EF9EBD6B52B0FC29AD5DEBDA4CD7779612594897B736E23729CAC733A03F2BB0C80BB4F3F79588F9704806E5145140197ABA1291BF18048FCFFF00D55955B9A9A86B262472A411F9E3FAD61D26615370A28A2910795FC6144825D26E9032CD27991390C70CAB82011D3AB1E7DEBCADFE68D1C47B3710095C7033FAF27BD7AD7C668273A5E9974880C514AE8EC79C160368C673FC27F2AF26473710E648963380384E7AF6F4E6B1FB4CC2DEF32DA2C12B8900578D49DA8704F7C67DF8AF5FF82DE23B656BCD00AA4659BED1076DCDB4075E4F27001000E81BD2BC5A202372880866F994B9C60F6C9FCEB4F45BCBAD0B55B5D4EC9D7CEB6657F95C90D83C838C12A47047A1346DA8E2DC65CC7D774B59DA46A56DAC6996FA85A36E82E230EBC82467A83824641C823B106B42B74EE77A69ABA168A28A630A28A280219A08E740B22EE50738E9599AE69ED3786F53B3B28F324F6B2A226EEAEC84019278ED5B14847CA6935756264934D1F39FC2E551F1134DF9BE75330C63A8F29F07F4AFA36BE74F86813FE165696CA72DB250DFF7E9FF00CFE15F45D6549DD37FD6C8E6C23BC5BF3FD10B451456C758514514008DF74D7C9BE3500F8D75B6559322FE60CCADD3E73FE35F5937DD35F2978C6066F1A6B8EA481F6D9B383C8FDE356553A1CD88E8635A4823858B7EF1D72A99CF3904F23FC6A3BA28CC42DB989770C282718EB8F7E09EF4E24A4ACC89BF0781CE48EBDBE952A1962BF0E584C84161133705BA60EE39C9FEB5073799F45787FF00E45BD2FF00EBCE2FFD0057676BFF001EB0FF00B83F95719E1FFF00916F4BFF00AF38BFF4015D9DAFFC7AC3FEE0FE55AD3F851D543E15E84F4514559D0145145007837C6A3B3C5568FBF0C2C9001EBFBC7E6B84B49618523B831A3309318E48638C74FA9FCBA738AEF7E332AB78C2D4B3018D3C704F0DF3C991F9570622861B42B116D84166C1DDC119E3DF800763BB15CEFA9E6CFE27EA509676BC95CB3859140038CE0004633F80FC7350A2E6EA36321DCAE43281C75A92EDE442C542C71B9C118E109EA3F5EBEB5026EFB4C63702DB867E99FF00F5D4CBE164B5A33EA2A28A2BA0EA0ADBD3136D9839CEF627E9DBFA5625741629B2CE2071D33C7BF34D1A53DCB3451487A1A66C7CF1F15F51926F88CD14A89E5DAC51C4B838DCAC031072704E5D87D315CC69BA5C575E2AB0D3E4138B6BABD48B39F994161900F4C8C9A35ED421BFD7350D420B52F1DCCF2BA87DA1D559CB67A919EDED8AEB7E15DAC979E3AB39E376315BDBBCD26F046E25361DBEBCBAFEBE95CDBFCFF53CCF8A5EAFF33DCF56B1FED2D1AF6C7CCF2CDCC1243BF19DBB948CE3BE335F2B6953DDC4D2AC4E55620DE6145C64678C63B9C0AFAD9BA1AF993C5517F6278C353B416B1C07ED2EF1A201808CDB97007006C238ED9F5ABA9BA66F895B33291E5366F29590B6F0CCDB4F727AF61D6A18E58E42628F0122049C6383EB9F4FA7A558BC8A586DA278656304CA1C88DF8663D41F5C7A7BD53636D0DA4BE5AAA166DF8E7031D471C8EB8E6A4E5B1F47F846E9B52D3B4EBC3324AEF6CAF23A9182DB70DD38CEE278AEB3BD79E7C20B8171E0D50B1855B791A153BB3BBF8FF0FBE07E15E87DAB5A6EF147A1435A698B589AAC7B6E55C0C075EB9EA47FF5B15B559BABA030C6FCE4363F31FF00D6AB65CD6864D1451526015D0593EFB388E3185C7E5C7F4AE7EB63497DD6CC9BB255BA7A03FE4D34694DEA68D14514CD828A28A0028A28A002B2F42D2A6D1ED6EADE5B98E7492F6E2EA22B11428B2CAD2EC6F98EE219D86E18C8C71DCEA5140051451400C740E85586411822B9B910C72321C65490715D3D62EAB1ECB859063E71CFD47F914999D45A5CA145145231392F8936715DF82EE5E4DC4DBC892A007009DDB707DB0C6BC11E39E29C7EEDC866C0E32083FF00D635F4EEA96AF7BA45EDA4454493C0F1A96E80B29033EDCD7CBD76D2472984862A1B2A72726B296923292F78B1308A295494C3E771E31820F4FA55AB41396F2E6C9DD83F781201E71F4AA112B5D1248398B6E791D33D6B4228D778E360518DFDC8ED48996C7A97C25F171B1BCFF847AF6591A09DCFD959D86D85F93B79E7E6EC3D4703E626BDBF35F1E2CF736C65411A9620E0927F223BF5E3D335F41FC32F1AB789B4936378BB352B28D15C993779E98C09064E49E9BBDC8E79C0A84ADA1B61EA5BDC7F23D068A28AD8EB0A28A2800A0F43451401E45A1F8335FB3F8B336B53D82A69CF73732097CE424AB070A76EECF3B876EFCD7AE51454C60A2AC8CE10504D2168A28AA340A28A28010FDDAF963C4DE6378E75D8CE4A1BE980E4640DE7F4AFA9CFDDAF963C56BBBC6FAD330D845ECE37FB6F6C56553A1CB89D91951471AB22952C4B107231F419ED923158C1C866567273D76E719C75FE75A226B8B7F363F2D199948049383D7823BF5FC33554AB22AEF015530463AB771ED50732D8FA57C3FF00F22DE97FF5E717FE802BB3B5FF008F587FDC1FCAB8CF0FFF00C8B7A5FF00D79C5FFA00AECED7FE3D61FF00707F2AD69FC28EBA1F0AF427A28A2ACE80A28A2803C03E37153E2FB38D8F0D62BDBAFCEDF9579E3ECB348A2D84CA14FCC304303C9EBE99FF000AECBE27425FE266A4E776C5111C2AE724449C7EA2B8EBC50D22E4630380CA3A75FEB5CDDFE679937EF3F5645E608596E1CA962C4A465095E71EBC74FD6B434082293C59A3453408565BA8C3A300CADF37208E954E511CD1A2333285C65327E6CE7BD741E14B45D43C5BA32DBB22BC3207903F7DA4B923DF008FCA896C26F4B1EF3451456E750574912797122673B540CFAE2B9FB74F32E6342A58161903D3BD749DA9A35A682B0FC57AAFF62785B53D43CE30BC36EE639366EDB21184E3073F311DB1EB5B95E79F193507B1F01BA2052B73711C2D9192072FC7BE5075F7A99BB458EA3B41B478233C0D031F386361192A3AF7FE66BD7BE07D938B3D4EFE48D1A32D1C104DD48C02CEA3B81CA13D01E3D2BC522684C45A7C818D808E704F427F5F5FA57D27F0AF4D3A7F816D19D6412DD335C481C6393F282A303E52AAA47AE7359457BC91CB4A3EFA5D8EE2BC07E2FE92B178B85CE26097B023B395CAEE5F94AA9C7F75509EFCFA115EFD5E59F1A6C3CCD1F4DBFF0038AF933BC3B00EBE62E739CF6F2FA7BFB569536B9BE217B97EC791E9F0C8D633A3ED11ABEE036E3E63C023D38F4E2AB931C32B49147B140F2D893BB71E99AB96FA94F6D0490A22B33904306C37B727DB1515F069A2081CA9C8DC5C16DB9F7FE23F4FD2B33CFBEA7A5FC10D41526D674C6BADEFFBB9A38867680321D80E80F283DF8F4AF65C735F3AFC249E5B0F1FC31C4B98AF6292290C8A7230BBF820E3AA2FAF04FE1F449EB5A53DAC77E1DDE16EC2D57BE4DF692818E99E7DB9AB1DA9AE81D0AB0C823045686EF54733452B29476561865382292A4E60AD0D21C89E44E30573F91FFEBD67D58B2709791139EB8E3DF8A0A8BB33A1A28A2A8E80A28A2800A28A2800A28AE7DEFF00ED1E32D13ECB77E6D8DCE957938F2A4DD1CB892D763F1C370ED83E8C71D6803A0A28A28012AADFC266B660B9DCBF301EB56E8A04D5D58E5A8AB37F6FE45C1C0C23FCCBFE155AA4E76ACEC15F3E7C41D31B4EF144B6891F950063344CB1EC52AE73B40F4049191E95F41D7997C5AD2659C6997F6D180E19A09652DC018DCA31FF007D9E3D39ED59D45B332A9D19E4B1C2F6ABB670226C7041E5875C9ABC88258964898303DBA9AAF30B7DF247F34F2F6238507DBD6974F8B12EE6711E3904BE39FC2A4CD932C9857F3F70DBD5C64807B60FA71EBFE20B1D52FF004CD42D350D3A76B7BAB793702840C647DDC72318E083EF91575DADEE588802C7E628123F51918391E9546EED6112960F2856C142464F19E9EBC9A094CFA87C25E2DB0F1769097B665A3954013DBB9F9E26F43EA0F383DFEA081D157CB1E16F145C78375586F6145756CC5221076C91E412A1BB1FBA73EA3B8C83F48E83AF58F8934B8B51D3A5F3207E083C32377561D88FFEB8C820D69095F4676D2ABCDA3DCD7A28A2B4370A28A2800A28A2800A28A2800A28A28010F435F2CF8BA22DE30D6994827EDD3F1D4FDF35F531E86BE55F13463FE13FD79CC82302FA6218B63F88D6553A1CB89D918EB2615FCFDC36F5719201ED83E9C7AFF88A53EEB88E3DB80558E57D32338ADA76B7B962200B1F98A048FD46460E47A551BBB5844A583CA15B0509193C67A7AF26A0E54CFA2BC3FF00F22DE97FF5E717FE802BB3B5FF008F587FDC1FCAB8CF0FFF00C8B7A5FF00D79C5FFA00AECED7FE3D61FF00707F2AD69FC28ECA1F0AF427A28A2ACE80A4ED4551D5EFFF00B3348BDBEF2F79B68249B6671BB6A938CF6CE2937657626D2573E6EF18B5CDF78B358064672B7D2AE59CE70AD81C9EC0600C71C7B567DE5AE6D2D5DF6AAB29248C654827AFA8359D384761E548A55C8041E08E7278AB91CD298504E88B0A8CC591D39EFDF1D6B9E3B1E53BBDCAA92C50802521493B81209FCBDBEB5D4FC30B2177E35FB52B945B5824900DBF7F3853F4FBC0FE15CACD6B1CD11712346FBC8055B2A78CF5AF4AF847A579105FEA0E15F76D8A39558FA6E75C7FDF1CFE5DE8DDA45475691E9B451456E751774B8F7DD6FC1C22939ED9E9FE35B959DA547B6DD9C8C166EB9EA07FF5F35A3548DE0AC84AF0DF8F77493DE68DA7A29F3A1592624E3690FF002803DF287F4AF71AF9A3E285CC7A8F8EF507FB4CCF1C65218C10D8428B860A0F6DFBB3DBA9EF59D4DAC675E568A5DCE1E35919910C7B524DABC0E0FB9F5E6BEC2D22C7FB3347B2B0F33CC36D0470EFC6376D50338ED9C57CDBE07D33FB4BC59A4E9ED142EA67123798094644F9D97BE72BC60D7D3E2A69AD5B230EAEDB16B90F89160D7DE07D4045024B2C2AB3A6EC0D9B5816604F4213774E7191DEBAFAA1AC5BC579A3DE5ACCCCB1CF0BC4C57A80C0AF1EFCD692578B46F523CD068F972720109FBB49446BBB19E7EBD334B1248DB4F93D55892C72BD3B0FCBDF9E2AA3796F2BA82A831D01F9B238E3F2AB16F3496E48798B1FBFF73193D33D7AD609DD5CF315AD745ED1EE069DAFD95D3ABB5BDA5EA4D22A8C3B2AB06C804F3C76E2BEA553F2D7C8570EAF30922954EF6C907A839C9E2BEA3F0AEA6359F0BE9B7E66333CD02F99215DB9900C3F181FC41BA71E9C55D37A9D5857AB4CDCA28A2B63B0E7AF5025E4A067AE79F7E6ABD686AE844F1BF182B8FC8FFF005EB3EA4E792B30A55628EACA70CA720D25141274C8E1D0329C82320D3AABD8BEFB4889C74C71EDC558AA3A56A85A28A281851451400565E9BE1ED3349B869ECE0915CA18D03CF248B0A1209489598889385F95028F9578F946352B838BC4B78BE37D3ED16EEEE7B4D42F6EAD54491DBC76FB61494B794A1BED05D1E354667CA1258800326003BCA28A2800A28A28029DFDBF9F6E7032EBF32FF8561575158BA95B7952F9AA3E473CF3D1A9332A91EA51ACCD7F495D6B46B8B3F944A46E85D80F95C743D0F1D8F1D091DEB4E8A96AEACCC5ABAB33E5FBF81AD66F29ADD6168B2922104156CF23079FCEA280065C2E481F8007FCE2BD1FE25F86960D613518814B7BDC07DABC2CA3AF418CB0E7924921ABCF96D1D6EA585CE0E76ED53C8358AECCC1767D0D6D355469D7619537CC0471E73D3183FAD66B5CE155B9C28DB19E70B83E9F5AB122016F0DA005D829CB27541BB3CFA723AD661B69A19090BB50B614EEC8FA034C4922C4325C2846F2926D80FCA476E3BFE7EF5DA781BC5F27847519653E5CD6570E05C42186FDBFC25093D57278EF9393D08E122BB7B676658B0C921C9719C7038F5A432CB725434992AD9E718340ED67747D83A76A36BAA5945796732CF6F32EE475E847F43D410790783577B57CEFF0DFE202785EE7FB2AF416D3AE642ECCAB9685B006FE39238191D78C8F43F414334771024D0BAC91BA86474390C0F20823A8AD612BFA9DB4AA73AF327A28A2ACD428A28A0028A28A0028A28A00435F2878B86EF1BEB8064E2FA6EF800EF6FF00EB57D5E6BE50F15C265F1D6BCBBB86BE946D079CEF3CD6553A1CB88E8374D551A75D8654DF3011C79CF4C60FEB59AD738556E70A36C679C2E0FA7D6AC48805BC36801760A72C9D506ECF3E9C8EB5986DA6864242ED42D853BB23E80D41CC923E95F0FF00FC8B7A5FFD79C5FF00A00AECED7FE3D61FF707F2AE33C3FF00F22DE97FF5E717FE802BB3B5FF008F587FDC1FCAB5A7F0A3AE87C2BD09E8A28AB3A04C5707F157567B0F08BDA5BB62EAFE41020126D60BF798E3F88600523A7CFCFA1EF3B57CEBF14BC4FF00DA5E39FB3C45DAD74E5F20F24A97C9DE40206D39F97DF6839C62B3A8F4B7731AF2B42DDCE1CC7731B156511CC8704300327E94E918A5B6E0EA436738C7C87FCFF3AB9AB4D05ED8457F141215076975E40FAD6747240A4852082A7F784719C7A7E5599C45E699E08879470A2205576637678E83815EDDE09D3869DE15B3042F9970BF6872A4904B723AF4F9768FC3F1AF20D0AD0EBB7D6F616C0EF9E4DBE6B8CEC40724804F3800F7E707BD7BF471A431245122A46802AAA8C0503A003B0A705797A154D5E571D4AAA5DD5546598E00A4AD0D2A12D334A47CA8300FB9FF00EB7F3AD4E84AEEC6B451AC512C6A3E551814FA28AA3A46370335F24EABAACB7FA9DD6A1328124D33C985CED562E49C03CE324D7D2DE38BC8EC7C17ABCD22B306B768405009CC9F20EBDB2C33ED5F299B69A17242ED42D853BB23E80D6353738F10EF248F4EF82D63F6AF144B77711171676CFE54A010B1B310064F4C952FC1F427B71F40638AF28F81DA7C71787351BE1E609A7BAF2DD18F00228231DF3F39EFE95EAF554D69736A0AD0B8550D524DB6BB3232EC060F5F5FF0ABFDEB23577CCB1AE3A2939FAFFF00AAB466937647CF3E31B3B7B2F176A513CCE5DA533640C0F9807FD3763F0CF7AC258D9A38D6D8A3A927649B725B3EDDABB1F8BB6BF67D6ACEF05B80278762C8BB726452724F73852BFE4579FD9DCBC73A3B2FCBD480BD3FCF35CCB4D0F3546CD9398EE6362ACA23990E0860064FD2BE81F83F7B25DF81D62711816B712429B3B8E1F9F7CB9FC315E19AB4D05ED8457F141215076975E40FAD7A3FC0CBDB74BFD5EC232E649628E60E00DB84254FE3F3AF6EC69AD2499AD276A88F6EA28A2BA0EF33F558F75BAB8192ADD73D01FF00EBE2B1ABA0BC40F692839FBA4F1EDCD73F4998D45A85145148CCD6D21C18644E721B3F98FF00EB569563692FB6E5D320065E9EA47F935B5548DE0F40A28A282C28A28A002A98D274D5BF7BF5D3ED05E3BABBDC0857CC665428A4B63248566507B0623A1AB95C9F85EED6E357D445C6A376FAA2DC5D2DC59B3B324512CECB6EC508221262DA571B7CC059887C6E001D65145140051451400531D164428EA194F5069F4500739736CF6B2ED6E41FBADD8D435D0DD5BADCC25481B87DD3E86B01D1A3728EA55875069184E36652D4F4E8356D3A6B1B9DE22946098D8AB29072083D88201FC2BC1754D0E4D0B5192D751322DC282CAE4E438CF054F70467B718C71D2BE85AE67C67E1AFEDED2647B5451A944BFB97271BB073B5BD475C67BF7009ACE71EA8C2A46FAA3C6626B73279A0120027682D960067238EB8EA31F435526568D85A4423DE5177B124B06E3900FE3D79FC3151C9F6C8AFDE0BE1E5C818AB2B46AA32339F971D73C73D29FA55D22CA04AB84C1E7683827FCF7A8314892E2DE3B86695196294AE0206EA791DFE959CF6D242EEA50161F2F0A783FD6B69582CB1411ED91165F324490852077E4F1DF3FE154EE659E57586155624F2C9C724F51C03DBBF1CD03526674324A926D4FE23839039E0FE5DABD7BE177C424D3618741D55D52CC13F67B8202F93939DAFFEC924FCDDBBF1CAF9A258EE0B1CCC54A91F30
)
ImageData3 =
(join
03F13915D35B5BD85A42C55A2995070A08638C51E686A6E2EE8FA5E8AF35F873E3A6D5E51A2EA12335D4685A09E461BA655E0AB7AB0E4E4750093C8C9F4AADA2F991DF09A9ABA168A28AA2C28A28A0028A28A0043DEBE5CF14A5B7FC263AE3BBB2C82F27208C0C7EF0F1F88FE55F519EF5F2D78BA578BC53AFF94C01FB74CCDB8E7FE5A1E83F0ACAA7439711D3E65089ADCC9E68048009DA0B658019C8E3AE3A8C7D0D54995A36169108F7945DEC492C1B8E403F8F5E7F0C540B34EF703ED0EB87CE0EC5DADD4E768153695748B2812AE13079DA0E09FF003DEA0E548FA1FC3FFF0022DE97FF005E717FE802BB3B5FF8F687FDC5FE55E4BE18F1DE8CDA75A69B77235A5CDBC51C244832AD818C861D06002738C67BF5AED6C75286E50CD61791CA81B05A19032E473838E3BF4F7ABA725648E8A3522924757456445AB38C09630C38E5783FE7F2AA1ACF8D34AD0E12D72D234B8C8823DA6461CF382471C1E4F1C63AE0568E496A74BA914AED9178EBC4C9E19F0ECD3472A8BF9418ED109E59CF1BB183C2E771C8C7007715F345B5B872659A10F82099036327AF007F335D2F8B7C46FE27D4CDFDDC58600A47129C6C8C670B9FE2E4B1CF5249E830061C7A9A43B645DAA36E079631BB39E48FD3158B7777386751CE4CDBB382DD34D78A4DF1C00EFF002CBE7009E9D7278F6AC8BC863B059151233E629D81867681C9EE7B67DFAF7C52C57923CD1A637296CED049C8C00463E83F2F7AD7874BBBD6EE53497CF9F211E46FC2EDEED93E80027BF3C63A526EC649D8EB7E18E84E04DAD5DA02D8F26DC951D3AB374F524641FEF0AF48AADA75841A5E9D6F636A8161810228C019C7738C0C9EA7DCD59AD20AC8EA847950AAA5DD5546598E00AE86D6016F02A0C647DE3EA6A96996BB479EE0827850476F5AD4AB4744236D428A28A66879DFC5BBFF00B2F8621B61301F68B85DF10237491A29738E09C06099C73D06466BC0E6568D85A4423DE5177B124B06E3900FE3D79FC315E9BF1B35091BC41A569ADE58892D9A6562B925998820F6C7EEC638F5AF36D0C4B7B7D0D9C30EF9AE1BCB8970A3E76381CF18C9EE6B9E4F56CF3EABBCD9F49F802CDECBC0FA5C726CDCD119BE4CE312317039EF8619F7AEA2A18618EDE048618D638D142A228C050380001D054D5BC74491DD08F2C52EC2D73F7F27997921C9C03B467B63FF00AF5BCC428249000E4935CCB317766639663926864D47A58F3BF8BBA7ADCE816572A5BCE8AE7CB41918C3A9C93C76DA3A7BD793DA5AA91BE483785C664DDD71E807F335F4078BEC5F50F08EA50C7B72B1195B71206D421CF4F65207B915E131EA690ED9176A8DB81E58C6ECE7923F4C560F49338A775268DBB382DD34D78A4DF1C00EFF002CBE7009E9D7278F6AD7F87D771F87FC79629E72C305E96B72A1376770F9578CE32E139E3A73C572515E48F34698DCA5B3B41272300118FA0FCBDEB5E0BCBAB0BC86E2401A7B4952E2D965518CAB03B4E08C8C03D0F5E3D293D15CCE32E577EC7D3D4520E8296BA4F542B98910C72321C65490715D35606A11F9778F8180DF30E7AE7AFEB9A4CCEA2D0AD451452312C59BF977911C672D8FCF8FEB5D057300952082411C822BA5470E8194E4119069A36A6FA0FA28A299A051451400557B3BEB7D42069AD64F3235964849DA461E3768DC73E8CAC3DF1C71562B83F0CE9FA95AEB825D4E0925B392F7526B15F2197EC521BA95B7B7277196376DB210A155768E653B803BCA28A2800A28A2800A28A28012A9DFDA7DA103263CC5E9EE3D2AED1409ABAB1CB90549041047041A4AD5D46C836E9A30011CB8F5F7ACAA93092B33CE7E24F8385EDB4FAED9161748A3CF4033B9471B87A6075ED8E78C73E4125A98B0495C1DB90307FF00D638F7AFA96BC73C7FE11BBD22F5F54D1E1C58CCE0B45003FBA90F1823A6D24E73D074C0EF94959DCE79C6DAA38E8941B6B7288A6466C1057B648073F98FFEBE2AA47A918C133C8F2336738C11B48EC4F3D3B7F5E6B45BEDC6C2649001244766C2D927A123F03D474C0AC4F2DDD22909017713F327F9E7AD2262913F9D6EBFEAEE24284E083EFD323EB5399EDDADC328FB2B4642928A5B7E7A9F41CA9FCEA92F93BCAA1C30182ADD0F7E0D2C593265BE5033938E3D4FF8FE140346D5B911DF5BCB673B070DBD248C9DC8C3046C3D8FA1AFA17C03E308BC55A21DE255BFB4DB1DD075C6E6C70E303186C1381D0E47A13F33ADF5C4CA648A40B860CAA4639048C0C7A735BFE1FD7EFF00C35ABDADFC1264AC80490AB604C870593241E303BE79E4720509D9DCAA7274E47D534B59FA4EA56FAC69B6FA85AB6E82740EBC82467A83824641C823B106AFD742773BD34D5D0B45145030A28A28011BEE9AF93FC5CC23F1DEBD21E717B37E5BCFFF005EBEB06FBA6BE4BF1B1917C6FAE14DB837D3641EF876FF00135954E873623A19CF1974936215520157240DBEBD7B75EF55E4B5316092B83B72060FFF00AC71EF4D967FDC463632BE09049F53D3E94EB59EE06C4B71217639509CE4F6F6EBEBE950733468C4A0DB5B944532336082BDB24039FCC7FF005F155ADF5696D64599A794CC1F72BA1FBBC0C153D723EBC7D79AF43BBF00EA575A05A5DE9370B399ADE390DBCCDB58160A480DD08C927071803B9E6BCEEFF48D474E9214D42D26B673FBC09710952549E1BF139E6A6E9AD44ACD7BC684DE2AD4E689A36D77509627CA3ABCCD8208C608AA925D433421C936CF190A59416DF9FA9E3953F9D505F27795438603055BA1EFC1A58B264CB7CA067271C7A9FF001FC29A49072ABE86BC71C525C47E4B8757C9FEF60F5C2E7F1AA696826BC6CA48C8588018ED64FAFAD46B7B712A9923902E1832A918E4123031E9CD753A0F84F5DD6F6B4102241927CF981118241FBA7EF1E4638CF279C51716DA1950C12EFF002210D2B3B85444CE5CF4C60739F6AF63F05F85DF40B369EF183DF4E0060002225C93B41FA9C9ED903D325DE17F065AE8012EA6227D44C615E403E443CE760EBDF193CFD0122BAC8AD66988D919DA7F88F03F3AB8C7AB34A74DDEEC8AB42C6C37626947C9D554F7F73ED566DF4C8E3C34BFBC6F4EC3FC6B42B5B1D7187561451453350A0F4A2A09A58EDE079A691638D14B3BB9C2A81C9249E82803E68F88F74BA9F8E759961475559162F31F6821A3508DDFA12A7BFE149F0D74337BE3ED343799E5C2DF68730FF0EC04AEE38FBA5828FC700E4D731AC6A32DF5E4D753B17B8964791A5C01B896249E38C679C7BD7A8FC06B032EA1A9EA5E69022856111EDEBBDB76739EDE5E31EFED5CCB56BCCF3E2B9A4BCFFE1D9EEA3A514515D27A056BE7D9672918E98E7DF8AE7EB5F5770218D39C96CFE43FFAF5914998D47A972C2DE3B959D664492368F6323AE558375041EA38E9EF5F2EDCE93341ABDCD9DD44C258A668A44DC3F76CA79E47047D2BEAFD323DB685B032EC4E7BE3A7F8D7CEFF0010ADCE97E38D5218183879C4AAB2E33BE450ED8200C0058D65516A998565651673E15A15650FB9770C7CD807F2AD0B6898DA7992BA004E626CFCDD7278C8E012A739E08E86ABDAC33CF68AF340A9BDB68DBC6FEBCF3EF5AB3C91C1676DBD082AC24403AAF2718A939EC7BC7826E52EFC1DA5346ACA23B758082070D1FC8DD0F4CA9C7B57455E7DF09752FB6785EE20F3558DB5CB2A4591B91180619EFCB17E4FBFA57A156B0F851E85277820AC8D5D009227E72411F97FFAEB5AA8EA885AD3231F2B027F97F5AB65CD6862D14515273856EE9EFBECD324123E538ED8E9FA62B0AB5B487CC72263A3039FAFFF00AA9A2E9BD4D3A28A299B8514514005538F56D366D526D2E2D42D1F508537CB68B32995178E5933903E65E48EE3D6AE571F61A5EA56DE28558ECA78F4D8EEE7B922E1EDE5B6532090992DD8013ACCCD26583FC803CAA091B3201D851451400514514005145140051451400562EA166223E6C4A761FBC074535B469A4060410083C10682651BA398A6C91A4D13C52A2BC6E0AB2B0C8607A823B8ABB7D69F6793280F94DD0FA1F4AA95260D5B46786F8BFC2B71E17767495DAC659774570DDB3FC0D8E8DFCC0FA81CADCBB4B109A3C650921533B403DCF7FF003F5AFA4F50B18353D3E7B2B95DD0CE851B8048CF719EE3A8F715E05E24F0EDFF00857516B59A1F36D9C334370B901D3BF7E081D41C8FCF9C5AE5F439A51E57E4632584B25934C1636863DAE483F7812738EFE95142E2397E7CC819B00B00147D6A679D8DAAC701508993C91DC0CE7D79AA3BF6162C0BB0F9881D31C73FCE80B1A886D6D9597CA70E0F1BBA93ED505C5D1BB9228403E6F4000F957FCF7A62DFB4B1AACA632C46DF308E54E4F039EB8C76F4AB7159BE9F209A46549655CC21BBFBF2303F1E280F53D97E11F881A36B8F0F5DDC6F7E66B72C71CFF1A0C9FF00810007F7C9AF5AAF95B4AD65B40D46DAF9259247B6B849A45498A87E81941E4E0AEE07D8F4AFA82CEEA1BDB282EE07DF0CD1AC91B608DCAC320E0F3D0D5D37F64E8C34EE9C5F42D514515A9D41451450021AF98F5CD2A0BEF1BEB2CD70B917D3978F1C81E61FE95F4E1AF95BC4F732278DF5E48C0045F4BCB1C0237B71C56553A1CB88E9F32BEA7A769115CA23DC94183FBA8C8CFB75FC69892436924FF616D8C620919C676E48CF079278EF556E6DD652D732DC4281C12E1867E6FA74ACF2F0C436265978C330CAF3D5BD722A0E65B1F4AF87FF00E45BD2FF00EBCE2FFD0057566D2DEFB4C4B7BA823B885D577472A0656C608C83C7500D729E1FFF00916F4BFF00AF38BFF4015D9DAFFC7AC3FEE0FE55A43E1475D1578AF439BBEF877E13D4A6125CE896DB95768F2B74431927A21033CF5EB507FC2ADF067FD0153FF0225FFE2ABB1A29F247B1A7B38765F718C3C27E1EFF00A01E99FF008091FF008569FD96DFFE78C7FF007C8A9A8AA492D914A315B21890C519CA468A7A65540A928A2994145145001451450025739E36B9369E0FD498AEE1245E475C63CC223CFE1BB38EF8ED5D1D79A7C66D47ECDE1AB3B48E7293DC5D06F2F2C03A203BB38EC095383DF07B544FE166755DA0CF19D4F4ED222B9447B928307F751919F6EBF8D7B87C26D2E1B1F091B9852345BB9D9D1941DC517E40189E7EF2B90327EF7B915E07716A27733BCF12F999DCAC3396F602BE9FF0769ABA5783F4AB3585E1D96C85E37CEE5761B9F39E41DC4F1DAB386B23970EAF2F437E8A28ADCEE313547DD7214313B54647A1FF0038AA352DD49E6DD4AFC6376011D081C0A6C28249E3439C330071F5A939DEACDEB54296D12EDDA768C83EBDEBC47E3969F3FF006EE9576A54A4F0985064E432316248F4C38FC8D7BAD79DFC5FB1926F09C5790C51B4B6972AC656DA0A2302A793D8B14C81EDE953517BB71D65FBBF43C619AE4A2833F9924254124039C73D0F6FC7FF00AF1DE4D25CEA05A56203818DA3951EBFAF4F6FC2ABBCC9040E924ACFF38693E7CAE7A71F866A494068942AED08085054E30071C6739ED599E7A3D23E0EEA0BFDBD7F676E83ECD35A898C8C086628F81DF81F3B67E83F1F6BF5AF99BE1F6A96F6DE3FD26678F76E99A0DD12AAFCCEA517E5E3BB649F4F5E2BE991D2AE975477E1DFBAD0B505CC7E6DB489804953819EFDBF5A9E8AD4E8396A29F3208E7910670AC40CFD6995272855ED29F6DC952C46E5381EA7FCE6A8D4F68E52EE1231F780E7DF8A0A8BB33A2A28A2A8E80A28A2800ACB87C43A65C6A874E8E790CFBDA35730482291D73B91252BB1DC6D6CAAB12363E47CAD8D4AE4ECFC3BA943AA59C729B4FECFB1D4EEB528A75958CB2B4FE7FEEDA3DA0205FB437CC1DB3E58F946EF9403ACA28A2800A28A2800A28A2800A28A2800A28A28018E8B2215750CA7A83581756ED6F31520ED3F74FA8AE86A29E159E1646039E87D0FAD04CA3739CACED7347835DD265B19F0A1F051F68628C3A1E7F23D32091919AD59A1786531C83047E47DEA3A96AEACCE76AFA33E67D77C3F79A0EA72D8EA0BB19798C8E56452782A7D3FC0D65E58904AEC07D7827DABE8BF17785A1F1469AB1EFF002EEE0CB5BC873B413D430F4381CF51DBD0F84DC6953DBEA13C33C477C529595397098386E57DF3D3D2B16ACECCC2578E8C55B74F26CC851E418F73C473C365B907A9FAFAE054B6F009635DE4C8ACA49924185038E0A8E4F7FC69B731CC5A2B5240F2FE4DB9186E781F41CFF914927991F96D120408DC6D0ABB8E7A8C753DBBF4E473C866DDC74A517CC4E046AFE500C319238E3DF23F2AF7BF84FAC9D4BC1AB6B2B1373612340E1E5DEFB7AA923A8183B47B2F1E83C1572EA43EC0E00219C65875EDF9F6AF41F833A98B5F114DA7BDE6F4BB84EC1B3EFBA60AF38E309BCFA73EB8A13B49334A52E59AFB8F79A28A2BA0F4428A28A004EC6BE5AF15F923C5FADB3485A41793FEE9400DB7CC6E41EF8EB8FF0023EA5EC6BE55F16C8ABE38D615EDD65517D39C1CE4FCE7807B76E95954DD1CB88E8732CACAE51D81048643C90C0F5C8F5A9311A93B83E78C10300E7EBDAA59D443239499B6C8A483B7903FC6A06BE9C30560ACC400AF8CB28FAFA706A0E7DCFA57C3FF00F22DE97FF5E717FE802BB3B5FF008F587FDC1FCAB8CF0FFF00C8B7A5FF00D79C5FFA00AECED7FE3D61FF00707F2AD69FC28EAA1F0AF427A28A2ACE80A28A2800A28A2800A28A2800A28A2801BDC5787FC65D4E29F5EB5D3BCC89C5ADB994C71B7EF0339E73F455420633CF71D3DC4F4AF983C7DA9ADFFC41D5647B35658E730EC2725BCB01320F18CED07F1C738ACAA3D91CF887EEA473161F678F55B71A8BCBF64F355DDA1E5DA3EAD8CF1BB1EBC7E15EF2BF1BBC32A30D6BAA0FAC283FF67AF059D443239499B6C8A483B7903FC6A06BE9C30560ACC400AF8CB28FAFA706A15D3D19CF1938BBC59F43C5F19BC3D344658ED75164032488E3CE3E9BF34C3F1AFC37BCC62D752320FE1F293F0FE3AF13B1962B7B09241BDCA29619C1C75C107B8F635912C9224FBC28453CA9C7F3A7CD2EE52AB53B9ED927C56D0226DAF06A0A7D0C4BFF00C553ED7E307872DEE2395A0D471CFF00CB15C9E3FDEF7AF0F6BA6DEE66F99C1C938E093DBF1AB115B1B87F3950B46CC18820B055EFD391F87A52BCBB91CF25ADCF7F1F197C3C515C59EA7B58641F2A3E47FDF7ED591E25F891E1FF00137866FB4F169A9059E2CA33246177021973F39E320678CE335E45731CC5A2B5240F2FE4DB9186E781F41CFF00914927991F96D120408DC6D0ABB8E7A8C753DBBF4E473C8DC9AB3639559C93571D2945F313811ABF94030C648E38F7C8FCA98D74F8118B70E63C2795227BF3CFD7073EF522E5D487D81C004338CB0EBDBF3ED4FB464106C7BA671C92401CA81EFE8067F1E71D6832D875897B0BE8EEECCEC9ADE547818C40E0AE08233F427D38AFAB61963B881268645923750C8EA72181E41047515F25DDCB25B6D4197DEA546FF94A6719033818C719AF7AF06EA17571E10D35DE42A522F2804638C21283BFA28A707691B61E7CB26BB9E8545737F69B8FF9EF2FFDF668FB4DC7FCF797FEFB35B5CEBF6889B53522F18F1F30047F2FE95529CF23C872EECC7A658E69B48C9BBBB851451408E96371246AE3386008CD3FB553D39F7D9A65892B9539EDFE462AED51D29DD05145140C2B9FB0F1759DFEA2B6AB677D123DDCF631DCCD1058E4B884C9BA35F9B71F962760D8D9818DC1F2A3A0AE7EDFC31F67FECDFF004CDDF62D56EF52FF00558DFE7FDA3E4EBC6DFB475E73B3A0CF001D051451400514514005145140086815CBF8E7C5E3C17A1C7A9B5935DABCEB0F96B26C23218E7383FDDFD6AEF8575FFF00849BC3769AB8B636C2E031F28B6E2B862BD703D3D2A7995F97A91CF172E5EA6E5145154585145140156F2D05CC40670EBF74F6AC16528ECAC30CA7045751597A9DAEE1E7A0248E1801DBD693339C6FA9955C4F8F74490DB1D6AC731CD02FFA4AC6A4B4A9C73C775C73FECF53C015DB53648D2689E29515E3705595864303D411DC544A375639E71E6563E784794D9BCA5642DBC3336D3DC9EBD875A85248E60D0A85D91839C007F33E9EDED5B1E28D1AE7C3FA94D62B249F6727CC8C2BE7CC42C705BD7A608C75CF6C561B1B686D25F2D550B36FC73818EA38E475C7359239511B32A46CC24F9C3606070467823DB835D57802F23B1F16E9172225777BAF2080C403E60284F7E9BB38F6C715CB8485B6B2BE311742783D78FCBF956958B9D35EDE7B2904724520991DB0C1587CCA79EF903DB9A1ED71DECEFD8FAB074A2907414B5D27AA14514500237DD35F26F8D403E35D6D9564C8BF98332B74F9CFF8D7D64DF74D7CA5E31819BC69AE3A9207DB66CE0F23F78D5954E873623A18D69208E162DFBC75CAA673CE413C8FF1A8EE8A3310B6E625DC30A09C63AE3DF827BD389292B3226FC1E073923AF6FA54A8658AFC396132105844CDC16E983B8E727FAD41CDE67D15E1FF00F916F4BFFAF38BFF004015D9DAFF00C7AC3FEE0FE55C6787FF00E45BD2FF00EBCE2FFD0057676BFF001EB0FF00B83F956B4FE147550F857A13D1451567405145140051451400514514005145140156F2EA1B2B29EEEE1F6430C6D248D8276AA8C9381CF415F216A131BBBC96E733C923BEE966321662C7924E79C9CD7D3DF10EF65B0F016B1342232E61F2BF799DB876087A7B31AF9785B1118DAC3EE80C51B3CE79AC67F11C7887EF25D97E64B681A3819CA348C32B19209CE41EA3EBEB51DC2191888ED1E350C0855CE31E9EFC1F5AFA4BE1769E9A7F80EC4F90F13CECF3BEF0416258856C1E80A85E9C639EF5DAE314A309495EE28506D295F7F23E3CB28E4B778731B951F7811C7A118F71525DC012E2448D657859C95E73B47F9CD7D7F8AC4D4DF75E918C6C503EBDFF00AD3F672EFF00804A8496BCDF87FC13E4E9ADA759BCC4576CE703CB3C0CF7AD5D2EE2F20040631050C5F0BB7233C01EA4E07E55F48514B925DFF021D393EBF81F3AA4CDF66663B8C85C372304E49EDD075A8C6D6061F2F6A203C60727EBDC7B0F4AFA3A8A3925DFF017B1977FC0F9A5F11231DF8915B0063A8CF07E9C1AB7692C30A47706346612631C90C718E9F53F974E715D6FC4EB08E2F134776232827B6059CE76C8C0952327BEDDBD3DBD6B9311430DA1588B6C20B360EEE08CF1EFC003B1DD8A95E665E4CA12CED792B9670B22800719C0008C67F01F8E6BD63E12DDA49A1DFD9FCDE6C37464738C0C38E31FF7C9FD2BC96EDE442C542C71B9C118E109EA3F5EBEB5DDFC25BD6875EBDB27B840B3C1BC4648CBBA918C773C16E3D39A7B34CD23A34CF60A28A2B63A028A28A0028A28A00D5D21C949138C020FE7FF00EAAD3AC3D2DC2DDE0E7E65207F3FE95B94D1BC1E82D14514CB0A28A2800A28A2802B497B0452147930C3A8DA6A70430041041E411583A8FF00C7F4BF87F215B56DFF001EB0FF00B8BFCA82232BB689A8A28A0B3CD3E368CF832D8601FF004F8F82719F91E9DF055E66F054B1CB23B88EF1D630CC582A95460067A0E49C7A9351FC70655F04DAB3AEE517F192BCF3F2BF1C550F8157B2BE93ABD8B2AF950CE93464FDE264539CF6C7C8318F7AC7FE5E1CD7FDF1EB9451456C7485145140053480C0820107820D3A8A00E72E60304ED19CE072A7D45435AFAA421E1128C6E4E0FB83FE7F9D645239E4ACCE17E25698B3D8DADF84C989CC4E421C80DF75891D002303DDFF003F2A26386569228F6281E5B12776E3D335EFFAED936A1A1DEDB226F95A226250DB7F78394E7FDE03DABC1EF733C202B95CE371704EDCFF00E847E9F90AC24AD2392A2B4FD4C8976091E1674393825475EF8F6EBDAA7CA59F91114FDE01CBF04329E4FE59FF000A48AD3171BC799E5FDEC14E491DBAE39E3F3A5BC50D22E4630380CA3A75FEB49ABAB12ECD58FADECEEA1BDB182EE07DF0CD1AC91B608DCAC320E0F3D0D59AC6F099FF008A4747FF00AF183FF45AD6CD74277499E9C5DE285A28A299421FBB5F2C789BCC6F1CEBB19C9437D301C8C81BCFE95F539FBB5F2C78AD7778DF5A661B08BD9C6FF6DED8ACAA7439713B232A28E356452A589620E463E833DB2462B18390CCACE4E7AEDCE338EBFCEB444D716FE6C7E5A333290092707AF0477EBF866AA956455DE02AA608C756EE3DAA0E65B1F4AF87FF00E45BD2FF00EBCE2FFD0057676BFF001EB0FF00B83F95719E1FFF00916F4BFF00AF38BFF4015D9DAFFC7AC3FEE0FE55AD3F851D743E15E84F4514559D014514500145145001451450014514500793FC73BF8A0F0DE9B64E1FCC9EEC4A84018C20C107DCEF1FAD78A5A79E4949B277007EF02403CE3E95E8DF1BAEDAF3C49656093A3C5690090C4BB498DDD8E49EFCAAA1C1FEB5CA78374D3A8F8C349B55B649544E864572A43C6A773641EA3686E3BE2B9E4F56D1C159DE4EDFD743E99D22C3FB3348B2B1F3379B6823877E31BB6A819C76CE2AF76A3B515BA565A1DC924AC85AE6667124F238CE198919FAD6FDCC9E55B48F900853838EFDBF5AE76866751F41D1A19245418CB10066BA6AC1D3937DE27CA085CB1CF6FF002715BD421D35A0B451453343C9FE395809F42D36F5A4C2C33B44536E776F5CE73DB1E5FEB5E2AFB2CD228B6132853F30C10C0F27AFA67FC2BE99F1FD9BDF781F558A3D995884A77E71B5183B0FAE14E3DEBE67BC50D22E4630380CA3A75FEB58495A4CE0AEAD37E645E608596E1CA962C4A465095E71EBC74FD6BA0F035E49A678FF00439238A30F34E2260DC8C49F231E0F5C138AC3944734688CCCA17194C9F9B39EF52CBF67710C8182792B871D493B89047F2353D0C94BB1F5E0A2A9E9D7B1EA3A65ADEC61962B9892540C30406008CFBF3573AD74AD4F4D3BABA118060410083C106B9A910C72321C65490715D3D73F7E9E5DE4985201F987BE7AFEB9A4C8A8B4B95A8A28A4624D6AFE5DCC4DB82FCC324FA77AE8EB96AE9227F32257C6372838F4CD346B4DF425A28A299A8572F25B3C1E34B24B3BEBE96E24F36E750135CB3C2B6D8658E311E7646C6429B08552CB04B962776EEA2B1ED7C31A6D96B13EA96E6F96EA795A6941D42E1A3772BB72632FB0E14003E5E02AE3181800D8A28A28030351FF008FE97F0FE42B52C1CBD945B8E4E08FC8E2B2F51FF8FE97F0FE42B474C7DD660631B188FAF7FEB48CA3F132F514514CD4F32F8DDB7FE10CB6DEE517EDF1E48FF71EB9BF829A8C9FDBFA869DE5A2C6D68B293DF2AF818F6F9CFE9E95D37C6D5DFE0CB75C139BD5E07FD7392BCCFE10EA135AF8EECD4C82282647B7919F18
)
ImageData4 =
(join
61B728992339DE17183EDDEB09693BF9A38E6ED56FE68FA5E8A28ADCEC0A28A2800A28A280192209236439C3020E2B9B910C72321C65490715D3D61EA8816F3233F32827F97F4A4CCEA2D2E52AF04D534E6D3B5BBBB34864D90C922A9988E547DD38C75236FD73915EF75E31E38B9687C6FA80F3080046C17048CF96BCFD6B2A9BA671D6E8CE626865937C517DD490F53B49F7E7D8FF009353DE5AE6D2D5DF6AAB29248C654827AFA8359F72525977472A9121E41E0839C9E2ADC52CAD1209A3510A8CC431D39EF9FC6A1BB2B983EE7D37E13FF914747FFAF183FF0045AD6CD53D3ACA3D3B4CB5B288B3456D1244A58E490A0019F7E2AE56F15648F562AD1498B4514551421E86BE59F17445BC61AD32904FDBA7E3A9FBE6BEA63D0D7CABE268C7FC27FAF39904605F4C4316C7F11ACAA7439713B231D64C2BF9FB86DEAE32403DB07D38F5FF00114A7DD711C7B700AB1CAFA646715B4ED6F72C440163F314091FA8C8C1C8F4AA3776B0894B07942B60A123278CF4F5E4D41CA99F45787FFE45BD2FFEBCE2FF00D0057676BFF1EB0FFB83F95719E1FF00F916F4BFFAF38BFF004015D9DAFF00C7AC3FEE0FE55AD3F851D943E15E84F4514559D01451450014514500145145001487A51D2A9EA57B1E9DA65D5ECA19A2B689E570A32485049C7BF143D3513765767CC9E3FBE92F7C7BACCF71E5C58B830A14EEB1FC809F7F96BA4F839650DE78CD6E7CC626DADA49630A463248420F1D30E4FD715E7571F6669664F9E69339523803FC6BDB7E0469E60F0FEA77E64C9B8B858BCBDBF7762E739EF9DFE9DBDEB9E2AED27FD753869A7292BFF5D4F5CA28A2BA0EF28EA8E56D3031F33007F9FF004AC4AD1D5DF32C498E8A4E7EBFFEAACEA4CC26F534F484E6590A9ECA0FF3FE95AB54F4C40B66A47F1124FF002FE957053358AB2168A28A0A2ADE5AC37B633DA4E9BE19A368E45C91B958608C8E7A1AF96F51B07862812E13C965DC2452BB5E3656208607F2F5E2BEAD35F3778E6DDEC3C6DAADBCB224B109CCE8C531B4C989307AE40DC466B2A8B54CE3C5C76672492C50802521493B81209FCBDBEB59F3957B8E32AA7386E393D6AFCD6B1CD11712346FBC8055B2A78CF5A8238223885A6123FCAD8897272C391CFA541CF13E95F867A836A7F0FF004B92599259634313EDC6536B10AA40E842EDF7E87BD760074AF28F8217529D2B55B260BE4C53A4D1B60EE3BC1539FF00BF63F5AF58CD6D0F851DF49DE085AC7D5D312C6F9EAA463E9FFEBAD7AA1AAA6EB50C141DAC327D07F9C5532E6B431A8A28A939C2B6F4D7F32C94724A12A73FE7D0D6256A690FFEB232C3B301FCFF00A5345D37A9AB451453370AF3BD32085354D1B5458A35D42EFC47A95ADCDD850259A14FB6EC8DDFAB22F9516149C0F2D31F7463D12B1EDFFE11BFF84A2EFECDFD95FF00090F943ED5E5797F6BF2F0B8DF8F9F6E3675E3EEFB5006C5145140181A97FC7F4BF87F21573487CC72A63A3039FAFF00FAAA9EA5FF001FD2FE1FC854FA43E259531D541CFD3FFD74BA98AF8CD8A28A299B1E65F1C14B7822DD57A9BE4FFD01EBC5BC3F7FFD89AADA4EC7CD314F1CDE483B4315656EBD067006715EDFF195637F0A592C8C154DFA727A0F91F19F6AF03BCB3937030C8B96395D8DC91D8FE9584D5DB470577EF9F610208145737E09D4E6D5BC19A65DDC071318BCB937BEF6664250B13DC92B9FC7BD749DEB68EA933B632E68A6BA8B4514532828A28A004EF599ABA92B1363E504827EBFFEAAD3EF5475442D69918F95813FCBFAD04CF6316BC97E2924AFE25B45880DC6D140CAE7F8DEBD6ABC6FE27EA117FC2676E884B1B7B655986D3F2924B0E7E8474AC6A7438EAEC8E24C7731B156511CC8704300327E952A92A9190CAC19B040C7C87D3F5FD6ACEAD3417B6115FC5048541DA5D7903EB577C0D07DABC6DA3C5691F9AC2E6394B1217E542198FE0A09FC2B37B3326AFA1F538E829681D28AEA3D30A28A28010D7CA1E2E1BBC6FAE01938BE9BBE003BDBFF00AD5F579AF943C570997C75AF2EEE1AFA51B41E73BCF35954E872E23A0DD355469D7619537CC0471E73D3183FAD66B5CE155B9C28DB19E70B83E9F5AB122016F0DA005D829CB27541BB3CFA723AD661B69A19090BB50B614EEC8FA035073248FA57C3FF00F22DE97FF5E717FE802BB3B5FF008F587FDC1FCAB8CF0FFF00C8B7A5FF00D79C5FFA00AECED7FE3D61FF00707F2AD69FC28EBA1F0AF427A28A2ACE80A28A2800A28A2800A28A28013B5721F122FDB4FF0002EA2C9711C32CCAB021723E6DEC032807AFCBBBDF009ED5D8578FFC73BE91F4ED374885A3669A469E44CFCEA146D53D780773F6E71EC6A26FDD66559DA0CF119FCBD91BC51C6A9B7076E7EBFD6BEA3F87561269BE01D1EDE564673079994CE30E4B8EBDF0C33EF5F35D9E977324B1C0D1969247511C48B92E49E8001C93FE7AD7D710C31DBC290C31AC71A285445180A0700003A0A887C46187D64DF6FD49E8A29A4850492001C926B63B0C1BF7F32F24C31207CA3DB1D7F5CD56A5662EECCC72CC724D3EDD3CCB88D0A96058640F4EF52733D59D0C2A5208D0E32AA01C7D2A4A28AA3A428A28A004AF0EF8E16B343ABE9F7DB93CA9AD8C2BFDE0C8C49278E989077F5AF71AF33F8CD60937862DAF7C9667B6B8DA6400911A3A90491D31B82727BE3D6B3A9F0DCC6BABC0F14699E08879470A2205576637678E8381515BDCACD3036E46F2B824F0739E00FAF4A9E1B88E4B7257D4E1E419C0073819FA7F3AD7B6F0FD9AED9EC650D275DD8DC07E1DC7A66B3380EA7E186A36F078DA38163915EE6DA484743B5C6D739E7A611BA7735EEB5F327862F5747F1A584CB70B1917689334980B1231DAE727819563F4C93D6BE9B1D055D3EA8EBC33D1A16A0BA4F32D645DBB8ED3803D7B54F456A751CB51524D1F953491E0E158819EB8ED51D49CA15734C7DB7A0633BD48FA77FE954EA481FCBB88DCB15018648F4EF40D3B33A5A28A2A8E90AF3BD32785F54D1B4B59636D42D3C47A95D5CDA060658617FB6EC91D3AAA379B16188C1F3131F7867D12B2E1F10E9971AA1D3A39E433EF68D5CC1208A475CEE4494AEC771B5B2AAC48D8F91F2B6003528A28A00E7F51FF008FE97F0FE42974E7D9789F3001B2A73DFF00C9C51A8FFC7F4BF87F215042E239E3739C2B0271F5A473B7691D3514514CE83CEBE30797FF0008BD90948119BF40C4E381E5C9CF35E10225B6859E721327E42C72403CE78E7B8FCEBDC7E35923C1D6C412317D1F207FB0F5E057CE25C4D00C20017919E076AC25F133CFACAF519ED5F05F5D8A51A9E8A6452F195B94C2B6581015CE7A60108077E4F5EDEBB5F297C3CF108F0FF8CAD2FE6774B56FDCCC15982946E32400738386C639207D6BEAD1D2AE9BD2C74E1DFBBCBD85A28A2B4370A28A28012AAEA3FF001E12FE1FCC55AAABA8FF00C784BF87F3140A5B3306BC27C67243A878DB53B8FB3318E391622CCD8394014E00ED907935EDF797496563717728631C11B48C17A90A3271EFC57CF32EB6D2DD3DECAE0C92967664182ECC4E491F8F4E958CF748E0AAF548D7B382DD34D78A4DF1C00EFF002CBE7009E9D7278F6AE93E1768C87C7492A3AA2DB4324EA81412411E5E339E3FD667F0E9CE6B858AF2479A34C6E52D9DA093918008C7D07E5EF5ED7F0974EB9874DD42FEE5DF13CAB0C48C98C2C609C83DF9761EC54FD04A57691349734D23D2A8A28AE83D20A28A28010F7AF973C5296DFF00098EB8EEECB20BC9C823031FBC3C7E23F957D467BD7CB5E2E95E2F14EBFE53007EDD3336E39FF9687A0FC2B2A9BA39711D3E65089ADCC9E68048009DA0B658019C8E3AE3A8C7D0D54995A36169108F7945DEC492C1B8E403F8F5E7F0C540B34EF703ED0EB87CE0EC5DADD4E768153695748B2812AE13079DA0E09FF3DEA0E548FA1FC3FF00F22DE97FF5E717FE802BB3B5FF008F587FDC1FCAB8AF0E489278674B68DD580B58D49539E428047D41047E15DADAFF00C7AC3FEE0FE55AD3F851D943E15E84F4514559D0145145001451450014514500257CFDF16EFE2B8F194AB2A88FEC90C702B96CE723CCDD81C8FF005807E1F97BDCF3476F03CD348B1C68A59DD8E0281C9249E82BE49F115F1D5B57BCD4E28C209E7794AE776DDCC5B6E71CF5ACAA3D5239712EF689D0F820C9AA78E349B182653E5DC2DC1DC0E309876C1EBD14819EF8FAD7D363A57CE1F04ACE3BDF1D497321756B4B5778C29E092421CE7D98F4C738AFA3E8A7D58F0D1B2606ABDEBECB394E3395C7E7C7F5AB159BABB810A27392D9FC87FF005EB53793B2326AE6989BAF41CE36293F5EDFD6A9D6A6909FEB242A3B283FCFFA523182BB3568A28A67405145140095CB7C44B196FF00C07ABC1098C3883CDFDE676908C1C838F6535D4D53D46CA3D474CBAB2959962B989E262A70406041C7BF3532574D1338DE2D1F244AF2BB63E5631954DCBD7775EDE9939FC6B613557D3F4D4B789631333065E430DBDB3EF8C563ADB2B38893646A878207CEF92063239E4803D79E01CE0DD5B20D772CD73741CAFCEEB1AE40F45247009E2B04EEAE79CACD5CB3133CF11B8BD902BB9C118E9CF5FC07D3AF7AFA7F48BEFED2D1ECAFFCBF2CDCC11CDB339DBB941C67BE335F29EA37925C5D9D98485146C403714040CE4FE15EF1F08F578750F06ADAC3B55ACA578CAEF04ED625C311D87CC40F5DA7F0A83B4BD4D70EED3B773D0E8A28ADCEE30B534DB7A4E73BD41FA76FE954EB5757425237E30091F9FF00FAAB2A91CF3566145145224E921632411B9C6594138FA549DAA9698E1ACD40FE1241FE7FD6AF551D29DD0579FE996578BE28B485A1BEFF0047D56F2EA4B57B62B696D1B8B8DB3C736D1BE47F31329E6381E749F22EC1E5FA05140C28A28A00C0D47FE3FA5FC3F90AAB56B51FF8FE97F0FE42AAD49CD2DD9D0DA49E6DAC6D924EDC127A92383538ACED2A5DD1B4448F9395FA1FF3FAD68D51D1177479A7C6F5DFE0AB75F33CBCDF47F37A7C8F5E091EE84833EF2846D7C9EFEA2BDF3E366DFF008432D8B91B05FC658119C8D8F915E0B2EE281A3645503853DC1FAF7E38AC25F1338AB7C6C6345CB7967F747A60F7ED5EF9F0A3C60757D31B43BD38BFB0501408F01A0180BC8E3209C76E31D4E4D786C4A4A79EBB420E093C0DC3D3DFA5334DD62F744D6ADF55B265134120902B3101C0CF04820E082411DC1A57B3BA269CDC5DD1F6051585E15F11DB78A740B7D56D97CBF3462484B86689C75538FCC74C820E066B77B56E9A6AE8EF4D35742D14514C62554D47FE3C64FC3F98AB9591AF5D4369A7B4D3BEC8E3CC8E704E154124F149E8899BB45B3CEBE216B5F63D363D2A1908B8BD386D87E6118EBD0F1BBA723046EAF164B4135E36524642C400C76B27D7D6B4FC47E25B8F10EB775A8412958778FB3A3641DAA48503938EE48E9926A999278514663672DF2A9E9923B1EBC5617BBB9E736DBB930468559036E5DC31CE01FCABE9AF09692FA2785B4EB0903096388191598315918967191C6033103DBD6BC63E1868D71ABF896D6E6E2D545BDA7EFE46CB004AFDC3F5DF83CF508DD718AFA12AA9ABBB9BE1A1AB93F4168A28AD8EC0A28A2801ADF74D7C7323797792C8C391DBDB8FE7CD7D73ABDEFF0066E8F7B7DE5F986DA0926D99C6EDAA4E33DB38AF8FE79243233A05C31CED27AF5FF1358D4DD1C9887AA2CBC65D24D885548055C9036FAF5EDD7BD5792D4C5824AE0EDC8183FF00EB1C7BD3659FF7118D8CAF824127D4F4FA53AD67B81B12DC485D8E5427393DBDBAFAFA5498347BFF00C3EFF91174CE9F75FA7FD746AF45B17DF691938E98E3DB8AF28F85F74EFA05CD94F231B9B6B83BE3249F2C301800F4FBC1FA7BFAD7AAE9DFF1E31FE3FCCD694FE1474E1FE145CA28A2B43A428A28A0028A28A0028A28A00E37E246AE346F03EA0E64412DCAFD96212292097E0F4E9F2EE3CF191F857CD51EE84833EF2846D7C9EFEA2BD53E37EB8B36AFA7688B32F95021B8B85126E0C4F4564EC428C83D70FC7BF96CBB8A068D91540E14F707EBDF8E2B093BC99C35A5CD267ADFC0DB2B7FB5EB378A80C88B1471B863C236E2C319C72517F2AF68EF5E31F042F225BED52D363799344920650367EEC9561F5FDE2FEB5ECE6AE97C26F87FE18B58BAAC9BAE5501C845E98E84FF00F5B15B5DAB9CBA93CDBA95F231BB008E840E055B2EA3D08AB734E5D966B90416CB1CF7FF002315875D2449E5C4899CED5033EB8A1134D6A4B451453360A28A2800A43D0D2D21E86803E59F112DAE9BAEEA76966117CBBB9912324B15446231CFB01CE73D6B0A0BB580801942073CF5691FB13F4CF435D2F88AF6DB56D66ECA85B8B592F26646208C2BBB32B72323F1FCBA83C84E822BE58D8A830955DB8EB8EA73F5CD732D91E62F22576926493CC68D0487871D54FD7A9AF50F829AAB596BF75A5CE42FDB22054B0259A48F27008E00DA58F3E9F9F956FDD75BA475111F98A95CE403D3DBBD6D68BAA4BA36B9A7EA703605B4A8E63590A79884F2BBB9C64023DC134376D4B4F95A7D8FAD28A8619A3B881268645923750C8E872AC0F20823A8A9ABA4F40A5A8AEFB36C024AE1863B7F919AC3AE9254F32274CE372919F4CD7374998D45A85145148CCD2D224F9E48C93C80C3D3DFFA56B56069F27977899380DF29E3AE7A7EB8AE829A3783D028A28A6585145140181A8FFC7F4BF87F21556AD6A3FF001FD2FE1FC8555A939A5BB27B49BECF728E49DBD1BE95D1572D5B5A75C092DC4648DE9C63DBB7F8534694DF4384F8D440F075B12323EDD1E41EFF0023D78334B01876A29DE80FCA7F89BB904FF9F4AF77F8DC42F82E024E07DB539FF80495E29E15F0D5DF8B75C874D85D447212F34FB4B08D4724E07E433819206466B197C4CE6ADF1B20952258937B18F7827046467A703D7A54FA668D6B732285BA0E17E6642A41038FE99AEFF5BF833AC431EED3AF20BDD8A08523CA90B16E70092A7031C96CE063D33E772C57FA6DDCB6B736F35BDC47B415B95646C1191C75E841FC6A7C999B4E3A3563AAD1BC403C13AD2DC585DA98A45DB3D916F96500F19FEE9EB83DBD08C83EDFE1DF17E93E27B5F334F9FF007C33BEDA521654008192B93C7239191CFAF15F31DCDBACA5AE65B88503825C30CFCDF4E95520BC3A74C925A4D247221564941230739DC08E723AFE5549B8EC5D3A9286C7D93457CDFA57C4FF0014E9D616D3BDF8B985770F2AE5449BCF3C96FBFDC11F37B74E2AE5DFC68F144D0BC515AD940C403E7451B12A0104E37311D33D4557B5F237FAC47B33DEEEEF2DEC6D9EE2EEE238215C6E92570AAB93819278EA40AF00F887F11FFE124BCFECED3B70D2A372BBCF1F686FEF37A2FA0FC4F60392D7BC4DAB788E51717D7AF3B2E701DC6D4E141C28C28E9CE0738AC0DFB0B1605D87CC40E98E39FE75329391954A8E7A6C8D4436B6CACBE5387078DDD49F6A82E2E8DDBC50807CDE8001F2AFF9EF4C5BF69635594C6588DBE611CA9C9E073D718EDE95E85F0D7C1525CEA6BAD5E44DF678981B6C311BE507A818E403FA8039E454F9232D76EA7ABFC3DD027D07C389F6D60F7D39DD33E41200E15320741CF1CF24F3CD7622A38A3F2E244CE76A819F5C5495D1156563D084546292168A28A65094570DE20F8A7A1786F589F4BBE86F9A7842EE68A352A77286182587635CD6A5F1B6DE4461A2E9CCC368FF0048BB60155B3C828A79E3BEE1C9F6E61CE264EB4175353E2EF89934CD017488AE7CAB9BF043953F32443AF4391B8E074208DE2BC4F4CD1AD6E6450B741C2FCCC85482071FD334DD6EFEEF53D49EEAFA769EE662643283B8E33C74C0E0003D001C74AA76B7926E7119C91801A42791E9C7359377776724A5CEDC99A7A9E9DA4457288F725060FEEA3233EDD7F1A62490DA493FD85B63188246719DB9233C1E49E3BD55B9B7594B5CCB710A0704B8619F9BE9D2B3CBC310D89965E30CC32BCF56F5C8A085B1DC780F58FF00847F578DAE67516B7727932B17C0C93F2B104800838C93D89EE6BE8BD38FFA0C7F8FF335F2506DDA5412E1540C000FCD920E7BFAF15DF7837E2C5D7876C574CD46CA4BEB4898795323E1E28BF8873F7B1D40247A6718C38CB95F91AD29A83D763E82A2BCD07C6DF0C95245BEA440EFE547FF00C5D7A069D7B1EA3A65B5EC6ACB15CC492A061860180233EFCD6AA49EC75C67193B22E5145154585145140086B235FD7EC3C37A5CBA96A53F976F1F00019676ECAA3B93FF00D7E0026B95F881F1164F08DCC3A75A59A4D773C62412CCD88D017DA0607249C37A01C75E95E1DE23F126ADAC08AF756BE92770DBA346C6D1C01C28E147CBD87279ACE53E88E7A9592F763B95F55BFB8D6B58B8D5EFDD8CF73219021CED233C28C9240038033D2ABB4B01876A29DE80FCA7F89BB904FF009F4A84DDB4EACF3BB6F231B8E31F862990406724CAC861CE5DF3DFAE2B34AC72F43A9F0B6BFF00F08AEBF63A96E748B244F10C9DF19E1800081BB18201EE01AFA66CEEE1BEB282EA07DF0CD1AC91B608DCAC320E0F3D0D7C8F77C3AC67D372943B8819CF6EA7A67D856E784FC77ACF865E44D3E657B7660CD05C0CC6E70467D41E99208CE06720538CB959A52A9C9E87D413BF970492646554919E99ED5CE572B61F15ED758923B2B8D364B696E6648A2D93094124F7C85C738E99EFF8F555A29296C6AEA467F092DBAEFB98976EE05C64633C77AE92B9FD3BFE3FA2FC7F91AE82A91AD3D828A28A668145141E9400DFA5731E35F1245E1BD06595660B793031DB2F562C782C060E4283BB9E3803B8AE3355F8D96B109069DA648C027125C385DAE73FC0B9DC0707EF0CF238EB5E6DAF6AF7BE21BF9350BF90C93B6E0B9521114670AAB9E00C91D79EA724927275135689C9531116AD132EE2F0298FEC618230DC1CE577F3DC67DBF4ACCBC8A40E3E561B00F31F070793D33DBD8558B8984E54C463470FB3CC0A1473C01B7F1273F9D17B70F15B47339239CAAE73903EBD39CFFF00AB15073455B62182DC44AB24A5B3D554AE03F3FA77A9DA580C3B514EF407E53FC4DDC827FCFA5426EDA75679DDB7918DC718FC314C8203392656430E72EF9EFD71414CF70F865E3C8BECF69E1DD55BCB976EDB399DC9120CF11924F04745EC4607040DDEB40823DABE3FBAE1D233D71B94A1DC40CE7B753D33EC2BD1BC35F1A351B2B3167A9598D43C95558E73298E471CFDFE0EE3D06703A1CE4F35519DB47B1BD2AD65696C7BDFB57353208E7910670AC40CFD6B4741D6ADFC41A3C1A9DAA4A90CDBB6ACA0061B58A9CE091D41EF54EFC05BD9428C0C83F98CD6B7BABA369B4E29A2BD145148C8504A9041208E4115D2C6E248D5C746008CD7335B5A6481AD02F1942475FC7FCFD29A34A6F5B17E8A28A66C14514500606A3FF1FD2FE1FC8555AB3A8FFC7F4BF87F2155AA4E696EC2A48A578640E87047E47DAA3A2811CF7C5E586FFC1F62AC7F7725EAE739E3F7727A7D2A87C18D2AD62B5D5352B582311C922DB46CC3F7A36E59B27D0EE4E87B74E29FF112D2F2FBC3B041670CD338BC490A4519908C23F381F5C7E22B7BE17690DA2F82A149609A09E795E692195769439DA3008040DAAA79F5ACD6B5051F7AA9DBF6AC4F10F8634BF13D90B6D4EDFCC29B8C5229DAF11231953F91C1C838190715B7456AD26ACCEA6935667CC3E33F873AB784A569417BDD3701C5D2C470A780C24009DA72460F7CFD40E4711A93B83E78C10300E7EBDABEC69A18EE21786645923752AE8C32181E0820F515E7BE26F84BA66ACB25CE9127F67DE107036EE889E4E31D5392071C00385AC9C1AD8E59D06BE1D8F10B3549743906F4071BC22E18A907E9EC78AA897077C103C51B346E724704A9E7071D6BBD93E1A78974786E02589BD5850BAC904A8DB8E09F943618F5C636F51C6735C949E11F1489D9D7C3FA8A2F507ECAFC7D78A9F530B35B9852DBEC76590951D94FA67151658904AEC07D7827DABB98BE1C78AE69D7CFB3857738DD234C8401DC900E71CF6FC2BB8D03E17E95A748B75A91FB75D643046E2243C1E077C107AF041E450AEF643577A24727E0AF028D756D2FAED5A3D2A35DC62C63CE93713807AEDF53D7B0E9C7B86956B1F9A8891848A151B55570A31C0031D3FF00AD55238D218922891523401555460281D001D856F69D088AD5588C33FCC7FA7E95AC63637A50B3D4BB4514559D4145145007807C43F0CEABAA7C40D4264D22FA7B4904604D15BBBA71128382A39E78FC2B96B9F076B71C886C7C35A904561F7EDA4DC403D4F183D6BEA6C03D68C0F4ACBD9F99CCF0F76DDCF9626F0AF898F9420F0FEA48163C126DA4C86F4E3FA71C9A0784B5AB78C799A56A2EF8DBB059BA1239C3648EDCD7D4FB47A5616A0DBAF1F0C085C28C76FF0027347B3F326542CB73E65FF844BC47B9D4E8D7C5436549B77C30EF91EB520F096B8339D135124742B6EC01FD2BE8CA29723EE67ECDF73C0EDFC37AC8D25E19348BE473CAA0B563820FAEDA8A3F0D7891D2053E1CBE758DCE5D6D5F9538E0E0735F40D6A692D959232470411EBEFF00D28E47DC71A2DBB5CF978F81FC4CCCD9D0353DBD87D95FFC2BE9EF0D452C3E17D2A19A378E48ECE15747186521002083D0D6BED1E9455460D3BDCE8A74B91DEE2D14515A1B051451401E33F15B44D4B51F14DACF69A65D5DC4B66885A2B569003E63E4640E0E0F4FA579C49E0AF10CBBC368BAA7DE2C09B493271DBA639C0FA66BEABC71CD1B47A564E9BBE8CE6950BC9BB9F2A5AF82B5E70B0DCF87F5358F18CFD964C0FA6066A5B9F076B51C886C7C35A904561F7EDA4DC403D4F183D6BEA6DA3D29768F4A3D9F98BEAFE67CAF37857C4C7CA10787F5240B1E0936D26437A71FD38E4D489E0ED7A28816D1F549587CBB56C9D491EB9C76AFA938F4A648CB1C6CE470A0938A3D9BEE1F57F3FC0F983C37E18D7ECFC55A6C975A45FC5145791B97781D401919273D2BDEA9D2399246738CB124E29B4E31B6A4461CACB7A70CDF47D38CF7F6ADEAE7F4EFF8FE8BF1FE46BA0AB474D3D828A28A6681487A1A5A2803E5C6F0B7885F783A0EA7B4F18368FCFBF03AE7F4C5237873C4C2251FF08DEA120550046F68E7EBCE3AE467F1AFA8F8F4A3F0AC552B2B5CE4586495AFF81F2E47E0FD723762BA06A25720006C5CFCBC77C7D6AB49E09F10CBBC368BAA7DE2C09B493271DBA639C0FA66BEACDA28DA29FB3F31FD59773E53B5F056BEE161B9F0FEA6B1E319FB2C981F4C0CD4B73E0ED6A3910D8F86B5208AC3EFDB49B8
)
ImageData5 =
(join
807A9E307AD7D4DB47A51B47A51ECFCC3EAFE67CB137857C4C7CA10787F5240B1E0936D26437A71FD38E4D489E0ED7A28816D1F549587CBB56C9D491EB9C76AFA938F4A4E3D28F66FB87D5FCFF000393F873697361E03D32DAF219609903868E6428E3F78C4641E9C7357B51FF008FE97F0FE42B7C600AE7EFC86BD94A9C8C81F90C55A56491A38F2C147B15E8A28A0CC2AF6972ECB931F3871FA8E7FC6A8D3A3731C8AE3195208CD034ECEE74F4532371246AE3386008CD3EA8E90A28A28039FD47FE3FA5FC3F90AAD56751FF008FE97F0FE42A044691C2229663D00A939E5B8DA2A77B1B94193131FF00779FE5505026AC1576C6F4DB9F2E424C67FF001DAA545009DB5474C8EB2286460CA7A114EAE6E29E580931B95CF5EF5A116ADD44A9F429FE069DCD5544F73528AA1FDAD07F724FC87F8D31F574006C899BD771C7F8D32B9E26892141248007249AC8BEBEDD98A2FBBD19877F61ED55E7BB9E7E1DB0BFDD5E0557A573394EFA20A28A500B1000249E00148CC9ED20FB45C2A1FBA396FA57422AAD95B0B78403F7DB96FF000AB5546F08D9051451416145145001451514B3C702EE91C28ED9EA68009E51042D237451D3D6B9C662EECCC72CC724D58BBBB6B97EEB18FBABFD4D56A4CC272BB0A28A29101562CE7FB3DC07206D3F2B7B0F5AAF45034EC7534958F63A87943CB989DA3EEB75C7B56B2B2BA8652181E841C8AA378C931F45145050514514005145140051453490A0924003924D002D66EAB3ED8D611D5B96FA7FFAFF00953AE7538D0158B0EDEA7EEFFF005EB25DDA472EEC598F52693339CD5AC86D145148C455628EACA70CA720D7470C826855C63E619E0E6B9BAB16D7725B13B70C87AA9A68B84AC7414B54A1D4209979608DDC31C7EB56C10C010410790453364D3D875145140C28A28A0028A28A0028A28A0028A2A096EA0878925507D3A9FCA8016794410B48DD1474F5AE7598BBB331CB31C9356AF2F4DCE142ED8C1CE0F5355293309CAEC28A28A44051451401ABA65C8205BB000AE4A9F5AD3AE6012A410482390456ADAEA6ADB5271B5BA6FEC7EBE94D1AC27D19A74535595D432B0653D083914533530751FF008FE97F0FE42AF6951810B485792D80C7D3FF00D754B52FF8FF0097F0FE42B5AC53659C40E338CF1EFCD2328AF79966A95C69F15C02400AFF00DE03AFD455DA4A668D27B9CE4F6F2DBBED91719E8474351574CCAAEA5594303D4119159971A5E0168093FEC1FE86958CA54DAD8CCA29595918AB29561D411834948CC28A28A0028A295559D82AA9663D0019340095ABA7D9050B3480127941E9EF4EB2D3FCA612CB82E3EEAF61FF00D7AD1A691AC21D58B451453350A28A28012AAEA5FF001E32FE1FCC55AED51CF0ACF0B46C4856EB8EB409EA8E6E8AD9FEC883FBF2FE63FC28FEC883FBF2FE63FC2958C7D9B31A8AD9FEC883FBF2FE63FC28FEC883FBF2FE63FC28B07B3663515B3FD9107F7E5FCC7F851FD9107F7E5FCC7F85160F66CC6A2B67FB220FEFCBF98FF0A3FB220FEFCBF98FF0A2C1ECD98D456CFF006441FDF97F31FE147F6441FDF97F31FE14583D9B33F4EFF8FE8BF1FE46BA0AA30E9D143289559CB2F4C918FE557A99A4134B50A28A282C28A28A004ACBD63AC3FF0002FE95AB55AE2D23BADBBCB0DB9C6D3EB4132575639FA2B67FB220FEFCBF98FF000A3FB220FEFCBF98FF000A5632F66CC6A2B67FB220FEFCBF98FF000A3FB220FEFCBF98FF000A2C1ECD98D456CFF6441FDF97F31FE147F6441FDF97F31FE14583D9B31AB5347EB37FC07FAD4BFD9107F7E5FCC7F854F6D691DB6ED858EEC6771F4A0A8C1A772CD14514CD428A28A0028A28A0028A28A00CED5BFE3D53FDF1FC8D63D745736C97318472C0039F96AB7F6441FDF97F31FE148CA506DDCC6A2B67FB220FEFCBF98FF0A3FB220FEFCBF98FF0A2C4FB3663515B3FD9107F7E5FCC7F851FD9107F7E5FCC7F85160F66CC6A2B67FB220FEFCBF98FF0A3FB220FEFCBF98FF0A2C1ECD98D456CFF006441FDF97F31FE147F6441FDF97F31FE14583D9B33F4EFF8FE8FF1FE468AD28B4D862904819C903032463F9514D1714D220BAD3E69EE1E45640AD8C649CF4FA56842A63823438CAA8071F4A28A0A515725A28A282828A28A00827B58AE0624404F661D455293485CE62908E3A30CF3F5A28A09714F720FEC9B8FEF45F99FF0A3FB26E3FBD17E67FC28A29589E444F1E90B9CCB213C74518E7EB57A2B78611F222AF6CF7FCE8A2994A296C4D451450505145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451401FFFD9
)
loop 5
 {
  ImageData := ( ImageData ImageData%a_index% )
  ImageData%a_index% =
 }
WriteFile( A_ScriptDir "\spaimage.jpg" ,ImageData)
ImageData =
}
return

CreatePictures&Icons:
;-------------SpaTrayIcon.ico-------------------
ifnotexist, %A_ScriptDir%\SpaTrayIcon.ico
{
IconData =
(join 
0000010001002020000001001800A80C0000160000002800000020000000400000000100180000000000000000000000000000000000000000000000000078AF827AC1887CC2897DC1877EC2897CC28A7DC28B7DC28B7DC18B7DC28B7DC28B7DC18B7DC18A7EC28B7DC28B7CC18A7DC18B7CC18A7DC18B7DC28B7CC18A7DC28B7CC18A7DC28B7DC18B7DC28B7CC28B7BC3897DC2897BC18A77BE8694B19A3F974849B0523884461D644C2C884D31964B2C84462C88482E904A2C86462F8C452F934A309D4E2B86452C894932A04F2F8F4832A14F3197482E8E493194492D8743339B492E8E492F8F482E89463092492A844B28724840A84C45AC4C6C976D8B995BB0B6655D664C08236411335F123960092F6C0B3A750C3B700A30691347690D3B6A0D3E6E0D2A5E0E30621440630E366511436C1742570C336615496311345919495A0F2D5C13405F113860154864134268203852989C5997B25C9A9E79B59C5FD6B768736A53042D7307276906266E06286F062870052872052A77053686052872062E7709398007256B052974042C78042E7C07398307368009398109236908276F082973082870062B72052E7903307C1C2F58B89E60CBB364AD9E7DB89D5DD8B868736B5502327C053079053686053582053484063483052D7903388803398803398A053E91033583033A8904358203398A053A8B053B8C093D8A08297005368503388803388803388905317C0232811C3461B79D5FD3B465AC9E7BB99E5DD8B868756B5303297004317F043789033788033889053482052D7904358604378604307F03398C053481043788063280043888033788043889063683052F7A043687033788033788033788052E790331811C3360B79D5FD3B366AD9D7CB99E5ED8B86776725A06327B04307B072D77062D7A053480043482052D7A053486043686042F7C03398A04327F06338008287106307C033684033689043380052F7A033687053D8E053B8C0337880529710234811C305BB79D5FD3B365AF9E7BB89E5ED9B867756F5804317A052E78052E7805307B06327F062F7B062C77043689043789042F7C03388A05307C05358306307C043787043582063280062F7C052F7B06368405388305388309408B09317604408D1C3561B89E5FD4B466AE9D7BB79D5ED8B867746A54032B7307307905358504348205317E072970062C7603388A03388A04317F033A8C04348204388A043381033786043483043382072C78062C7506358204307F033280053584052D780639881D335FB79D5FD3B365AE9E7CB99E5ED8B868736A5206317709347E07347F04327F04388705368405318002398B03398B043786023B8E043684053787062F7C05317E043684043889062E77082265072F7A062F7C04358203378803307D043C8B1E3764B79D5ED2B365AC9E7CB89D5DD8B868746B53042D7407338008327E06307B05338006338005327F02398D023B8C043787023A8C05307C053483062F7D04388A053F8F03398908347D08236605368402378703378703368704307C0334831E3460B79D5FD3B365AE9E7DB99E5ED8B867776E57072F7605317F06317F05317F06317D043382043480033787033888053687023A8E0433820935830A327C03388902378A033789072D7507236703368702378A03388A043B8B05317E0231821C3360B89D5ED3B365AE9D7BB89D5FD9B867746C55042B74052D77033887043B8B054393053582052E7904348304358405317E033B8E0236882555A73059A4073F8E033889073C8D0A347B082266053B8B043E8E03398A0846960634800232831C3563B99D5ED4B365AE9E7BB99E61DAB868736B5203276E052A72043887043D8D033A8B06317D052E78043484053584043380064395053C8C2252A3375AA30A3F8D033888043A8A08307808246706368604388904378806378905307D0232821C3561B99D5ED4B365AE9D7CB89D5ED8B868736A5203256A062B74043888053C8C03378A043585063C8705398A06317E052D7706307B052C770C337B37579D194089043382023788062F7A092A730535870437870537870537870532800431811C315EB99D5FD3B365AC9E7BB89D5DD7B868746A5104236806297305317E04348204327F062B76093277094693063B87043380053B8607408D043583153F89315097113F8D03338105338205348304348304348203358103358205338004307D1D355FB99D5FD3B365AC9E7BB99E5ED3B4655B574D04256A03246D02236C06286F07276C0A276A0E2C6D032972022872082A6F0B2C720C2F740F3071052770193C8234569F1C367C092A730A2A710D2B6F072A6F102F6E13316F072970052B70142C55A38C59D3B366AE9D7BB89D5DD6B66667645807337E33548B56729C627B9E70829A506A8F6C80A16480A66380A88599B2909DB190A0B49DA8B15B73976F859F4671AE4874C53E68B84269B2758DA779899E9AA3A5A0A7A773879F1F457E18376AAC945CD3B465AF9E7AB89E5EDAB96881765F73798BC9C2B7D1CBBED0CCBCCFC8BAC9C1B3CFC7BBD0CDC4D5D1C6ADB7C78CA5CA8A98B9BFC1C6DAD4C3A9C4C5369ADB4781D74F7BCC477CC485B2C4CABEAECDC5B3D3CAB6D8D2BAA6A39C4F4F4EBDA15ED2B365AE9D7CB99E5ED6B768C5AD73C3B38BC6BB9FC4BEAFCFC9B8D7D1C8D2CBC6CAC4BC8099C7A5AFC494A0BC4D7BD05274BFACB2C3D1C9B76ABBD60EA7EA3872AD4970BE2F8BD478B8CFC4B9ADC4BEB0AEADA99F9F96A29A83B49E66D2B366D1B264AD9E7BB89D5DD5B667D5B566D3B569C3AE7BBCAA82B8AC8DB6B09CC0B69ED2C29D7289B8748CC07A89B44F7DD2587BBFA9A599BAA98250AAC01397D5496A9E5876B0347AB56CABBEA39C8BB2A888AFA37FC7B27DD6BC7DD7BA70D4B566D1B264AB9E7BB99D5DD5B667D4B566D4B568D3B66AD4B569D1B46BCEB26DD0B673D9BE7B8F99A6537ECB5872B25375BF5974B5AEA58FDBBF7E60B5BE13A5EA4092E32F5E8A1A658C79AEA3D0B472D7BF7FDBC080D9BC7BD4B76DD3B567D4B566D1B265AE9D7CBA9E5ED5B668D3B566D3B567D4B668D4B566D4B466D5B466D4B66CD7BA71979A974F83D85481D0548EE55386DB9C9F9EDCC07B7EB4A905AEF406ACF404A7F118A8DF9EB58FD9BB74D8BF80D9BF7ED5B971D2B466D3B566D4B566D1B264AE9D7ABA9D5CD6B568D3B569D4B870D7BB74D5B66AD3B76DD3B770D4B872D6BA6FB7A87F5C80C3508BE74E81D9527DCDA1A09BDBC07DC3B87D4AB2C70CAFF014B0E970B2ACD2B66CD5B872D7BE7DD7BC7BD5B66BD3B566D3B467D4B566D1B264AF9E7CB89E5FD3B97CCDBB98CCBEA6D0C19DD0C199D0C4AAD2C8B1D4C9AFD8C391D1B8739E96875C75AA4E6FBC596EA0BFAE83D9BF7FD7B970C1B473A0B48CADB688CFB56CD1B671D0B779D2BA80D0BB8ED0B77FD2B469D4B466D4B467D1B264AE9D7BBAA36ED9CDB3D8D3D0D9D6D0E0DED5DDD9CAE0DED2E5E4DBE4E3DCE0D5B9D2B97B6C6760475D8D4975C73F537DB7A26AD7BA73D4B86FD5B66AD9B86ED6B870D5BB75CEBC94CDC2B1CFC4BCD0C9C3D3CAB9CFC0A1D0B783D4B567D1B264AC9E7BB9A26CDCD0AEE2DAC0E5E1CDE7E7E0E5E6DEE5E7E0E5E6DDE0D7BCDAC7949D926F29335C25428835599E2135707B6F5FD3B567D5B76DD7BA76D5B86FD5B870D5BC79D9C797E1DDCCE5E4DCE6E5DDE6E6DCE1DED6D2C3A4D3B46AD1B264AC9D7CB89C5CD4B66DD5BB7CDFD4B6E4E4D9E3E2D5E4E3D3E4E1CFDAC38CD6B9738D826816265A0E2565192A6103104356504DD2B367D5B76BD5B86ED6B76DD3BF8FD1C3A9D8CAA3E4E2D1E7E8E0E7E8DFE7E8DFE5E6DFD4CBB6D2B570D1B264AF9D7BB99D5CD0B46AD1B670DCCFA7E4E0CFDCCC9FD6C07FD7BF80D5B76ED7B869AB9562172856061E5D0B215C091A4F776C58D4B466D4B66AD6B871D7B975DED6BAE3E4DDE5E3D6E7E4DBE7E6E0E7E7DFE7E8DFE6E8E0DED5B8D2B66ED1B264AE9E7AB99E5FD5B667D4B467CFB46DD3B97BD4B86ED4B565D3B465D3B466D4B566D0B265776A4E21284B11163E4A4544BAA161D5B566D4B668D5B86ED6B86ED7C289E5DFCAE6E5DBE2E0D2E7E7E0E6E3D7E5E0D0E4E3D8DACA9FD2B36AD1B264AE9D7CBCA46DD8BC74D6B970D2B56AD3B369D5B567D5B567D5B568D5B568D5B567D6B667CEAF65AF97637D715CC6AC67D7B667D5B567D5B667D5B668D6B668D5B567D9C284DAC891D9C48BE1D9BBE1D9BCD6BD7FD3BE83D1B674D3B36AD2B366ACA082A69367C7B078C0AB7AC3A764C2A45FC2A460C2A460C2A560C2A45FC2A460C2A460C3A461C5A967C3A96EC3A86AC2A563C3A766C3A664C3A461C2A460C3A460C2A45FC2A55FC2A35EC4A96BC6B07CC2A661C1A35EC3A460C3A460BB9F5CA2967C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
)
WriteFile( A_ScriptDir "\SpaTrayIcon.ico",IconData)
IconData =
}
IfNotExist,%a_scriptdir%\OriginalSpaTrayIcon.ico
 FileCopy, %a_scriptdir%\SpaTrayIcon.ico,%a_scriptdir%\OriginalSpaTrayIcon.ico
ifnotexist, %A_ScriptDir%\BlackCamera.ico
{
IconData1 =
(join
0000010001003030000001002000A825000016000000280000003000000060000000010020000000000080250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000001000000010000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000B00000011000000140000001700000018000000180000001700000014000000110000000B0000000700000005000000050000000500000005000000050000000500000005000000050000000500000005000000050000000500000005000000050000000500000005000000050000000500000005000000050000000500000005000000050000000500000005000000050000000533333305000000040000000300000001000000000000000000000000000000000000000A0000002F0000005600000069020202740202027A0202027C0202027C0000007A000000740000006A0000005A0000004A000000410000004100000041000000410000004100000041000000410000004100000041000000410000004100000041000000410000004100000041000000410000004100000041000000410000004100000041000000410000004103030341070707410B0B0B410F0F0F41131313401919193D181818341D1D1D232222220F000000030000000000000003000000280808088F191919CE323232DE434343E63A3A3AE9252525EA151515EA131313E9111111E5101010DF0D0D0DD30B0B0BC2010101BC000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB000000BB010101BB050505BB080808BB0D0D0DBB111111BB151515BB1A1A1AB81C1C1CAB1E1E1E8D202020571C1C1C1B00000002000000090505055C1A1A1AE7383838FF5F5F5FFF787878FF626262FF3B3B3BFF242424FF222222FF222222FF212121FF212121FF1C1C1CFE040404FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD000000FD020202FD070707FD0B0B0BFD111111FD161616FD1C1C1CFD232323FD272727FB292929F3262626C71C1C1C511919190A0000000D0606069A181818FE313131FF535353FF636363FF525252FF363636FF242424FF1D1D1DFF161616FF161616FF171717FF151515FF030303FF000000FF000000FF000000FF000000FF000000FF000000FF010101FF020202FF020202FF010101FF020202FF030303FF040404FF050505FF040404FF030303FF020202FF010101FF020202FF020202FF010101FF020202FF070707FF0C0C0CFF131313FF191919FF202020FF272727FF2F2F2FFF353535FF333333FC242424980F0F0F1000000011010101B90B0B0BFF262626FF444444FF494949FF3D3D3DFF303030FF252525FF151515FF020202FF010101FF010101FF010101FF000000FF000000FF000000FF000000FF000000FF020202FF050505FF060606FF060606FF080808FF101010FF161616FF1C1C1CFF1F1F1FFF212121FF212121FF1D1D1DFF171717FF0F0F0FFF080808FF050505FF070707FF060606FF080808FF0C0C0CFF131313FF191919FF202020FF282828FF303030FF383838FF383838FF2A2A2ABA1C1C1C1200000017010101CD0D0D0DFF2C2C2CFF4A4A4AFF4C4C4CFF3D3D3DFF303030FF252525FF111111FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF040404FF0C0C0CFF0C0C0CFF0C0C0CFF171717FF202020FF272727FF2D2D2DFF303030FF2F2F2FFF2D2D2DFF2D2D2DFF2D2D2DFF2D2D2DFF2B2B2BFF252525FF171717FF0B0B0BFF0D0D0DFF0D0D0DFF0D0D0DFF131313FF191919FF202020FF282828FF303030FF383838FF3B3B3BFF2E2E2ECA242424150000001C020202D50F0F0FFF313131FF505050FF4F4F4FFF3D3D3DFF303030FF252525FF0D0D0DFF000000FF000000FF000000FF000000FF000000FF000000FF000000FF040404FF111111FF121212FF151515FF242424FF262626FF303030FF333333FF2A2A2AFF222222FF202020FF1F1F1FFF202020FF212121FF252525FF2A2A2AFF2F2F2FFF2F2F2FFF272727FF131313FF131313FF141414FF141414FF191919FF202020FF282828FF303030FF383838FF3B3B3BFF323232D32727271A0000001F020202D8111111FF363636FF555555FF525252FF3E3E3EFF303030FF242424FF0C0C0CFF000000FF000000FF000000FF000000FF000000FF000000FF030303FF161616FF1A1A1AFF1D1D1DFF2B2B2BFF262626FF2E2E2EFF262626FF1A1A1AFF151515FF101010FF0D0D0DFF0C0C0CFF0E0E0EFF131313FF1A1A1AFF202020FF252525FF2D2D2DFF323232FF323232FF1A1A1AFF1B1B1BFF1B1B1BFF191919FF202020FF282828FF303030FF383838FF3C3C3CFF343434D52323231D00000024030303DC131313FF3A3A3AFF5A5A5AFF555555FF3F3F3FFF303030FF232323FF0A0A0AFF000000FF000000FF000000FF000000FF000000FF010101FF131313FF242424FF202020FF323232FF232323FF262626FF1B1B1BFF131313FF0A0A0AFF030303FF010101FF010101FF010101FF010101FF010101FF050505FF0F0F0FFF1C1C1CFF232323FF2C2C2CFF343434FF393939FF1E1E1EFF262626FF202020FF202020FF282828FF303030FF383838FF3C3C3CFF343434D91E1E1E2200000029030303DF151515FF3D3D3DFF5F5F5FFF585858FF3F3F3FFF303030FF232323FF090909FF000000FF000000FF000000FF000000FF000000FF080808FF2A2A2AFF252525FF373737FF252525FF1F1F1FFF171717FF0F0F0FFF050505FF020202FF080808FF0D0D0DFF101010FF101010FF0C0C0CFF070707FF020202FF010101FF090909FF1A1A1AFF232323FF2D2D2DFF3B3B3BFF383838FF272727FF2E2E2EFF232323FF282828FF303030FF383838FF3D3D3DFF333333DF181818290000002C030303E1161616FF414141FF656565FF5B5B5BFF404040FF303030FF232323FF080808FF000000FF000000FF000000FF000000FF000000FF1C1C1CFF353535FF303030FF363636FF191919FF161616FF0F0F0FFF040404FF050505FF131313FF1B1B1BFF1E1E1EFF1F1F1FFF1D1D1DFF1C1C1CFF181818FF0E0E0EFF040404FF010101FF080808FF1C1C1CFF252525FF303030FF484848FF2D2D2DFF383838FF2B2B2BFF282828FF303030FF383838FF3D3D3DFF333333E31B1B1B2E0000002F030303E4171717FF444444FF696969FF5E5E5EFF414141FF313131FF242424FF080808FF010101FF000000FF000000FF000000FF050505FF333333FF343434FF434343FF212121FF141414FF111111FF070707FF040404FF181818FF212121FF232323FF1D1D1DFF191919FF161616FF151515FF181818FF1B1B1BFF111111FF050505FF010101FF0E0E0EFF1F1F1FFF2A2A2AFF3D3D3DFF434343FF383838FF383838FF292929FF303030FF393939FF3D3D3DFF343434E61A1A1A3100000030030303E5181818FF474747FF6D6D6DFF616161FF434343FF323232FF252525FF0A0A0AFF030303FF020202FF010101FF000000FF0E0E0EFF434343FF353535FF424242FF151515FF111111FF0C0C0CFF020202FF141414FF252525FF262626FF1F1F1FFF1C1C1CFF1A1A1AFF181818FF161616FF141414FF151515FF1C1C1CFF0F0F0FFF030303FF040404FF191919FF242424FF313131FF4E4E4EFF363636FF464646FF2F2F2FFF313131FF393939FF3D3D3DFF333333E71E1E1E3300000032040404E6191919FF494949FF717171FF636363FF444444FF333333FF262626FF0C0C0CFF050505FF050505FF040404FF030303FF1B1B1BFF4C4C4CFF383838FF323232FF121212FF0F0F0FFF070707FF050505FF232323FF282828FF242424FF212121FF1E1E1EFF1A1A1AFF181718FF161616FF151515FF141414FF171717FF191919FF080808FF010101FF121212FF202020FF2C2C2CFF4A4A4AFF373737FF4E4E4EFF333333FF2F2F2FFF383838FF3D3D3DFF343434E81D1D1D3400000033040404E71A1A1AFF4C4C4CFF747474FF666666FF444444FF343434FF282828FF0E0E0EFF080808FF080808FF070707FF060606FF2A2A2AFF4F4F4FFF373737FF262626FF111111FF0E0E0EFF050605FF0F110EFF2D2F2CFF2C2E2CFF272827FF262726FF222022FF271C26FF2A1B29FF1C161BFF161616FF151515FF141414FF1D1D1DFF0E0E0EFF020202FF0C0C0CFF1E1E1EFF292929FF404040FF373737FF515151FF2F2F2FFF262626FF333333FF3D3D3DFF343434E91C1C1C3500000034040404E81B1B1BFF4D4D4DFF767676FF686868FF464646FF363636FF2A2A2AFF111111FF0B0B0BFF0B0B0BFF0B0B0BFF0C0C0CFF373737FF4B4B4BFF323232FF202020FF0F0F0FFF0D0D0DFF090F09FF1C281BFF384538FF354134FF313A31FF313630FF2E272DFF462944FF4D2D4AFF301D2FFF191718FF181818FF161616FF1D1D1DFF111111FF030303FF0A0A0AFF1D1D1DFF292929FF383838FF333333FF505050FF393939FF242424FF343434FF3D3D3DFF353535EA2121213600000035050505E81B1B1BFF4E4E4EFF767676FF686868FF474747FF383838FF2C2C2CFF141414FF0F0F0FFF101010FF0F0F0FFF101010FF363636FF484848FF2C2C2CFF1D1D1DFF0E0E0EFF0C0D0CFF0F1C0EFF264025FF455E44FF415A40FF3D523CFF3E4C3DFF393838FF4C3049FF50304EFF332032FF1C1A1CFF1A1A1AFF191919FF1F1F1FFF121212FF030303FF0B0B0BFF1D1D1DFF2A2A2AFF353535FF2E2E2EFF494949FF313131FF2B2B2BFF373737FF404040FF353535EB2020203700000035050505E91C1C1CFF4D4D4DFF757575FF686868FF484848FF3A3A3AFF2F2F2FFF171717FF131313FF141414FF141414FF141414FF303030FF434343FF272727FF1D1D1DFF0D0D0DFF0B0C0BFF132212FF2D542BFF527650FF50744FFF496948FF496248FF425041FF3D393BFF372936FF272127FF1F1F1FFF1C1C1CFF1C1C1CFF1F1F1FFF111111FF020202FF0E0E0EFF1E1E1EFF2C2C2CFF323232FF282828FF434343FF2A2A2AFF212121FF3B3B3BFF454545FF363636EB1F1F1F3800000035050505E91B1B1BFF4C4C4CFF727272FF666666FF494949FF3B3B3BFF313131FF1B1B1BFF161616FF181818FF191919FF181818FF282828FF3D3D3DFF252525FF1F1F1FFF0D0D0DFF0B0B0BFF111C11FF325B30FF5D895BFF648D62FF588056FF4E704DFF4A6248FF404D3FFF333733FF292929FF232323FF1F1F1FFF222222FF1D1D1DFF0C0C0CFF020202FF131313FF232323FF2D2D2DFF2C2C2CFF272727FF3C3C3CFF1F1F1FFF2C2C2CFF4C4C4CFF424242FF363636EB1F1F1F3800000034050505E81B1B1BFF4A4A4AFF6F6F6FFF646464FF494949FF3D3D3DFF343434FF1F1F1FFF1A1A1AFF1C1C1CFF1E1E1EFF1D1D1DFF242424FF383838FF282828FF202020FF0F0F0FFF0B0B0BFF0D100DFF334C31FF6A9368FF7FA67DFF6B9469FF587F56FF496847FF3D513CFF323B32FF282928FF232323FF252525FF232323FF181818FF040404FF080808FF181818FF2C2C2CFF2B2B2BFF242424FF282828FF393939FF363636FF464646FF424242FF3E3E3EFF363636EC232323390000002F040404E31B1B1BFF484848FF6C6C6CFF626262FF4A4A4AFF3E3E3EFF373737FF232323FF1E1E1EFF212121FF232323FF222222FF242424FF313131FF2E2E2EFF1C1C1CFF161616FF0B0B0BFF0A0A0AFF1E261EFF637C62FF88AB86FF7DA47BFF628A60FF4F714DFF40573FFF333E33FF2B2D2BFF282828FF262626FF1E1E1EFF080808FF030303FF111111FF222222FF303030FF292929FF1B1B1BFF2A2A2AFF313131FF2E2E2EFF323232FF393939FF3E3E3EFF363636ED2626263B00000024040404DB191919FF454545FF686868FF606060FF4A4A4AFF3F3F3FFF393939FF262626FF222222FF262626FF292929FF282828FF262626FF2B2B2BFF2F2F2FFF1E1E1EFF1D1D1DFF0E0E0EFF0A0A0AFF0B0C0BFF2E362EFF60795EFF658E63FF5C865AFF517450FF445C43FF384337FF2E302EFF262626FF1A1A1AFF070707FF020202FF0D0D0DFF1A1A1AFF313131FF292929FF222222FF191919FF272727FF292929FF282828FF303030FF393939FF3E3E3EFF363636EC232323390000001C040404D4181818FF424242FF646464FF5E5E5EFF4B4B4BFF414141FF3B3B3BFF2A2A2AFF262626FF2B2B2BFF2D2D2DFF2D2D2DFF2C2C2CFF2B2B2BFF292929FF282828FF1B1B1BFF1C1C1CFF0C0C0CFF0A0A0AFF0C0C0CFF1E251DFF2F492DFF2F552DFF2C4F2AFF273F26FF1F291EFF121412FF080808FF020202FF050505FF0E0E0EFF171717FF2B2B2BFF2A2A2AFF282828FF171717FF1D1D1DFF202020FF242424FF282828FF303030FF393939FF3E3E3EFF363636EB1F1F1F3800000014050505CA161616FF3E3E3EFF5F5F5FFF5C5C5CFF4B4B4BFF424242FF3D3D3DFF2E2E2EFF2A2A2AFF303030FF323232FF333333FF313131FF303030FF272727FF2F2F2FFF232323FF202020FF1D1D1DFF0C0C0CFF0A0A0AFF0A0A0AFF0D100DFF111B11FF112010FF0D180CFF070C07FF040404FF060606FF0A0A0AFF101010FF171717FF242424FF262626FF2A2A2AFF1C1C1CFF171717FF212121FF1D1D1DFF222222FF282828FF303030FF393939FF3D3D3DFF343434E9212121360000000D040404B7141414FF3A3A3AFF5A5A5AFF595959FF4B4B4BFF444444FF404040FF313131FF2E2E2EFF343434FF373737FF383838FF373737FF353535FF2B2B2BFF282828FF2C2C2CFF232323FF242424FF222222FF101010FF0B0B0BFF0B0B0BFF0B0B0BFF0B0B0BFF0C0D0CFF0C0C0CFF0D0D0DFF0F0F0FFF111111FF161616FF1E1E1EFF222222FF2D2D2DFF202020FF161616FF1B1B1BFF1F1F1FFF1D1D1DFF202020FF282828FF303030FF383838FF3D3D3DFF333333E41B1B1B2F00000008040404A2121212FF363636FF555555FF575757FF4B4B4BFF444444FF414141FF343434FF313131FF373737FF3C3C3CFF3E3E3EFF414141FF3B3B3AFF333333FF1C1C1CFF1A1A1AFF313131FF292929FF252525FF2B2B2BFF1D1D1DFF101010FF0D0D0DFF0D0D0DFF0E0E0EFF0F0F0FFF101010FF121212FF151515FF1B1B1BFF272727FF2F2F2FFF1F1F1FFF191919FF1D1D1DFF121212FF181818FF1E1E1EFF212121FF282828FF303030FF383838FF3C3C3CFF333333D62020201F0000000303030389101010FE313131FF4F4F4FFF525252FF484848FF424242FF3F3F3FFF363636FF333333FF3A3A3AFF404040FF636362FFA1A09FFF666564FF3B3B3BFF202020FF0A0A0AFF202020FF343434FF353535FF2A2A2AFF2C2C2CFF2F2F2FFF282828FF212121FF1C1C1CFF1B1B1BFF1F1F1FFF252525FF2D2D2DFF313131FF282828FF1F1F1FFF222222FF212121FF151515FF0B0B0BFF191919FF202020FF232323FF292929FF313131FF383838FF3A3A3AFF2D2D2DBE1F1F1F10000000010202026E0E0E0EFB2C2C2CFF434343FF454545FF3A3A3AFF2E2E2EFF232323FF1B1B1BFF1D1D1DFF313131FF444343FF81807EFFC3C2C0FF949291FF444343FF2A2A2AFF0E0E0EFF0C0C0CFF121212FF2F2F2FFF434343FF404040FF353535FF303030FF2F2F2FFF313131FF313131FF303030FF2C2C2CFF2A2A2AFF2A2A2AFF2E2E2EFF2E2E2EFF1F1F1FFF0E0E0EFF0A0A0AFF101010FF1D1D1DFF212121FF252525FF2C2C2CFF333333FF383838FF363636FE2929298E0000000500000000060606511C1C1CF5333333FF3B3B3AFF3D3C3BFF3D3B3AFF3A3837FF343332FF292828FF1D1C1CFF151515FF353535FF636261FF9B9A99FF6C6B6BFF434343FF363636FF171717FF0C0C0CFF141414FF0A0A0AFF191919FF353535FF4A4A4AFF525252FF505050FF4C4C4CFF484848FF454545FF444444FF424242FF383838FF272727FF111111FF0B0B0BFF141414FF090909FF181818FF212121FF242424FF282828FF2E2E2EFF353535FF363636FF303030E92121214500000000000000001010102F272727E23F3D3BFF56514DFF7B7672FFA4A09DFFAEAAA8FF8D8985FF635F5AFF484440FF2F2E2EFF2F2F2FFF3D3D3DFF454545FF3E3E3EFF363636FF323232FF1E1E1EFF0D0D0DFF2A2A2AFF2B2B2BFF1C1C1CFF181818FF1D1D1DFF282828FF333333FF3A3A3AFF3B3B3BFF363636FF2E2E2EFF232323FF1A1A1AFF181818FF1F1F1FFF2A2A2AFF191919FF0E0E0EFF1B1B1BFF222222FF242424FF292929FF2D2D2DFF313131FF2E2E2EF1232323821919190A00000000000000001C1C1C0929292981484441E7827D78FCBEBBB8FFD7D5D1FFDCD9D6FFCBC9C5FF9F9C97FE5B5651F82C2B2AF6282826FD4A4947FF646261FF44423FFF353330FF272624FE181818F8101010FD232323FF323232FF222222FF212121FF232323FF232323FF242424FF252525FF252525FF252525FF242424FF232323FF222222FF202020FF242424FF2A2A2AFF131313FF121212FC161616F6181818F51C1C1CF5202020F2232323E7242424BF1E1E1E641111110F000000000000000000000000000000003333330A4540403B88837F78BEB9B5A9DFDCDAD0E2E0DDD7CECBC7BDA49F9B8D494944641D1D1A5F57524CD2918C85FFBBB8B3FF807A73FF7F7A72FF655F57E51C1A18730E0E0ED11C1C1CFF3E3E3EFF2C2C2CFF232323FF232323FF232323FF232323FF242424FF242424FF242424FF232323FF232323FF232323FF242424FF2D2D2DFF2D2D2DFF131313FF0E0E0EB60B0B0B590C0C0C550F0F0F5515151548141414320C0C0C140000000200000000000000000000000000000000000000000000000000000000FFFFFF01B2B2B20AEAEAEA19EEE6E61FDFCFCF107F7F7F0400000000666666059A979182BAB5B1E2C5C2BDECBCB9B2EDB9B5B0E6A49F99A06363541214141486191919FD404040FF3D3D3DFF2D2D2DFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2E2E2EFF393939FF2B2B2BFF141414F61313135C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C4C4C40DD4D4CE2AD4D4D03CD5D1CD3ECFCFC930C9C9C913FFFF0001161616431A1A1AED3C3C3CFF4C4C4CFF383838FF333333FF333333FF333333FF333333FF333333FF333333FF333333FF333333FF333333FF383838FF424242FF282828FF191919D815151524000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022222216212121C53C3C3CFF585858FF444444FF3A3A3AFF393939FF393939FF393939FF393939FF393939FF393939FF393939FF393939FF414141FF4E4E4EFF313131FE1F1F1FA01F1F1F0800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003F3F3F042C2C2C84484848FD666666FF515151FF434343FF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF434343FF4C4C4CFF5F5F5FFF454545F62A2A2A5A000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004B4B4B3D5C5C5CE7696969FF4F4F4FFF484848FF494949FF484848FF484848FF484848FF484848FF484848FF484848FF474747FF474747FF5B5B5BFF606060CE4F4F4F20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007373730B7979798B646464F44A4A4AFF464646FF464646FF464646FF464646FF464646FF464646FF464646FF464646FF464646FF464646FD525252D876767658AAAAAA030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
)
IconData2 =
(join
0000000000000000000000000000000000008D8D8D1259595964474747B3484848E44B4B4BFC454545F8464646FB454545FC464646FB474747FC4A4A4AF7454545D746464698494949347F7F7F0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000014848480E6B6B6B4E7F7F7DA24C4C4C5D4545455F464646624545455F646262877A79798B4B4B4B253F3F3F0800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F7F049999990A000000010000000000000000000000007F7F7F069F9F9F0800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFDB06FC3FFFFFFFFFDB06C00000000007DB06800000000001DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06000000000000DB06800000000001DB06800000000001DB06800000000003DB06C00000000007DB06F020000003FFDB06FFF0000003FFDB06FFFFE00003FFDB06FFFFE00003FFDB06FFFFF00007FFDB06FFFFF00007FFDB06FFFFF8000FFFDB06FFFFFC003FFFDB06FFFFFF1CFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06
)

loop 2
 {
  IconData := ( IconData IconData%a_index% )
  IconData%a_index% =
 }
WriteFile( A_ScriptDir "\BlackCamera.ico" ,IconData)
IconData =
}
ifnotexist, %A_ScriptDir%\BlueSkyGreenGrass.ico
{
IconData1 =
(join
0000010001003030000001002000A8250000160000002800000030000000600000000100200000000000802500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A3A3A30EABABAB40ADADAD45ADADAD45ADADAD45ADADAD45A9A9A9459B9B9B4597979745939393459393934593939345909090459090904590909045909090458C8C8C458C8C8C458C8C8C458C8C8C45888888458888884588888845888888458585854585858545858585458181814581818145818181457D7D7D457D7D7D457D7D7D457D7D7D457D7D7D457979794579797945797979457676764576767645767676456060603A484848070000000000000000000000000000000000000000A1A1A134D6D6D6E4E9E9E9F5E8E8E8F5E8E8E8F5E7E7E7F5E6E6E6F5E2E2E2F5E0E0E0F5DFDFDFF5DFDFDFF5DFDFDFF5DDDDDDF5DDDDDDF5DDDDDDF5DCDCDCF5DCDCDCF5DBDBDBF5DBDBDBF5DADADAF5DADADAF5D9D9D9F5D8D8D8F5D8D8D8F5D7D7D7F5D7D7D7F5D6D6D6F5D6D6D6F5D5D5D5F5D4D4D4F5D3D3D3F5D3D3D3F5D3D3D3F5D2D2D2F5D2D2D2F5D1D1D1F5D1D1D1F5D0D0D0F5D0D0D0F5CFCFCFF5CECECEF58D8D8DE5636363616666660500000000000000000000000000000000A5A5A536E6E6E6EDFCFCFCFFFBFBFBFFFBFBFBFFFBFBFBFFFAFAFAFFFAFAFAFFF9F9F9FFF9F9F9FFF8F8F8FFF8F8F8FFF7F7F7FFF7F7F7FFF7F7F7FFF6F6F6FFF6F6F6FFF5F5F5FFF5F5F5FFF5F5F5FFF4F4F4FFF4F4F4FFF3F3F3FFF3F3F3FFF2F2F2FFF2F2F2FFF1F1F1FFF1F1F1FFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFEEEEEEFFEDEDEDFFEDEDEDFFEDEDEDFFECECECFFECECECFFEAEAEAFFAEAEAEFF9C9C9CE4686868583F3F3F04000000000000000000000000A5A5A536E7E7E7EDFCFCFCFFFCFCFCFFFBFBFBFFFBFBFBFFFAFAFAFFFAFAFAFFFAFAFAFFF9F9F9FFF9F9F9FFF8F8F8FFF8F8F8FFF8F8F8FFF7F7F7FFF7F7F7FFF6F6F6FFF6F6F6FFF5F5F5FFF5F5F5FFF4F4F4FFF4F4F4FFF4F4F4FFF3F3F3FFF3F3F3FFF2F2F2FFF2F2F2FFF1F1F1FFF1F1F1FFF0F0F0FFF0F0F0FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFEEEEEEFFEDEDEDFFEDEDEDFFEDEDEDFFECECECFFEBEBEBFFB6B6B6FFD0D0D0FF9E9E9EDF6565654E555555030000000000000000A5A5A536E7E7E7EDFDFDFDFFFCFCFCFFFCFCFCFFFBFBFBFFFBFBFBFFFAFAFAFFFAFAFAFFF9F9F9FFF9F9F9FFF9F9F9FFF8F8F8FFF8F8F8FFF7F7F7FFF7F7F7FFF6F6F6FFF6F6F6FFF5F5F5FFF5F5F5FFF5F5F5FFF4F4F4FFF4F4F4FFF3F3F3FFF3F3F3FFF3F3F3FFF2F2F2FFF2F2F2FFF1F1F1FFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFFEFEFEFFFEFEFEFFFEEEEEEFFEEEEEEFFEDEDEDFFEDEDEDFFECECECFFEBEBEBFFB6B6B6FFD7D7D7FFCDCDCDFE919191D75D5D5D440000000200000000A5A5A536E7E7E7EDFDFDFDFFFCFCFCFFF3F4F2FFBFD1BCFFB5CDB2FFB5CEB2FFB4CDB1FFB4CDB1FFB3CDB1FFB3CDB0FFB3CDB0FFB3CDB0FFB3CDB0FFB2CDAFFFB2CDAFFFB1CDAEFFB1CDAEFFB1CDAEFFB1CDAEFFB0CDADFFB0CDADFFB0CDADFFAFCCACFFAFCDACFFAECCABFFAECCABFFAECCABFFAECCABFFAECCAAFFADCCAAFFADCCAAFFACCCA9FFACCCA9FFACCCA9FFACCCA8FFACCCA8FFABCCA8FFABCCA8FFAECBABFFB1B6AFFFB8B8B8FFB7B7B7FFACACACFE808080B94444440F00000000A5A5A536E8E8E8EDFDFDFDFFFDFDFDFFDDE4DBFF2F992BFF0EA60CFF0EA70CFF0DA80CFF0DAA0CFF0DAB0CFF0DAC0CFF0DAE0CFF0DAF0CFF0DB10CFF0DB30CFF0DB40CFF0DB50CFF0DB70CFF0DB90CFF0DBA0CFF0DBB0CFF0DBD0CFF0DBF0CFF0DBF0CFF0DC10CFF0DC30CFF0DC40CFF0DC50CFF0DC70CFF0DC80CFF0DCA0CFF0DCB0CFF0DCD0CFF0DCE0CFF0DD00CFF0DD10BFF0DD20BFF0DD40BFF0DD50BFF19C715FFACC8A9FFEBEBEBFFEAEAEAFFE9E9E9FFADADADC94B4B4B1100000000A5A5A536E8E8E8EDFEFEFEFFFDFDFDFFDCE4DAFF249F20FF00B100FF00B200FF00B400FF00B600FF00B700FF00B900FF00BB00FF00BC00FF00BE00FF00C000FF00C200FF00C300FF00C500FF00C700FF00C900FF00CA00FF00CC00FF00CE00FF00CF00FF00D100FF00D300FF00D400FF00D600FF00D800FF00D900FF00DB00FF00DD00FF00DF00FF00E000FF00E200FF00E400FF00E500FF00E700FF00E900FF0CD70AFFA9C9A5FFECECECFFECECECFFEAEAEAFFAFAFAFC94B4B4B1100000000A5A5A536E8E8E8EDFEFEFEFFFDFDFDFFDCE4DAFF249F20FF00B100FF00B200FF00B400FF00B600FF00B700FF00B900FF00BB00FF00BC00FF00BE00FF00C000FF00C200FF00C300FF00C500FF00C700FF00C900FF00CA00FF00CC00FF00CE00FF00CF00FF00D100FF00D300FF00D400FF00D600FF00D800FF00D900FF00DB00FF00DD00FF00DF00FF00E000FF00E200FF00E400FF00E500FF00E700FF00E900FF0CD70AFFA9C9A5FFECECECFFECECECFFEBEBEBFFAFAFAFC94B4B4B1100000000A5A5A536E8E8E8EDFEFEFEFFFEFEFEFFDCE4DAFF249F20FF00B100FF00B200FF00B400FF00B600FF00B700FF00B900FF00BB00FF00BC00FF00BE00FF00C000FF00C200FF00C300FF00C500FF00C700FF00C900FF00CA00FF00CC00FF00CE00FF00CF00FF00D100FF00D300FF00D400FF00D600FF00D800FF00D900FF00DB00FF00DD00FF00DF00FF00E000FF00E200FF00E400FF00E500FF00E700FF00E900FF0CD70AFFA9C9A5FFEDEDEDFFECECECFFEBEBEBFFAFAFAFC94B4B4B1100000000A5A5A536E7E7E7EDFEFEFEFFFEFEFEFFDCE5DBFF27A022FF07B102FF0FB105FF1CB209FF20B40AFF1FB50AFF1DB709FF1BB909FF15BA07FF0ABD03FF06BF02FF03C201FF01C300FF00C500FF00C700FF00C900FF00CA00FF00CC00FF00CE00FF00CF00FF00D100FF00D300FF00D400FF00D600FF00D800FF00D900FF00DB00FF00DD00FF00DF00FF00E000FF00E200FF00E400FF00E500FF00E700FF00E900FF0CD70AFFAAC9A6FFEDEDEDFFEDEDEDFFEBEBEBFFAFAFAFC94B4B4B1100000000A5A5A536E7E7E7EDFEFEFEFFFEFEFEFFE3E5DEFF8B9C43FFA8A835FFC0A83DFFD2A743FFD6A845FFD5A844FFD2A844FFD0A943FFC8AA40FFB7AC3BFF9FAF33FF85B32AFF6AB622FF4CBB18FF2CC10EFF16C607FF07C902FF01CC00FF00CE00FF00CF00FF00D100FF00D300FF00D400FF00D600FF00D800FF00D900FF00DB00FF00DD00FF00DF00FF00E000FF00E200FF00E400FF01E500FF09E503FF25DF0BFF53C321FFB9C6ADFFEDEDEDFFEDEDEDFFECECECFFAFAFAFC94B4B4B1100000000A5A5A536E6E6E6EDFDFDFDFFFEFEFEFFEAE5E1FFD9995EFFFFA351FFFFA351FFFFA351FFFFA351FFFFA351FFFFA351FFFFA351FFFFA351FFFFA351FFFEA451FFFEA451FFFCA450FFF3A54DFFE3A748FFC8AB3FFFA5B134FF7CB827FF53C01AFF35C610FF1ECB09FF12CF06FF0DD104FF0BD404FF0CD504FF0ED604FF0FD805FF10D905FF15DA07FF26D70CFF3CD313FF57CE1BFF7AC526FFA7BA35FFD9AD45FFE19C4FFFCEC1B5FFEEEEEEFFEDEDEDFFECECECFFB0B0B0C94B4B4B1100000000A5A5A536E6E6E6EDFCFCFCFFFDFDFDFFE9E4E0FFDA985DFFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFFA250FFFCA24FFFF7A34DFFE9A649FFD6A943FFC9AC3FFFBBAF3AFFB2B138FFB6B139FFBCB03BFFC2AF3DFFC8AE3FFFCFAD41FFDDAA45FFEEA64BFFF8A44EFFFCA34FFFFEA250FFFFA250FFEA9951FFCEC1B5FFEEEEEEFFEEEEEEFFECECECFFB0B0B0C94B4B4B1100000000A5A5A536E5E5E5EDFBFBFBFFFCFCFCFFE9E4E0FFDA975CFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFFFA14FFFEA9851FFCFC1B6FFEEEEEEFFEEEEEEFFEDEDEDFFB0B0B0C94B4B4B1100000000A5A5A536E5E5E5EDFBFBFBFFFCFCFCFFE8E3DFFFDA955CFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFFF9F4EFFEA9650FFCFC1B5FFEFEFEFFFEEEEEEFFEDEDEDFFB0B0B0C94B4B4B1100000000A5A5A536E4E4E4EDFAFAFAFFFBFBFBFFE7E3DEFFDA945CFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFFF9E4EFFEA9550FFCFC1B5FFEFEFEFFFEFEFEFFFEDEDEDFFB0B0B0C94B4B4B1100000000A5A5A536E4E4E4EDF9F9F9FFFAFAFAFFE7E2DEFFDA935BFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFFF9C4DFFEA944FFFD0C1B6FFEFEFEFFFEFEFEFFFEEEEEEFFB0B0B0C94B4B4B1100000000A5A5A536E3E3E3EDF9F9F9FFFAFAFAFFE6E1DDFFDA925AFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFFF9A4CFFEA924EFFD0C1B6FFF0F0F0FFEFEFEFFFEEEEEEFFB1B1B1C94B4B4B1100000000A5A5A536E3E3E3EDF8F8F8FFF9F9F9FFE6E1DDFFDA9159FFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFFF994BFFEA914DFFD0C1B6FFF0F0F0FFF0F0F0FFEEEEEEFFB1B1B1C94B4B4B1100000000A5A5A536E1E1E1EDF7F7F7FFF8F8F8FFE5E0DCFFDA8F58FFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFFF974AFFEA8F4CFFD0C1B6FFF0F0F0FFF0F0F0FFEFEFEFFFB1B1B1C94B4B4B1100000000A5A5A536E1E1E1EDF6F6F6FFF7F7F7FFE5DFDBFFDA8F58FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFFF9649FFEA8E4BFFD0C1B6FFF1F1F1FFF0F0F0FFEFEFEFFFB1B1B1C94B4B4B1100000000A5A5A536E0E0E0EDF6F6F6FFF7F7F7FFE4DEDAFFD98D57FFFF9448FFFF9448FFFE954AFFFA9C58FFF7A367FFF4A973FFF4A872FFFA9F5EFFFE964CFFFE964CFFFA9C59FFF6A368FFF3A66FFFFA9C5AFFFF9448FFFF9448FFFF9448FFFF9448FFFF9448FFFF9448FFFF9448FFFF9448FFFF9448FFFF9448FFFF9448FFFF9448FFFF9448FFFF9448FFFF9549FFFD974FFFFB9A55FFFD9851FFFF954AFFFF9549FFE98E4EFFD0C1B7FFF1F1F1FFF1F1F1FFEFEFEFFFB1B1B1C94B4B4B1100000000A5A5A536E0E0E0EDF5F5F5FFF6F6F6FFE3DEDAFFD98C56FFFF9347FFFF9348FFF8A163FFE4CCBCFFE0D8D3FFE1DCD9FFE3DDD9FFE6D6CBFFF1BD99FFEEC1A1FFE4D1C4FFDDD5D0FFDAD4CFFFE4BFA5FFFC9751FFFF9347FFFF9347FFFE954DFFF8A063FFF5A770FFF7A46AFFFC9A55FFFC9953FFF7A164FFF4A46CFFFC9851FFFF9347FFFE9349FFF2A773FFE3C4AFFFE3CDBDFFE8CCB9FFF2BB95FFF4B386FFD7B39AFFCDC7C3FFF1F1F1FFF1F1F1FFF0F0F0FFB1B1B1C94B4B4B1100000000A5A5A536DFDFDFEDF4F4F4FFF5F5F5FFE2DDDAFFD2966EFFF1AC7CFFEEB791FFECC5AAFFE5E2E0FFE8E8E8FFEBEBEBFFEDEDEDFFEEEEEEFFEDEBEAFFEAE9E9FFE7E7E7FFE4E1DFFFE3D4CAFFE6C2AAFFF89E60FFFB9855FFF8A165FFF2B389FFE5D8D0FFE7E1DDFFEBE2DCFFEFD7C6FFEDD4C3FFE4D9D2FFE0D1C8FFEDB28AFFEDAD82FFE6B898FFE0CBBCFFE0DFDFFFE7E7E7FFEDEDEDFFF0EEEDFFEDEAE9FFD4D3D2FFCDCBC9FFF2F2F2FFF1F1F1FFF0F0F0FFB1B1B1C94B4B4B1100000000A5A5A536DFDFDFEDF4F4F4FFF5F5F5FFE2DDD9FFCBA184FFE1CABBFFE0DAD6FFE4E3E3FFE9E9E9FFEEEEEEFFF3F3F3FFF7F7F7FFF9F9F9FFF6F6F6FFF2F2F2FFEEEEEEFFE8E8E7FFE4E1DFFFE1D7D0FFE5C2AAFFEEAD83FFE5C9B6FFE5DED9FFEAE9E9FFF0F0EFFFF5F5F5FFF5F5F5FFF0F0F0FFEAE9E8FFE4DDD9FFE3CDBEFFE5BB9FFFDBC9BDFFDAD9D8FFE3E3E2FFECEBEAFFF3F3F3FFF7F7F7FFF2F2F2FFD8D6D5FFCECCCAFFF2F2F2FFF2F2F2FFF0F0F0FFB1B1B1C94B4B4B1100000000A5A5A536DEDEDEEDF3F3F3FFF4F4F4FFE1DBD8FFD58E60FFEEAE85FFE5CBBAFFE3E1E0FFE7E7E7FFECE9E8FFF0EBE8FFF3F2F2FFF4F4F4FFF2F2F2FFEFEFEFFFEBEAE9FFE7E2DEFFE4DBD5FFE1D4CCFFE3C5B2FFF2A472FFE9B797FFE6CCBAFFEDCBB5FFEFCEB8FFEAE8E6FFE9E9E9FFE7E7E7FFE5DCD6FFEDBC9DFFF0AD82FFEDAC83FFE0C0ABFFDFC8BAFFEAC2A9FFEDC9B0FFE8E6E4FFE9E9E9FFE7E7E7FFD1CDCBFFCECAC8FFF2F2F2FFF2F2F2FFF1F1F1FFB1B1B1C94B4B4B1100000000A5A5A536DEDEDEEDF2F2F2FFF3F3F3FFE1DBD7FFD58E61FFECAF89FFE4C2ACFFE5CAB8FFECC3A9FFF5B186FFF2BC9AFFE7E4E2FFE7E7E7FFE6E6E6FFE4E4E4FFE2E1E0FFE3D3CAFFF4A775FFF9995BFFFC934FFFFE8E46FFFD914BFFFC9350FFFD914BFFF89C61FFE7BDA3FFE4C2ADFFE6BEA5FFEDAF86FFFC924EFFFF8D44FFFE8E46FFFB934FFFFB9451FFFE8F48FFF4A26EFFE3C7B6FFE1CCBFFFE1C8B9FFD2B29EFFCEC6C1FFF3F3F3FFF2F2F2FFF1F1F1FFB2B2B2C94B4B4B1100000000A5A5A536DDDDDDEDF1F1F1FFF2F2F2FFE0DAD6FFD98653FFFE8C44FFFD8E49FFFC904CFFFE8E47FFFF8C44FFF3A575FFE1CDC1FFDED4CDFFDED4CDFFDED1C9FFE0CABDFFECB08BFFFD8F4AFFFF8B43FFFF8B43FFFF8B43FFFF8B43FFFF8B43FFFF8B43FFFF8B43FFFE8D46FFFE8D47FFFE8D46FFFF8C44FFFF8B43FFFF8B43FFFF8B43FFFF8B43FFFF8B43FFFF8B43FFFE8C44FFFC914EFFFA9352FFFB914FFFE8874AFFD2C2B7FFF3F3F3FFF3F3F3FFF1F1F1FFB2B2B2C94B4B4B1100000000A5A5A536DDDDDDEDF1F1F1FFF2F2F2FFE0DBD8FFC1845FFFDA8550FFDA8550FFDA8551FFDA8551FFDB8551FFDA8754FFD59065FFD29570FFD29670FFD4936CFFD78E61FFDA8855FFDB8652FFDB8652FFDB8652FFDB8652FFDB8652FFDB8651FFDB8651FFDB8651FFDB8651FFDB8651FFDB8651FFDB8551FFDB8551FFDB8551FFDB8551FFDB8551FFDA8551FFDA8551FFDA8551FFDA8551FFDA8550FFDA8550FFCD8254FFD2C6BDFFF3F3F3FFF3F3F3FFF2F2F2FFB2B2B2C94B4B4B1100000000A5A5A536DCDCDCEDF0F0F0FFF1F1F1FFEEEDEDFFDFDAD7FFE0D9D5FFE0D9D5FFE1DAD6FFE2DBD7FFE3DCD8FFE3DDD8FFE4DDD9FFE5DEDAFFE6DFDBFFE7E0DCFFE7E1DDFFE8E2DDFFE8E2DDFFE8E2DDFFE8E1DDFFE7E1DDFFE7E1DDFFE7E0DCFFE7E0DCFFE6DFDBFFE6DFDBFFE5DEDAFFE5DEDAFFE5DEDAFFE4DDD9FFE4DDD9FFE3DCD8FFE3DCD8FFE3DCD8FFE2DBD7FFE2DBD7FFE1DBD6FFE1DAD6FFE1DAD5FFE0DBD7FFECEBEBFFF4F4F4FFF3F3F3FFF2F2F2FFB2B2B2C94B4B4B1100000000A5A5A536DBDBDBEDEFEFEFFFF0F0F0FFF1F1F1FFF2F2F2FFF3F3F3FFF4F4F4FFF5F5F5FFF6F6F6FFF7F7F7FFF8F8F8FFF9F9F9FFF9F9F9FFFAFAFAFFFBFBFBFFFCFCFCFFFDFDFDFFFEFEFEFFFEFEFEFFFEFEFEFFFDFDFDFFFDFDFDFFFCFCFCFFFCFCFCFFFCFCFCFFFBFBFBFFFBFBFBFFFAFAFAFFFAFAFAFFF9F9F9FFF9F9F9FFF8F8F8FFF8F8F8FFF8F8F8FFF7F7F7FFF7F7F7FFF6F6F6FFF6F6F6FFF5F5F5FFF5F5F5FFF5F5F5FFF4F4F4FFF4F4F4FFF2F2F2FFB2B2B2C94B4B4B1100000000A0A0A036DBDBDBEDEFEFEFFFF0F0F0FFF1F1F1FFF2F2F2FFF3F3F3FFF3F3F3FFF4F4F4FFF5F5F5FFF6F6F6FFF7F7F7FFF8F8F8FFF9F9F9FFFAFAFAFFFBFBFBFFFCFCFCFFFDFDFDFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFDFDFDFFFDFDFDFFFCFCFCFFFCFCFCFFFBFBFBFFFBFBFBFFFBFBFBFFFAFAFAFFFAFAFAFFF9F9F9FFF9F9F9FFF8F8F8FFF8F8F8FFF8F8F8FFF7F7F7FFF7F7F7FFF6F6F6FFF6F6F6FFF5F5F5FFF5F5F5FFF4F4F4FFF4F4F4FFF3F3F3FFB2B2B2C94B4B4B1100000000A0A0A036D6D6D6EDE8E8E8FFE9E9E9FFEAEAEAFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFECECECFFEDEDEDFFEEEEEEFFEEEEEEFFEFEFEFFFF0F0F0FFF1F1F1FFF1F1F1FFF2F2F2FFF3F3F3FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF3F3F3FFF2F2F2FFF2F2F2FFF1F1F1FFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFEEEEEEFFEDEDEDFFEDEDEDFFECECECFFECECECFFEBEBEBFFEBEBEBFFEBEBEBFFEAEAEAFFEAEAEAFFE9E9E9FFE8E8E8FFADADADC94B4B4B11000000009A9A9A1CB1B1B179B9B9B981B9B9B981B9B9B981B9B9B981B7B7B781ABABAB81A8A8A881A8A8A881A8A8A881A8A8A881A6A6A681A6A6A681A6A6A681A6A6A681A6A6A681A4A4A481A4A4A481A4A4A481A4A4A481A2A2A281A2A2A281A0A0A081A0A0A081A0A0A0819E9E9E819E9E9E819C9C9C819C9C9C819A9A9A819A9A9A8198989881989898819898988196969681949494819494948194949481929292819292928192929281929292819292928190909081787878665F5F5F08000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
)
IconData2 =
(join
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB0680000000000FDB06800000000007DB06800000000003DB06800000000001DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06
)

loop 2
 {
  IconData := ( IconData IconData%a_index% )
  IconData%a_index% =
 }
WriteFile( A_ScriptDir "\BlueSkyGreenGrass.ico" ,IconData)
IconData =
}
ifnotexist, %A_ScriptDir%\FilmCanister.ico
{
IconData1 =
(join
0000010001003030000001002000A8250000160000002800000030000000600000000100200000000000802500000000000000000000000000000000000000000000000000000000000000000001000000010000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000200000003000000040000000500000006000000070000000700000006000000060000000500000003000000020000000100000000000000000000000000000000000000000000000000000000000000000000000534270D27432E15483B2816381B1B091C0000000B000000040000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000003000000060000000A0000000E0000001300000019000000200505052B1511113C3535324C655F5C586E696466413E39661A1A175812120E460A0A0A330909001C0000000C000000050000000200000000000000000000000000000000000000043624122A6E4F24B776592FEC7D5D30DE8C6A3ABB765A318A5A43245A3D2D1932170B0B16000000090000000300000001000000000000000000000000000000000000000000000000000000000000000000000001000000060000000B000000120000001A000000220000002C00000039030303540B0B0789151510BE272620DC58534EED8D8782F38B8580F64F4C46F624231DF3191813EE12120DDE0D0D0ABE070705810404043C0000001400000006000000010000000000000002000000114D351560876535F187714FFF87693EFFB08951FFB38950FCAB824BF09D7742D98A6939B170542E7F563F23503624182A0D0D00130000000700000002000000000000000000000000000000000000000300000009000000110000001B00000025000000300000003D000000500404047C0C0A09D111100DF9181B18FF263332FF4E6566FF799092FF738F94FF446871FF254451FF1D313BFF151E23FF0F1212FF0B0B0AFB080807D70404047600000020000000070000000000000003000000135D3F1A688F6C3BF68A7555FF886B42FFB7905BFFBD965FFFBB935BFFB89058FFB58D55FEB18850FAA8814AEC9A7643D1856538A66C522D754F3D20472A1C0E240F0F0010000000060000000300000007000000100000001A00000026000000320000003F0000005100000072090908D00F1113FE132C3DFF175E7EFF1D8CAEFF35AEC7FF55BBD1FF59BAD3FF40ABD2FF2F96CEFF2D83C0FF2969A4FF22497AFF162541FF0C0E15FF060607EC0202026C00000011000000020000000100000004724F2057906E3DF58E795BFF886D47FFBB9663FFC49E6AFFC39C67FFC19964FFBF9761FFBE955FFFBB935CFFB99159FFB68E55FEB08851F8A78049E8967341C97E61349B654B2A6C44341C3F1A1406260000001D00000020000000290000003500000042000000530202027B0C0F14E8153664FF196EB3FF1A95D2FF1DADDCFF36BFDDFF57C5DDFF5CC3DDFF43B4DDFF32A0DBFF3191D5FF3181CCFF306EC2FF2E57ADFF223575FF0E1023FE0303069C0000001300000002000000000000000077562453916E3DF4917D60FF8A704BFFBD9865FFCAA470FFCAA470FFC8A26EFFC6A16CFFC6A06BFFC39C68FFC19B65FFC09A64FFBE9760FFBC945CFFB99159FFB58D54FEAF864EF6A47C47E3906E3DC272572E984E3C206E261C0F500B070344000000410000004E0303049C122351F41E58B3FF1B7BCBFF1A98D7FF1EB0DFFF38C2E0FF59C8E0FF5EC6E0FF44B7E0FF34A3DEFF3394D8FF3283CFFF3270C6FF315EBCFF324CB0FF262F7DFE0D0F29980000000B00000001000000000000000079572552916E3EF4968368FF8B724FFFBC9865FFCCA772FFCCA773FFCCA673FFCBA571FFCAA571FFC9A470FFC8A36FFFC7A16DFFC59F6BFFC59E69FFC29B65FFC09962FFBE965FFFBB935BFFB99057FFB38A50FCA57F49F48F6D3DE071572FC1513E219F231B0D9704050CED1B3482FF205DC1FF1C7DCFFF1C9BDBFF1FB3E3FF39C6E4FF5BCCE4FF60CAE4FF46BAE4FF35A6E2FF3497DCFF3486D3FF3373C9FF3360BFFF334EB5FF333DA7FE21236D9F00002A0600000000000000000000000075562350917040F39B896FFF8C7554FFBB9665FFCDA875FFCEA976FFCEA976FFCEA875FFCDA874FFCDA874FFCDA874FFCCA773FFCCA673FFCAA572FFC9A470FFC8A26EFFC6A06BFFC49D68FFC19A63FFBF975FFFBA915AFFB08852FFA17C49FF93713FFC6B512DF70C0C11FE1C378CFF215FC4FF1D7FD2FF1C9EDEFF20B6E6FF3BC9E7FF5DCFE7FF62CDE7FF48BEE7FF37A9E6FF369AE0FF3589D7FF3575CDFF3462C2FF354FB8FF343FACFE252778A300002A060000000000000000000000007757234F927142F3A19076FF8E7859FFBA9665FFD0AA78FFD0AA78FFD0AA78FFCFAA78FFD0AB79FFD0AB78FFD0AA78FFCFAA78FFCFAA77FFCEA976FFCDA874FFCDA874FFCCA672FFC9A370FFC7A16CFFC49E69FFC19B65FFB9935FFFAC8755FFA27F4EFF7C613AFF100F14FF1C388EFF2261C8FF1E82D5FF1EA1E1FF22B9E9FF3DCCEBFF5FD2EBFF64D0EBFF4AC1EBFF39ACEAFF379CE4FF378BDAFF3678D1FF3564C5FF3651BBFF3540AFFE25287AA200002A060000000000000000000000007757234F957343F2A5957DFF8F7C5FFFB79565FFD2AD7CFFD3AD7CFFD2AD7CFFD2AD7CFFD1AD7BFFD1AC7BFFD1AC7BFFD1AD7AFFD0AC7AFFD0AB79FFD0AB78FFD0AA78FFCDA874FFCCA873FFCAA570FFC9A46FFFC7A26DFFBF9B67FFB28F5FFFA98758FF816742FF111015FF1D3990FF2263CBFF1F84D8FF1FA3E5FF23BCEDFF3ECFEFFF61D6EFFF66D3EFFF4BC4EFFF3AAFEDFF389FE7FF388EDEFF377AD4FF3666C9FF3753BFFF3641B2FE25287CA200002A060000000000000000000000007757234F957445F2AA9B84FF917F63FFB59364FFD4B181FFD3B180FFD3AF7FFFD4B080FFD3AF7EFFD3AE7EFFD3AF7EFFD2AE7DFFD2AD7CFFD2AE7CFFD2AD7CFFD1AC7AFFD0AB78FFD0AA77FFCEA975FFCDA873FFCBA672FFC4A06CFFB79464FFAE8D5EFF886D48FF131116FF1D3A92FF2365CEFF1F86DCFF1FA6E8FF23C0F0FF3FD3F2FF63D9F2FF68D7F3FF4CC8F3FF3BB2F1FF3AA2EBFF3990E1FF397CD7FF3768CCFF3854C2FF3743B5FE27287DA200002A060000000000000000000000007757234F967646F2AFA089FF948269FFB49365FFD6B485FFD5B384FFD5B283FFD6B384FFD4B282FFD5B282FFD5B282FFD4B180FFD4B07FFFD4AF7FFFD3AE7EFFD2AD7CFFD2AD7BFFD0AB78FFD0AA77FFD0AA77FFCEA974FFC7A26FFFBA9768FFB19061FF8C714BFF131217FF1E3B95FF2466D1FF2188DFFF20A9ECFF25C3F4FF41D6F6FF65DCF6FF6ADAF6FF4ECAF6FF3CB5F4FF3BA5EEFF3A92E5FF3A7EDAFF396ACFFF3956C5FF3944B8FE272A81A2000055060000000000000000000000007757234F977747F2B2A38EFF96856FFFB09064FFD7B78AFFD8B789FFD8B789FFD8B789FFD6B687FFD6B586FFD6B586FFD6B384FFD6B484FFD6B484FFD5B281FFD3B07FFFD3AF7EFFD2AD7CFFD1AC79FFD1AB78FFCFAA77FFC9A573FFBC9A6AFFB39163FF8E734EFF151318FF1E3C96FF2468D4FF218AE2FF20ABEFFF25C5F7FF41D8F9FF66DFF9FF6BDDF9FF4FCDF9FF3DB7F7FF3CA6F0FF3B94E7FF3B80DDFF3A6BD2FF3A57C7FF3A45BAFE282A82A2000055060000000000000000000000007757234F977849F2B5A793FF988A76FFAC8D62FFD9BA8FFFD9BA8FFFDABA8EFFDABA8EFFD9B98DFFD9B98CFFD8B88BFFD7B689FFD8B688FFD7B687FFD7B585FFD5B283FFD5B281FFD3AF7FFFD2AE7CFFD2AD7BFFD1AC79FFCCA776FFBF9C6DFFB49365FF8F744FFF151418FF1F3C98FF2569D6FF228BE4FF21ADF2FF26C8FAFF42DBFCFF67E1FCFF6CDFFCFF50CFFCFF3DB9FAFF3CA8F3FF3B96EAFF3B81DFFF3A6CD4FF3A58CAFF3A45BCFE282A84A2000055060000000000000000000000007858234E98794BF2B8AB99FF9C8F7DFFA7895FFFD9BC93FFDABD94FFDBBD93FFDCBE94FFDBBD92FFDABC91FFDABB90FFDABB8FFFDABA8EFFD9B98CFFD8B78AFFD7B689FFD6B486FFD5B383FFD4B180FFD4B180FFD3AF7EFFCEAA79FFC19E70FFB69568FF917651FF161519FF1F3D99FF256AD8FF218CE6FF21AEF4FF25C8FCFF43DCFEFF68E3FEFF6DE0FEFF51D0FEFF3EBAFCFF3DA9F5FF3C97EBFF3B82E1FF3A6DD6FF3B59CBFF3A46BDFE282A84A2000055060000000000000000000000007858234E9A7B4CF2BBAF9EFFA19687FFA4865DFFDBBF98FFDCC099FFDCC098FFDDC198FFDDC098FFDCBF96FFDBBE95FFDCBE94FFDBBD92FFDABB90FFD9BA8FFFD9B98DFFD9B88BFFD8B689FFD6B485FFD5B383FFD5B282FFD0AD7DFFC4A274FFB9986CFF947954FF17151AFF1F3D9AFF256AD9FF218DE7FF21AEF5FF25C9FDFF42DDFFFF67E4FFFF6DE1FFFF50D1FFFF3EBAFDFF3CAAF6FF3B97ECFF3B82E2FF3A6DD6FF3B59CBFF3A46BEFE282A84A2000055060000000000000000000000007858234E9B7D4FF2BEB3A3FFA79E91FFA1835BFFDBC19BFFDEC39DFFDEC39DFFDEC39CFFDDC29CFFDDC29BFFDDC199FFDDC198FFDCBF97FFDCBE95FFDBBD94FFDABC91FFD9BB90FFDABA8EFFD8B88BFFD7B688FFD6B486FFD1B081FFC6A679FFBB9B70FF987D59FF18161BFF1F3D9AFF256AD9FF208DE7FF20AEF5FF25C9FDFF42DDFFFF67E4FFFF6CE1FFFF50D1FFFF3DBAFDFF3BA9F6FF3B97ECFF3A82E1FF3A6DD6FF3A58CBFF3A46BEFE282A84A2000055060000000000000000000000007858234E9D7E50F2C1B6A6FFAEA79CFF9E815AFFDDC39FFFDFC6A2FFDFC5A1FFDFC5A0FFDFC49FFFDFC39EFFDEC39DFFDDC29BFFDDC19AFFDDC199FFDCC098FFDCBF96FFDBBE94FFDBBD92FFD9BA8FFFD8B88CFFD7B689FFD3B286FFC8A97DFFBE9F75FF99805CFF19171CFF1F3D9AFF2469D9FF208CE7FF1FAEF5FF24C9FDFF42DDFFFF68E4FFFF6DE1FFFF51D1FFFF3EBAFDFF3CA9F6FF3B97ECFF3A81E1FF396CD6FF3A58CBFF3A46BEFF2B2C83A52A2A55060000000000000000000000007858234E9E7E52F2C4BAABFFB5AFA7FF9B805AFFDCC3A0FFE1C8A5FFE0C7A5FFE1C7A5FFE0C6A3FFE0C6A2FFDFC5A1FFDFC4A0FFDFC49FFFDEC39DFFDDC29CFFDEC29BFFDDC199FFDCC097FFDBBD94FFD9BB90FFD8BA8EFFD5B58AFFCBAC82FFC0A279FF9D8360FF1A181DFF1F3D9AFF2469D9FF228BE4FF26A3E1FF31ABD0FF5AB8CAFF8ECBD7FF93C5D1FF619BADFF3E7B99FF3979A3FF3A7AB5FF3B77C7FF3B6BD0FF3A58CBFF3A46BEFF302E83A92A2A55060000000000000000000000007858234E9E8054F1C7BDB0FFBCB7B2FF997F5CFFDBC2A0FFE3CAA9FFE2CAA8FFE1C9A8FFE1C8A7FFE2C9A7FFE1C8A6FFE0C7A4FFE1C7A3FFDFC5A1FFDFC5A0FFDFC5A0FFDEC49DFFDEC29CFFDDC199FFDCBF96FFDABD92FFD7B98FFFCDB086FFC3A57DFFA08865FF1B191EFF203D99FF2960BCFF24547EFF243F48FF343E3BFF6E6F68FFB0A9A3FFAEA6A0FF635F57FF2D2D26FF21231EFF1B2021FF1C2631FF25365BFF354999FF3C46B9FF333283AD242448070000000000000000000000007858274E9F8256F1CBC1B4FFC2BFBBFF99815EFFDAC1A0FFE4CCABFFE4CCACFFE3CBABFFE2CAAAFFE2CAA9FFE2CAA9FFE3CAA9FFE2CAA8FFE2C9A6FFE1C7A5FFE1C7A4FFE0C6A1FFDFC5A0FFDEC39DFFDDC29BFFDDC198FFD9BC94FFD0B38BFFC6AA83FFA48C6BFF1D1B1FFF1F3272FF1B263BFF171715FF1E1E17FF323029FF66625BFF9C948FFF958E89FF57544DFF2B2A24FF1F1F19FF171714FF12120FFF0E0F0DFF11131CFF282C64FF363576B1482448070000000000000000000000007857284CA18359F0CEC5B9FFC8C6C3FF9A8262FFD6BE9DFFE4CDADFFE5CEAEFFE5CEAEFFE4CDADFFE3CCACFFE4CDACFFE4CCACFFE3CCABFFE3CBAAFFE3CBA9FFE2CAA7FFE1C8A5FFE0C7A4FFDEC5A0FFDEC49EFFDEC39CFFDBBF99FFD3B790FFCAAE88FFA89171FF1F1C1BFF141725FF131311FF181815FF23231FFF302F2DFF42403EFF4C4948FF494746FF413F3DFF3B3938FF363433FF2E2D2CFF222120FF161616FF0E0E0EFF0D0D13FF272436B53F3F3F080000000000000000000000007856254AA4855AEFD1C9BDFFCFCDCBFF9A8466FFD3BB9AFFE4CEAFFFE5CFAFFFE5CEAFFFE4CEAEFFE4CEAEFFE5CEAFFFE5CEAEFFE4CDADFFE4CCACFFE4CCABFFE3CBA9FFE2CAA8FFE1C9A6FFE0C7A5FFDFC6A2FFDEC49FFFDCC19CFFD5BB95FFCDB28EFFB19A78FF423A2EFF181716FF1E1E1EFF363434FF434140FF454342FF413F3EFF42403EFF575352FF4C4847FF373533FF3A3837FF413F3EFF454342FF3E3D3CFF2A2929FF131214FF201C18BF6D5B360E0000000000000000000000007856254AA5875DEFD5CDC2FFD6D5D4FF9C886CFFD0B897FFE6D0B1FFE5D0B1FFE5D0B1FFE5CFB1FFE5D0B1FFE6CFB1FFE5CFB0FFE5CFAFFFE4CEAEFFE4CDACFFE3CBAAFFE3CBA9FFE2CAA8FFE0C8A7FFE0C8A4FFDFC6A2FFDEC4A0FFD8BE9AFFD0B693FFC8B08BFFA59073FF302D28FF3B3A3AFF474545FF424040FF343232FF1A1919FF4B4844FFC7BEB9FF807974FF161412FF0F0E0BFF1F1F1EFF3B3A3AFF454242FF474545FF2A2A2AFF342D24CB94744A180000000000000000000000007C59254AA68960EFD8D1C7FFDCDCDCFFA18E76FFC9B18FFFE7D1B3FFE6D1B3FFE7D2B4FFE7D1B4FFE6D1B3FFE6D1B3FFE7D1B2FFE6D0B1FFE6CFB1FFE5CEAEFFE3CCACFFE1CBAAFFE2CAA9FFE1C9A8FFE0C8A6FFDFC7A4FFDEC5A1FFDAC09DFFD4BA97FFD0B793FFBBA484FF454039FF3F3E3EFF484646FF413E3FFF1A1919FF030303FF45423FFFBAB2ADFF77716DFF181714FF090806FF0C0C0DFF323031FF444242FF494747FF313130FF5C4F3BD7B1925C210000000000000000000000007C59254AA78961EFDBD5CBFFE1E1E1FFA79781FFC0A784FFE7D2B5FFE6D1B4FFE7D2B5FFE7D2B5FFE7D2B5FFE7D2B5FFE7D1B4FFE7D1B3FFE6D0B2FFE5CFB0FFE4CEAEFFE3CCACFFE2CBAAFFE1C9A9FFE0C9A7FFE0C8A6FFDFC6A4FFDDC3A0FFD9C09CFFD6BD99FFD3B994FF97856DFF45413BFF3F3E3DFF444343FF1B1A1AFF111111FF1F1F1EFF282726FF1D1D1DFF181818FF161615FF111112FF353335FF434242FF3A3837FF574D3EFFAB8D63E3C2A36D2A0000000000000000000000007C59254AA88B63EFDED8CFFFE5E4E4FFAFA28FFFB79D7AFFE8D3B7FFE7D3B6FFE7D3B7FFE7D3B7FFE8D4B7FFE8D3B7FFE7D2B5FFE7D2B4FFE6D1B3FFE5D0B1FFE5CFB0FFE4CDAEFFE2CCACFFE2CBABFFE2CAA9FFE0C9A7FFE0C8A6FFDFC6A4FFDCC4A0FFDBC19DFFDABF9BFFD7BC97FFB59F81FF7B6F5CFF514B43FF22201EFF090909FF050504FF030303FF070606FF121111FF161614FF181817FF393530FF5B5143FF8B775AFFBC9D71FFCBA676EDC6A571360000000000000000000000007C59254AA98C64EFE0DBD3FFE8E8E8FFB9AFA1FFAE9571FFE7D2B6FFE7D3B7FFE7D3B8FFE8D4B8FFE8D4B8FFE8D4B7FFE7D3B6FFE7D2B5FFE7D2B4FFE6D1B3FFE6D0B2FFE5CFB0FFE3CDAEFFE2CCACFFE2CBABFFE1CAA9FFE1C9A7FFE0C7A5FFDEC6A3FFDDC3A0FFDCC29EFFDBC19CFFD9BE99FFD5BB95FFC7AE8AFF9A866BFF423A2FFF1D1B17FF181814FF3D3B37FF7B7570FF524D44FF685A46FFAE946FFFC6A77BFFCDAC7EFFCEAC7DFFCEAB7CF2CAA77A490000000000000000000000007C59254AAA8E67EFE2DDD5FFEBEBEBFFC7BFB6FFA68C69FFE4D0B4FFE7D4B8FFE8D4B8FFE8D4B9FFE8D4B9FFE8D4B8FFE8D3B8FFE8D3B6FFE7D2B5FFE6D1B4FFE5D0B2FFE5CFB1FFE4CEAFFFE3CDADFFE2CCACFFE1CAAAFFDFC8A7FFDFC7A5FFDEC6A4FFDCC4A1FFDCC29FFFDBC29DFFDAC09CFFD9BE99FFD7BD96FFD5B892FFC5AB87FFA79172FF907D61FF927F64FFA99476FFB69B77FFCAAC81FFD0B184FFCFB082FFCEAE81FFCEAE80FFCFAD80F7CDAB7C5C0000000000000000000000007856254AAA9068EFE2DED7FFEDEDEDFFD3CFC9FFA08765FFE1CDB1FFE8D5BAFFE7D4B9FFE7D4B8FFE8D5B9FFE8D4B8FFE7D3B8FFE7D3B7FFE7D3B6FFE6D1B4FFE5D0B3FFE5CFB1FFE4CFB0FFE3CEAEFFE2CCACFFE0CAAAFFDFC8A8FFDEC7A6FFDEC6A5FFDCC4A2FFDCC3A0FFDBC29FFFDAC09CFFD9BF9AFFD8BE98FFD6BB95FFD7BB95FFD7BA93FFD4B78FFFD2B58CFFD1B48BFFD0B388FFD1B287FFD1B286FFD1B286FFD0B185FFCFB083FFCFAE82FBCBAB7F6E0000000000000000000000007856254AAB906AEFE3DFD8FFEFEFEFFFDFDCDAFFA08A6BFFDBC7AAFFE8D5BAFFE8D5BAFFE8D5BAFFE8D5B9FFE7D4B8FFE7D3B8FFE7D3B7FFE8D3B7FFE6D2B5FFE6D1B4FFE5D0B2FFE4CFB1FFE3CEAFFFE2CCADFFE1CBABFFE0C9AAFFDFC8A7FFDEC7A6FFDEC6A5FFDDC4A1FFDCC3A0FFDBC19EFFD9C09CFFD8BE99FFD7BD97FFD6BC96FFD7BB95FFD6BA92FFD4B88FFFD3B68EFFD2B58CFFD1B48AFFD1B389FFD1B389FFD1B387FFD0B286FFD0B185FFCDAF8281FFFFFF0100000000000000007856254AAC916CEFE4E0DAFFF1F1F1FFEBEAEAFFAC9C85FFC7B193FFE8D6BCFFE9D6BBFFE9D5BBFFE8D5BAFFE7D4B9FFE7D4B8FFE7D3B8FFE7D3B7FFE6D2B6FFE6D1B5FFE5D0B3FFE4CFB1FFE4CEB0FFE3CDAEFFE2CCADFFE1CAABFFDFC9A9FFDEC7A7FFDFC8A6FFDEC5A4FFDCC4A2FFDBC3A0FFDAC19EFFD9BF9BFFD7BD99FFD7BD97FFD8BC97FFD5BA93FFD4B992FFD5B991FFD4B78FFFD2B68DFFD2B58CFFD2B58CFFD2B48AFFD2B48AFFD1B388FFD0B18698D4AA7F0600000000000000007859254AAD936EEFE5E1DCFFF3F3F3FFF5F5F5FFD1CBC3FFA59174FFC3AE91FFD9C6ABFFE4D2B8FFE7D5BBFFE8D5BBFFE8D5BAFFE7D4B9FFE7D3B8FFE6D3B7FFE6D2B5FFE5D1B4FFE4D0B2FFE4CEB0FFE3CEB0FFE4CEAFFFE2CCADFFE0CAAAFFDFC8A8FFDFC8A7FFDFC6A5FFDDC5A3FFDCC3A1FFDBC29EFFD9BF9CFFD7BD9AFFD6BC98FFD7BC97FFD6BB95FFD5BA95FFD6BA94FFD5B993FFD3B790FFD2B68EFFD2B58DFFD2B58CFFD3B58CFFD3B58CFFD0B38AAFD0A28B0B00000000000000007859254AAD9470EFEAE6E1FFEEEEEEFFF0F0F0FFEBEBEBFFD3D0CAFFB3A897FFA89780FFA89478FFB5A083FFC5B094FFD7C4A8FFE1CFB4FFE6D4B9FFE7D5B9FFE7D3B7FFE6D1B5FFE4D0B2FFE4CFB1FFE4CEB1FFE3CEB0FFE2CCAEFFE1CAABFFDFC9A9FFDFC8A8FFDEC7A6FFDDC6A5FFDCC4A2FFDAC19FFFD9C09DFFD7BE9BFFD7BD99FFD6BC98FFD7BC97FFD6BB96FFD7BC96FFD6BB95FFD5BA94FFD3B891FFD3B790FFD2B68EFFD3B68EFFD2B68EFFD1B48CC4CFAF8F10000000000000000078582348AD9067EED8CAB5FFE3DED6FFEFEEEEFFECECECFFE8E8E8FFE1E1E1FFDAD9D8FFD0CECBFFC2BCB4FFB5AB9DFFAA9B85FFAA967CFFB29D7FFFC4AE91FFD3BEA1FFDECBAFFFE4D0B5FFE4D0B4FFE4CFB3FFE2CDB0FFE2CCAEFFE2CCADFFE0CAABFFDFC8A9FFDEC7A7FFDDC6A6FFDDC5A4FFDCC3A2FFDAC2A0FFD9C09EFFD9BF9CFFD5BC98FFD5BB97FFD6BC98FFD7BD97FFD7BC97FFD6BB96FFD5BA94FFD4B992FFD2B790FFD5B992FFD3B790FFD2B58ED5D3B88C1D0000000000000000755420279E7E52CFC8AB83FDCEBCA3FFEFEEEDFFEEEEEEFFEDEDEDFFEEEEEEFFECECECFFEAEAEAFFE5E5E5FFE0E0E0FFDCDCDBFFD3D1CFFFC8C3BDFFB9B0A3FFAFA18DFFAB987DFFB19C7DFFBFA889FFCEB99BFFD9C5A8FFE0CBAFFFE2CEB1FFE2CCAFFFDFC9AAFFDEC8A8FFDEC7A7FFDCC5A5FFDBC3A3FFDAC2A1FFDAC19FFFD9C09EFFD7BE9AFFD6BC99FFD6BC99FFD7BD99FFD8BD98FFD8BD98FFD7BC97FFD6BB96FFD4B994FFD4B993FFD5B993FFD3B892E3D2B6902E0000000000000000555500038260305AB09166E9CDB390FFDACBB6FFE0D6C8FFE8E1D8FFEBE7E2FFECEAE8FFECEBEAFFECECECFFECECECFFECECECFFE9E9E9FFE5E5E5FFE1E1E1FFDCDCDCFFD6D5D3FFCBC8C2FFBFB7ABFFB2A592FFAD9B81FFB19A7BFFBDA585FFCBB494FFD6C0A2FFDDC7AAFFDFC9ABFFDDC7A8FFDCC5A5FFDAC3A1FFD9C1A0FFD8C09EFFD8BF9DFFD6BD9BFFD5BC99FFD5BC98FFD8BE9AFFD7BE9AFFD7BD99FFD6BB97FFD6BC97FFD4BA95FFD5BA95FFD3B994F1D3B793400000000000000000000000006D5B240E917041ACC7A77CFECDAC7FFFCCAD82FFCDAE86FFCDB28DFFD0B898FFD3C0A6FFD9CAB7FFDED4C6FFE0DAD1FFE5E1DCFFE6E4E2FFEAE9E9FFEBEAEAFFE9E9E9FFE6E6E6FFDDDDDDFFD4D4D4FFD3D2D1FFCFCCC7FFC3BCB2FFB7AB9AFFB09D84FFB19B7CFFBBA27FFFC7AE8DFFD2BB9BFFD8C2A3FFDBC5A6FFDAC3A3FFD9C2A0FFD8C09EFFD6BD9BFFD7BE9BFFD8BF9CFFD8BE9BFFD6BD99FFD6BD99FFD6BC98FFD6BC98FFD5BB97FFD5BB97F8D3B993580000000000000000000000000000000180613273BE9E73F8D2B183FFD0AF81FFD1AF82FFD0AF82FFD0AF82FFCFAF81FFCFAF82FFCDAE83FFCEB088FFD0B590FFD0B99AFFD1BEA3FFD3C4B1FFD8CEC1FFDDD6CEFFE0DDD8FFDBDAD8FFCECECDFFD5D5D5FFDCDCDCFFDBDBDBFFD6D6D5FFC9C7C3FFC3BDB5FFBBAFA0FFB3A18AFFB39B7CFFB99F7CFFC5AA87FFCFB795FFD6BF9FFFD9C2A2FFDAC2A2FFD8C09FFFD7BE9CFFD6BE9BFFD6BD9AFFD4BC98FFD7BD9AFFD7BD9AFFD7BC99FBD3B99776000000000000000000000000000000007B5B2B40B09164EBD4B487FFD2B184FFD2B184FFD2B183FFD3B184FFD2B184FFD3B284FFD3B284FFD4B385FFD5B387FFD5B486FFD3B285FFD2B286FFD1B187FFCFB28CFFCDB595FECCB79BFFC9B8A1FFBFB2A1FFCBC4BBFFE3E2DFFFE1E1E1FFB3B3B3FF7A7A7AFF888888FFADACACFFC2C0BEFFC6C1BBFFBEB4A7FFB7A58FFFB59E80FFBA9F7CFFC3A884FFCDB490FFD5BD9CFFD9C2A1FFD8C09FFFD7BE9DFFD8BF9DFFD8BF9CFFD6BD9AFED5BB98930000000000000000000000000000000074551F18987A4EC0CDB087FCD6B78DFFD6B68BFFD5B488FFD4B386FFD5B386FFD6B487FFD6B487FFD6B487FFD6B487FFD7B5
)
IconData2 =
(join
88FFD6B488FFD6B587FFD6B589FFD5B68FE7B3966DB4BA9D74D4C5A881EBCBAE89FBC8AE8CFDCBBBA5FFE1DDD7FFEAEAE9FFB5B5B5FF454545FF181818FF2E2E2EFF555555FF848484FFABAAAAFFC9C7C6FFCECAC5FFC4BBAFFFBAAA96FFB7A082FFB99E7BFFC0A37CFDCBB089F6D5BC9AFCD8C1A1FDD9C2A3FED8C1A199000000000000000000000000000000007F7F0002775C2A42927549AEA78A61D8BA9D76EEC9AC86F8D2B58EFDD7B88FFED9B98EFFD8B78BFFD7B689FFD8B689FFD9B78AFFD8B689FFD7B689FFD8B88EFBD3B5908896784B1183643621927041429F7F516EAB8B5E9FB3946BC7B59F7FE6CABFB2F6E7E5E2FED5D5D5FF6D6D6DFF121212FF010101FF030303FF1B1B1BFF9E9E9EFFDADADAFFD7D7D7FFDFDFDFFFDAD9D9FFCFCCC8FFAB9E8EEAA17A4775B0874F86B99361B0C9AA81ADD7C0A441000000000000000000000000000000000000000000000001754E270D755B27277C5E344E896B407E967952AEAA8D66D3BA9E77EACBAE89F7D5B790FAD9BB92FEDABA8FFFD9B88CFFD9B88DFFDABC94D6D4B68B2A0000000000000000000000007F7F0002916D24078A6A351893703F3492724D60AEA19299DEDDDADBE5E5E5FC9D9D9DFF2A2A2AFF030303FF484848FFDADAD9FFD3CCC3FFD3C8BAFFE3DDD5FFE4E2DEFFE4E4E3FFCEC8C0E2A991732A7F7F3F04A9713809997F330AFFFFFF010000000000000000000000000000000000000000000000000000000000000000000000007F7F0002754E270D785C31247F6338488C6C447A997D56A9AA8D66CCBCA17AE7CAAE88F3D5B993F5D5BA927ABFBF7F0400000000000000000000000000000000000000000000000000000000000000005F3F3F0897979236D0D0D0A0E9E9E9EFC4C4C4FF626262FFB4B4B4FFDFDCD6FBC7B092FBD5B892FED7BC97FFD6BF9FFFD9C6AEFFD6C4ADE4C8B08B2A00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F0002735C2E0B7B5C36218163374590704768A5875E5EB9A2731600000000000000000000000000000000000000000000000000000000000000000000000000000000000000016B6B6B13B6B6B663E2E2E2CEE9E9E9FBECECECF6BEB7AE92A883546DBA93639DC3A071C6CFAD82E5D5B78EEFD9BD98C0D3B8951D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FF0000010000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333059797972FD1D1D198D4D4D4A97F7F7F1E7F000002AA7F2A069D793C15AA7A4530B98F5E3ED2B48E22FF7F7F0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016666660F84848419000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E3FFFFF0003FDC06C03FFF000007DC068003FC000001DC06000078000001DC06000000000000DC06000000000000DC06C00000000000DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000001DC06C00000000000DC06C00000000000DC06C00000000000DC06C00000000000DC06C00000000000DC06C00000000000DC06C00000000000DC06E00000000000DC06E00000000000DC06F00000000000DC06F00000000000DC06F00000000000DC06F80007000000DC06FF8007F8000FDC06FFF80FFC000FDC06FFFF9FFF000FDC06FFFFFFFF87FFDC06
)

loop 2
 {
  IconData := ( IconData IconData%a_index% )
  IconData%a_index% =
 }
WriteFile( A_ScriptDir "\FilmCanister.ico" ,IconData)
IconData =
}
ifnotexist, %A_ScriptDir%\PictureInBlueFolder.ico
{
IconData1 =
(join
0000010001003030000001002000A825000016000000280000003000000060000000010020000000000080250000000000000000000000000000000000000000000000000000000000010000000E00000024000000210000001300000009000000040000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000691E1E1170252374531D199E3110108A1909076C090303500000003800000024000000150000000A00000004000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018D302D5593342EEF9B3C30FB963A2DF4833029E46B2521CC501B18AE3511108F1D090970090303530000003B00000026000000160000000B0000000500000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F00000292332F7CA3473CFEB1523AFFC6643AFFC05F38FFB65536FFA94933FD983C2EF586312AE6702723D0541C1BB2391311931F0B08730B0202570000003D00000029000000180000000C00000005000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F3F3F049335308AB25A49FEB35743FFCA693EFFCE6C3DFFCE6C3CFFCC6A3CFFC8663AFFC25F38FFB85636FFAB4A33FD9C3F2FF6893329E9722823D2591E1BB73B141296220A0A760B020259030000400000002A000000190000000E000000060000000200000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009933330595383196BA6551FEBB6350FFC4643FFFD06E3FFFD06E3FFFD06E3EFFCF6D3EFFCE6C3DFFCE6B3CFFCC6A3BFFC96739FFC46138FFBB5836FFAE4D33FD9E422FF78B362BEB762A24D75A1F1CB94015139A250C0C7A1005055D030000420000002C0000001B0000000E0000000600000002000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F2A2A06963932A1BE6B56FFC8755FFFBC5E41FFD06F40FFD06E3FFFD06E3FFFD06E3EFFD06E3EFFCF6D3EFFCF6D3DFFCF6C3CFFCE6C3CFFCE6B3BFFCC6A3BFFCA673AFFC56239FFBC5A36FFB14F34FEA24330F890372CED7A2C25D961221EBE4416159D2A0E0C7E12050560030000450000002F0000001D0000000F000000070000000300000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000091242407983B33ACC1705BFFD3866CFFB95E47FFCD6C40FFD06F40FFD06F3FFFD06E3FFFD06E3EFFD06E3EFFCF6D3EFFCF6D3DFFCF6D3DFFCF6D3DFFCF6C3DFFCF6C3CFFCE6B3CFFCD6B3BFFCD6A3BFFCB673AFFC66339FFBE5C37FFB25134FEA54630FA93392CEF7E2E27DD64221FC1491917A32D0F0D821407076307030348000000310000001F00000010000000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009F1F1F089A3D36B6C57660FFDB9276FFBE6854FFC76840FFD07041FFD06F40FFD06F40FFD06E3FFFD06E3FFFD06E3EFFCF6E3EFFCF6D3EFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6C3DFFCE6C3CFFCE6B3CFFCD6A3BFFCB683AFFC76439FFC05D37FFB65435FEA74830FA973C2DF1823028DF692520C64C1918A731110F86190707630500002D000000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000893A270D9A3E38BFC87B65FFDE987BFFCA7C66FFC06647FFD2794EFFD2774BFFD27547FFD17344FFD17142FFD06F40FFD06E3FFFD06E3EFFCF6D3EFFCF6D3EFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6C3DFFCF6C3CFFCE6C3CFFCE6B3CFFCD6A3BFFCC693AFFC86539FFC25F37FFB85635FFAC4A32FC993D2DF2803027DC682320955218181F00000000000000000000000000000000000000000000000000000000000000000000000000000000000000008D2A2A129D4139C6CA7F69FFE09C80FFD89076FFBB644EFFD48159FFD68259FFD58056FFD57E54FFD47C50FFD3794DFFD3764AFFD27446FFD17142FFD06E3FFFCF6D3EFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6C3DFFCF6C3CFFCE6C3CFFCE6B3BFFCD6A3BFFCC683AFFC66337FFBA5731FC9F432CDE852D2A5400000001000000000000000000000000000000000000000000000000000000000000000000000000000000008A2A2A189E453CCECD846EFFE19F84FFE19E82FFBD6A57FFD17F5DFFD88961FFD7875FFFD7855DFFD6835AFFD68158FFD57F55FFD57E53FFD47B50FFD3784BFFD17345FFD06F40FFCF6D3EFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6C3CFFCC6839FFC25E33FDB2542EE695382C94943F2A0C0000000000000000000000000000000000000000000000000000000000000000000000000000000090332A1EA1473FD5D08974FFE3A388FFE5A589FFC77B66FFC9785BFFDB8F6BFFDA8E68FFD98C66FFD88A63FFD88861FFD7865EFFD7845CFFD68259FFD68056FFD57E54FFD47B4FFFD27446FFCF6E3FFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCE6C3DFFCE6C3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6D3DFFCF6C3DFFCC693AFFC25E33FDB95C2FE6A6462FC190302B350000000000000000000000000000000000000000000000000000000000000000000000000000000091322B23A34B43DCD28F79FFE4A78DFFE7A98EFFD59079FFC06F58FFDC9573FFDC9572FFDB936FFFDB916CFFDA8F6AFFD98D67FFD98B64FFD88962FFD8875FFFD7855DFFD7835AFFD68157FFD47B50FFD17345FFCF6E3EFFCF6D3DFFCF6D3DFFCF6D3DFFCE6C3DFFC7693AFFC66739FFCC6B3BFFCF6D3DFFCF6D3DFFCF6D3DFFCF6C3DFFCC693AFFC25E33FDBC5C2FE5B85630CF99372E787F2A2A060000000000000000000000000000000000000000000000000000000000000000000000008F312B29A54E46E3D5947FFFE6AB92FFE8AD92FFE1A188FFBD6D5BFFD99476FFDF9C7CFFDE9A7AFFDE9877FFDD9674FFDC9471FFDB926EFFDB906CFFDA8E69FFD98C66FFD98A63FFD88861FFD8865FFFD7835AFFD37A4FFFD07142FFCF6D3DFFCE6C3DFFC96D40FFC46F44FFBD6438FFC26537FFCC6A3BFFCF6D3DFFCF6D3DFFCF6C3DFFCC693AFFC15E33FDBB5C2FE5C46032D0A5422FB091322B230000000000000000000000000000000000000000000000000000000000000000000000008D302B2FA8534AE9D89A85FFE7AF96FFE9B096FFE7AC92FFC57A68FFD18B72FFE1A486FFE1A284FFE0A081FFE09E7EFFDF9C7BFFDE9978FFDD9775FFDC9573FFDC9370FFDB916DFFDB8F6BFFDA8D68FFDA8B65FFD98962FFD7845BFFD2784CFFCB6F42FFC9754BFFCB7A51FFC57248FFBC6439FFC16437FFCB6A3BFFCF6D3DFFCF6C3DFFCC683AFFC25F33FCBB5C2EE4C76432D0B75231C896352D5F5500000300000000000000000000000000000000000000000000000000000000000000008D332F36AB574EEEDB9F8AFFE9B39BFFEAB39AFFE9B097FFD38F7BFFC67C68FFE3AB90FFE3AA8EFFE2A88BFFE2A688FFE1A386FFE0A283FFE09F80FFDF9D7DFFDE9B7AFFDD9977FFDD9775FFDC9572FFDC926FFFDB916CFFDA8E6AFFD58B67FFD08763FFD1835CFFD18057FFCE7C53FFC6734AFFBD653AFFBF6336FFCA6A3AFFCE6C3CFFCC683AFFC25E32FCBA5C2EE4C76432D0C56033CCA03E2FA091303015000000000000000000000000000000000000000000000000000000000000000093332F40AE5D52F1DDA48FFFEAB69FFFEBB79EFFEAB49CFFE0A48DFFC07363FFE2AC93FFE6B299FFE5B096FFE4AD93FFE4AB91FFE3AA8DFFE2A78BFFE2A588FFE1A385FFE0A182FFDF9F7FFFDF9C7CFFDE9A79FFDD9877FFDA9674FFD79879FFDB9D7EFFDB9B7BFFD8916DFFD4855DFFCF7E55FFC7754CFFBD673CFFBF6336FFC86839FFCB6839FFC15E32FCBB5D2FE3C86532CFCA6633CCB04D30C394312E48000000010000000000000000000000000000000000000000000000000000000092322F4BB06257F4DFA995FFEBBAA3FFECBAA3FFEBB8A0FFE8B19AFFC37969FFDBA38EFFE9BAA3FFE8B8A1FFE7B59DFFE6B39BFFE6B298FFE5AF95FFE4AD92FFE4AB8FFFE3A98CFFE2A68AFFE2A487FFE1A283FFDE9F81FFDAA084FFDDA589FFE0A68AFFE0A689FFDFA386FFDC9E7DFFD8916EFFD2845DFFC8774FFFBE683DFFBD6235FFC46436FFC05D32FCBC5D2FE2C86532CFCB6633CCC05C32CC9C3A2F8CA22E2E0B000000000000000000000000000000000000000000000000000000008E322F56B5685DF5E1AD9AFFECBEA8FFEDBDA7FFECBBA4FFEBB8A1FFD08D7BFFD0907FFFEBC1ACFFEAC0ABFFE9BDA8FFE8BBA5FFE8B9A3FFE7B7A0FFE6B59DFFE6B39AFFE5B097FFE4AE94FFE4AC92FFE1AA8EFFDEA98FFFE0AD94FFE2AF96FFE2AE94FFE2AD92FFE1AA8FFFE0A98CFFDFA68AFFDDA182FFD89574FFCE8560FFC16F46FFBB6135FFBA5B30FCBB5D2FE2C86532CFCB6633CCC96433CCAA462FBB91322D330000000000000000000000000000000000000000000000000000000092353260B86E63F8E3B29FFFEEC2ACFFEEC1ABFFEEBEA8FFEDBCA5FFDEA490FFC47E6FFFEAC3B1FFEDC7B5FFECC5B2FFEBC3AFFFEBC1ADFFEABFAAFFE9BDA7FFE9BBA5FFE8B9A2FFE7B69FFFE5B49CFFE2B39CFFE3B69FFFE5B7A0FFE6B79FFFE5B59DFFE4B49BFFE4B198FFE3AF95FFE2AE93FFE1AC91FFE0A98EFFDEA589FFD89B7DFFCB8665FFBE6E49FCBC653BE7C86736D2CB6633CCCB6633CCBC5731CA9A362F75993333050000000000000000000000000000000000000000000000009534326ABC756AFAE5B6A4FFEFC5B0FFEFC4AFFFEEC2ACFFEEBFA9FFE8B7A1FFC37C6DFFE0B3A4FFEFCEBEFFEFCDBCFFEECBB9FFEEC9B7FFEDC7B4FFECC5B1FFEBC3AFFFEBC1ACFFE9BEA9FFE5BCA8FFE6BEABFFE9C0ACFFE7BEA9FFE9BEA8FFE8BCA6FFE7BAA4FFE6B8A1FFE6B69FFFE5B49CFFE4B39AFFE3B097FFE2AE95FFE1AC91FFDCA68CFFD2997EFECA8C6EF3CF8864E2D28056D6D07445D0C9673ACEA64431AF92362E2100000000000000000000000000000000000000000000000095343274C07B71FCE7BBA9FFF0C8B4FFF0C7B3FFF0C5B0FFEFC3ADFFEEC0A9FFD89D8BFFC37F72FFE1B5A5FFEECDBEFFF0D0C1FFEFD0C0FFEFCEBEFFEECCBBFFEDCAB9FFECC8B6FFE9C6B4FFE9C7B6FFECC8B7FFEAC5B3FFE8C2AEFFEAC2AEFFEAC3AFFFE9C1ADFFE8BFAAFFE7BDA8FFE7BBA5FFE6B9A3FFE5B7A0FFE5B69EFFE4B49BFFE2B198FFDFAC93FFD7A289FBD19A7EF1D79B7DE6DB9B7ADEDB9571D9BE6C52CF9636315D7F00000200000000000000000000000000000000000000009436327FC38378FFE9C0AEFFF1CCB9FFF1CAB7FFF1C8B4FFF0C6B1FFEFC4AEFFEDBFA9FFDAA08EFFC47D6FFFC68476FFCF9587FFD7A396FFE0B3A4FFE6BFB0FFEAC7B7FFEBCBBCFFECCFC0FFEFD0C2FFEDCEBFFFEBCAB9FFEDC8B6FFECC6B4FFEDC7B4FFECC8B6FFEBC6B3FFEAC4B0FFEAC2AEFFE8C0ACFFE8BEAAFFE7BCA7FFE7BBA5FFE5B9A2FFE4B69FFFE1B29AFFDAA991FCD6A187F3D9A186E9DFA486E1D79579DBA44A3FA18C333314000000000000000000000000000000007F00000296393589C7897EFFEBC4B3FFF3CFBDFFF3CEBBFFF2CCB8FFF1C9B5FFF0C7B2FFEFC5B0FFEEC1ACFFE9B9A3FFE0A895FFD69A87FFCE8C7BFFC78171FFBD776AFFB7796FFFBF8980FFCF9C92FFD6A79CFFDCB3A5FFEAC6B6FFEFCFBFFFEECCBBFFEECAB9FFEECCBAFFEECDBCFFEDCBBAFFECC9B8FFEBC7B5FFEAC5B3FFEAC4B1FFE9C1AEFFE8C0ACFFE8BEA9FFE6BBA6FFE4B8A2FFDEB29AFCD9A991F4DBA88EEBDFA88DE3BB6D5BCB93352E47000000010000000000000000000000007F3F3F04973C3894CA8F84FFECC8B7FFF4D3C1FFF3D1BFFFF3CFBCFFF2CCB9FFF1CAB7FFF0C8B4FFF0C5B1FFEFC3AEFFEEC0AAFFEDBEA7FFECBBA4FFE5B39DFFC8A394FFBDAEABFFDBCBCAFFCFB6B5FFB88F8AFFC5867AFFC8887AFFE8C3B3FFEFCEBFFFEFCDBDFFEECDBDFFEFCFC0FFEFD1C2FFEED0C0FFEDCEBDFFECCCBBFFECCAB9FFEBC8B7FFEAC7B5FFEAC5B2FFE9C3B0FFE8C0ADFFE6BEA9FFE1B7A2FDDBAF99F6DDAE96EDD2967FE0A0453C8C8B2E2E0B0000000000000000000000009124240798403B9FCD968AFFEECCBCFFF5D6C5FFF4D4C3FFF3D2C0FFF3D0BDFFF2CEBBFFF2CBB8FFF1C9B5FFF0C6B2FFEFC4AFFFEEC1ACFFEABCA7FFD0AD9CFFBFB6B2FFE3E3E3FFE9EAEAFFCBC6C3FFE4C8B9FFEFC5B2FFCD8B7AFFC67C6CFFEDC9BCFFF1D3C5FFF0D1C3FFF0D1C3FFF1D4C5FFF1D6C8FFF0D4C6FFEFD3C4FFEED1C2FFEECFC0FFEDCDBDFFECCCBBFFECCAB9FFEBC8B6FFEAC6B4FFE8C3B0FFE4BEABFDDEB6A2F7DCAE99EEB26557C78E322D320000000000000000000000007F33330A9B423FA9D19C91FFF0D0C0FFF6D9C8FFF5D7C6FFF5D5C3FFF4D3C1FFF4D0BEFFF3CEBBFFF2CCB8FFF1CAB6FFF0C7B3FFEDC3AEFFD5B3A2FFBFB5AFFFE0E0DFFFECECECFFCDC9C7FFE2CABDFFF3CFBCFFF1CAB6FFDB9479FFC65E46FFCD887AFFEDCBBDFFF2D6CAFFF2D6CAFFF1D6C9FFF2D8CBFFF2DACDFFF2D9CCFFF1D7CAFFF0D5C8FFF0D4C6FFEFD2C4FFEED1C2FFEECFBFFFEDCDBDFFECCBBBFFEAC8B7FFE6C3B1FEE3BDAAF8C99080E5983E37776633330500000000000000007F2A2A0C9C4541B3D4A397FFF1D3C4FFF7DBCCFFF6DACAFFF6D8C7FFF5D5C5FFF4D4C2FFF3D1BFFFF3CFBCFFF2CDBAFFEFC9B5FFDAB8A8FFBEB3ADFFDCDCDBFFEEEFEFFFCFCDCCFFE0CBC0FFF4D4C2FFF3CFBCFFF1CAB6FFDE9478FFE87C59FFCD654DFFC26C5BFFCA8577FFD0978AFFDAA597FFE1B4A7FFE7C4B7FFEED1C5FFF1D8CDFFF1D9CEFFF1D9CDFFF1D9CCFFF0D7CAFFF0D5C8FFEFD3C6FFEED1C3FFEDCFC1FFEBCDBDFFE9C9B8FBE2B9A8ECAF5E53B48F2F2F2000000000000000009136240E9F4843BDD8A99EFFF3D7C8FFF8DECFFFF7DDCDFFF6DACBFFF6D8C8FFF5D7C6FFF4D4C3FFF4D2C0FFF2CFBDFFDFBFB0FFC0B3ADFFD8D8D7FFF0F1F0FFD2D1D0FFDCCCC2FFF5D7C7FFF5D4C2FFF3CFBDFFF0C7B3FFD47E5EFFDD7A58FFE07D5DFFD37C63FFD6A195FFCB8C7FFFBF5038FFBB4D39FFB85441FFBC6B5BFFC58479FFCE9B91FFD3A49BFFD9AFA5FFE1BCB0FFE6C6BAFFEBCDC1FFEDD1C4FFEED3C6FFECD1C3FDEDCFC1F4EDCEBFEDCC9082D99638355F7F00000200000000872D2D11A14B46C7DBB0A4FFF4DACCFFF8E1D2FFF8E0D1FFF8DECEFFF7DBCCFFF6D9C9FFF5D7C7FFF4D4C3FFE4C6B7FFC1B4ADFFD4D3D3FFF1F1F1FFD6D5D5FFD9CCC4FFF6DCCCFFF6D9C8FFF4D5C3FFF2CEBCFFD1B5ABFF7B808FFF537EA3FF5281A8FF86A7C1FFE0E5EAFFE2A38EFFDE633EFFDB5A36FFD3502DFFC95735FFD38267FFDCA799FFDABCB9FFCCAAA7FFC59C99FFC08F8CFFC08C86FFBE8983FFBC867DF5C68F84E2D4A195E0DCB1A3E5CF9789DE9B403A7E7F3F3F04000000008C332614A14D48CDDCB2A7FFF4DCCEFFF9E3D5FFF8E2D3FFF8E0D1FFF7DECFFFF7DCCCFFF6DACAFFE8CEBEFFC5B7AFFFD0CFCEFFF1F1F1FFDADADAFFD5CBC5FFF6DED0FFF7DDCEFFF6D9C8FFF4D4C2FFE1A994FF8F7B84FF3495D5FF2A93D9FF248CD4FF2384C9FF709FC2FFD68267FFE7714CFFE16642FFDC5C37FFD2522DFFD47A58FFE2987AFFEEC7B6FFF2EFEDFFE6E5E5FFE0DDDDFFD3CCCCFFB3A6A6ED896866848B34314D9639365D9E413D749D423C7696342E2C00000001000000008833330F9F4844BBD7AAA0FFF3DBCEFFFAE5D7FFF9E4D6FFF9E2D4FFF8E0D2FFF8DFD0FFF3DACBFFCFC0B7FFCBC9C8FFEFEFEFFFDFDFDFFFCFC9C4FFF5E1D4FFF8E1D2FFF7DDCEFFF6D9C8FFE8BEABFFC2634CFF75758AFF379EDFFF329ADDFF2C93D9FF258DD5FF3380B9FFC67A64FFEF7E5AFFE9734EFFE26642FFD45D38FFD88462FFDF9373FFE8AF97FFF4EEEAFFE6E6E6FFDBDBDBFFBFBFBFF293939387454545160000000100000000AA5555037F3F3F040000000000000000000000007F1F1F08993F3CA0CD978FFFF0D6CAFFF9E6D8FFFAE6D9FFF9E5D7FFF9E3D5FFF9E1D3FFF0DACDFFC6C0BDFFDCDCDCFFF4F4F4FFE3E3E3FFCDC8C5FFEFDDD1FFF8E1D3FFF7DDCEFFF6D9C9FFDB9C85FFBC4C35FF816671FF3493CEFF3AA1E2FF339BDEFF2C94DAFF3088C6FFB67766FFE57852FFE3744FFFD76B47FFD67E5CFFE09676FFE6AA90FFF4E5DFFFE9E9E9FFDEDEDEFFC2C2C2F6969696954B4B4B1B00000001000000000000000000000000000000000000000000000000000000000000000192333059B6726BF4E9CABFFFF8E3D7FFFAE8DBFFFAE6D9FFFAE5D7FFF9E4D6FFF8E1D3FFE6D4CAFFCAC6C4FFE4E3E3FFF6F6F6FFE6E5E6FFCEC8C5FFEAD8CDFFF7DDCEFFF3D7C6FFD88B71FFC35137FF9F4F49FF4B7598FF3094D1FF38A0E1FF339BDFFF3D89BEFFB66F59FFD47D5CFFDC8F70FFDE9576FFE29B7CFFE6A88EFFF4E2DAFFECEBEBFFE0E0E0FFC7C7C7F99D9D9DA4545454240000000200000000000000000000000000000000000000000000000000000000000000000000000094352A18A34D49C5D8ADA4FFF4DED2FFFBE9DCFFFBE8DBFFFAE7DAFFFAE6D9FFF9E4D6FFF8E2D4FFE9D7CCFFCCC7C3FFE1E1E1FFF7F6F7FFE9E9EAFFCDC9C6FFE6D3C7FFF3D6C5FFDC9379FFD36240FFAD4739FF9D544FFF696A7FFF577EA4FF667E9FFF8C8590FFDEA68DFFE6A88DFFE6A589FFE4A083FFE6A78DFFF4DFD5FFEEEDEDFFE2E3E2FFCACACAFC9E9E9EB65A5A5A2D00000002000000000000000000000000000000000000000000000000000000000000000000000000000000005555000394383671BD7B75F9E9CABFFFF5E0D4FFF8E5D8FFF9E6D9FFFAE6D9FFF9E5D8FFF9E4D6FFF9E3D5FFEDDACEFFCEC7C3FFDCDCDCFFF5F5F5FFECECECFFCDC9C8FFE1CEC2FFDFA891FFE17752FFDE7152FFB54A37FFAF4738FFB54E3DFFC0634DFFDC9F86FFE8AF95FFE7AA8FFFE6A589FFE6A98EFFF3DBD0FFF0EFEEFFE5E5E5FFCFCFCFFDA3A3A3C36060603A0000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090303025A04945CDC58B83FEDFB9AFFFE7C7BCFFEBCEC2FFEED3C7FFF0D6C9FFF2D8CCFFF3DACDFFF3DACDFFE9D0C4FFC9BDB8FFD8D6D6FFF3F3F3FFEFEFEFFFCFCCCAFFD5B7A9FFD58161FFDA7855FFD76C48FFD46A4AFFCE7357FFE0A289FFEAB49BFFE9AF96FFE7AA8FFFE7AA90FFF3D7CBFFF3F1F0FFE7E7E7FFD3D2D3FEACACACCB6C6C6C4200000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005555550392302D449A3F3CB9A65550DAAE645EE8B7726BF2BE8178FBC68E85FECF9B93FED7A99FFFDBB0A5FFD9ACA1FFC08A82FEAD8F8EEAD2D1D2F7F1F1F1FFF1F2F1FFD1CFCEFFD4BDB1FFE4B9A5FFE3AF99FFE4B19BFFEABAA4FFECBAA2FFEAB59CFFE9AF96FFE8AE94FFF3D3C6FFF4F2F0FFE9EAE9FFD8D7D7FEB0B0B0D67777774D242424070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F0000028D2A2A129431311F91322D339030304A93342F619639377D9A403C9B9E4641B6A24F4ACAA4514BD8993F3BB5874A474FB4B2B486CFCFCFF0EEEEEEFFF2F2F2FFD4D2D1FFD5C2B9FFEEC8B5FFEFC5AFFFEEBFA9FFECBAA3FFEBB59DFFE9B299FFF2D1C3FFF6F3F1FFECECECFFDCDCDBFEB5B5B5DF7C7C7C5A1C1C1C090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055000003993333059933330A902C2C178E2D2D228F2F2F107F000002AAAAAA0CB5B5B573CACACAEBEBECECFFF3F3F3FFD7D6D6FFD1BFB7FFEBC3AFFFEEBFA9FFECBAA3FFEBB69EFFF1CFBFFFF7F3F0FFEEEEEEFFE0E0DFFFBABABAE6868686682727270D0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
)
IconData2 =
(join
0000A9A9A909B4B4B467C7C7C7E5E8E8E8FFF3F3F3FFDBDADAFFCEBEB6FFE8BEABFFEDBBA4FFF1CDBDFFF8F2EFFFF0F0F0FFE3E3E4FFBFBFC0EC8B8B8B773C3C3C11000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AAAAAA06B4B4B455C4C4C4D9E4E4E4FEF2F2F2FFDEDEDEFFCCBDB7FFEBCCBDFFF9F2EEFFF2F2F2FFE7E6E6FFC4C4C4F1929292863C3C3C150000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AAAAAA03B2B2B243C0C0C0CFDFDFDFFEF2F2F1FFE6E6E6FFF1EFEEFFF4F4F4FFE9E9EAFFC9C9C9F6989898954B4B4B1B000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F7F02B2B2B239BEBEBEC5DCDBDBFDF0F1F1FFF3F3F3FFECECECFFCECECEF99E9E9EA457575723000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFF01B1B1B12EBABABAB7D6D7D7FBE6E6E6FFD2D2D2FBA2A2A2B16262622C0000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFF01B1B1B121B7B7B7A5C3C3C4F5AAAAAABB666666340000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ADADAD19B0B0B07591919131000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C03FFFFFFFFFDB06C003FFFFFFFFDB0680003FFFFFFFDB06800003FFFFFFDB068000001FFFFFDB0680000001FFFFDB06800000001FFFDB068000000007FFDB068000000003FFDB068000000003FFDB068000000001FFDB068000000001FFDB068000000001FFDB068000000000FFDB068000000000FFDB0680000000007FDB0680000000007FDB0680000000003FDB0680000000003FDB0680000000003FDB0680000000001FDB0680000000001FDB0680000000000FDB0680000000000FDB06000000000007DB06000000000007DB06000000000007DB06000000000003DB06000000000003DB06000000000001DB06000000000001DB06000000000001DB06000000000027DB0600000000007FDB060000000000FFDB068000000001FFDB068000000003FFDB06C000000007FFDB06C00000000FFFDB06E00000001FFFDB06FF8000003FFFDB06FFFF80003FFFDB06FFFFC0007FFFDB06FFFFE000FFFFDB06FFFFF001FFFFDB06FFFFF803FFFFDB06FFFFFC07FFFFDB06FFFFFF0FFFFFDB06
)

loop 2
 {
  IconData := ( IconData IconData%a_index% )
  IconData%a_index% =
 }
WriteFile( A_ScriptDir "\PictureInBlueFolder.ico" ,IconData)
IconData =
}
ifnotexist, %A_ScriptDir%\PictureOnFolder.ico
{
IconData1 =
(join
0000010001003030000001002000A825000016000000280000003000000060000000010020000000000080250000000000000000000000000000000000000000000000000000000000000000000100000004000000070000000500000002000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000031111110F1818122A0F0F0A3207070024000000150000000B00000006000000030000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020D0D0D1348484871716D69C85F4F3BC94B3B28A2352C21721F1B14490B0B052B000000190000000E000000080000000300000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000B3131314E777777E4B4B3B3FF7B7163FF76624AFD7A6750F46B5944DD594A37B946392A8A2F261E5C161612380707072000000012000000090000000500000002000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050000001C3A3A3A8C878787FDAEAEAEFF75706AFF7E6B55FF907C68FF8E7B66FF8A7661FE816E57FA74624BEC63533ECF524431A43D3425742A231C4812120C2A000000170000000C00000006000000020000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000027393939988B8B8BFEB0B0B0FF746F69FF7D6B55FF8D7A65FF8D7A65FF8E7B66FF8F7C67FF8F7C68FF8D7A65FF86735DFE7C6952F66E5C47E25D4F3BBE4B3E2E8E3830235E201B17370808081D0000000F0000000800000003000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070000001B4242428A959595FEBFBFBFFF7B7771FF806E59FF907E69FF8F7C68FF8E7B67FF8D7A66FF8D7A65FF8E7B66FF8E7B67FF8F7C68FF8F7B67FF8B7762FF837059FC77654DEF685742D4584B37AA463B2C773029224A191913280C0C0C140000000A00000005000000020000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000021C1C1C094E4E4E7C969696FEC1C1C1FF7E7A74FF84725DFF978571FF968470FF95826EFF93806CFF917E69FF8F7C68FF8E7B67FF8D7A66FF8D7A65FF8D7A66FF8F7B67FF8F7C67FF8D7A65FF88745FFE7E6A54F8725F49E663533DC35345349341372A612D241F381212121C0000000E00000007000000030000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005555550350505079909090FEBCBCBCFF7D7872FF85735EFF9A8874FF998773FF998772FF988672FF978571FF96846FFF94826EFF927F6BFF8D7A67FF887663FF887662FF8A7763FF8C7965FF8D7A66FF8F7C67FF8F7C67FF8C7863FF84705AFD796650F26B5A45DA5E4F3BB04E41317C3C35284C26261F280D0D0D1300000009000000040000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F7F024F4F4F7A898989FEAFAFAFFF75716BFF84725DFF998773FF9A8874FF9A8974FF9B8975FF9A8874FF998873FF988672FF96836FFF8A7967FF7D6E5EFF7A6A5AFF7F6F5DFF837260FF877561FF897763FF8B7864FF8C7965FF8E7B66FF8F7C68FF8E7B66FF897660FE806D56FA74624BEA675741CA584B399B4B3E2F663430273A241B1B1C0000000C000000060000000200000001000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F7F025050507C919191FEB7B7B7FF77726DFF84735DFF988773FF988772FF988672FF998773FF998873FF9A8874FF998873FF958470FF998D80FFBAB5B0FF989089FF7E7469FF74675AFF766758FF7B6C5BFF81715EFF867461FF897663FF8B7864FF8C7965FF8E7A66FF8E7B67FF8E7B66FF8C7963FF86715BFD7B6951F56F5E47DE62523EB754473684463C2F50302A242A1A1A0D13000000080000000300000001000000000000000000000000000000000000000000000000000000007F7F7F024F4F4F7D989898FEC4C4C5FF7F7B75FF887862FF9E8E7AFF9C8C78FF9A8A76FF998874FF988773FF988772FF988672FF93836FFFA3998DFFEAE9E8FFB7B6B5FFC6C5C4FFC0BDB9FFA39E97FF877E75FF756A5EFF746658FF7B6C5BFF82715FFF867562FF897764FF8A7864FF8B7965FF8D7A65FF8E7B66FF8F7C67FF8E7B65FF8A7660FF826E57FB77654DED6B5A43D05E503DA25044366C423A2D3D2B2B231D1515150C000000050000000200000001000000000000000000000000555555035050507E979797FEC5C5C6FF807C76FF8C7B66FFA59481FFA49380FFA3927FFFA1907DFF9E8E7AFF9C8B78FF9A8975FF958470FFA4998EFFCCCBCBFF29292AFF303033FF5D5E5FFF919192FFB9B8B8FFC0BEBCFFA49F9AFF837B72FF72675AFF716455FF786A5AFF7F6E5DFF847361FF887663FF8A7864FF8C7965FF8C7965FF8D7A66FF8F7B67FF8F7C67FF8D7964FF87745DFE7D6B53F7726048E4675740BE5A4D3B8A42372649251E16221111000F000000060000000100000000555555034F4F4F808D8D8DFEBABABAFF7C7872FF8D7C67FFA79784FFA79683FFA69683FFA69582FFA59581FFA49480FFA2927EFF9D8C79FFA99F93FFCCCCCEFF1F212CFF0B1226FF0B1125FF0F1426FF1F222DFF484B54FF87888CFFB5B4B6FFBCBAB9FFA5A09BFF867E76FF72685DFF6E6254FF766858FF7E6E5DFF837260FF867462FF887663FF8A7864FF8C7965FF8D7A66FF8E7B67FF8F7C67FF8F7B66FF8B7762FF816D55FB655037DB59462CB653412A84382D1E320000000800000000555555034E4E4E828B8B8BFEB3B3B3FF77726DFF8B7B66FFA59683FFA69683FFA79784FFA89885FFA89784FFA79784FFA69683FFA39280FFAFA59AFFCCCED1FF212638FF0D1A3DFF0E2255FF0E2253FF0B1636FF0B163BFF101838FF252E4BFF4D556AFF848691FFB2B2B9FFC0BFC0FFA49F9AFF7A7268FF675C51FF685C4EFF6F6253FF766858FF7E6F5EFF857462FF897764FF8B7865FF8C7966FF8D7A66FF8E7B67FF897762FE68553DDD5E482FCD604930CF5B472C99372C161700000000555555034F4F4F83969696FEC0C1C1FF7C7772FF8E7D69FFA79886FFA69784FFA69684FFA69683FFA69684FFA79784FFA79785FFA69583FFB3A99DFFCDCFD2FF242C47FF0F1F48FF102A64FF123376FF12377AFF11377DFF112D67FF113072FF12387CFF0F204EFF191F43FF404662FF7E808FFFB2B2B5FFB2AFADFF928D86FF726A61FF62594DFF64594CFF6D6152FF766859FF7E6F5EFF857462FF8B7966FF8E7B68FF8B7763FD6F5A40D5664E33BD674E32BC664D31A45A41291F0000000055555503505050859A9A9AFEC9C9C9FF827E78FF93836FFFAFA18FFFAD9E8CFFAC9D8BFFAA9B89FFA99A88FFA89987FFA89886FFA69784FFB4AB9EFFCDCED3FF242A41FF111B3AFF10224FFF102E6EFF124190FF1353ACFF1663BEFF196EC6FF1C6DBDFF1D5DA5FF183577FF204885FF142A5CFF232841FF4F5159FF8A8A8CFFB2B2B1FFAAA7A3FF7F7872FF635A50FF5E5448FF64584CFF6D6152FF7E6F5EFF8F7D6BFF917D69FD745F44D06C5335B56C5335B56A5334A5604B302500000000555555034F4F4F86989898FEC8C8C9FF837E79FF998B77FFBBAF9EFFBBAE9EFFBAAE9DFFBAAD9CFFB8AB9BFFB6A999FFB3A796FFB0A392FFBBB2A7FFCED4E4FF264891FF123B86FF113676FF0F3170FF0F357EFF104399FF125BB8FF187BD5FF2398E5FF41B0E6FF80BBDCFF67BFE3FF2683C8FF134482FF070E23FF090E18FF1C1F23FF4A4C4DFF8E8E8EFFB0AEACFF96918CFF6F675EFF61574DFF736657FF8E7D6AFF93816CFD766247D06F5636B36F5536B36B5434A65D492E2600000000555555034F4F4F878E8E8EFEBBBBBBFF7D7873FF9C8E7BFFC0B5A5FFBFB5A5FFBFB3A4FFBEB2A2FFBDB1A1FFBCB09FFFBBAF9EFFB8AC9CFFC2B9AEFFCFDBEDFF2C6AC0FF1867CAFF156DCFFF146CCCFF146DC7FF1369C1FF1368C3FF1676D1FF1F93E4FF3EB8F0FFA4E6F7FF7DD9F4FF36B0EDFF208AD8FF123F75FF103C76FF09142AFF090F21FF0F1016FF373839FF787979FFABABAAFFB5B1AEFF8B8275FF8E7D6BFF95836EFD796348D0705836B3705636B36D5434A65D492E2600000000555555034E4E4E89909090FEB9B9B9FF79756FFF9A8D7AFFBEB4A4FFBEB4A3FFBEB3A4FFBEB3A4FFBFB3A3FFBEB3A2FFBDB2A1FFBDB0A0FFC5BDB2FFD1DFEFFF347CCBFF247ED6FF2186DDFF2190E3FF1F94E7FF1C99EAFF1FA1EDFF29AEF0FF38BAF2FF52C8F4FF7FDEF9FF5DCCF4FF2CA7EBFF1F8FE3FF197AD1FF124989FF113A70FF12428AFF0D2D68FF0B1D42FF0F1625FF303438FFC3C4C3FFA0978CFF8F7E6CFF93826CFD7A6449D0715937B3715837B36D5635A65D492E26000000003F3F3F044F4F4F8A9A9A9AFEC9C9C9FF817C77FF9D907DFFC0B6A7FFBFB5A5FFBEB4A5FFBDB3A3FFBDB2A2FFBDB1A2FFBDB2A2FFBDB2A1FFC6BFB4FFD1D7E3FF355992FF2766ADFF2C83CEFF3098DFFF34A5E9FF36ADEFFF39B5F1FF46C7F8FF61D7F8FFA5EBFBFFC6F3FCFF8CDEF8FF2DA6E8FF1885DBFF1359B0FF103375FF1256ACFF135AB8FF1150AEFF104097FF0F2E6EFF283654FFC8C9CCFF9D9286FF968673FF978671FD7D684DD0745C3AB3735B38B36E5735A664502E26000000003F3F3F045050508B9D9D9DFECECECEFF86817CFFA19482FFC8BEAFFFC6BCADFFC4BAABFFC2B8A8FFC0B5A6FFBEB4A4FFBCB1A1FFBBB09FFFC5BEB3FFD1D4DBFF35496FFF264B81FF2A66A9FF3281C5FF3792D5FF40A7E5FF4DBBF1FF60CEF7FF83E1F9FFB2EBF6FFD4F2F8FFCBEFFAFF57B6E9FF1C8FDFFF1459ACFF1254AEFF114DABFF0F4099FF0F3C91FF0F3C8EFF113A89FF2E4C89FFCFD3DDFFA09588FF9E8E7BFF9E8D78FD816E53D07A6241B3796040B3715A3AA664502E26000000003F3F3F044F4F4F8D999999FECBCCCCFF85817BFFA39784FFCAC2B3FFCAC1B1FFC8BFB0FFC7BEAEFFC6BCADFFC4BAABFFC1B7A8FFBFB5A4FFC6C0B4FFD0D2D7FF313F59FF233C64FF28538CFF367BB9FF4BA2DDFF58B8EBFF64C6F3FF6FD0F8FF85DCF9FFA4E4F5FF94DEF2FF67C8F0FF59B1E6FF2678C6FF1D6CBAFF1A75C9FF1768C2FF1466C8FF1149A7FF0F3684FF0F2862FF31426CFFD5D7DCFFA2978AFFA1917EFFA1917CFD857258D07E6948B37D6747B3765F40A664502E26000000003F3F3F044F4F4F8E909090FEBDBDBDFF7D7973FFA29683FFCBC3B4FFCBC3B3FFCAC2B3FFCAC1B1FFC9C0B0FFC7BEAFFFC7BDAEFFC5BBACFFCBC5BAFFD0D1D4FF30384BFF202D4BFF213864FF264D85FF316DACFF4593CEFF59B2E5FF6CC6F1FF72CCF3FF5EB0DFFF54A5D9FF439FDBFF3D9BD9FF2C6AAFFF225DA1FF1D518EFF1D5899FF1C63ACFF186BC0FF146DCAFF1150A4FF314C80FFD7D9DEFFA3988AFFA1927EFFA1927DFD89755BD0846D4EB3836C4CB37A6345A664503526000000003F3F3F044F4F4F90959595FEC0C1C1FF7D7873FFA29583FFC9C1B2FFC9C1B2FFC9C1B2FFC9C1B2FFCAC2B2FFCAC1B1FFC9C0B1FFC8BFAFFFCDC7BCFFD0D0D3FF323645FF20283FFF213155FF223D6FFF234A82FF285C9CFF2F72B5FF3C8DCDFF4DA4DDFF4893CCFF2661ACFF1749A1FF1E52A3FF143478FF142D64FF285E94FF2B6696FF3087BEFF2998E1FF1E91E3FF197ED8FF337ACBFFD3DEEAFFA89E91FFA29380FFA0917CFD8B785FD0887355B3877154B37D6849A664503526000000003F3F3F044F4F4F909E9E9EFED1D1D1FF86827CFFA59987FFCDC6B7FFCBC4B5FFCAC3B4FFC9C1B2FFC9C0B1FFC8C0B0FFC8BFB0FFC8BFB0FFCEC8BDFFD1D1D5FF33384CFF22293FFF202C48FF1F3153FF1F3661FF224278FF24508EFF275CA0FF2866ACFF296DB5FF24599DFF143172FF0D1F5CFF0D1848FF10193EFF182C52FF244C78FF265782FF27669FFF2888CFFF2893E1FF3B95DDFFD0E1EEFFB2A89AFFAA9C88FFA69784FD8F7D64D08D7759B38B7658B3816B4CA664503526000000003F3F3F044F4F4F919E9E9EFED4D4D5FF898580FFA79C89FFD3CCBDFFD1CBBBFFD0C9BAFFCEC6B8FFCCC4B5FFCAC2B3FFC8C0B1FFC6BEAFFFCCC7BCFFD1D1D5FF353A4DFF232D48FF223050FF223359FF21335BFF213867FF213E74FF234B88FF235092FF215092FF19386FFF132A5CFF0C1438FF090D24FF0D1129FF0A0E1CFF182F4EFF3174A9FF3489C6FF3291D4FF339BE1FF449DE0FFCEE1EFFFB7AEA1FFAFA18EFFAC9D8AFD938169D08F7B5EB38F7A5EB3846E51A664573526000000003F3F3F044F4F4F91969696FECECECEFF8A8884FF9D9180FFD6CFC1FFD4CEBFFFD3CDBEFFD2CBBDFFD1CABBFFD0C9B9FFCEC7B7FFCBC3B4FFCEC9BEFFE8E8E8FF999BA0FF5F636EFF3A4357FF273455FF1F2F51FF1F3159FF203666FF224077FF234986FF245291FF275A9DFF214B89FF0F1833FF090A14FF0D1222FF172E50FF13203CFF235086FF2F7EC3FF3089D0FF2F88D1FF4191D4FFC9DDEDFFBBB2A6FFB1A491FFAEA18DFD96856DD0948163B3928062B3877154A664573526000000003F3F3F044F4F4F91929292FEC9C9C9FF969695FF797063FFBAB1A3FFD3CDBFFFD6CFC1FFD5CEC0FFD4CDBEFFD2CBBCFFD1CABBFFD1C9BAFFCDC7B8FFD2CDC3FFDBD8D2FFE0DFDCFFD1D1D3FFABAEB6FF7A8091FF4A556DFF2B3A5CFF21345CFF273F6DFF224075FF234883FF204580FF121E39FF0C1019FF10182AFF204272FF24528AFF2964A3FF317DC6FF2D79C5FF2971BDFF3A7EC3FFC4D8E9FFBCB4A9FFB0A390FFADA08DFD998970D0988569B3978467B38A7659A66B573526000000003F3F3F04505050929B9B9BFEDADADAFFC3C3C3FF93918FFF847C70FF918677FFA09585FFB5AC9DFFC8C1B3FFD2CCBEFFD4CEC0FFD3CDBEFFD2CBBCFFD0C9B9FFCDC6B6FFCBC4B5FFCDC7BBFFD5D0C8FFDFDCD8FFDCDCDCFFC2C5CDFF949AA9FF7E879AFF6D7C95FF4D6286FF354E7AFF273E6AFF182744FF162544FF20427AFF255696FF2C6CB4FF2E74BFFF2C72BEFF286AB4FF356EAFFFC2D1E3FFC1BAAFFFB2A693FFADA18EFD9B8B73D09B886DB39B886DB38D795CA66B573526000000003F3F3F0450505092A1A1A1FEE9E9E9FFE6E6E6FFDBDBDBFFCCCBCBFFB9B8B7FFA29F9CFF8D8880FF877D72FF908576FFA69B8CFFBEB5A6FFCCC6B7FFD2CCBEFFD2CCBCFFD1C9B9FFCFC8B7FFCCC5B4FFC9C2B2FFCAC3B5FFCEC9BEFFD4D1CBFFE3E2E1FFE5E6E8FFD1D5DCFFAFB6C5FF8A97AFFF657491FF495C7FFF365285FF22427AFF204684FF26579CFF265CA3FF25589CFF2E558FFFBBC6D5FFC8C1B7FFBAAF9CFFB5A996FD9F9078D09F8E71B39E8D71B3907D60A66B573C26000000003F3F3F04505050929F9F9FFEE9E9E9FFEAEAEAFFEAEAEAFFEAEAEAFFE9E9E9FFE4E4E4FFDADADAFFC8C8C8FFB1B0AEFF999590FF898178FF897F71FF9B9081FFB4AA9BFFC8C1B2FFD0C9BAFFD0C8B8FFCFC8B7FFCFC7B6FFCDC5B4FFCAC3B5FFDDDAD0FFE4E1DAFFE9E6E2FFEEECE9FFECEDEEFFDFE2E7FFC2C8D4FF95A0B4FF425479FF1E325CFF172E59FF183362FF1A3265FF273B68FFB6BDC9FFCCC6BCFFBEB3A0FFB9AE9CFDA4957ED0A39277B3A29176B3918163A66B573C26000000003F3F3F044E4E4E92949494FEDADADAFFDFDFDFFFE4E4E4FFE8E8E8FFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFE9E9E9FFE2E2E2FFD4D4D4FFBEBDBDFFA3A09DFF8B867EFF847A6DFF9A8F7FFFC1BAABFFCDC6B6FFCDC5B4FFCDC6B4FFCCC5B5FFD8D2C7FFE0DBD1FFE3DED5FFE3DFD6FFE3DFD8FFE6E3DDFFEBE9E5FFE5E5E4FFCDD0D4FFAEB4C0FF788192FF465264FF26334BFF23304BFFB2B6BEFFCEC9BFFFBFB4A2FFBBB19EFDA69981D0A6977BB3A6977AB3958468A66B573C26000000003F3F3F044E4E4E92959595FED6D6D6FFD5D5D5FFD5D5D5FFD8D8D8FFDCDCDCFFE1E1E1FFE6E6E6FFEAEAEAFFECECECFFECECECFFECECECFFEBEBEBFFE6E6E6FFD9DADAFFBBBBBBFF8A8681FF837869FFC0B8A8FFCDC6B6FFCBC4B4FFCAC3B2FFC9C2B1FFCAC3B3FFCDC7B9FFD3CDC1FFDBD5CAFFDFDBD1FFE1DDD4FFDDD9D0FFCAC4B9FFD0CBC1FFDCD9D4FFDBDBDAFFC5C7CAFFA0A5ACFFD3D5D8FFD0CBC2FFBCB2A0FFB9AF9DFDA79B84D0AA9B80B3A9997EB399886BA66B5D3C26000000003F3F3F0450505092A0A0A0FEE8E8E8FFE3E3E3FFDEDEDEFFD9D9D9FFD6D6D6FFD6D6D6FFD7D7D7FFDADADAFFDEDEDEFFE4E4E4FFE8E8E8FFEBEBEBFFECECECFFEDEDEDFFE9E9EAFFCCCCCCFF8B8884FF8D8271FFCDC6B7FFD1CAB9FFCDC7B6FFCCC5B4FFCBC4B3FFC9C2B1FFC8C1AFFFC8C1AFFFC9C2B2FFCDC6B8FFD1CBBDFFC9C2B2FFC9C1AFFFC7BFAEFFC7BFB0FFCCC5B9FFD6D2CAFFE4E2DEFFD1CBC1FFC0B7A5FFBBB29FFDAA9E88D0AD9F84B3AD9F83B39B8B70A66B5D3C26000000003F3F3F044F4F4F93A2A2A2FEEEEEEEFFEEEEEEFFEEEEEEFFECECECFFE7E7E7FFE2E2E2FFDDDDDDFFD9D9D9FFD7D7D7FFD6D6D6FFD8D8D8FFDCDCDCFFE1E1E1FFE6E6E6FFEAEAEAFFE8E8E8FFC2C1C2FF827D76FFA19585FFD5CFC0FFD4CEBDFFD3CCBBFFD0CAB9FFCEC7B6FFCCC5B4FFCAC3B1FFC9C2B0FFC8C1AFFFC7C0AEFFC9C1AFFFCAC2B1FFCBC3B2FFCCC3B2FFCBC2B1FFC9C0AFFFC7BFAFFFC8C0AEFFC8C0ADFFC3BAA7FDAFA38BD0B0A388B3B0A287B39E8E73A6725D4326000000003F3F3F044E4E4E929D9D9DFEEBEBEBFFEEEEEEFFEFEFEFFFF0F0F0FFF0F0F0FFEFEFEFFFEEEEEEFFEBEBEBFFE7E7E7FFE2E2E2FFDDDDDDFFDADADAFFD7D7D7FFD8D8D8FFDADADAFFDDDDDDFFDBDBDBFFACACACFF7D746AFFB5AB9AFFD8D2C2FFD6D0BFFFD6D0BEFFD5CFBDFFD3CDBBFFD1CBB9FFCFC9B7FFCDC6B4FFCBC4B2FFCAC3B1FFC9C2B0FFC9C2AFFFC9C2B0FFCAC2B0FFCBC3B1FFCCC3B2FFCCC3B2FFCCC4B1FFC6BDABFDB1A790D0B4A88DB3B3A68BB3A19377A6725D4326000000003F3F3F044E4E4E92939393FEDADADAFFDEDEDEFFE3E3E3FFE9E9E9FFEDEDEDFFEFEFEFFFF0F0F0FFF0F0F0FFF0F0F0FFF0F0F0FFEFEFEFFFEBEBEBFFE6E6E6FFE1E1E1FFDCDCDCFFD9D9D9FFD7D7D7FFCACACAFF939190FF7D7365FFBCB4A4FFD6D1C1FFD7D2C2FFD7D1C0FFD6D0BFFFD6D0BEFFD5CFBDFFD4CEBCFFD2CCBAFFD0CAB8FFCEC8B6FFCDC6B4FFCBC4B2FFCAC3B0FFC9C2B0FFC9C1AFFFC9C1B0FFCAC2B1FFC6BEACFDB5AA94D0B7AC91B3B6AA8FB3A29579A6725D4326000000003F3F3F044E4E4E92969696FEDEDEDEFFDADADAFFD8D8D8FFD9D9D9FFDBDBDBFFE0E0E0FFE6E6E6FFEBEBEBFFEFEFEFFFF1F1F1FFF1F1F1FFF1F1F1FFF1F1F1FFF1F1F1FFEEEEEEFFEBEBEBFFE5E5E5FFDFDFDFFFC6C6C6FF949391FF81786CFF958B7BFFAFA697FFC4BDAEFFD2CCBCFFD8D2C2FFD7D2C0FFD6D0BEFFD6D0BEFFD5CFBDFFD4CEBCFFD3CDBBFFD2CCBAFFD1CAB8FFCFC8B6FFCCC5B3FFCBC4B1FFC9C2B0FFC4BDAAFDB5AC95D0BCB095B3BAAF95B3A5987DA6725D4326000000003F3F3F045151518A7F7F7FFED7D7D7FFEAEAEAFFE9E9E9FFE3E3E3FFDDDDDDFFDADADAFFD9D9D9FFDADADAFFDDDDDDFFE2E2E2FFE8E8E8FFEDEDEDFFF0F0F0FFF2F2F2FFF2F2F2FFF2F2F2FFECECECFFE8E8E8FFEAEAEAFFDFDFDFFFC6C5C5FFABA9A6FF948F88FF888075FF8D8274FF9E9483FFB6AD9EFFCAC3B3FFD4CFBFFFD8D2C1FFD7D1C0FFD6D0BEFFD5D0BEFFD5CFBDFFD4CEBCFFD4CEBCFFD3CCBAFFD0CAB8FFC9C2B0FDB7B09AD0BDB399B3BDB398B3A89C81A67264432600000000000000015E5E5E417B7B7BCE9A9A9AF7AEAEAEFEC2C2C2FFDADADAFFEAEAEAFFEDEDEDFFE8E8E8FFE2E2E2FFDEDEDEFFDBDBDBFFDADADAFFDCDCDCFFE0E0E0FFE5E5E5FFEBEBEBFFD3D3D3FAA4A4A4EFA8A8A8F8B3B3B3FEC6C6C6FFD9D9D9FFE5E5E5FFE4E4E4FFD5D5D5FFBFBEBDFFA5A29EFF908A82FF887F73FF918777FFA69C8CFFBDB5A5FFCEC8B9FFD6D0C0FFD7D2C1FFD7D1BFFFD6D0BEFFD6D0BEFFD5CFBDFFCFC8B7FDBBB49ED0C0B69EB3C0B69CB3AA9E84A67264432600000000000000005555550367676725848484609191919E9A9A9AD19F9F9FF0A8A8A8FDBBBBBBFFD1D1D1FFE5E5E5FFEEEEEEFFEDEDEDFFE7E7E7FFE1E1E1FFDDDD
)
IconData2 =
(join
DDFFDCDCDCFFCACACAF58A8A8A906D6D6D41878787629393939C9C9C9CCDA3A3A3EDA9A9A9FCB9B9B9FFCECECEFFDFDFDFFFE7E7E8FFE2E2E2FFD0D0D0FFB7B6B4FF9E9A95FF8D867DFF8A8073FF978D7DFFAEA595FFC4BCACFFD2CCBCFFD8D2C2FFD8D2C0FFD1CBB9FDBFB7A1D0C3BAA0B3C3B9A0B3ADA187A6726449260000000000000000000000000000000000000001484848075D5D5D1E7F7F7F488D8D8D82979797BD9E9E9EE5A4A4A4F9B2B2B2FFC8C8C8FFDEDEDEFFECECECFFEDEDEDFFD7D7D7F797979794636363120000000000000001484848076262621A797979418D8D8D75969696AFA0A0A0DAA7A7A7F3B0B0B0FDC1C1C1FFD6D6D6FFE5E5E5FFE9E9E9FFDFDFDFFFCBCACAFFB1AFADFF99948EFF8B8479FF8D8375FF9E9383FFB5AC9CFFC4BDAEFDBFB8A5D1C8C1A9B3C7C0A6B3AFA48BA478614B220000000000000000000000000000000000000000000000000000000000000000555555035A5A5A117373733386868668959595A49C9C9CD6A2A2A2F2AAAAAAFBA4A4A4F083838395686868160000000000000000000000000000000000000000000000007F7F7F025555550C6B6B6B267F7F7F528F8F8F8B9A9A9AC1A2A2A2E7ABABABF9B7B7B7FECACACAFFDFDFDFFFEBEBEBFFE9E9E9FFDADADAFFC4C4C3FFABA8A5FF958F88FF867C70FD7F715FCA9C8E79B7ADA28EBC97897382624E3A0D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000154545409696969228181814F848484756D6D6D4F4F4F4F1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003F3F3F0459595914717171368686866A959595A69F9F9FD5A7A7A7F1AFAFAFFDC1C1C1FFD5D5D5FFE7E7E7FFEEEEEEFFE7E7E7FFC8C8C8F97572706F695037296C5841426B583A1A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000154545409646464218181814B8E8E8E869B9B9BC0A3A3A3E8A8A8A8FBB3B3B3FFC5C5C5FFB6B6B6D781818135000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003F3F3F045D5D5D13747474398A8A8A78939393B0808080B36464644F3F3F3F04000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F7F025C5C5C0B5555550C7F7F7F020000000000000000000000000000000000000000E07FFFFFFFFFDB06C00FFFFFFFFFDB068001FFFFFFFFDB0600001FFFFFFFDB06000003FFFFFFDB060000007FFFFFDB0600000007FFFFDB0600000000FFFFDB06800000001FFFDB068000000001FFDB0680000000003FDB06800000000003DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06800000000000DB06C00000000000DB06F00008000000DB06FF001F800000DB06FFE03FF80001DB06FFFEFFFF000FDB06FFFFFFFFF00FDB06FFFFFFFFFE1FDB06
)

loop 2
 {
  IconData := ( IconData IconData%a_index% )
  IconData%a_index% =
 }
WriteFile( A_ScriptDir "\PictureOnFolder.ico" ,IconData)
IconData =
}
ifnotexist, %A_ScriptDir%\PictureOnWall.ico
{
IconData1 =
(join
0000010001003030000001002000A82500001600000028000000300000006000000001002000000000008025000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000000000000000000000000000000000000000000000000000000000000000000030000000F00000018000000190000001900000019000000190000001900000019000000190000001900000019000000190000001900000019000000190000001900000019000000190000001900000019000000190000001900000019000000190000001900000019000000190000001900000019000000190000001900000019000000190000001900000019000000190000001900000019000000180000000E000000020000000000000000000000000000000000000000000000002211110F4A44445D564F4F8458504E855A504E855A5050855C5050855D5050855D5050855D5252855D5252855D5252855F5252855F5252855F5252856152528561525285635252856354528563545485655454856554548563545485635252856352528561525285615252855F5252855F5252855F5252855D5252855D5252855D5252855D5050855C5050855C5050855A5050855A504E8558504E85574F4F83484242541919190A000000000000000000000000000000000000000000000000736C6C21B5B1B1CFC8C2C2FACDC4C4FACEC5C5FACFC6C6FAD1C7C7FAD2C9C8FAD3C9C9FAD4CACAFAD5CDCBFAD5CDCDFAD7CDCDFAD7CFCFFAD9D0D0FADAD2D1FADBD2D2FADCD3D3FADDD4D4FADED5D5FADFD6D5FADFD6D5FADED5D5FADDD4D4FADCD3D3FADBD2D2FADAD2D1FAD9D0CFFAD7CECEFAD7CDCDFAD5CDCDFAD4CBCBFAD4CACAFAD3C9C9FAD2C8C8FAD0C7C7FACFC6C6FACEC5C5FACDC4C4FAC8C2C2FAB3AFAFBD5C5C5C16000000000000000000000000000000000000000000000000A5A5A525DAD7D7DBDED9D9FEE4DFDEF9E6E2E1F9E7E3E2F9E9E5E4F9EAE6E6F9EBE7E6F9ECE8E7F9EDEAE9F9EEEAEAF9EFEBEBF9F0EDECF9F2EFEEF9F3F0F0F9F4F1F1F9F5F3F2F9F6F4F4F9F7F4F4F9F7F5F5F9F7F5F5F9F6F4F4F9F6F4F3F9F5F3F2F9F4F1F1F9F3F0F0F9F1EEEDF9F0ECECF9EFEBEBF9EEEAEAF9EDE9E8F9ECE8E8F9EBE7E7F9EAE6E5F9E9E5E4F9E7E3E3F9E6E2E1F9E4DFDFF9E0DCDCFED6D2D2C87F7F7F18000000000000000000000000000000000000000000000000ACA5A525E0DEDEDBE1DEDEE8D4CFCB77BEB8AF8ABDB5AC8FBFB6AD90BFB8AF91C0B9AE92C1B9B092C2B9B093C2B9B093C2BBB093C2BBB293C4BDB293C4BDB293C4BDB493C5BEB493C5BEB493C5C0B493C5C0B493C5C0B693C5C0B693C5C0B693C5C0B493C5C0B493C5C0B493C4BEB293C4BEB293C4BEB293C4BEB293C4BEB293C4BEB093C3BEB292C3BFAF91C2BDAF90C0BDAE8FC3BFB289D8D4D078E8E5E4EAD8D6D6C87F7F7F18000000000000000000000000000000000000000000000000A5A5A525E0DFDEDBDAD8DAE0A6938470B08E68E2AF8962E9B18A62E9B28B60EAB48C62EAB78E62EAB99064EABA9367EABA9569EABA966AEABC9869EABD9A6AEABD9E6AEABFA06AEAC0A26CEAC0A46CEAC0A56EEAC0A670EAC0A670EAC0A870EAC1A973EAC1AB74EAC1AC75EAC1AD74EAC3AE73EAC1AE73EAC1AF74EAC1AE72EAC0AE6FEAC0AE6EEAC0AE6AEABFAC69E9BEAA64E9BEAB65E1B8AD8A70E8E6E6E2D7D6D6C87F7F7F18000000000000000000000000000000000000000000000000A5A5A525E0DEDEDBDAD8D9E0A8978876B59470F9B28E65FFB0895DFFAF8556FFB18352FFB2844FFFB4854DFFB5854FFFB68650FFB68750FFB78A4FFFB98D4EFFB98F4FFFBA924FFFBC944FFFBC9651FFBB9A54FFBB9B55FFBB9C55FFBC9D55FFBC9F58FFBCA15CFFBCA25EFFBCA45EFFBEA65CFFBEA65DFFBEA65DFFBEA75BFFBFA75BFFBFA85AFFBEA858FFBEA857FFBEA753FFBDA653F8B3A87D76E7E5E5E2D7D4D4C87F7F7F18000000000000000000000000000000000000000000000000A5A5A525DFDEDDDBD9D6D9E0B5AAA276CDB8A2F9CAB298FFC3A889FFBB9C77FFB69269FFB48D61FFB38A5AFFB38856FFB48752FFB48751FFB58850FFB68B4DFFB98C4CFFBA8F4CFFBB914BFFBC944DFFBB974FFFBB994FFFBB9951FFBC9B51FFBC9E54FFBCA058FFBCA15BFFBCA25BFFBDA45AFFBDA55BFFBEA65BFFBEA75BFFC0A85CFFC0AA5CFFC1AB5DFFC2AD5CFFBFAA56FFBDA651F8B5A87D76E7E5E3E2D6D3D3C87F7F7F18000000000000000000000000000000000000000000000000A5A5A525DFDDDDDBD8D4D8E0BAB1AD77DECEC0F9DECDBFFFDCC9B8FFD4BFAAFFCAB295FFBFA27EFFB8966DFFB59165FFB58E60FFB48B5BFFB58A56FFB68C52FFB78C4FFFB98E4EFFBA914DFFBB944FFFBC964DFFBB994FFFBB9950FFBC9B51FFBD9E53FFBC9F57FFBCA15AFFBDA25AFFBEA35AFFBFA65BFFC0A75CFFC0A85CFFC0AA5CFFC1AB5DFFC2AD5DFFC3AF5EFFC0AC58FFBCA752F8B3A77C77E6E3E3E2D4D2D2C87F7F7F18000000000000000000000000000000000000000000000000A5A5A525DEDCDCDBD7D3D7E0AD9E9377CBB59EF9DAC7B6FFE3D3C6FFE4D4C6FFE0CFBFFFD8C4B1FFCCB599FFC0A581FFB99970FFB59367FFB58F61FFB58E5BFFB58E56FFB78F53FFB99151FFBA9250FFBB964EFFBB984FFFBB9950FFBC9B53FFBD9E53FFBD9F56FFBCA159FFBDA25AFFBEA45BFFBEA65BFFBFA75BFFC0A95CFFC1AB5DFFC1AB5DFFC3AD5DFFC3AF5EFFC0AC59FFBDA753F8B3A77C77E5E2E2E2D3D1D1C87F747418000000000000000000000000000000000000000000000000A5A5A525DDDADADBD6D3D6E09E897777AD8661F9B89775FFC8AE93FFD7C3B0FFE2D2C4FFE5D5C9FFE1D0C1FFD9C6B3FFCCB69AFFC0A47EFFBA996EFFB69466FFB6915FFFB79058FFB89154FFB99251FFBB964FFFBB984FFFBB9950FFBC9B52FFBC9D55FFBD9F55FFBDA258FFBDA359FFBEA55BFFBEA75CFFBFA85BFFC1AA5CFFC1AB5DFFC2AB5DFFC4AE5FFFC3AF5FFFC0AC59FFBEA954F8B3A97C77E3E1E1E2D2CFCFC87F747418000000000000000000000000000000000000000000000000A5A5A525DAD9D9DBD3D1D4E09A806B77A87447F9AE8055FFB48E67FFB99975FFC5AB8CFFD6C2ADFFE4D4C6FFE6D7CAFFE0D0C0FFD7C3AEFFC9B091FFBDA078FFB8986AFFB79663FFB7945CFFB89357FFBA9653FFBA9752FFBB9950FFBB9A51FFBC9D55FFBDA057FFBDA257FFBDA35AFFBFA75CFFC0A85DFFBFA95CFFC0AA5DFFC1AB5DFFC3AD5FFFC3AF60FFC3B05FFFC2AD5AFFBFAA55F8B2A77B78E2E0E0E2CFCECEC874747418000000000000000000000000000000000000000000000000A59E9E25D9D8D8DBD2D0D3E0987A6477A86732F9AF723DFFB38050FFB3885DFFB59169FFBB9D78FFCAB194FFDCCAB7FFE6D8CBFFE5D6C8FFDDCCBBFFD1BBA1FFC3A882FFBC9D70FFB99A66FFB8975FFFB9975CFFBB9858FFBB9954FFBC9A52FFBC9D53FFBD9F56FFBDA257FFBDA35AFFC0A75CFFC1A95EFFC0AA5DFFC0AA5CFFC2AC5DFFC4AE60FFC4B060FFC4B160FFC2AE5BFFBFAB56F8B2A77B78E1DFDFE2CECDCDC8747474180000000000000000000000000000000000000000000000009E9E9E25D8D7D7DBD1CFD2E098755E77AC6023F9B16A2EFFB4763EFFB37C48FFB38557FFB48F65FFB99971FFC2A784FFD2BDA4FFE3D4C5FFE8DACDFFE2D2C4FFD8C4AFFFC9B08DFFBEA274FFBC9D6AFFBB9A63FFBA9A5EFFBB9A5BFFBB9C58FFBC9D56FFBD9E56FFBDA157FFBDA359FFBEA65BFFC0A85DFFC0AA5CFFC1AA5DFFC3AD5DFFC4AF5FFFC4B160FFC5B262FFC3B05CFFC0AC56F8B2A77B78E0DFDEE2CDCACAC8747474180000000000000000000000000000000000000000000000009E9E9E25D8D7D7DBD2D1D3E098735C77AD5C1DF9B36425FFB66F32FFB57439FFB47C46FFB38453FFB48E61FFB8976DFFBFA27BFFCBB496FFDECDBCFFE8DACEFFE5D7C9FFDDCAB8FFCDB797FFC1A779FFBD9F6BFFBB9E64FFBB9D60FFBC9E5DFFBC9F5AFFBDA159FFBDA158FFBDA259FFBEA65BFFBEA85CFFC0AB5DFFC1AB5DFFC2AE5EFFC4AF5FFFC4B160FFC6B363FFC3B15CFFC0AD57F8B4AA7D78E1E0DFE2CDCACAC874747418000000000000000000000000000000000000000000000000A59E9E25D9D8D8DBD1CFD2E098715C77AD591BF9B46222FFB76B2DFFB67033FFB5753AFFB47C44FFB48451FFB48C5EFFB8966CFFBEA179FFC7AF8EFFDBC8B3FFE9DBCEFFE7D9CDFFDFCFBEFFD1BD9FFFC4AB7EFFBEA26DFFBDA166FFBCA062FFBCA15FFFBDA25CFFBDA35CFFBEA45AFFBEA65BFFBFA85CFFC1AB5DFFC2AC5EFFC3AE5FFFC4B05FFFC5B261FFC7B463FFC3B15DFFC1AF58F8B4AA7B78E0DFDEE2CECDCDC874747418000000000000000000000000000000000000000000000000A59E9E25D9D8D8DBCFCED1E095715C77AD581AF9B46020FFB76A2BFFB76F31FFB67336FFB5773DFFB57D44FFB4834FFFB58C5EFFB8966CFFBEA079FFC7AD8BFFD8C5ADFFE8DACDFFE9DCD0FFE2D2C2FFD5C1A5FFC7AF81FFC0A66EFFBEA467FFBEA364FFBEA35FFFBDA55EFFBEA65DFFBFA85DFFBFA85CFFC1AA5DFFC2AC5EFFC4AF60FFC4B160FFC6B362FFC7B563FFC4B35EFFC2B059F8B2A77B78DFDEDEE2CECBCBC874747418000000000000000000000000000000000000000000000000A59E9E25D9D7D7DBCFCCD0E095715977AE5617F9B55F1EFFB76A2CFFB86E30FFB87234FFB77639FFB77A40FFB78047FFB68756FFB68F64FFBB9870FFC1A37CFFC8AF8CFFD8C4AEFFE9DACFFFEBDDD2FFE3D4C5FFD8C5AAFFCAB386FFC3A972FFC2A76BFFC1A766FFC0A763FFC0A862FFC1AA61FFC1AB5EFFC2AC5FFFC4AE60FFC5B161FFC6B363FFC8B564FFC9B664FFC6B45FFFC3B159F8B2AA7B78DEDDDCE2CECBCBC874747418000000000000000000000000000000000000000000000000A59E9E25D9D7D7DBCFCCCFE098735E77B15D21F9B76629FFBB7137FFBB743BFFBB773DFFBC7A41FFBC7F46FFBB844DFFBB8957FFBA8F61FFBC966DFFBF9F78FFC5AA84FFCCB593FFDBC8B3FFEADDD1FFECE0D5FFE5D7C9FFDBCAAFFFCFB98EFFC8B07AFFC7AE73FFC7AE70FFC6AE6EFFC5AF6BFFC6B16AFFC6B269FFC8B36AFFCAB56AFFCBB86CFFCBBA6CFFCCBB6CFFCAB866FFC7B560F8B4AC7F78DEDCDCE2CECBCBC874747418000000000000000000000000000000000000000000000000A59E9E25D9D7D7DBCFCBCFE09A776277B4642CF9BA6C33FFBE753DFFBD7840FFBD7A43FFBE7C44FFBE8049FFBE854EFFBD8A56FFBC8E5EFFBD9468FFBE9C73FFC2A47DFFC7AD88FFCFB99AFFDDCCB8FFECE0D6FFEDE2D7FFE7D9CBFFDDCDB3FFD1BD91FFCBB57EFFCAB378FFC9B275FFCAB372FFCAB471FFCAB671FFCBB770FFCCB96FFFCDBA71FFCDBD72FFCFBF72FFCDBD6EFFCBBB69F8B8AE8378DEDCDCE2CECBCBC8747474180000000000000000000000000000000000000000000000009B949424D6D4D4DACECBCFE09A776477B66631F9BC6E38FFBF7741FFBF7942FFBF7C45FFC07E48FFBF824DFFC08852FFC08A55FFBE8E5CFFBE9466FFBE9A71FFC1A079FFC5A882FFCBB28FFFD3BEA1FFE1D1C0FFEEE2D8FFEEE3D9FFE8DACCFFDECFB5FFD4C194FFCEB982FFCCB77DFFCDB77BFFCDB779FFCDB977FFCDBA76FFCEBB75FFCFBD75FFCFBF77FFD0C277FFCFBF72FFCCBD6FF8B8B08578DEDCDCE2CAC8C8C8747474180000000000000000000000000000000000000000000000009B949424D4D3D2DACAC8CBE09C776677B96936F9BD713EFFC07947FFC17C47FFC17D48FFC1804CFFC18351FFC18957FFC18C58FFC18E5AFFC19261FFC0996FFFC19F78FFC4A57FFFC8AD88FFCEB796FFD7C4AAFFE5D7C7FFF0E5DCFFEFE3D9FFE8DBCDFFE0D1B6FFD4C396FFD0BC86FFCFBC82FFCFBB80FFD0BC7EFFD0BE7DFFD0BF7BFFD0C17AFFD1C27AFFD3C47DFFD1C177FFCEBF73F8B8B08878DAD9D8E2C8C6C6C8747474180000000000000000000000000000000000000000000000009B949424D4D2D2DAC9C7CAE09C7C6877BA6D3CF9BF7443FFC27C4CFFC27E4CFFC37F4CFFC4824FFFC38654FFC48B59FFC38E5BFFC3905EFFC39260FFC29668FFC29D74FFC4A47EFFC7AA85FFCCB38FFFD2BD9EFFDBCAB3FFE9DCD0FFF2E8DFFFEFE4DAFFE9DCCDFFE0D2B6FFD6C598FFD2C08AFFD2C087FFD2C186FFD2C284FFD2C383FFD3C481FFD4C67FFFD5C680FFD2C47BFFD0C277F8BBB28A78D9D8D7E2C8C6C6C8747474180000000000000000000000000000000000000000000000009B949424D4D3D2DAC9C7C9E09E7C6B77BC7041F9C17647FFC47E50FFC48050FFC58251FFC58251FFC58654FFC58C5AFFC58F5EFFC59162FFC59363FFC59767FFC59A6EFFC5A17AFFC7A984FFCAAF8CFFCFB897FFD6C4A8FFDFD0BDFFEDE2D6FFF3E9E0FFEFE4DAFFE9DDCEFFE1D4B6FFD7C899FFD5C58EFFD6C68CFFD6C78CFFD6C78AFFD6C989FFD6CA86FFD6CA84FFD4C77FFFD1C57AF8BAB38D77D9D8D7E2C8C6C6C8747474180000000000000000000000000000000000000000000000009B949424D4D3D2DAC9C7C9E09E7C6D77BE7043F9C37848FFC67F53FFC68254FFC58455FFC68555FFC68858FFC78C5AFFC68F5FFFC79264FFC79566FFC79868FFC79B6DFFC69E73FFC7A57FFFCAAF8BFFCDB593FFD3BEA0FFDBCAB1FFE4D7C6FFF0E7DDFFF4EBE2FFF0E5DAFFEADFCEFFE2D5B6FFD9CB9AFFD7CA91FFD7CA90FFD8CB90FFD9CC8FFFD9CE8FFFD9CF8BFFD6CB85FFD3C97FF8BCB68D77D9D8D7E2C8C6C6C8747474180000000000000000000000000000000000000000000000009B949424D4D3D2DAC9C7CAE0A07E6F77C07247F9C7784AFFC98253FFC98356FFC88658FFC98759FFC9895AFFC98D5CFFCA905FFFCA9262FFCA9565FFCA9869FFCA9C6DFFC99E72FFC9A178FFCAA883FFCDB391FFD1BA9AFFD7C5A8FFDFD0BBFFE9DDCFFFF4ECE4FFF4EBE3FFF0E6DBFFEBE0CEFFE2D6B4FFDBCF9DFFDACE97FFDACF95FFDCCF96FFDCD196FFDCD294FFDACF8CFFD6CC86F8BCB68F77D9D8D7E2C8C6C6C8747474180000000000000000000000000000000000000000000000009B949424D4D2D2DAC9C7CAE0A2817276C2754BF9C97B4FFFCC8355FFCC8557FFCB875AFFCB895DFFCC8B5DFFCC8D5FFFCC9061FFCD9264FFCD9566FFCC9869FFCC9B6DFFCC9E71FFCCA176FFCBA47BFFCCAD89FFD1B998FFD5C0A2FFDCCCB2FFE3D6C4FFEDE3D8FFF6EEE8FFF5ECE3FFF1E7DBFFEBE1CDFFE3D8B3FFDED3A1FFDDD29CFFDDD39BFFDFD59CFFDFD69CFFDCD395FFD9CF8DF8BEB99576D9D8D7E2C8C6C6C8747474180000000000000000000000000000000000000000000000009B949424D4D2D2DAC9C7CAE0A4837676C57951F9CB7E54FFCE855BFFCE895CFFCE8A5EFFCD8C61FFCE8E62FFCD9063FFCE9166FFCE9568FFCE9769FFCE996BFFCE9C6FFFCE9F71FFCEA174FFCEA479FFCDA87FFFCFB18DFFD4BD9FFFD9C8ABFFE0D2BBFFE7DCCCFFF2E9E0FFF7F0E9FFF5ECE4FFF1E8DCFFEBE2CDFFE3D9B2FFE0D6A5FFE0D7A2FFE1D8A2FFE1D9A2FFDFD79CFFDDD395F8C0B99976D9D8D7E2C8C6C6C8747474180000000000000000000000000000000000000000000000009B949424D4D3D2DAC9C7CAE0A4857976C67D57F9CB7D54FFCC8057FFCB8459FFCC875BFFCB885BFFCB895DFFCB8C5FFFCB8D61FFCC9064FFCC9365FFCC9567FFCC996BFFCC9B6DFFCC9D6FFFCCA174FFCBA378FFCCA67DFFCEB08EFFD4C0A0FFDACAAEFFE1D4C0FFE9DDD0FFF4EBE4FFF7F0E8FFF4EBE2FFF0E7DAFFEAE0C8FFE2D9AEFFE0D7A6FFE1D9A4FFE2DAA4FFE1D9A1FFE0D79DF8C1BD9F75D9D8D7E2C8C6C6C8747474180000000000000000000000000000000000000000000000009B949424D4D3D2DACAC8CADFAD8E836DC88866E8C8835EEFC8835EEFC88460EFC88862EFC88A61EFC88B62EFC88D65EFC88E66EFC99169EFC99369EFCA966BEFCA996EEFCA9B72EFCA9D73EFCBA176EFCBA47AEFCAA67DEFCBA984EFD0B796EFD8C6A9EFDDCEB7EFE4D8C7EFEBE3D8EFF6F0E8EFF5EEE7EFF3EAE1EFF0E7D9EFE8E0C3EFE2D9AEEFE2DAA9EFE2DBA8EFE3DBA7EFE3DBA8E7CBC6A96CDAD9D8E1C8C6C6C8747474180000000000000000000000000000000000000000000000009B949424D4D2D2DACECCCCEEA39E9C9E9F938CB29E918AB49E918AB49E918AB49E938CB49E938AB49E938CB49E948CB4A0948CB4A0948CB4A0968DB4A1978DB4A2988FB4A2988FB4A2988FB4A29A90B4A29A90B4A29B91B4A29B91B4A49D94B4A7A29AB4A8A49DB4A9A7A1B4A9A7A2B4ACA9A7B4ACABA8B4ACA9A7B4ABA9A5B4ABA8A2B4A8A59BB4A8A59AB4A8A59AB4A8A598B4A7A699B2ADABA89FDAD8D8EFC8C6C6C874747418000000000000000000000000000000000000000000000000B2AAAA1ED7D6D6D4DCDBDBFED6D5D4FED5D3D3FED5D3D3FED5D3D3FED5D3D3FED5D3D3FED5D3D3FED5D3D2FED5D3D2FED5D3D3FED5D3D3FED6D5D4FED9D7D6FED9D7D6FED9D7D6FED9D7D6FED9D7D6FED9D7D7FED9D7D6FED9D7D6FED9D7D6FED9D7D6FED9D7D7FED9D7D7FED6D4D4FED5D3D3FED5D3D3FED5D3D2FED5D3D3FED5D3D3FED5D3D3FED5D3D3FED5D3D3FED5D3D3FED5D3D3FED7D6D5FEDDDCDCFECDCACAC286868613000000000000000000000000000000000000000000000000C6C6C609D4D2D266D4D3D391D3D1D192D3D1D192D3D1D192D3D1D192D3D1D192D3D1D192D3D1D192C4C5C5A0BBBEBEA7CAC9C998D0CECE94D5D3D392D8D5D592D8D5D592D8D5D592D8D5D592D8D5D592D8D5D592D8D5D592D8D5D592D8D5D592D8D5D592D8D5D592D8D5D592D1D0D093CDCBCB95C4C4C49DB7BBBBABCFCDCD95D1CFCF92D1CFCF92D1CFCF92D1CFCF92D1CFCF92D1CFCF92D1CFCF92D3CFCF91CEC9C95A9999990500000000000000000000000000000000000000000000000000000000FFFFFF029999990599999905999999059999990599999905999999059999990599999905667F7F0A355E5E2B2A4C4C3C253434223A3A3A0D7F7F7F06999999059999990599999905999999059999990599999905999999059999990599999905999999055F5F5F0830303015243939312F52523B3F6A6A1899CCCC0599999905999999059999990599999905999999059999990599999905BFBFBF047F7F7F02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F02274E4E1A2147
)
IconData2 =
(join
473D152F2F30000E0E120000000500000001000000000000000000000000000000000000000000000000000000020000000A1119191E1D3B3B3C254B4B2F334C4C0A00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000334C4C0A274F4F2D1E3C3C3B071717200000000C000000030000000000000000000000000000000100000007000C0C14162C2C2E2249493B274E4E1A007F7F02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F022A555518234A4A3A152B2B2F000B0B160000000800000005000000060000000E0F1717201E39393A274F4F2D334C4C0A00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000385454092851512C1F3E3E390E1515240000003000060629162C2C2E284C4C39285B5B19007F7F02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F022A5F5F182244443C363A3A82303D3D632754542D3366660A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003F6A6A0C717373756D757541007F7F02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000B6B6B607AAFFFF030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06F8000000001FDB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06E00000000007DB06F0000000000FDB06FFFC07E07FFFDB06FFFF0380FFFFDB06FFFF8003FFFFDB06FFFFE007FFFFDB06FFFFF01FFFFFDB06FFFFFC3FFFFFDB06FFFFFE7FFFFFDB06
)

loop 2
 {
  IconData := ( IconData IconData%a_index% )
  IconData%a_index% =
 }
WriteFile( A_ScriptDir "\PictureOnWall.ico" ,IconData)
IconData =
}
ifnotexist, %A_ScriptDir%\PictureWindow.ico
{
IconData1 =
(join
0000010001003030000001002000A82500001600000028000000300000006000000001002000000000008025000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000100000002000000020000000200000002000000030000000300000003000000030000000300000003000000030000000400000004000000040000000400000004000000040000000400000004000000040000000400000003000000030000000300000003000000030000000300000003000000020000000200000002000000020000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000010000000300000006000000090000000C0000000E0000001000000011000000120000001300000014000000140000001500000015000000160000001600000017000000180000001800000018000000190000001900000018000000180000001800000017000000160000001600000015000000150000001400000014000000130000001200000011000000100000000E0000000C0000000900000006000000030000000100000000000000000000000000000000000000000000000000000002000000070000000E000000150000001C000000210000002400000027000000290000002B0000002D0000002E0000002F000000300000003100000033000000340000003500000036000000370000003700000037000000370000003600000035000000340000003300000031000000300000002F0000002E0000002D0000002B000000290000002700000024000000200000001C000000150000000E0000000700000002000000000000000000000000000000000000000000000001000000040000000B0000001500000020000000290000003000000034000000380000003B0000003E0000004000000042000000440000004500000047000000480000004A0000004C0000004D0000004E0000004F0000004F0000004E0000004D0000004B0000004A0000004800000047000000450000004400000042000000400000003E0000003B0000003800000034000000300000002900000020000000150000000B000000040000000100000000000000000000000000000000000000010000000300000009000000120000001C000000240000002A0000002E000000310000003400000036000000380000003A0000003B0000003D0000003E0000004000000041000000420000004400000045000000460000004600000045000000440000004200000041000000400000003E0000003C0000003B0000003A000000380000003600000034000000310000002E0000002A000000240000001C00000012000000090000000300000001000000000000000000000000000000000000000000000002000000050000000A0000000F00000014000000180000001A0000001C0000001D0000001E000000200000002000000021000000220000002300000024000000250000002500000026000000270000002800000028000000270000002600000025000000250000002400000023000000220000002100000020000000200000001E0000001D0000001B0000001A00000017000000140000000F0000000A00000005000000020000000000000000000000000000000000000000000000000000000000000002000000020000000400000005000000060000000700000008000000080000000900000009000000090000000A0000000A0000000A0000000B0000000B0000000B0000000B0000000C0000000C0000000C0000000C0000000B0000000B0000000B0000000B0000000A0000000A0000000A000000090000000900000009000000080000000800000007000000060000000500000004000000020000000100000000000000000000000000000000000000000000000000000000000000000000000100000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000300000003000000030000000300000003000000030000000300000003000000030000000300000003000000030000000300000003000000030000000300000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000100000000000000000000000000000000000000000000000000000000545454099797972A95959535959595359595953595959535959595359595953595959535959595359595953595959535959595359595953595959535959595359595953595959535959595359595953595959535959595359595953595959535959595359090903590909035909090359090903590909035909090359090903590909035909090359090903590909035909090358B8B8B358B8B8B358E8E8E3495959529383838090000000000000000000000000000000000000000000000018A8A8A23F1F1F1C0F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F8F8F8E4F7F7F7E4F7F7F7E4F7F7F7E4F6F6F6E4F6F6F6E4F4F4F4E4F4F4F4E4F3F3F3E4F3F3F3E4F2F2F2E4F2F2F2E4F1F1F1E4F1F1F1E4F0F0F0E4F0F0F0E4EFEFEFE4EEEEEEE4EEEEEEE4EDEDEDE4EBEBEBE4EBEBEBE4EAEAEAE4E4E4E4BE838383210000000100000000000000000000000000000000000000028282822BF5F5F5D9FFFFFFFFFAFBFCFFF8F8FAFFF8F8FAFFF8F8FAFFF8F8FAFFF8F8FAFFF8F8FAFFF8F8FAFFF8F9FAFFF8F9FAFFF8F8FAFFF8F8FAFFF8F8FAFFF8F8FAFFF7F8F9FFF7F7F9FFF6F7F8FFF6F6F8FFF5F6F7FFF5F5F7FFF4F5F6FFF4F4F6FFF3F3F5FFF3F3F5FFF2F2F4FFF1F1F3FFF1F1F3FFF0F0F2FFEFEFF1FFEFEFF1FFEEEEF0FFEDEDEFFFECEDEEFFEBECEDFFEBEBEDFFEDEDEEFFF0F0F0FFE6E6E6D7767676290000000100000000000000000000000000000000000000028282822BF5F5F5D9FEFEFEFF9197ACFF505B80FF515C82FF525F85FF515E84FF536087FF515D83FF525E85FF54628AFF55648CFF546189FF536088FF54628AFF55638BFF55648CFF546289FF54628BFF546189FF54628AFF526087FF536189FF525F87FF536189FF526087FF505C83FF4F5B80FF53638AFF515F86FF505C83FF505C83FF505D84FF505D84FF4D5980FF4D587EFF4D577DFF8B92A6FFEEEEEEFFE4E4E4D7767676290000000100000000000000000000000000000000000000028282822BF5F5F5D9FDFDFDFF666F8FFF0B1D55FF0C1F59FF0D205AFF0E225CFF10245FFF0E225BFF0E225CFF0F235DFF112662FF112661FF102560FF112661FF122864FF112863FF102560FF112661FF122662FF102560FF0F235EFF112763FF122763FF112662FF0F235EFF0E225CFF0F235EFF122964FF112661FF0E205AFF0D2059FF0E205AFF0C1E57FF0C1D56FF0A1C53FF0C1E55FF636D8BFFECECECFFE3E3E3D7767676290000000100000000000000000000000000000000000000028282822BF5F5F5D9FDFDFDFF666F8FFF0B1C53FF0C1F58FF0E215CFF0F235EFF102560FF112762FF122864FF112662FF122966FF132A66FF112661FF122A67FF132A66FF122864FF112763FF122966FF152D6AFF142D6AFF132B68FF142D6AFF142B68FF152D6AFF142B67FF122864FF122864FF112762FF122764FF112863FF102561FF112763FF122965FF102560FF0F245FFF0F225CFF646E8EFFEBEBEBFFE2E2E2D7767676290000000100000000000000000000000000000000000000028282822BF5F5F5D9FDFDFDFF677191FF0D2059FF0F235DFF112661FF112662FF112662FF132A67FF122965FF132A67FF132A67FF142B67FF162F6CFF152F6CFF16306DFF152E6BFF162F6CFF17326FFF152E6CFF17326FFF183371FF16316EFF16306DFF16306DFF17316EFF142C69FF142B68FF142C69FF152D6AFF16306DFF142C69FF142D6AFF142B68FF112763FF102560FF112560FF657091FFEAEAEAFFE1E1E1D7767676290000000100000000000000000000000000000000000000028282822BF5F5F5D9FDFDFDFF697495FF10245EFF112863FF122763FF122966FF132A67FF132A66FF132A66FF142D6AFF152E6AFF152E6BFF152D6BFF162F6DFF17316FFF162F6DFF17316FFF152E6BFF17326FFF183370FF193471FF183371FF183370FF183371FF173270FF16306DFF17316FFF17326FFF17316FFF17316FFF16306DFF142D6AFF142C69FF142C69FF122966FF102660FF657192FFE8E8E9FFE0E0E0D7767676290000000100000000000000000000000000000000000000028282822BF5F5F5D9FDFDFDFF6A7596FF102560FF102560FF112662FF132B67FF132B67FF142C69FF132A66FF142D6AFF162F6DFF152F6CFF152F6CFF17316FFF183270FF17316EFF173270FF17326FFF17326FFF1A3673FF1A3673FF193572FF183371FF183371FF18326FFF17326FFF183370FF173270FF17316EFF152F6CFF152E6CFF152E6CFF142C69FF142C69FF132B68FF122964FF657192FFE7E7E7FFDEDEDED7767676290000000100000000000000000000000000000000000000028282822BF5F5F5D9FDFDFDFF6A7596FF122762FF132966FF142B68FF152E6BFF142C69FF152F6CFF16306DFF16306DFF183270FF183270FF18326FFF183270FF1A3573FF1A3774FF1C3875FF1B3774FF1C3875FF1D3977FF1C3976FF1C3976FF1B3774FF1C3976FF1D3A77FF1C3976FF1C3875FF1B3774FF1B3774FF1B3774FF193572FF1A3573FF193370FF193370FF193471FF18326FFF677697FFE6E6E6FFDDDDDDD76F6F6F290000000100000000000000000000000000000000000000028282822BF5F5F5D9FDFDFEFF6A7798FF122965FF142C69FF152E6BFF162E6CFF16306EFF183370FF1B3774FF1B3774FF1B3674FF1C3875FF1C3875FF1C3875FF1D3A77FF1D3A77FF1E3B79FF1F3C79FF203D7AFF203C7AFF213F7CFF23407DFF203D7AFF203D7AFF22407DFF24417EFF23417DFF23407DFF223F7CFF213E7BFF203C79FF1F3C79FF203C79FF203D7AFF1E3A77FF1D3976FF6A7A9BFFE5E5E5FFDCDCDCD76F6F6F290000000100000000000000000000000000000000000000028282822BF5F5F5D9FDFDFDFF6B7A9CFF152E6BFF17326FFF183370FF1A3573FF1A3573FF1B3774FF1D3A77FF1D3A77FF1E3B78FF1F3B78FF203D7BFF223F7CFF22407DFF24417EFF254481FF264582FF264482FF254481FF264582FF274582FF274683FF284784FF274683FF274684FF264583FF274582FF264582FF264481FF25427FFF24417EFF23417EFF22407DFF203D7AFF203C78FF6B7B9DFFE4E4E4FFDBDBDBD76F6F6F290000000100000000000000000000000000000000000000028282822BF4F4F4D9FCFCFDFF6C7B9EFF17326FFF193572FF1B3774FF1C3976FF1E3A77FF1F3C79FF203C79FF213E7BFF23407DFF24417EFF24427FFF254380FF264582FF264582FF274683FF284784FF294886FF294886FF294986FF2A4987FF294986FF2A4B88FF2A4B88FF2A4987FF294885FF284684FF294886FF284784FF274683FF264482FF254380FF24427FFF23417EFF213D7AFF6B7B9CFFE3E3E3FFDADADAD76F6F6F290000000100000000000000000000000000000000000000028282822BF4F4F4D9FBFBFCFF6E7E9FFF1C3772FF1D3A76FF1F3B78FF203D7AFF233F7CFF23417EFF244280FF264582FF274583FF284784FF294985FF2A4A86FF2A4A87FF2B4C88FF2D4D8AFF2D4E8BFF2E4F8CFF2E4F8BFF2F508CFF30518EFF30518EFF30528EFF30528EFF30518EFF2F518DFF2E4F8BFF2D4D8AFF2C4D8AFF2C4C89FF2B4A87FF294985FF284784FF274683FF274481FF6D7E9FFFE1E2E2FFD9D9D9D76F6F6F290000000100000000000000000000000000000000000000028282822BF3F3F3D9FBFBFBFF8A949DFF4C5E70FF3E5065FF495B73FF4A5D76FF4C607BFF536784FF4A5F7EFF4C6284FF4C6386FF4B6387FF4E678DFF516A91FF526C95FF4F6A95FF4A6691FF496593FF496695FF496696FF496799FF466599FF426197FF3E5E96FF3D5D97FF3C5D97FF3A5B96FF395A96FF375995FF365793FF345692FF335591FF31538FFF30528EFF2E4F8BFF2D4E89FF7184A4FFE0E1E1FFD7D7D7D76F6F6F290000000100000000000000000000000000000000000000028282822BF3F3F3D9FAFAFAFF909793FF5E6A63FF54605AFF5C6761FF5E6B64FF6A7670FF6E7B74FF637069FF68746EFF727E79FF727E79FF77847FFF818D89FF86928EFF8A9794FF808D8BFF82908FFF849192FF879497FF859399FF7C8C94FF7C8D99FF728595FF677C90FF5E758EFF526B8AFF456085FF395781FF2C4B7AFF223E6EFF213D6DFF234173FF254476FF234274FF224072FF6B7B97FFDFE0E0FFD7D7D7D76F6F6F290000000100000000000000000000000000000000000000028282822BF2F2F2D9F9FAFAFF919996FF5F6D68FF5C6A65FF687673FF707F7CFF768482FF758483FF788787FF829293FF8B9A9DFF8E9EA2FF95A6AAFF9BADB2FF9FB1B8FFACBEC6FFA4B7C0FF98ADB8FF778A98FF53677AFF4C6880FF3A5975FF325370FF2E4F6DFF294B69FF264867FF234363FF1D3C5EFF1C3B5DFF1B3A5CFF193759FF1C3A5CFF224266FF27496CFF244467FF1F3D5FFF67778AFFDEDEDFFFD6D6D6D76F6F6F290000000100000000000000000000000000000000000000028282822BF0F0F0D9F9F9FAFFB7C2C7FF9FB2BCFFA6BAC6FFADC1CDFFB1C6D2FFB3C8D5FFB6CBD8FFB8CCDBFFB9CEDDFFBACFDEFFBBCFDEFFBBD0DFFFBACFDEFFBAD0DFFFBBD0DFFFBBD0DFFFBAD0DFFFB8CDDCFFB0C5D5FFA4BCCEFF7D9BB3FF6889A4FF557896FF476B8BFF3F6282FF3C5F80FF416484FF436585FF3A5E80FF406687FF4F7594FF557B9BFF597F9EFF587E9EFF577C9BFF879BACFFDDDEDEFFD5D5D5D76F6F6F290000000100000000000000000000000000000000000000028282822BF0F0F0D9F8F9F9FFC6D2DAFFB9CDDCFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBBD0DFFFBACFDEFFB8CEDDFFB0C7D8FFAAC2D4FFAAC1D3FFA6BDCFFFACC3D4FFADC3D5FF9BB6CAFF99B5C9FFA1BBCFFF9CB8CCFF97B4C9FF92B0C6FF8DABC1FFA8B8C3FFDDDDDEFFD4D4D4D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BEFEFEFD9F7F8F8FFC5D0D8FFB7CBD9FFB9CEDCFFBACDDCFFB9CDDCFFBACDDCFFB9CDDBFFB9CEDCFFBACDDCFFBACDDCFFB9CEDCFFBACDDCFFBACDDCFFBACDDCFFB9CEDCFFB9CDDCFFBACDDBFFB9CEDCFFB9CDDCFFBACDDBFFB9CEDCFFB9CEDCFFBACEDCFFBACEDBFFB9CEDCFFB9CEDCFFB9CEDBFFB9CEDCFFB9CEDCFFBACEDCFFB9CEDCFFBACEDBFFB9CEDBFFB8CDDBFFB4C9D6FFBBC6CEFFDCDDDDFFD3D3D3D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BEEEEEED9F6F7F7FFC2CDD4FFB4C6D3FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB6C9D6FFB3C6D3FFB9C4CBFFDBDCDCFFD3D3D3D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BEDEDEDD9F5F6F6FFBFCAD0FFAFC1CDFFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB2C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB2C4D0FFB2C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFB1C4D0FFAFC1CDFFB6C1C7FFDBDBDBFFD1D1D1D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BECECECD9F4F4F4FFBDC7CCFFABBCC5FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFADBEC8FFAABBC5FFB4BDC2FFDADADAFFD1D1D1D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BEBEBEBD9F3F3F3FFB9C3C7FFA5B6BEFFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA7B8C0FFA4B5BDFFB0BABEFFD9D9DAFFD0D0D0D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BEBEBEBD9F2F2F2FFB5BEC2FF9FAFB6FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FFA1B1B8FF9FAEB5FFADB6BAFFD9D9D9FFD0D0D0D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BE9E9E9D9F1F1F1FFB1BABCFF99A8ADFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF9BAAAFFF99A8ACFFA9B1B4FFD8D8D9FFD0D0D0D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BE8E8E8D9EFEFEFFFAEB6B7FF94A2A4FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF95A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF96A4A6FF95A4A6FF95A4A6FF96A4A6FF96A4A6FF96A4A6FF94A1A4FFA6AEAFFFD8D8D8FFD0D0D0D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BE7E7E7D9EEEEEEFFA8B0B0FF8A9798FF8C999AFF8C999AFF8C999BFF8C999AFF8C999BFF8C999AFF8C999AFF8C999AFF8C999AFF8C999AFF8C999AFF8C999BFF8C999AFF8C999BFF8C999AFF8C999BFF8C999BFF8C989AFF8C999AFF8C999AFF8C999AFF8C999BFF8C999AFF8C999BFF8C999AFF8C999AFF8C999AFF8C999AFF8C999AFF8C999BFF8C999BFF8C999BFF8A9798FFA1A8A9FFD8D8D8FFD0D0D0D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BE6E6E6D9EDEEEEFFB3B7B7FF959C9CFF969D9DFF959D9DFF959D9DFF959D9CFF959C9CFF949C9CFF949C9CFF949C9CFF949B9BFF939B9BFF939B9BFF939B9BFF939A9AFF939A9AFF939A9AFF929A9AFF929A9AFF929A99FF929A99FF919999FF929999FF919999FF919999FF919999FF919999FF919898FF919899FF919898FF909898FF909898FF909898FF919898FF909797FFA8ADADFFD8D8D8FFD0D0D0D76F6F6F290000000100000000000000000000000000000000000000027C7C7C2BE5E5E5D9EDEDEDFFE9E9E9FFE7E7E7FFE6E6E6FFE5E5E5FFE4E5E5FFE4E4E4FFE3E3E3FFE2E3E3FFE2E2E2FFE1E1E1FFE0E0E0FFDFE0E0FFDEDFDFFFDEDEDEFFDDDDDDFFDCDDDDFFDCDCDCFFDBDBDBFFDBDBDBFFDADADAFFDADADAFFD9D9D9FFD8D9D9FFD8D8D8FFD7D8D8FFD7D7D7FFD6D7D7FFD6D6D6FFD6D6D6FFD5D6D6FFD5D6D6FFD5D6D6FFD5D6D6FFD5D6D6FFD5D6D6FFD7D7D7FFD9D9D9FFD0D0D0D76F6F6F2900000001000000000000000000000000000000000000000183838323E2E2E2C2E8E8E8E6E7E7E7E6E7E7E7E6E6E6E6E6E5E5E5E6E5E5E5E6E4E4E4E6E4E4E4E6E3E3E3E6E3E3E3E6E2E2E2E6E1E1E1E6E1E1E1E6DFDFDFE6DFDFDFE6DEDEDEE6DEDEDEE6DDDDDDE6DDDDDDE6DCDCDCE6DCDCDCE6DCDCDCE6DBDBDBE6DADADAE6DADADAE6DADADAE6DADADAE6D9D9D9E6D9D9D9E6D9D9D9E6D9D9D9E6D9D9D9E6D9D9D9E6D9D9D9E6D9D9D9E6D9D9D9E6D9D9D9E6D9D9D9E6D3D3D3C0787878220000000100000000000000000000000000000000000000004C4C4C0A9A9A9A2B949494378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378F8F8F378B8B8B378B8B8B378B8B8B378B8B8B378B8B8B378B8B8B378B8B8B378B8B8B378B8B8B378B8B8B378B8B8B378B8B8B378B8B8B378B8B8B378D8D8D368E8E8E2B38383809000000000000000000000000000000000000000000000000000000010000000200000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000200000002000000020000000200000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
)
IconData2 =
(join
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FC000000003FDB06E00000000007DB06E00000000007DB06C00000000003DB06C00000000003DB06E00000000007DB06F0000000000FDB06F0000000000FDB06E00000000007DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06C00000000003DB06E00000000007DB06E00000000007DB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06FFFFFFFFFFFFDB06
)

loop 2
 {
  IconData := ( IconData IconData%a_index% )
  IconData%a_index% =
 }
WriteFile( A_ScriptDir "\PictureWindow.ico" ,IconData)
IconData =
}
ifnotexist, %A_ScriptDir%\PinkSunset.ico
{
IconData =
(join
0000010001002020000001002000A81000001600000028000000200000004000000001002000000000008010000000000000000000000000000000000000FBFBFB05A7A7A761484848CB1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF1A1A1AFF484848CBA7A7A761FBFBFB05A7A7A761686868FFCACACAFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFFCACACAFF686868FFA7A7A761484848CBCDCDCDFFB0B0B0FF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFFB0B0B0FFCDCDCDFF484848CB1A1A1AFFDEDEDEFFA5A5A5FF363636FF363636FF363636FF363636FF363636FF363636FF363636FF363636FF363636FF363636FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFFACACACFFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFA8A8A8FFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFACACACFFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFFB3B3B3FF373737FF373737FF373737FF373737FF373737FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFFBABABAFFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF240909FF240808FF230707FF230707FF240708FF270708FF2B0708FF300708FF340709FF35080CFF3D0F20FF532160FF632E91FF632E93FF632E91FF622D8AFF652F89FF662E85FF622777FF561759FF53133FFF400916FF41080FFF3F070BFF3B0708FF3B0709FF380709FF390909FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF1E0000FF1F0000FF220001FF240001FF260001FF290001FF2D0002FF300003FF3A0516FF4C134CFF5D2381FF662C98FF672E97FF672D8BFF672B84FF65277EFF652775FF5B154CFF4E0628FF4D031AFF46000DFF420009FF3F0003FF390101FF360001FF360000FF340000FF330000FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF2A0001FF2C0002FF2E0002FF2F0002FF300102FF320103FF380007FF46000FFF570629FF67195FFF6B2887FF69298FFF692889FF661F70FF65175DFF5B0A45FF57032DFF500120FF4C0018FF4A0012FF48000FFF45000DFF44000AFF410008FF3C0104FF380001FF380000FF360000FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF510110FF510112FF520214FF530316FF540218FF57021CFF5C0321FF610528FF650631FF690A3CFF6A124DFF6C1B61FF6E206EFF6B1B6AFF671663FF63084AFF5C043FFF590131FF550128FF540223FF52021EFF54011EFF52011BFF530116FF4F0015FF500114FF4D0113FF4E0110FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF6A153DFF6D153FFF711643FF761748FF7A194EFF7D1B53FF7E1C59FF7C1C5AFF751B59FF6F1A5BFF6F1B62FF761E71FF7B227FFF762183FF701F82FF681E79FF611B6FFF5E1865FF5D175DFF5C1655FF59154EFF5B154AFF5D1546FF5E1445FF5C1543FF5F1442FF5E153EFF611340FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF771F5BFF79205FFF7C2267FF7F246EFF802673FF812879FF7E297CFF77277FFF712784FF6F2989FF772D98FF8131A4FF8330A6FF822EA4FF7F2DA1FF732895FF68258BFF632483FF5F227FFF5D237AFF5D2375FF5B216DFF5E2169FF5E1E67FF631C60FF641A5BFF651B52FF64184FFFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF823192FF863397FF8A37A2FF8A3BACFF873FB6FF8344BFFF7E47C7FF774BCEFF724ED5FF7652E3FF8058EFFF865CF2FF8B5FF2FFFCFBFFFFFCFCFFFF977DF5FF7D55EDFF764FE8FF6E4BDBFF6645CCFF6543C4FF653BB4FF6737ACFF6932A8FF6B329FFF6D2F9BFF6C2C92FF6D2780FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF9647C1FF9749C5FF974ECDFF9653D4FF9259DCFF8A5FE1FF8261E0FF7A62E0FF7865EAFF806EF9FF8670FEFF8A70FDFF9077FEFFFFFFFFFFFFFFFFFF9187FBFF8D7CFEFF8874FCFF856FFCFF7D68F6FF7563ECFF6E51DBFF7149CCFF7139B8FF7231A8FF722D9FFF712994FF70288FFFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF9E44CFFF9E45CAFF9A43C2FF9641BDFF9140B7FF8941B3FF8143B4FF7C44B5FF8049C0FF854FCCFF8652D1FF8C5AD8FF8F68DEFF9072E4FF8D71E7FF8C73EFFF8F80F7FF8F76F2FF8F70E7FF8A63E0FF844AD2FF7A34BAFF792C9AFF761E7DFF7B1C74FF801C6FFF7D1A6AFF7E1769FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF9E4AD4FF9C49D1FF9A48CEFF9A46C7FF953FB8FF8B36AAFF7F2EA2FF7E2DA1FF842DA3FF852CA2FF852CA2FF8938A5FF8B46ACFF8848BAFF8545C2FF8553D4FF8B7BF0FF9191FAFF9087EFFF9183EDFF9682EEFF9776ECFF946CEFFF905DEDFF9059E9FF9458EDFF9856EBFF9951E4FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFFA468F4FFA46BF6FFA471F9FFA478FBFFA17CFBFF997AF9FF9478F8FF967EF8FF9A85F9FF9986F9FF9787F7FF9590F5FF9599F7FF929DF9FF8F9DF9FF90A8FDFF93B3FDFF96B3FFFF9AB0FFFF9DADFEFFA1ABFFFFA4A8FFFFAB9DFFFFA98AFFFFA87AFFFFA46DFEFFA166FEFFA161FAFFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF9F66EBFFA06AEEFFA272F3FFA37AF8FFA07EFAFF9C80FCFF9D84FDFF9D8DFDFF9A95FEFF979AFEFF96A1FEFF97AAFFFF98AFFFFF95B0FEFF92B0FEFF92B1FFFF94B0FFFF93AEFFFF96ABFEFF9AA9FEFF9EA8FDFFA5A6FEFFA9A4FEFFAF9EFEFFAF8EFDFFA978FCFFA36AF9FF9E60F3FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF965FDDFF9964E1FF9D6DE7FF9D73EBFF9B77EEFF9A7BF1FF9B82F4FF998AF5FF9491F6FF9397F8FF939EF9FF93A4FCFF93A8FDFF91A7FDFF8FA6FCFF8FA7FDFF91A7FDFF92A6FDFF93A3FBFF96A1FAFF999EF9FF9F9DF8FFA39CF8FFA79AF7FFAA95F6FFA887F2FFA370EEFF9B61E6FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF9058CFFF935CD3FF9661D9FF9465DDFF9269E0FF9472E3FF967BE6FF9382E8FF8F87EAFF8F8EECFF9094EFFF909AF2FF909DF4FF8E9CF4FF8C9BF3FF8B9CF3FF8E9EF4FF8F9CF3FF919AF2FF9297F0FF9594EEFF9991EDFF9B8FEBFF9E8CEAFFA089E8FFA086E2FFA17EDFFF9967D9FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF874CC4FF874EC6FF8651CAFF8555CEFF885CD3FF8B68D7FF8B71DAFF8B77DCFF8A7CDEFF8A83E1FF8A88E4FF8A8DE7FF8D92E9FF8B92EAFF8991E9FF8991E9FF8B94E8FF8D94E6FF8C91E4FF8E8EE4FF8F89E2FF9283E0FF9582DFFF967FDDFF9479D8FF9474D5FF9572D2FF956ECFFFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF7B3FB4FF7A41B5FF7944B9FF7C48BEFF8051C4FF845DCAFF8667CEFF866CD0FF8572D2FF8478D5FF847CD7FF8580DAFF8784DDFF8785DEFF8785DEFF8583DDFF8786DDFF8987DCFF8985DAFF8983D9FF8A7ED6FF8978D3FF8976CFFF8C73CFFF8B6DCCFF8863C7FF865DC4FF885CC0FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF6E34A6FF6F36A9FF723AAEFF763FB3FF7B48B9FF7F53BEFF815CC1FF7E60C3FF7E64C6FF806BCAFF806FCDFF8274D0FF8477D2FF8277D1FF8176D1FF8176D2FF8378D2FF8479D1FF8578D0FF8475CDFF8473CCFF846DC9FF8265C5FF8163C2FF8563C1FF805CBBFF7B50B7FF7B49B4FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF672D9AFF692E9EFF6C31A4FF7137AAFF7841B1FF7C4AB6FF7B50BAFF7952BBFF7A57BEFF7A5EC1FF7A62C4FF7E67C7FF806AC8FF7E6AC7FF7D69C7FF7D69C7FF7E6BC8FF7F6BC8FF816BC7FF8168C5FF8066C2FF7F62BFFF7B5ABAFF7753B5FF7B54B6FF7C54B4FF7749AEFF713CA9FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF622694FF632895FF672B9BFF7031A3FF763AABFF783FB0FF7641B1FF7344B2FF734BB5FF7552B7FF7755BBFF795ABDFF7B5EBDFF7B5EBDFF7A5DBDFF7A5CBDFF7B5EBDFF7B5EBDFF7B5DBBFF7C5CBAFF7A59B8FF7857B6FF7752B2FF7249AFFF7245ACFF7447A9FF7644A8FF6F39A2FFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF5D1F8AFF5F208EFF652495FF6D2C9CFF7234A3FF7236A6FF7037A9FF6D3BAAFF6E42ACFF7047AFFF7249B1FF744DB2FF754FB4FF754FB4FF754FB4FF7550B4FF7550B3FF7651B2FF7653B2FF7652B2FF744FAFFF714AACFF714AABFF7043A8FF6D3AA2FF6C39A1FF703CA0FF6E379DFFDEDEDEFF1A1A1AFF1A1A1AFFDEDEDEFF5B1984FF5F1B87FF641E8EFF692595FF6C2C9AFF6B2C9DFF6A2C9FFF6930A2FF6A37A4FF6D3CA7FF6C3DA9FF6E40ABFF6F42ABFF6E43ABFF6E43AAFF6E43A9FF6F45AAFF7049A9FF7048A9FF7247A9FF7045A7FF6C3EA4FF6D3CA4FF6F3BA2FF6A359CFF662E97FF663096FF6A3396FFDEDEDEFF1A1A1AFF484848CBDBDBDBFF59157FFF5C1681FF611A87FF64208EFF662392FF652395FF632497FF622799FF642C9CFF67319FFF6833A0FF6936A2FF6A39A2FF6A3AA1FF693AA0FF693AA0FF6A3BA2FF6B3E9FFF6A3C9FFF6D3FA1FF6A3B9EFF69359DFF68309DFF6A329AFF683097FF602890FF5E258CFF622A8EFFDBDBDBFF484848CBA7A7A761747474FFDBDBDBFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDBDBDBFF747474FFA7A7A761FBFBFB05A7A7A761484848CB202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF202020FF484848CBA7A7A761FBFBFB05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000034323836
)
WriteFile( A_ScriptDir "\PinkSunset.ico" ,IconData)
IconData =
}
ifnotexist, %A_ScriptDir%\SunAndClouds.ico
{
IconData =
(join
0000010001002020000001002000A8100000160000002800000020000000400000000100200000000000801000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A0807010504040B000000180000001D0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001E000000180505040B0D0C0B01000000000000000000000000000000000000000016120E020605031E0000005F02020297030303A2030303A3030302A3030303A3030302A3030302A3030303A3030303A3030302A3030302A3030302A3030302A3030302A3030302A3030303A3030302A3030302A3030302A3030303A3030302A202020298000000600807061F221E190200000000000000000000000000000000100E0B110A08067C8A7056F2DCB691FFE0BA93FFE1B78FFFE1B78DFFEFC9A4FFF1D0B0FFF2CFAFFFF6DABDFFF9E0C7FFF8DEC4FFF8DCC1FFF9DEC4FFFAE1C9FFFBE3CCFFF9E0C8FFFBE3CBFFFCE7D1FFFBE2C9FFF2D1B0FFF2D1B0FFF5D8BBFFEFD6BDFFA39180F30E0C0A7D16120F11000000000000000000000000000000000303022C917C67EFE0B994FFDEB185FFE5BA91FFEAC29CFFE5B98FFFE5BB8FFFE4B98CFFDBAB7AFFDDB082FFE3BE96FFE8C39FFFE6BE98FFE0B68DFFEEC9A4FFF3D1AFFFEEC69EFFEDC9A3FFF6D6B6FFF8DABCFFF5D5B5FFF7D9BBFFF9DEC3FFF0CDAAFFE6BF97FF9E8A75EF0404032D00000000000000000000000027211C0102020157E3BE9AFFF1CFADFFEECBA7FFF0CCA8FFEFC6A1FFEDC59EFFF5D3B5FFF1CCAAFFF0CDAAFFEEC69FFFEEC69FFFEFC59EFFECC096FFF1CBA7FFF4D2AFFFF4D3B0FFECC399FFEDC69FFFF4D4B3FFFAE1C8FFF8DEC3FFFAE0C6FFFBE4CCFFF2D0AEFFEECAA4FFEBCEB0FF02020259423A32010000000000000000332B24010000005DEECAA7FFEFC9A7FFE9C39FFFDEAF83FFE0AD7DFFE2B48BFFE5B78AFFE3B588FFDAA875FFCC9660FFDDAB79FFDDB084FFD6A97BFFE2B78BFFE8BB8DFFE6B687FFE8BA8DFFF3CCA8FFF3CEABFFF7D7B8FFF4D1AFFFF0CBA4FFE8BC8FFFE1B17FFFF2CEA9FFF5D4B5FF0303026052483E010000000000000000393028010000005DE7C098FFDFB285FFE0B285FFD29D6CFFD09A65FFE8BB8FFFF0C8A2FFEABE94FFDDA876FFD49C66FFE6B98CFFEDC6A0FFEEC6A0FFF1C8A2FFEDC49FFFEAC096FFE5B787FFEEC79FFFF2CDA9FFF6D4B4FFF0CAA5FFEECBA7FFECC9A7FFEFCEACFFECC7A2FFF1D0AFFF030202605A4F44010000000000000000393028010100005DF0D0B5FFE0B58EFFE0B081FFE1B385FFE5B588FFE8BD93FFEEC49DFFEABF94FFDEB184FFE6BA90FFEBBF96FFEFC7A3FFF0C8A3FFEEC69DFFECC39BFFEEC6A0FFE9BE94FFE6B78BFFE5BA8DFFE2B689FFE4BB92FFE9BA8EFFECC299FFEBC096FFEFCBA7FFF3D4B8FF030202605A4E43010000000000000000393129010000005DE1B489FFE2B384FFEBC49EFFEFC7A2FFEEC7A1FFF4D2B2FFF4D2B2FFEFC7A0FFEDC49DFFEFC7A2FFE5B685FFEBC197FFEBC29AFFE6B78BFFEEC59FFFF0C7A2FFEEC39AFFEDC29BFFECC29CFFE4B991FFE3BB96FFEEC7A2FFEEC5A0FFE8BD92FFE4B88BFFE9C39BFF03030260594F4401000000000000000038302A010100005DEFD1B7FFEDCDB0FFEDCAAAFFEDC8A8FFECC7A5FFF0CEAFFFEAC19DFFF0CCADFFF3D3B6FFF7D9BEFFF3D2B6FFF7D9BFFFF3D3B4FFF7DAC0FFF7DBC1FFF4D4B8FFF3D4B8FFF7DDC5FFF6DAC1FFF6DDC5FFF5DAC0FFF0D3B6FFF2D6BCFFF2D7BCFFF1D5BBFFF2D9C2FF030302605A5149010000000000000000382F28010100005DE9C4A9FFE8C0A3FFEDCAB0FFF0CFB5FFF1D0B7FFF4D2B8FFF8DBC8FFFAE1D0FFF6D8C1FFF4D6BEFFF1DBC5FFEDDCC8FFECE0CEFFECDFCCFFEEE2D0FFF3E7D9FFF8E9DCFFFBEBDFFFFCECE1FFFCECE2FFFBECE2FFFAEBE0FFFAEBE2FFF8EBE1FFF9EBE2FFF8EBE1FF030303605A524B010000000000000000382E27010000005DE8BD9EFFE8B896FFEFC9AEFFF0C5A7FFF5D1B7FFF7D3B9FFF8D8C1FFF6DAC4FFF1DDC8FFE7D4BAFFDBCEB1FFD2D2B7FFCFDFCBFFD0E3D3FFD6E7D8FFE1E9DCFFECECE0FFF5ECE0FFFAECE0FFFCEBDFFFFCE9DCFFFBE7D9FFF9E6D8FFF8E4D6FFF7E5D7FFF6E5D8FF030303605A524C010000000000000000372C24010000005DE8B896FFEEC3A5FFF1C9ADFFF0B892FFF2B992FFF5C19EFFF3C8A8FFEED0B4FFE3D8BFFFD0D6BDFFB9D0B3FFA3D0B8FF84C8C3FF85D2D1FFA8ECE3FFBFEFE4FFD4EEE2FFE7EDE0FFF4ECDFFFFAEADDFFFCE7D9FFFCE7D9FFFBE8DBFFF9E2D4FFF6DECCFFF2D8C4FF0302025F594E46010000000000000000372A20010000005DE7AB82FFECB28AFFF3C5A5FFF2B084FFF5BB94FFF7CFB2FFF3DAC4FFE6E0CCFFCAD2B6FFA4CEB4FF44ACC4FF0790C9FF008DC9FF008DC9FF0791CBFF46B9D9FFAAF0E9FFD0EFE3FFE8EBDEFFF6EADCFFFCE8DAFFFEE8DAFFFDE8DBFFFBE6D7FFF3CCB0FFEDBD9BFF0302025F594B4101000000000000000037271C010000005DE6A070FFECA373FFF2AD80FFF4AB7CFFF5B387FFF4C39FFFEBD0B1FFD4DAC1FFA9DBC7FF27A1C8FF0091CCFF0092CCFF0092CCFF0092CCFF0092CCFF0091CCFF26A8D5FFACEFE7FFD7EEE0FFEFEADCFFFCE9DBFFFEE7D8FFFDE4D4FFFDE4D4FFF8D9C3FFEFBB98FF0302025F594A3F010000000000000000372519010000005DE69158FFEC8E50FFF08F50FFF18B4AFFF3975CFFEFA976FFE0BD94FFBEC8A4FF4EB2C1FF0099D1FF009AD2FF009DD3FF00A0D5FF00A0D5FF009DD3FF009AD2FF0099D1FF4EBCD3FFC0D6B9FFE4D9BFFFF9E5D2FFFFE6D4FFFEDFCAFFFEE2D1FFFCE3D2FFF7D4BCFF0302025F5A4C42010000000000000000382316010000005DE98C4EFFF08845FFF18641FFF38641FFF28A45FFEA8C48FFD4A269FFACBD92FF0EA4D5FF00A6DCFF00AEE0FF00B4E4FF00B7E7FF00B7E7FF00B4E4FF00AEE0FF00A7DCFF0CA3D5FFA9B587FFD39C5FFFF2BF96FFF9B486FFF9B589FFFEDFCAFFFEE3D1FFFBDECCFF030302605C4F47010000000000000000392314010000005DEE8A4AFFF2823BFFF38037FFF48034FFF48033FFEA873EFFD19E60FF99BA99FF00B2E6FF00BDECFF00C3F1FF00C9F7FF00CEFBFF00CEFBFF00C9F7FF00C3F1FF00BDECFF00B3E6FF96B897FFD19C5EFFEA883FFFF4843AFFF89A5DFFFDCFB0FFFFDFCBFFFDDECAFF030303605D50480100000000000000003A2314010000005DF28A47FFF48137FFF68034FFF67F32FFF78032FFEE893FFFD69F60FFA0BD97FF00BAEDFF00C9F7FF00D1FDFF00DAFFFF16E6FFFF16E6FFFF00DAFFFF00D2FDFF00C9F8FF00BBEEFF9DBD98FFD5A060FFEF8A40FFF78133FFF78033FFF78C47FFFECEAEFFFED8C0FF030302605D4B3F0100000000000000003A2314010100005DF68B48FFF78339FFF88236FFFA8235FFFC8335FFF58C40FFE09E5CFFB8BE8BFF1BBFE6FF00D1FEFF00DAFFFF04E6FFFF51F8FFFF52F8FFFF04E6FFFF00DAFFFF00D1FEFF19BFE7FFB8BF8DFFE0A05DFFF68C41FFFC8436FFFB8336FFF98337FFFA9758FFFBAD7BFF0302025F5D44340100000000000000003B2314010100005DF98D4AFFFA853BFFFC8539FFFE8538FFFF8638FFFC8D40FFEE9C56FFCFB67DFF6DC5C1FF00D9FDFF00E3FFFF05ECFFFF3CF9FFFF3DF9FFFF05ECFFFF00E4FFFF00DBFEFF6CC5C2FFCFB87FFFEE9E58FFFC8E41FFFF8739FFFE8639FFFD863AFFFB8A43FFFA8F4DFF0302025F5D3D290100000000000000003C2415010100005DFC8F4DFFFD883EFFFE883CFFFF893CFFFF8B3CFFFF9041FFFC9B51FFE9AE6DFFC7CA97FF53CFD8FF02E9FEFF02F4FFFF19FBFFFF1AFBFFFF02F4FFFF02EAFEFF51D0DAFFC7CC98FFE9AF6EFFFC9C52FFFF9143FFFF8C3DFFFF8A3DFFFF893DFFFE883FFFFD904DFF0302025F5D38210100000000000000003D2415010100005DFE914FFFFF8B42FFFF8B40FFFF8C3FFFFF8F41FFFF9344FFFF9B4DFFFCA860FFEDBB7BFFD0D39FFF83D6CCFF33E2EEFF13E7F9FF13E7F9FF32E2EEFF83D7CDFFD1D4A0FFEDBC7CFFFDA961FFFF9C4FFFFF9445FFFF9042FFFF8E41FFFF8C41FFFF8B42FFFE924FFF0302025F5E371F0100000000000000003D2516010100005CFE9451FFFF8E45FFFF8E43FFFF9044FFFF9445FFFF9748FFFF9C4EFFFFA558FFFEB169FFF9C17FFFEBD297FFDBDFABFFD2E7B7FFD2E7B8FFDBE0ACFFEBD398FFF9C280FFFEB36BFFFFA65AFFFF9D4FFFFF9849FFFF9547FFFF9245FFFF8F44FFFF8E46FFFF9451FF0302025F5E3820010000000000000000000000000100005AFE9553FFFF9048FFFF9147FFFF9448FFFF984BFFFF9B4DFFFFA051FFFFA658FFFFAE62FFFFB86DFFFFC27BFFFECB87FFFDD08EFFFDD08EFFFECB88FFFFC37CFFFFB96FFFFFB063FFFFA859FFFFA152FFFF9D4EFFFF994BFFFF9549FFFF9349FFFF9149FFFF9553FF0302025C0000000000000000000000000000000019100949F69253FFFF934AFFFF954CFFFF984DFFFF9B4FFFFFA052FFFFA556FFFFA95BFFFFB061FFFFB668FFFFBC6FFFFFC275FFFFC578FFFFC579FFFFC376FFFFBE70FFFFB769FFFFB162FFFFAB5CFFFFA658FFFFA154FFFF9D50FFFF994EFFFF964DFFFF934BFFF79353FF1D120A4B000000000000000000000000000000005E38200CA1643CE4FF934BFFFF974FFFFF9A51FFFF9F53FFFFA357FFFFA85BFFFFAE5FFFFFB364FFFFB96AFFFFBD6EFFFFC172FFFFC373FFFFC374FFFFC172FFFFBE70FFFFBA6BFFFFB566FFFFAF61FFFFAA5CFFFFA558FFFFA054FFFF9C52FFFF9850FFFF944CFFA2653CE6673E220C00000000000000000000000000000000000000007B4B2B36AC6C41E4F49857FFFFA15CFFFFA65FFFFFAB63FFFFB067FFFFB56CFFFFBB71FFFFC076FFFFC47AFFFFC87DFFFFCB7FFFFFCB7FFFFFC97EFFFFC57AFFFFC177FFFFBC72FFFFB76DFFFFB169FFFFAC64FFFFA760FFFFA25DFFF59957FFB27144E47E4E2C3700000000000000000000000000000000000000000000000000000000A666390583522F39643F24456340254562422645624428456245294562472B4562492D45624B2E45624C3045624D3045624D3045624D3045624C2F45624A2E4562482C4562462A45624528456243274562412645644025458655313AA9693B050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFE0000007C0000003C0000003C00000038000000180000001800000018000000180000001800000018000000180000001800000018000000180000001800000018000000180000001800000018000000180000001800000018000000180000001C0000003C0000003C0000003E0000007F000000FFFFFFFFFFFFFFFFF
)
WriteFile( A_ScriptDir "\SunAndClouds.ico" ,IconData)
IconData =
}




ifnotexist, %A_ScriptDir%\transparent_square.ico
{
IconData =
(join
0000010001002020000001002000A8100000160000002800000020000000400000000100200000000000001000004D2800004D2800000000000000000000000000E8000000B6000000B2000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B3000000B2000000B6000000E8000000B700000014000000090000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000A0000000900000014000000B7000000B40000000A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A000000B4000000B40000000B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000B000000B4000000B40000000C000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C000000B5000000B50000000C000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C000000B5000000B50000000C000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000D000000B5000000B50000000D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000D000000B5000000B50000000D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E000000B5000000B50000000E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E000000B6000000B60000000E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F000000B6000000B60000000E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F000000B6000000B60000000F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000B6000000B60000000F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000B6000000B6000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000B6000000B6000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000B7000000B6000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000B7000000B6000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000B7000000B7000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013000000B7000000B7000000120000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013000000B7000000B7000000120000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000014000000B7000000B7000000130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000014000000B7000000B7000000130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000015000000B7000000B7000000140000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000000B7000000B7000000140000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000000B7000000B7000000150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000017000000B7000000B7000000150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000017000000B7000000B7000000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018000000B7000000B7000000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000019000000B6000000B6000000150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000019000000B6000000BE000000320000001C0000001C0000001B0000001A0000001A00000019000000180000001700000017000000160000001500000014000000140000001300000012000000120000001100000010000000100000000F0000000F0000000E0000000D0000000D0000000C0000000C0000000B0000000900000023000000B8000000C0000000B9000000B5000000B5000000B5000000B5000000B6000000B6000000B6000000B6000000B6000000B6000000B6000000B6000000B6000000B6000000B6000000B6000000B6000000B6000000B5000000B5000000B5000000B5000000B5000000B4000000B4000000B4000000B3000000B3000000BC000000D5000000000000000000000000000000001E005E00000000000000000000000000000020000000000000700070000000000040004000000000003000300000000000700070000A800800000000000AA008000000000000000000800080000000000000000001050100000000000000000000700070000000000000000000000000
)
WriteFile( A_ScriptDir "\transparent_square.ico" ,IconData)
IconData =
}
ifnotexist, %A_ScriptDir%\Hotkeys.ico
{
IconData =
(join
0000010001003030000001000800A80E000016000000280000003000000060000000010008000000000000090000000000000000000000010000000100000000000093807500998273009B8374009C8B7E009F8F830096918F00949290009B979400A08F8400A1918500A5938600A5948600AA948500A3948800A6958A00A6988E00AA988A00AA9A8E00AE9A8D00B29D8F00A5979000A0989300AC9B9000AB9E9200AD9E9200AE9E9400A09B9800B19E9100AEA09300AFA09500B3A09300B0A19600B6A39400B8A59500B1A19800B2A49800B5A69A00B6A69D00BAA69900B8A79C00B5A89B00B6A89D00BBAA9B00BCA99B00B8A99E00A7A5A300AAA3A000AFA6A000AEA9A400B0A6A000B6AAA100B9ABA100B9ACA100BCADA300BBAEA400BCAEA400BEB0A500BFB1A800BFB9B600C1AC9E00C2ADA000C2B2A500C4B1A600C8B4A700C7BBA500C0B2A900C2B5AA00C4B6AA00C1B6AD00C4B7AD00C3B9AD00C4B8AE00C9BBAA00CCBBAE00CBBCAF00D0BBAC00C0B7B100C6BAB000C7BCB100C7BCB400C8BBB100CCBBB000C8BCB200CEBEB100C9BBB400CABEB500CCBEB600C3BDB800C4BDB900CDC1AA00CEC2AD00CAC0B700CCC0B600CBC2B800CDC1B900CEC4BA00D0C0B200D1C1B500D4C3B600D1C6B700D7C4B500D4C9B600D8C9B500D1C4BA00D6C5BA00D1C6BC00D5C7BD00D2C9B800D2C8BF00D5C9BF00D9C9B900DACCBA00D9C9BD00DCCABE00DACCBD00DCCDBE00DCD0BF00CFC8C000D2C9C200D5CAC100D6CCC100D5CDC600DFCAC200DBCEC200DDCDC100D9CEC500DECFC400DED0C100DDD0C500DAD0C900DCD1C800DDD4C900DFD5CE00DDD8CB00DED6D000DFD9D500E0CEC200E0CFC400E0D0C200E1D1C500E0D6C700E4D5C700E2D2C800E4D3C800E2D4C900E4D5C900E1D6CC00E5D6CD00E5D8CB00E1D9CD00E5D8CD00E8D9CB00E8DACF00E1D9D100E6DAD100E2DCD200E6DCD100E1DCD600E5DDD500E8DAD000E9DCD200ECDCD000E9DDD500E7DED800EADFD800ECDFD800EAE0D600ECE1D600EAE4D700E6E1D800EAE1D900ECE2DA00E9E4D900EEE4DA00E9E3DC00EAE5DE00EDE5DD00EDE9DD00F4E6D600F1E7DD00F2E9DF00F6EADF00EEE6E100EEE9E200EEE8E500F0E7E000F1E8E100F4EAE300F2ECE100F1EAE500F1ECE500F4ECE500F2EDE800F5EFE900F4EFED00F3F0EB00F5F1E800F3F0ED00F6F1ED00F6F4EF00F8F1EB00F8F6EB00F5F2F000F7F4F000F8F5F100FAF6F400F8F8F200FAF9F600FCF9F600FCFAF800FDFCFA00FEFEFE00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005931310000000000000000000000000000000000000000000000000000000000000000000000000000000000878192A2B6B34C313100000000000000000000000000000000000000000000000000000000000000000000008271718EA2A29D92B7B7222563303100000000000000000000000000000000000000000000000000000000006B61718E99A2A29D99929292BEA22133364A632F310000000000000000000000000000000000000000000000004A6F8E9299999292929292929D929DC3991C3645484563522E310000000000000000000000000000000000000000006F999292818989898A9292929D9D9DA0CD921C364548525E528931310000000000000000000000000000000000000000CB8989898989898E83929292A09DA0A2D0920F394548525E785EA8B731000000000000000000000000000000000000000092898989818A8A929292929DA29DA4D0890F394348505E6B6DAA822B1507310000000000000000000000000000000000A08978898A8E718A9292A09D9DA4B7D06B0B39454552615E6FB776450F432D3100000000000000000000000000000000C182718A8A8E8A929292A09D9DA2B7D0610B394545485E5E789D786B113645693231000000000000000000000000000000A2718A718E898A9292A09DA4A4BED0400B3643434552509287B9711C3A50486B6B310000000000000000000000000000A48E718E8E8A8E9292A0A2A4A8BED04309363943454848A482CD711C3A48525E6B893131000000000000000000000000B799718A8A8E8992929DA2A4B7BED02B092536454548529D83D052253A48525E6B76C550060000000000000000000000C5A4718A8E899292A09D9DA4A2C5D01F04212D2B39395E8287D0401C454550615E89AA5063283131000000000000000000B78E718971898992A0A2B7B7CDD02B01091C332D25826DBED03D1C4545485E5E88827A631C5052310000000000000000B7A2718EA0B7BEBEC3C1C3CBD0D1CB885E1C151C2D826FC5D0281C39454552509978C3611D455289313100000000000000C5B4B7B79DB7C3C5CBB9BEC3C5CDD0D0CB9D50335082CDD01F1139454548528789CB52214550616B9231000000000000000061415B75A4BEB9B7B7B7B7B7B7B7B9C5CFB450A2CDD00D102B3645435E8299D143213A50506F78CB0000000000000000000000828DB6B4B7A8998181716767718182B7A8CDD003041C362B367882B7D12B2F4548525EAA9D000000000000000000000000000000000000B763708E929DB7BEBEC3D1CD78250E101D2D8278BED11F2145455250BE9D000000000000000000000000000000000000BEB6BEB9B9C5C5D1C5B9C5D1D0D0B97A33255E82C0D1111D45434850B700000000000000000000000000000000000000009D675B6786BEB9B4B7B9B7B7B9C3CBC58652A8BED00D1C2B45456182000000000000000000000000000000000000000000000000829DB6B9B799828E6767717599A2B7C3D1030425332B7888000000000000000000000000000000000000000000000000000000000000C38E89929DB7B7B7BED1D15E25101C1D820000000000000000000000000000000000000000000000000000000000000000BEA8A8AAB4C5C5B9BEC5D0D0C5883A5E00000000000000000000000000000000000000000000000000000000000000000000785B99BEBEBEBEB4B79DB7B4B00000000000000000000000000000000000000000000000000000000000000000000000000000AA99999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFF8FFFFFFF0000FFF803FFFFFF0000FF8000FFFFFF0000F800003FFFFF0000C000000FFFFF000080000007FFFF000080000003FFFF0000C00000007FFF0000C00000003FFF0000C00000000FFF0000E000000007FF0000E000000001FF0000E000000000FF0000E0000000001F0000F0000000000F0000F000000000030000F800000000010000FE00000000010000FFC0000000010000FFFF800000010000FFFF800000030000FFFFC00000030000FFFFFC0000030000FFFFFFF000070000FFFFFFF800070000FFFFFFFE000F0000FFFFFFFFC1FF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000
)
WriteFile( A_ScriptDir "\Hotkeys.ico" ,IconData)
IconData =
}
Return

TurnHotkeysOff:
Hotkey, IfWinActive, ahk_group BrowserWindows ;these hotkeys will only be active when one of the browsers is active
Loop 10
 {
  IniRead, savedHK%A_Index%, SpaConfig.ini, Hotkeys, HotkeyLabel%A_Index%, %A_Space%
  if ( savedHK%A_Index% <> "" and savedHK%a_index% <> "Error" ) 
   {
    Hotkey, % savedHK%A_Index% , HotkeyLabel%A_index%, Off, UseErrorLevel
    if ErrorLevel in 2,3,4
     {
      MsgBox,4112,SavePictureAs Error [1015],There was an error disabling the hotkey for "Favorite Folder #%a_index%".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" and verify your chosen hotkey is correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
     }
   }
 }

;11 Default Folder
IniRead, savedHK11, SpaConfig.ini, Hotkeys, HotkeyLabel11, %A_Space% 
if ( savedHK11 <> "" and savedHK11 <> "Error" )
 {
  Hotkey, %savedHK11%, HotkeyLabel11, Off, UseErrorLevel
  if ErrorLevel in 2,3,4
   {
    MsgBox,4112,SavePictureAs Error [1016],There was an error disabling the hotkey for your "Default Folder".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" and verify your chosen hotkey is correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
 }

;Hotkey 12 and 13 were reversed when I rearranged the gui. Need to keep Special Folder at Hotkey Label13 for backward compatibility
;13 Special Folder
IniRead, savedHK13, SpaConfig.ini, Hotkeys, HotkeyLabel13, %A_Space% 
if ( savedHK13 <> "" and savedHK13 <> "Error" )
 {
  Hotkey, %savedHK13%, HotkeyLabel13, Off, UseErrorLevel
  if ErrorLevel in 2,3,4
   {
    MsgBox,4112,SavePictureAs Error [1017],There was an error disabling the hotkey for your "Special Folder".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" and verify your chosen hotkey is correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
 }

Hotkey, IfWinActive

;12 ;Rename last saved picture
IniRead, savedHK12, SpaConfig.ini, Hotkeys, HotkeyLabel12, %A_Space%  
if ( savedHK12 <> "" and savedHK12 <> "Error" )
 {
  Hotkey, %savedHK12%, HotkeyLabel12, Off, UseErrorLevel
  if ErrorLevel in 2,3,4
   {
    MsgBox,4112,SavePictureAs Error [1018],There was an error disabling the hotkey for "Rename Last Saved Picture".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" and verify your chosen hotkey is correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
  }

;14 Capture Active Window ;off by one because SpecialFolder needs to stay at HotkeyLabel13 for backward compatibility
IniRead, savedHK14, SpaConfig.ini, Hotkeys, HotkeyLabel14, %A_Space% 
if ( savedHK14 <> "" and savedHK14 <> "Error" ) 
 {
  Hotkey, %savedHK14%, HotkeyLabel14, Off, UseErrorLevel
  if ErrorLevel in 2,3,4
   {
    MsgBox,4112,SavePictureAs Error [1019],There was an error disabling the hotkey for "Capture Active Window".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" and verify your chosen hotkey is correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
 }

;15 Capture Entire Screen - off by one because SpecialFolder needs to stay at HotkeyLabel13 for backward compatibility
IniRead, savedHK15, SpaConfig.ini, Hotkeys, HotkeyLabel15, %A_Space% 
if ( savedHK15 <> "" and savedHK15 <> "Error" )
 {
  Hotkey, %savedHK15%, HotkeyLabel15, Off, UseErrorLevel
  if ErrorLevel in 2,3,4
   {
   MsgBox,4112,SavePictureAs Error [1020],There was an error disabling the hotkey for "Capture Entire Screen".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" and verify your chosen hotkey is correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
 }

;16 Capture Area of Screen
IniRead, savedHK16, SpaConfig.ini, Hotkeys, HotkeyLabel16, %A_Space% 
if ( savedHK16 <> "" and savedHK16 <> "Error" ) 
 {
  Hotkey, %savedHK16%, HotkeyLabel16, Off, UseErrorLevel
  if ErrorLevel in 2,3,4
   {
    MsgBox,4112,SavePictureAs Error [1021],There was an error disabling the hotkey for "Capture Area of Screen".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" and verify your chosen hotkey is correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
 }
return

TurnHotkeysOn:
Hotkey, IfWinActive 
;Hotkeys for Capture Entire Screen, Capture Active Window, Capture Area of Screen, Rename Last Saved Picture will always be active
;Active Window #13 on Configure Hotkeys & Folders gui is HotkeyLabel14
IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel14
if ( TempVar <> "ERROR" and TempVar <> "" )
 {
  Hotkey, %TempVar% ,HotkeyLabel14,On, UseErrorLevel
  if ErrorLevel in 2,3,4
   {
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel14
    MsgBox,4112,SavePictureAs Error [1022],There was an error enabling the hotkey for "Capture Active Window".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
 }
 
;Entire Screen #14 on Configure Hotkeys & Folders gui is HotkeyLabel15
IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel15
if ( TempVar <> "ERROR" and TempVar <> "" )
 {
  Hotkey, %TempVar% ,HotkeyLabel15,On, UseErrorLevel
  if ErrorLevel in 2,3,4
   {
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel15
    MsgBox,4112,SavePictureAs Error [10323],There was an error enabling the hotkey for "Capture Entire Screen".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
 }
 
;Area Window #15 on Configure Hotkeys & Folders gui is HotkeyLabel16
IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel16
if ( TempVar <> "ERROR" and TempVar <> "" )
 {
  Hotkey, %TempVar% ,HotkeyLabel16,On, UseErrorlevel 
  if ErrorLevel in 2,3,4
   {
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel16
    MsgBox,4112,SavePictureAs Error [1024],There was an error enabling the hotkey for "Capture Active Window".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
 }
 
;Rename Last Saved Picture on Configure Hotkeys & Folders gui is HotkeyLabel12
IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel12
if ( TempVar <> "ERROR" and TempVar <> "" )
 {
  Hotkey, %TempVar% ,HotkeyLabel12,On, UseErrorLevel 
  if ErrorLevel in 2,3,4
   {
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel12
    MsgBox,4112,SavePictureAs Error [1025],There was an error enabling the hotkey for "Rename Last Saved Picture".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
 }

Hotkey, IfWinActive, ahk_group BrowserWindows  ;Hotkeys for Favorites 1-10, Special Folder, and the Default Folder will only be active when a supported browser is active
Loop, 11     ; % #ctrls        ;activate all hotkeys
 {
  IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel%a_index%
  if ( TempVar <> "ERROR" and TempVar <> "" )
   {
    Hotkey, %TempVar% ,HotkeyLabel%A_Index%,On, UseErrorLevel 
    if ErrorLevel in 2,3,4
     {
      if A_index < 11
       {
        IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel%A_Index%
        MsgBox,4112,SavePictureAs Error [1026],There was an error enabling the hotkey for "Favorite Folder #%a_index%".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
       }
      else
       {
        IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel%A_Index%
        MsgBox,4112,SavePictureAs Error [1026],There was an error enabling the hotkey for the "Default Folder".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
       }
     }
   }
 }

;Special Folder #12 on Configure Hotkeys & Folders gui is HotkeyLabel13
IniRead,TempVar,SpaConfig.ini,Hotkeys,HotkeyLabel13
if ( TempVar <> "ERROR" and TempVar <> "" )
 {
  Hotkey, %TempVar% ,HotkeyLabel13,On, UseErrorLevel
  if ErrorLevel in 2,3,4
   {
    IniWrite,%a_space%,SpaConfig.ini,Hotkeys,HotkeyLabel13
    MsgBox,4112,SavePictureAs Error [1027],There was an error enabling the hotkey for your "Special Folder".`n`nPlease go to Configure Hotkeys & Folders setup found by clicking on the system tray icon then "Settings" to correct.`n`nFor more information on Hotkeys please email Support@SavePictureAs.com
   }
 }
Hotkey, IfWinActive 
return

UpdateCheckForUpdatesDailyTimer:
IniRead,CheckForUpdatesDaily,spaconfig.ini,CheckForUpdates,CheckForUpdatesDaily,1
if ( CheckForUpdatesDaily = 1 and CurrentlyInSetup <> "Yes" )
 SetTimer,CheckForUpdatesDaily,on
return

GetDimensions:
GDIPToken := Gdip_Startup()                                     
pBM := Gdip_CreateBitmapFromFile( imagefile )                 
W:= Gdip_GetImageWidth( pBM )
H:= Gdip_GetImageHeight( pBM )   
Gdip_DisposeImage( pBM )                                          
Gdip_Shutdown( GDIPToken )                                        
return

;-----------------------------------------------------------Functions-------------------------------------------------------------------
;Functions:
;EnableGuiDrag
;Scrollable Gui
;Get Image Size
;Get right click menu contents
;Common dialog for changing Gui and font colors
;ScrollBar code thanks to Lexikos from http://www.autohotkey.com/forum/viewtopic.php?t=28496&start=0
;UrlDownloadToVar
;Control_Colors
;CaptureScreen
;functions by Lexicos to create a resizable gui with a thin border.
;Calc_MD5 function posted by Rseding91 from http://www.autohotkey.com/board/topic/77408-md5-function-for-comparing-images/
;Hide Cursor
;Ping() 
/*
Compare:
FileRead,File,%A_ScriptFullPath%
FileGetSize,FileSize,%A_ScriptFullPath%
HashValue := Calc_MD5(&File,FileSize)
MsgBox %HashValue%
return
*/
;Get Hash Value of a file
Calc_MD5(_VarAddress, _VarSize)
 {
  Static Hex = "123456789ABCDEF0"
  Ptr := A_PtrSize ? "Ptr" : "Uint"
  , VarSetCapacity(MD5_CTX,104,0)
  , DllCall("advapi32\MD5Init",Ptr,&MD5_CTX)
  , DllCall("advapi32\MD5Update",Ptr,&MD5_CTX,Ptr,_VarAddress,"UInt",_VarSize)
  , DllCall("advapi32\MD5Final",Ptr,&MD5_CTX)
  Loop,16
   N := NumGet( MD5_CTX,87+A_Index,"Char"), MD5 .= SubStr(Hex,N>>4,1) . SubStr(Hex,N&15,1)
  Return MD5
}

Ping(Address="8.8.8.8",Timeout = 1000,ByRef Data = "",Length = 0,ByRef Result = "",ByRef ResultLength = 0)
 {
  NumericAddress := DllCall("ws2_32\inet_addr","AStr",Address,"UInt")
  If NumericAddress = 0xFFFFFFFF ;INADDR_NONE
   Return 0 ;throw Exception("Could not convert IP address string to numeric format.")

  If DllCall("LoadLibrary","Str","icmp","UPtr") = 0 ;NULL
   Return 0 ;throw Exception("Could not load ICMP library.")

  hPort := DllCall("icmp\IcmpCreateFile","UPtr") ;open port
  If hPort = -1 ;INVALID_HANDLE_VALUE
   Return 0 ;throw Exception("Could not open port.")

  StructLength := 278 ;ICMP_ECHO_REPLY structure
  VarSetCapacity(Reply,StructLength)
  Count := DllCall("icmp\IcmpSendEcho","UPtr",hPort,"UInt",NumericAddress,"UPtr",&Data,"UShort",Length,"UPtr",0,"UPtr",&Reply,"UInt",StructLength,"UInt",Timeout)
  
  If NumGet(Reply,4,"UInt") = 11001 ;IP_BUF_TOO_SMALL
   {
    VarSetCapacity(Reply,StructLength * Count)
    DllCall("icmp\IcmpSendEcho","UPtr",hPort,"UInt",NumericAddress,"UPtr",&Data,"UShort",Length,"UPtr",0,"UPtr",&Reply,"UInt",StructLength * Count,"UInt",Timeout)
   }
  
  If NumGet(Reply,4,"UInt") != 0 ;IP_SUCCESS
   Return 0 ;throw Exception("Could not send echo.")
  
  If !DllCall("icmp\IcmpCloseHandle","UInt",hPort) ;close port
   Return 0 ;throw Exception("Could not close port.")

  ResultLength := NumGet(Reply,12,"UShort")
  VarSetCapacity(Result,ResultLength)
  DllCall("RtlMoveMemory","UPtr",&Result,"UPtr",NumGet(Reply,16),"UPtr",ResultLength)
  Return, NumGet(Reply,8,"UInt")
 }
;shimanov from  http://www.autohotkey.com/board/topic/5727-hiding-the-mouse-cursor/#entry35098
;Laszlo from http://www.autohotkey.com/board/topic/5727-hiding-the-mouse-cursor/#entry35221
SystemCursor(OnOff=1)   ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others
{
    static AndMask, XorMask, $, h_cursor
        ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors
        , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13   ; blank cursors
        , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13   ; handles of default cursors
    if (OnOff = "Init" or OnOff = "I" or $ = "")       ; init when requested or at first call
    {
        $ = h                                          ; active default cursors
        VarSetCapacity( h_cursor,4444, 1 )
        VarSetCapacity( AndMask, 32*4, 0xFF )
        VarSetCapacity( XorMask, 32*4, 0 )
        system_cursors = 32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650
        StringSplit c, system_cursors, `,
        Loop %c0%
        {
            h_cursor   := DllCall( "LoadCursor", "uint",0, "uint",c%A_Index% )
            h%A_Index% := DllCall( "CopyImage",  "uint",h_cursor, "uint",2, "int",0, "int",0, "uint",0 )
            b%A_Index% := DllCall("CreateCursor","uint",0, "int",0, "int",0
                , "int",32, "int",32, "uint",&AndMask, "uint",&XorMask )
        }
    }
    if (OnOff = 0 or OnOff = "Off" or $ = "h" and (OnOff < 0 or OnOff = "Toggle" or OnOff = "T"))
        $ = b  ; use blank cursors
    else
        $ = h  ; use the saved cursors

    Loop %c0%
    {
        h_cursor := DllCall( "CopyImage", "uint",%$%%A_Index%, "uint",2, "int",0, "int",0, "uint",0 )
        DllCall( "SetSystemCursor", "uint",h_cursor, "uint",c%A_Index% )
    }
}
return

;Create embedded icons ;Maybe by aCkRiTe first http://www.autohotkey.com/board/topic/11143-alarm-clock/page-1#entry70405
WriteFile(file,data) 
{
   Handle :=  DllCall("CreateFile","str",file,"Uint",0x40000000
                  ,"Uint",0,"UInt",0,"UInt",4,"Uint",0,"UInt",0)
   Loop
   {
     if strlen(data) = 0
        break
     StringLeft, Hex, data, 2
     StringTrimLeft, data, data, 2
     Hex = 0x%Hex%
     DllCall("WriteFile","UInt", Handle,"UChar *", Hex
     ,"UInt",1,"UInt *",UnusedVariable,"UInt",0)
    }

   DllCall("CloseHandle", "Uint", Handle)
   return
}
GetMenu(hMenu) ;code by Sean from http://www.autohotkey.com/forum/viewtopic.php?t=21451&start=0
 { 
   Loop, % DllCall("GetMenuItemCount", "Uint", hMenu)
   {
      idx := A_Index - 1
      idn := DllCall("GetMenuItemID", "Uint", hMenu, "int", idx)
      nSize++ := DllCall("GetMenuString", "Uint", hMenu, "int", idx, "Uint", 0, "int", 0, "Uint", 0x400)
      VarSetCapacity(sString, nSize)
      DllCall("GetMenuString", "Uint", hMenu, "int", idx, "str", sString, "int", nSize, "Uint", 0x400)   ;MF_BYPOSITION
      If !sString
         sString := "---------------------------------------"
      sContents .= idx . " : " . idn . A_Tab . A_Tab . sString . "`n"
      If (idn = -1) && (hSubMenu := DllCall("GetSubMenu", "Uint", hMenu, "int", idx))
         sContents .= GetMenu(hSubMenu)
   }
   Return   sContents
 }
;color function Returns user choice in var color
;usage   CmnDlg_Color( color:=7995B0)
CmnDlg_Color(ByRef pColor, hGui=0)
 { 
  ;covert from rgb
    clr := ((pColor & 0xFF) << 16) + (pColor & 0xFF00) + ((pColor >> 16) & 0xFF) 
    VarSetCapacity(sCHOOSECOLOR, 0x24, 0) 
    VarSetCapacity(aChooseColor, 64, 0) 
    NumPut(0x24,		 sCHOOSECOLOR, 0)      ; DWORD lStructSize 
    NumPut(hGui,		 sCHOOSECOLOR, 4)      ; HWND hwndOwner (makes dialog "modal"). 
    NumPut(clr,			 sCHOOSECOLOR, 12)     ; clr.rgbResult 
    NumPut(&aChooseColor,sCHOOSECOLOR, 16)     ; COLORREF *lpCustColors 
    NumPut(0x00000103,	 sCHOOSECOLOR, 20)     ; Flag: CC_ANYCOLOR || CC_RGBINIT 
    nRC := DllCall("comdlg32\ChooseColorA", str, sCHOOSECOLOR)  ; Display the dialog. 
    if (errorlevel <> 0) || (nRC = 0) 
       Return  false 
  
    clr := NumGet(sCHOOSECOLOR, 12) 
    
    oldFormat := A_FormatInteger 
    SetFormat, integer, hex  ; Show RGB color extracted below in hex format. 
 ;convert to rgb 
    pColor := (clr & 0xff00) + ((clr & 0xff0000) >> 16) + ((clr & 0xff) << 16) 
    StringTrimLeft, pColor, pColor, 2 
    loop, % 6-strlen(pColor) 
		pColor=0%pColor% 
    pColor=0x%pColor% 
    SetFormat, integer, %oldFormat% 
	Return true
 }

UrlDownloadToVar(URL)
 {
  WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
  WebRequest.Open("GET", URL)
  WebRequest.Send()
  Return WebRequest.ResponseText
 }
/*
url=http://www.autohotkey.net/~maestrith/commands.xml
Gui,Add,Edit,w800 h500 -Wrap,% URLDownloadToVar(url)
Gui,show,
return
URLDownloadToVar(url){
    hObject:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
    hObject.Open("GET",url)
    hObject.Send()
    return hObject.ResponseText
}

*/





;functions by Sean from http://www.autohotkey.com/board/topic/17633-retrieve-addressbar-of-firefox-through-dde-message/
GetURL: ;retrieve URL in iexplore, firefox and opera - 
sTopic  := "WWW_GetWindowInfo"
sItem   := "0xFFFFFFFF"
idInst  := DdeInitialize()
hServer := DdeCreateStringHandle(idInst, sServer)
hTopic  := DdeCreateStringHandle(idInst, sTopic )
hItem   := DdeCreateStringHandle(idInst, sItem  )
hConv := DdeConnect(idInst, hServer, hTopic)
hData := DdeClientTransaction(0x20B0, hConv, hItem)   ; XTYP_REQUEST
sData := DdeAccessData(hData)
DdeFreeStringHandle(idInst, hServer)
DdeFreeStringHandle(idInst, hTopic )
DdeFreeStringHandle(idInst, hItem  )
DdeUnaccessData(hData)
DdeFreeDataHandle(hData)
DdeDisconnect(hConv)
DdeUninitialize(idInst)
Loop,	Parse,	sData, CSV
If	A_Index = 1
 URL	:= A_LoopField
return
;GetURL functions by Sean from http://www.autohotkey.com/board/topic/17633-retrieve-addressbar-of-firefox-through-dde-message/
DdeInitialize(pCallback = 0, nFlags = 0){
   DllCall("DdeInitialize", "UintP", idInst, "Uint", pCallback, "Uint", nFlags, "Uint", 0)
   Return idInst
}
DdeUninitialize(idInst){
   Return DllCall("DdeUninitialize", "Uint", idInst)
}
DdeConnect(idInst, hServer, hTopic, pCC = 0){
   Return DllCall("DdeConnect", "Uint", idInst, "Uint", hServer, "Uint", hTopic, "Uint", pCC)
}
DdeDisconnect(hConv){
   Return DllCall("DdeDisconnect", "Uint", hConv)
}
DdeAccessData(hData){
   Return DllCall("DdeAccessData", "Uint", hData, "Uint", 0, "str")
}
DdeUnaccessData(hData){
   Return DllCall("DdeUnaccessData", "Uint", hData)
}
DdeFreeDataHandle(hData){
   Return DllCall("DdeFreeDataHandle", "Uint", hData)
}
DdeCreateStringHandle(idInst, sString, nCodePage = 1004){    
   Return DllCall("DdeCreateStringHandle", "Uint", idInst, "Uint", &sString, "int", nCodePage)
}
DdeFreeStringHandle(idInst, hString){
   Return DllCall("DdeFreeStringHandle", "Uint", idInst, "Uint", hString)
}
DdeClientTransaction(nType, hConv, hItem, sData = "", nFormat = 1, nTimeOut = 10000){
   Return DllCall("DdeClientTransaction", "Uint", sData = "" ? 0 : &sData, "Uint", sData = "" ? 0 : StrLen(sData)+1, "Uint", hConv, "Uint", hItem, "Uint", nFormat, "Uint", nType, "Uint", nTimeOut, "UintP", nResult)
}
CaptureScreen(aRect = 0, bCursor = False, sFile = "", nQuality = "")
{
	If	!aRect
	{
		SysGet, nL, 76  ; virtual screen left & top
		SysGet, nT, 77
		SysGet, nW, 78	; virtual screen width and height
		SysGet, nH, 79
	}
	Else If	aRect = 1
		WinGetPos, nL, nT, nW, nH, A
	Else If	aRect = 2
	{
		WinGet, hWnd, ID, A
		VarSetCapacity(rt, 16, 0)
		DllCall("GetClientRect" , "Uint", hWnd, "Uint", &rt)
		DllCall("ClientToScreen", "Uint", hWnd, "Uint", &rt)
		nL := NumGet(rt, 0, "int")
		nT := NumGet(rt, 4, "int")
		nW := NumGet(rt, 8)
		nH := NumGet(rt,12)
	}
	Else If	aRect = 3
	{
		VarSetCapacity(mi, 40, 0)
		DllCall("GetCursorPos", "int64P", pt)
		DllCall("GetMonitorInfo", "Uint", DllCall("MonitorFromPoint", "int64", pt, "Uint", 2), "Uint", NumPut(40,mi)-4)
		nL := NumGet(mi, 4, "int")
		nT := NumGet(mi, 8, "int")
		nW := NumGet(mi,12, "int") - nL
		nH := NumGet(mi,16, "int") - nT
	}
	Else
	{
		StringSplit, rt, aRect, `,, %A_Space%%A_Tab%
		nL := rt1	; convert the Left,top, right, bottom into left, top, width, height
		nT := rt2
		nW := rt3 - rt1
		nH := rt4 - rt2
		znW := rt5
		znH := rt6
	}

	mDC := DllCall("CreateCompatibleDC", "Uint", 0)
	hBM := CreateDIBSectionForScreenCapture(mDC, nW, nH)
	oBM := DllCall("SelectObject", "Uint", mDC, "Uint", hBM)
	hDC := DllCall("GetDC", "Uint", 0)
	DllCall("BitBlt", "Uint", mDC, "int", 0, "int", 0, "int", nW, "int", nH, "Uint", hDC, "int", nL, "int", nT, "Uint", 0x40000000 | 0x00CC0020)
	DllCall("ReleaseDC", "Uint", 0, "Uint", hDC)
	If	bCursor
		CaptureCursor(mDC, nL, nT)
	DllCall("SelectObject", "Uint", mDC, "Uint", oBM)
	DllCall("DeleteDC", "Uint", mDC)
	If	znW && znH
		hBM := Zoomer(hBM, nW, nH, znW, znH)
	If	sFile = 0
		SetClipboardData(hBM)
	Else	Convert(hBM, sFile, nQuality), DllCall("DeleteObject", "Uint", hBM)
}

CaptureCursor(hDC, nL, nT)
{
	VarSetCapacity(mi, 20, 0), mi := Chr(20)
	DllCall("GetCursorInfo", "Uint", &mi)
	bShow   := NumGet(mi, 4)
	hCursor := NumGet(mi, 8)
	xCursor := NumGet(mi,12)
	yCursor := NumGet(mi,16)

	If	bShow && hCursor:=DllCall("CopyIcon", "Uint", hCursor)
	{
	VarSetCapacity(ni, 20, 0)
	DllCall("GetIconInfo", "Uint", hCursor, "Uint", &ni)
	bIcon    := NumGet(ni, 0)
	xHotspot := NumGet(ni, 4)
	yHotspot := NumGet(ni, 8)
	hBMMask  := NumGet(ni,12)
	hBMColor := NumGet(ni,16)

	DllCall("DrawIcon", "Uint", hDC, "int", xCursor - xHotspot - nL, "int", yCursor - yHotspot - nT, "Uint", hCursor)
	DllCall("DestroyIcon", "Uint", hCursor)
	If	hBMMask
	DllCall("DeleteObject", "Uint", hBMMask)
	If	hBMColor
	DllCall("DeleteObject", "Uint", hBMColor)
	}
}

Zoomer(hBM, nW, nH, znW, znH)
{
	mDC1 := DllCall("CreateCompatibleDC", "Uint", 0)
	mDC2 := DllCall("CreateCompatibleDC", "Uint", 0)
	zhBM := CreateDIBSectionForScreenCapture(mDC2, znW, znH)
	oBM1 := DllCall("SelectObject", "Uint", mDC1, "Uint",  hBM)
	oBM2 := DllCall("SelectObject", "Uint", mDC2, "Uint", zhBM)
	DllCall("SetStretchBltMode", "Uint", mDC2, "int", 4)
	DllCall("StretchBlt", "Uint", mDC2, "int", 0, "int", 0, "int", znW, "int", znH, "Uint", mDC1, "int", 0, "int", 0, "int", nW, "int", nH, "Uint", 0x00CC0020)
	DllCall("SelectObject", "Uint", mDC1, "Uint", oBM1)
	DllCall("SelectObject", "Uint", mDC2, "Uint", oBM2)
	DllCall("DeleteDC", "Uint", mDC1)
	DllCall("DeleteDC", "Uint", mDC2)
	DllCall("DeleteObject", "Uint", hBM)
	Return	zhBM
}

Convert(sFileFr = "", sFileTo = "", nQuality = "")
{
	If	sFileTo  =
		sFileTo := A_ScriptDir . "\screen.bmp"
	SplitPath, sFileTo, , sDirTo, sExtTo, sNameTo

	If Not	hGdiPlus := DllCall("LoadLibrary", "str", "gdiplus.dll")
		Return	sFileFr+0 ? SaveHBITMAPToFile(sFileFr, sDirTo . "\" . sNameTo . ".bmp") : ""
	VarSetCapacity(si, 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", "UintP", pToken, "Uint", &si, "Uint", 0)

	If	!sFileFr
	{
		DllCall("OpenClipboard", "Uint", 0)
		If	 DllCall("IsClipboardFormatAvailable", "Uint", 2) && (hBM:=DllCall("GetClipboardData", "Uint", 2))
		DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "Uint", hBM, "Uint", 0, "UintP", pImage)
		DllCall("CloseClipboard")
	}
	Else If	sFileFr Is Integer
		DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "Uint", sFileFr, "Uint", 0, "UintP", pImage)
	Else	DllCall("gdiplus\GdipLoadImageFromFile", "Uint", Unicode4Ansi(wFileFr,sFileFr), "UintP", pImage)

	DllCall("gdiplus\GdipGetImageEncodersSize", "UintP", nCount, "UintP", nSize)
	VarSetCapacity(ci,nSize,0)
	DllCall("gdiplus\GdipGetImageEncoders", "Uint", nCount, "Uint", nSize, "Uint", &ci)
	Loop, %	nCount
		If	InStr(Ansi4Unicode(NumGet(ci,76*(A_Index-1)+44)), "." . sExtTo)
		{
			pCodec := &ci+76*(A_Index-1)
			Break
		}
	If	InStr(".JPG.JPEG.JPE.JFIF", "." . sExtTo) && nQuality<>"" && pImage && pCodec
	{
	DllCall("gdiplus\GdipGetEncoderParameterListSize", "Uint", pImage, "Uint", pCodec, "UintP", nSize)
	VarSetCapacity(pi,nSize,0)
	DllCall("gdiplus\GdipGetEncoderParameterList", "Uint", pImage, "Uint", pCodec, "Uint", nSize, "Uint", &pi)
	Loop, %	NumGet(pi)
		If	NumGet(pi,28*(A_Index-1)+20)=1 && NumGet(pi,28*(A_Index-1)+24)=6
		{
			pParam := &pi+28*(A_Index-1)
			NumPut(nQuality,NumGet(NumPut(4,NumPut(1,pParam+0)+20)))
			Break
		}
	}

	If	pImage
		pCodec	? DllCall("gdiplus\GdipSaveImageToFile", "Uint", pImage, "Uint", Unicode4Ansi(wFileTo,sFileTo), "Uint", pCodec, "Uint", pParam) : DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "Uint", pImage, "UintP", hBitmap, "Uint", 0) . SetClipboardData(hBitmap), DllCall("gdiplus\GdipDisposeImage", "Uint", pImage)

	DllCall("gdiplus\GdiplusShutdown" , "Uint", pToken)
	DllCall("FreeLibrary", "Uint", hGdiPlus)
}

CreateDIBSectionForScreenCapture(hDC, nW, nH, bpp = 32, ByRef pBits = "")
{
	NumPut(VarSetCapacity(bi, 40, 0), bi)
	NumPut(nW, bi, 4)
	NumPut(nH, bi, 8)
	NumPut(bpp, NumPut(1, bi, 12, "UShort"), 0, "Ushort")
	NumPut(0,  bi,16)
	Return	DllCall("gdi32\CreateDIBSection", "Uint", hDC, "Uint", &bi, "Uint", 0, "UintP", pBits, "Uint", 0, "Uint", 0)
}

SaveHBITMAPToFile(hBitmap, sFile)
{
	DllCall("GetObject", "Uint", hBitmap, "int", VarSetCapacity(oi,84,0), "Uint", &oi)
	hFile:=	DllCall("CreateFile", "Uint", &sFile, "Uint", 0x40000000, "Uint", 0, "Uint", 0, "Uint", 2, "Uint", 0, "Uint", 0)
	DllCall("WriteFile", "Uint", hFile, "int64P", 0x4D42|14+40+NumGet(oi,44)<<16, "Uint", 6, "UintP", 0, "Uint", 0)
	DllCall("WriteFile", "Uint", hFile, "int64P", 54<<32, "Uint", 8, "UintP", 0, "Uint", 0)
	DllCall("WriteFile", "Uint", hFile, "Uint", &oi+24, "Uint", 40, "UintP", 0, "Uint", 0)
	DllCall("WriteFile", "Uint", hFile, "Uint", NumGet(oi,20), "Uint", NumGet(oi,44), "UintP", 0, "Uint", 0)
	DllCall("CloseHandle", "Uint", hFile)
}

SetClipboardData(hBitmap)
{
	DllCall("GetObject", "Uint", hBitmap, "int", VarSetCapacity(oi,84,0), "Uint", &oi)
	hDIB :=	DllCall("GlobalAlloc", "Uint", 2, "Uint", 40+NumGet(oi,44))
	pDIB :=	DllCall("GlobalLock", "Uint", hDIB)
	DllCall("RtlMoveMemory", "Uint", pDIB, "Uint", &oi+24, "Uint", 40)
	DllCall("RtlMoveMemory", "Uint", pDIB+40, "Uint", NumGet(oi,20), "Uint", NumGet(oi,44))
	DllCall("GlobalUnlock", "Uint", hDIB)
	DllCall("DeleteObject", "Uint", hBitmap)
	DllCall("OpenClipboard", "Uint", 0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "Uint", 8, "Uint", hDIB)
	DllCall("CloseClipboard")
}

Unicode4Ansi(ByRef wString, sString)
{
	nSize := DllCall("MultiByteToWideChar", "Uint", 0, "Uint", 0, "Uint", &sString, "int", -1, "Uint", 0, "int", 0)
	VarSetCapacity(wString, nSize * 2)
	DllCall("MultiByteToWideChar", "Uint", 0, "Uint", 0, "Uint", &sString, "int", -1, "Uint", &wString, "int", nSize)
	Return	&wString
}

Ansi4Unicode(pString)
{
	nSize := DllCall("WideCharToMultiByte", "Uint", 0, "Uint", 0, "Uint", pString, "int", -1, "Uint", 0, "int",  0, "Uint", 0, "Uint", 0)
	VarSetCapacity(sString, nSize)
	DllCall("WideCharToMultiByte", "Uint", 0, "Uint", 0, "Uint", pString, "int", -1, "str", sString, "int", nSize, "Uint", 0, "Uint", 0)
	Return	sString
}

; Allow moving the GUI by dragging any point in its client area.
WM_LBUTTONDOWN()
{
    global CaptureAreaOfScreenID
    if ( A_Gui = 52 or A_Gui = 53 )
     IfWinNotExist, ahk_id %CaptureAreaofScreenID% ;prevent moving capture area of screen preview window when the capture area of screen configuration window is open
        PostMessage, 0xA1, 2 ; WM_NCLBUTTONDOWN
}

WM_LBUTTONDBLCLK() ;doubleclick
 {
  global HistoryID
  global DuplicateExistsID
  global OriginalImageForErrorLogging
  global DuplicateImageForErrorLogging
  MouseGetPos,,,,Control
  
  IfWinActive,ahk_id %Historyid%
   if Control = Static2
    {
     Guicontrolget, HighLightedLine, 3:
     IfExist, %HighLightedLine%
      run %HighLightedLine%
    }
   
  IfWinActive,ahk_id %DuplicateExistsID%
   {
    if Control = Static3
     run %OriginalImageForErrorLogging%
    if Control = Static4
     run %DuplicateImageForErrorLogging%
   }
 }
; Sizes the client area to fill the entire window.
WM_NCCALCSIZE()
{
    if A_Gui = 52
        return 0
}

; Prevents a border from being drawn when the window is activated.
WM_NCACTIVATE()
{
    if A_Gui = 52
        return 1
}

; Redefine where the sizing borders are.  This is necessary since
; returning 0 for WM_NCCALCSIZE effectively gives borders zero size.
WM_NCHITTEST(wParam, lParam)
{
    global CaptureAreaOfScreenID
    IfWinExist, ahk_id %CaptureAreaofScreenID%
     return
    static border_size = 6
    
    if A_gui <> 52
   	 return
    WinGetPos, gX, gY, gW, gH
    
    x := lParam<<48>>48, y := lParam<<32>>48
    
    hit_left    := x <  gX+border_size
    hit_right   := x >= gX+gW-border_size
    hit_top     := y <  gY+border_size
    hit_bottom  := y >= gY+gH-border_size
    
    if hit_top
    {
        if hit_left
            return 0xD
        else if hit_right
            return 0xE
        else
            return 0xC
    }
    else if hit_bottom
    {
        if hit_left
            return 0x10
        else if hit_right
            return 0x11
        else
            return 0xF
    }
    else if hit_left
        return 0xA
    else if hit_right
        return 0xB
    
    ; else let default hit-testing be done
}
return

emptymem(){
   return, dllcall("psapi.dll\EmptyWorkingSet", "UInt", -1) ;without return - dllcall("psapi.dll\EmptyWorkingSet", "UInt", -1)
}
return

;Scrollable Gui--------------------------------------------------------
#IfWinActive ahk_group MyGui
WheelUp::
WheelDown::
+WheelUp::
+WheelDown::    ; SB_LINEDOWN=1, SB_LINEUP=0, WM_HSCROLL=0x114, WM_VSCROLL=0x115
OnScroll(InStr(A_ThisHotkey,"Down") ? 1 : 0, 0, GetKeyState("Shift") ? 0x114 : 0x115, WinExist())
#IfWinActive
Return
UpdateScrollBars(GuiNum, GuiWidth, GuiHeight)
 {
  static SIF_RANGE=0x1, SIF_PAGE=0x2, SIF_DISABLENOSCROLL=0x8, SB_HORZ=0, SB_VERT=1
  Gui, %GuiNum%:Default
  Gui, +LastFound
 ; Calculate scrolling area.
  Left := Top := 9999
  Right := Bottom := 0
  WinGet, ControlList, ControlList
  Loop, Parse, ControlList, `n
   {
    GuiControlGet, c, Pos, %A_LoopField%
    if (cX < Left)
     Left := cX
    if (cY < Top)
     Top := cY
    if (cX + cW > Right)
     Right := cX + cW
    if (cY + cH > Bottom)
     Bottom := cY + cH
   }
  Left -= 8
  Top -= 8
  Right += 8
  Bottom += 8
  ScrollWidth := Right-Left
  ScrollHeight := Bottom-Top
 
  ; Initialize SCROLLINFO.
  VarSetCapacity(si, 28, 0)
  NumPut(28, si) ; cbSize
  NumPut(SIF_RANGE | SIF_PAGE, si, 4) ; fMask
  ; Update horizontal scroll bar.
  NumPut(ScrollWidth, si, 12) ; nMax
  NumPut(GuiWidth, si, 16) ; nPage
  DllCall("SetScrollInfo", "uint", WinExist(), "uint", SB_HORZ, "uint", &si, "int", 1)
  
  ; Update vertical scroll bar.
  ; NumPut(SIF_RANGE | SIF_PAGE | SIF_DISABLENOSCROLL, si, 4) ; fMask
  NumPut(ScrollHeight, si, 12) ; nMax
  NumPut(GuiHeight, si, 16) ; nPage
  DllCall("SetScrollInfo", "uint", WinExist(), "uint", SB_VERT, "uint", &si, "int", 1)
  if (Left < 0 && Right < GuiWidth)
   x := Abs(Left) > GuiWidth-Right ? GuiWidth-Right : Abs(Left)
  if (Top < 0 && Bottom < GuiHeight)
   y := Abs(Top) > GuiHeight-Bottom ? GuiHeight-Bottom : Abs(Top)
  if (x || y)
   DllCall("ScrollWindow", "uint", WinExist(), "int", x, "int", y, "uint", 0, "uint", 0)
 }
OnScroll(wParam, lParam, msg, hwnd)
 {
  static SIF_ALL=0x17, SCROLL_STEP=10
  bar := msg=0x115 ; SB_HORZ=0, SB_VERT=1
  VarSetCapacity(si, 28, 0)
  NumPut(28, si) ; cbSize
  NumPut(SIF_ALL, si, 4) ; fMask
  if !DllCall("GetScrollInfo", "uint", hwnd, "int", bar, "uint", &si)
   Return
  VarSetCapacity(rect, 16)
  DllCall("GetClientRect", "uint", hwnd, "uint", &rect)
  new_pos := NumGet(si, 20) ; nPos
  action := wParam & 0xFFFF
  if action = 0 ; SB_LINEUP
   new_pos -= SCROLL_STEP
  else if action = 1 ; SB_LINEDOWN
   new_pos += SCROLL_STEP
  else if action = 2 ; SB_PAGEUP
   new_pos -= NumGet(rect, 12, "int") - SCROLL_STEP
  else if action = 3 ; SB_PAGEDOWN
   new_pos += NumGet(rect, 12, "int") - SCROLL_STEP
  else if action = 5 ; SB_THUMBTRACK
   new_pos := NumGet(si, 24, "int") ; nTrackPos
  else if action = 6 ; SB_TOP
   new_pos := NumGet(si, 8, "int") ; nMin
  else if action = 7 ; SB_BOTTOM
   new_pos := NumGet(si, 12, "int") ; nMax
  else
   Return
  min := NumGet(si, 8, "int") ; nMin
  max := NumGet(si, 12, "int") - NumGet(si, 16) ; nMax-nPage
  new_pos := new_pos > max ? max : new_pos
  new_pos := new_pos < min ? min : new_pos
  old_pos := NumGet(si, 20, "int") ; nPos
  x := y := 0
  if bar = 0 ; SB_HORZ
   x := old_pos-new_pos
  else
   y := old_pos-new_pos
  
  ; Scroll contents of window and invalidate uncovered area.
  DllCall("ScrollWindow", "uint", hwnd, "int", x, "int", y, "uint", 0, "uint", 0)
  
  ; Update scroll bar.
  NumPut(new_pos, si, 20, "int") ; nPos
  DllCall("SetScrollInfo", "uint", hwnd, "int", bar, "uint", &si, "int", 1)
 }
return

;Control_Colors--------------------------------------------------------
Control_Colors(wParam, lParam, Msg, Hwnd) {
    Static Controls := {}
   If (lParam = "Set") {
      If !(CtlHwnd := wParam + 0)
         GuiControlGet, CtlHwnd, Hwnd, %wParam%
      If !(CtlHwnd + 0)
         Return False
      Controls[CtlHwnd, "CBG"] := Msg + 0
      Controls[CtlHwnd, "CTX"] := Hwnd + 0
      Return True
   }
   ; Critical
   If (Msg = 0x0133 Or Msg = 0x0134 Or Msg = 0x0138) {
      If Controls.HasKey(lParam) {
         If (Controls[lParam].CTX >= 0)
            DllCall("Gdi32.dll\SetTextColor", "Ptr", wParam, "UInt", Controls[lParam].CTX)
         DllCall("Gdi32.dll\SetBkColor", "Ptr", wParam, "UInt", Controls[lParam].CBG)
         Return DllCall("Gdi32.dll\CreateSolidBrush", "UInt", Controls[lParam].CBG)
      }
   }
}
;----------------------------------------------------------------------

;docka-----------------------------------------------------------------
/* Title:   DockA
			Dock AHK windows.

			Using dock module you can glue windows to an AHK window.
			Docked windows are called Clients and the window that keeps their  position relative to itself is called the Host. 
			Once Clients are connected to the Host, this group of windows will behave like single window - moving, sizing, focusing, hiding and other
			OS events will be handled by the module so that the "composite window" behaves like the single window.

			This module is version of Dock module that supports only AHK hosts (hence A in the name).
			Unlike Dock module, it doesnt'uses system hook to monitor windows changes.
*/
/*
	Function:  DockA
 
 	Parameters: 
			HHost	  - Hwnd of the host GUI. This window must be AHK window.
            HClient	  - HWND of the Client GUI. This window can be any window.
            DockDef   - Dock definition, see bellow. To remove dock client pass "-". 
						If you pass empty string, client will be docked to the host according to its current position relative to the host. 

	Dock definition:  
			Dock definition is white space separated combination of parameters which describe Client's position relative to the Host.
			Parameters are grouped into 4 classes - x, y, w & h parameters. Classes and their parameters are optional.
			
 > 		Syntax:		x(hw,cw,dx)  y(hh,ch,dy)  w(hw,dw)  h(hh,dh)


            o The *X* coordinate of the top, left corner of the client window is computed as 
            > x(hw,cw,dx) = HostX + hw*HostWidth + cw*ClientWidth + dx
            o The *Y* coordinate of the top, left corner of the client window is computed as 
            > y(hh,ch,dy) = HostY + hh*HostHeight + ch*ClientHeight + dy
            o The width *W* of the client window is computed as
			> w(hw,dw) = hw*HostWidth + dw
            o The height *H* of the client window is computed as 
			> h(hh,dh) = hh*HostHeight + dh

			If you omit any of the class parameters it will default to 0. So, the following expressions all have the same effect :
 > 		    x(0,0,0) = x(0,0) = x(0,0,) = x(0) = x(0,)= x(0,,) = x() = x(0,,0) = x(,0,0) = x(,,0) = ...
 >			y(0,1,0) = y(0,1) = y(,1) = y(,1,) = y(,1,0) = ...

			Notice that x() is not the same as omitting x entirely. First case is equal to x(0,0,0) so it will set Client's X coordinate to be equal as Host's. 
			In second case, x coordinate of the client will not be affected by the module (client will keep whatever x it has).

	Remarks:
			You can monitor WM_WINDOWPOSCHANGED=0x47 to detect when user move clients (if they are movable) in order to update dock properties
 */
DockA(HHost="", HClient="", DockDef="") {
   DockA_(HHost+0, HClient+0, DockDef, "")
}
DockA_(HHost, HClient, DockDef, Hwnd) {
   static
   
   if HClient && (DockDef != 3)
   {
      If !init 
         init := OnMessage(3, A_ThisFunc) ; WM_MOVE    ;adrSetWindowPos := DllCall("GetProcAddress", "uint", DllCall("GetModuleHandle", "str", "user32"), "str", "SetWindowPos")

      HClient += 0, HHost += 0
      if (DockDef="-") 
         if InStr(%HHost%, HClient) {
            StringReplace, %HHost%, %HHost%, %A_Space%%HClient%
            DllCall("SetWindowLong", "uint", HClient, "int", -8, "uint", %HClient%_oldparent)
            return
         } else return

      if (DockDef = "") {      ;pin
         WinGetPos hX, hY,,, ahk_id %HHost%
         WinGetPos cX, cY,,, ahk_id %HClient% 
         DockDef := "x(0,0," cX - hX ")  y(0,0," cY - hY ")"
      } 

      %HClient%_x1 := %HClient%_x2 := %HClient%_y1 := %HClient%_y2 := %HClient%_h1 := %HClient%_w1 := %HClient%_x3 := %HClient%_y3 := %HClient%_h2 := %HClient%_w2 := ""
      loop, parse, DockDef, %A_Space%%A_Tab%
      {
         ifEqual, A_LoopField,,continue

         t := A_LoopField, c := SubStr(t,1,1), t := SubStr(t,3,-1)
         StringReplace, t, t,`,,|,UseErrorLevel
         t .= !ErrorLevel ? "||" : (ErrorLevel=1 ? "|" : "")
         loop, parse, t,|,%A_Space%%A_Tab% 
            %HClient%_%c%%A_Index% := A_LoopField ? A_LoopField : 0         
      }
      %HClient%_oldparent := DllCall("SetWindowLong", "uint", HClient, "int", -8, "uint", hHost)
      %HHost% .= (%HHost% = "" ? " " : "") HClient " "
   } 
   
   ifEqual, HHost, 0,SetEnv, HHost, %Hwnd%
   ifEqual, %HHost%,,return

   oldDelay := A_WinDelay, oldCritical := A_IsCritical
   SetWinDelay, -1
   critical 100
   
   WinGetPos hX, hY, hW, hH, ahk_id %HHost%
   loop, parse, %HHost%, %A_Space%
   {       
      ifEqual, A_LoopField,,continue
      else j := A_LoopField
      WinGetPos cX, cY, cW, cH, ahk_id %j% 
      w := %j%_w1*hW + %j%_w2,  h := %j%_h1*hH + %j%_h2
      , x := hX + %j%_x1*hW + %j%_x2*(w ? w : cW) + %j%_x3
      , y := hY + %j%_y1*hH + %j%_y2*(h ? h : cH) + %j%_y3
      WinMove ahk_id %j%,,x,y, w ? w : "" ,h ? h : ""         ;   DllCall(adrSetWindowPos, "uint", hwnd, "uint", 0, "uint", x ? x : cX, "uint", y ? y : cY, "uint", w ? w : cW, "uint", h ? h :cH, "uint", 1044) ;4 | 0x10 | 0x400 
   }
   SetWinDelay, %oldDelay%
   critical %oldCritical%
}

;Gdip------------------------------------------------------------------
;{
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; Supports: Basic, _L ANSi, _L Unicode x86 and _L Unicode x64
;
;#####################################################################################
;#####################################################################################
; STATUS ENUMERATION
; Return values for functions specified to have status enumerated return type
;#####################################################################################
;
; Ok =						= 0
; GenericError				= 1
; InvalidParameter			= 2
; OutOfMemory				= 3
; ObjectBusy				= 4
; InsufficientBuffer		= 5
; NotImplemented			= 6
; Win32Error				= 7
; WrongState				= 8
; Aborted					= 9
; FileNotFound				= 10
; ValueOverflow				= 11
; AccessDenied				= 12
; UnknownImageFormat		= 13
; FontFamilyNotFound		= 14
; FontStyleNotFound			= 15
; NotTrueTypeFont			= 16
; UnsupportedGdiplusVersion	= 17
; GdiplusNotInitialized		= 18
; PropertyNotFound			= 19
; PropertyNotSupported		= 20
; ProfileNotFound			= 21
;
;#####################################################################################
;#####################################################################################
; FUNCTIONS
;#####################################################################################
;
; UpdateLayeredWindow(hwnd, hdc, x="", y="", w="", h="", Alpha=255)
; BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster="")
; StretchBlt(dDC, dx, dy, dw, dh, sDC, sx, sy, sw, sh, Raster="")
; SetImage(hwnd, hBitmap)
; Gdip_BitmapFromScreen(Screen=0, Raster="")
; CreateRectF(ByRef RectF, x, y, w, h)
; CreateSizeF(ByRef SizeF, w, h)
; CreateDIBSection
;
;#####################################################################################

; Function:     			UpdateLayeredWindow
; Description:  			Updates a layered window with the handle to the DC of a gdi bitmap
; 
; hwnd        				Handle of the layered window to update
; hdc           			Handle to the DC of the GDI bitmap to update the window with
; Layeredx      			x position to place the window
; Layeredy      			y position to place the window
; Layeredw      			Width of the window
; Layeredh      			Height of the window
; Alpha         			Default = 255 : The transparency (0-255) to set the window transparency
;
; return      				If the function succeeds, the return value is nonzero
;
; notes						If x or y omitted, then layered window will use its current coordinates
;							If w or h omitted then current width and height will be used

UpdateLayeredWindow(hwnd, hdc, x="", y="", w="", h="", Alpha=255)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if ((x != "") && (y != ""))
		VarSetCapacity(pt, 8), NumPut(x, pt, 0, "UInt"), NumPut(y, pt, 4, "UInt")

	if (w = "") ||(h = "")
		WinGetPos,,, w, h, ahk_id %hwnd%
   
	return DllCall("UpdateLayeredWindow"
					, Ptr, hwnd
					, Ptr, 0
					, Ptr, ((x = "") && (y = "")) ? 0 : &pt
					, "int64*", w|h<<32
					, Ptr, hdc
					, "int64*", 0
					, "uint", 0
					, "UInt*", Alpha<<16|1<<24
					, "uint", 2)
}

;#####################################################################################

; Function				BitBlt
; Description			The BitBlt function performs a bit-block transfer of the color data corresponding to a rectangle 
;						of pixels from the specified source device context into a destination device context.
;
; dDC					handle to destination DC
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of the area to copy
; dh					height of the area to copy
; sDC					handle to source DC
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; Raster				raster operation code
;
; return				If the function succeeds, the return value is nonzero
;
; notes					If no raster operation is specified, then SRCCOPY is used, which copies the source directly to the destination rectangle
;
; BLACKNESS				= 0x00000042
; NOTSRCERASE			= 0x001100A6
; NOTSRCCOPY			= 0x00330008
; SRCERASE				= 0x00440328
; DSTINVERT				= 0x00550009
; PATINVERT				= 0x005A0049
; SRCINVERT				= 0x00660046
; SRCAND				= 0x008800C6
; MERGEPAINT			= 0x00BB0226
; MERGECOPY				= 0x00C000CA
; SRCCOPY				= 0x00CC0020
; SRCPAINT				= 0x00EE0086
; PATCOPY				= 0x00F00021
; PATPAINT				= 0x00FB0A09
; WHITENESS				= 0x00FF0062
; CAPTUREBLT			= 0x40000000
; NOMIRRORBITMAP		= 0x80000000

BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdi32\BitBlt"
					, Ptr, dDC
					, "int", dx
					, "int", dy
					, "int", dw
					, "int", dh
					, Ptr, sDC
					, "int", sx
					, "int", sy
					, "uint", Raster ? Raster : 0x00CC0020)
}

;#####################################################################################

; Function				StretchBlt
; Description			The StretchBlt function copies a bitmap from a source rectangle into a destination rectangle, 
;						stretching or compressing the bitmap to fit the dimensions of the destination rectangle, if necessary.
;						The system stretches or compresses the bitmap according to the stretching mode currently set in the destination device context.
;
; ddc					handle to destination DC
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of destination rectangle
; dh					height of destination rectangle
; sdc					handle to source DC
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source rectangle
; sh					height of source rectangle
; Raster				raster operation code
;
; return				If the function succeeds, the return value is nonzero
;
; notes					If no raster operation is specified, then SRCCOPY is used. It uses the same raster operations as BitBlt		

StretchBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, sw, sh, Raster="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdi32\StretchBlt"
					, Ptr, ddc
					, "int", dx
					, "int", dy
					, "int", dw
					, "int", dh
					, Ptr, sdc
					, "int", sx
					, "int", sy
					, "int", sw
					, "int", sh
					, "uint", Raster ? Raster : 0x00CC0020)
}

;#####################################################################################

; Function				SetStretchBltMode
; Description			The SetStretchBltMode function sets the bitmap stretching mode in the specified device context
;
; hdc					handle to the DC
; iStretchMode			The stretching mode, describing how the target will be stretched
;
; return				If the function succeeds, the return value is the previous stretching mode. If it fails it will return 0
;
; STRETCH_ANDSCANS 		= 0x01
; STRETCH_ORSCANS 		= 0x02
; STRETCH_DELETESCANS 	= 0x03
; STRETCH_HALFTONE 		= 0x04

SetStretchBltMode(hdc, iStretchMode=4)
{
	return DllCall("gdi32\SetStretchBltMode"
					, A_PtrSize ? "UPtr" : "UInt", hdc
					, "int", iStretchMode)
}

;#####################################################################################

; Function				SetImage
; Description			Associates a new image with a static control
;
; hwnd					handle of the control to update
; hBitmap				a gdi bitmap to associate the static control with
;
; return				If the function succeeds, the return value is nonzero

SetImage(hwnd, hBitmap)
{
	SendMessage, 0x172, 0x0, hBitmap,, ahk_id %hwnd%
	E := ErrorLevel
	DeleteObject(E)
	return E
}

;#####################################################################################

; Function				SetSysColorToControl
; Description			Sets a solid colour to a control
;
; hwnd					handle of the control to update
; SysColor				A system colour to set to the control
;
; return				If the function succeeds, the return value is zero
;
; notes					A control must have the 0xE style set to it so it is recognised as a bitmap
;						By default SysColor=15 is used which is COLOR_3DFACE. This is the standard background for a control
;
; COLOR_3DDKSHADOW				= 21
; COLOR_3DFACE					= 15
; COLOR_3DHIGHLIGHT				= 20
; COLOR_3DHILIGHT				= 20
; COLOR_3DLIGHT					= 22
; COLOR_3DSHADOW				= 16
; COLOR_ACTIVEBORDER			= 10
; COLOR_ACTIVECAPTION			= 2
; COLOR_APPWORKSPACE			= 12
; COLOR_BACKGROUND				= 1
; COLOR_BTNFACE					= 15
; COLOR_BTNHIGHLIGHT			= 20
; COLOR_BTNHILIGHT				= 20
; COLOR_BTNSHADOW				= 16
; COLOR_BTNTEXT					= 18
; COLOR_CAPTIONTEXT				= 9
; COLOR_DESKTOP					= 1
; COLOR_GRADIENTACTIVECAPTION	= 27
; COLOR_GRADIENTINACTIVECAPTION	= 28
; COLOR_GRAYTEXT				= 17
; COLOR_HIGHLIGHT				= 13
; COLOR_HIGHLIGHTTEXT			= 14
; COLOR_HOTLIGHT				= 26
; COLOR_INACTIVEBORDER			= 11
; COLOR_INACTIVECAPTION			= 3
; COLOR_INACTIVECAPTIONTEXT		= 19
; COLOR_INFOBK					= 24
; COLOR_INFOTEXT				= 23
; COLOR_MENU					= 4
; COLOR_MENUHILIGHT				= 29
; COLOR_MENUBAR					= 30
; COLOR_MENUTEXT				= 7
; COLOR_SCROLLBAR				= 0
; COLOR_WINDOW					= 5
; COLOR_WINDOWFRAME				= 6
; COLOR_WINDOWTEXT				= 8

SetSysColorToControl(hwnd, SysColor=15)
{
   WinGetPos,,, w, h, ahk_id %hwnd%
   bc := DllCall("GetSysColor", "Int", SysColor, "UInt")
   pBrushClear := Gdip_BrushCreateSolid(0xff000000 | (bc >> 16 | bc & 0xff00 | (bc & 0xff) << 16))
   pBitmap := Gdip_CreateBitmap(w, h), G := Gdip_GraphicsFromImage(pBitmap)
   Gdip_FillRectangle(G, pBrushClear, 0, 0, w, h)
   hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
   SetImage(hwnd, hBitmap)
   Gdip_DeleteBrush(pBrushClear)
   Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
   return 0
}

;#####################################################################################

; Function				Gdip_BitmapFromScreen
; Description			Gets a gdi+ bitmap from the screen
;
; Screen				0 = All screens
;						Any numerical value = Just that screen
;						x|y|w|h = Take specific coordinates with a width and height
; Raster				raster operation code
;
; return      			If the function succeeds, the return value is a pointer to a gdi+ bitmap
;						-1:		one or more of x,y,w,h not passed properly
;
; notes					If no raster operation is specified, then SRCCOPY is used to the returned bitmap

Gdip_BitmapFromScreen(Screen=0, Raster="")
{
	if (Screen = 0)
	{
		Sysget, x, 76
		Sysget, y, 77	
		Sysget, w, 78
		Sysget, h, 79
	}
	else if (SubStr(Screen, 1, 5) = "hwnd:")
	{
		Screen := SubStr(Screen, 6)
		if !WinExist( "ahk_id " Screen)
			return -2
		WinGetPos,,, w, h, ahk_id %Screen%
		x := y := 0
		hhdc := GetDCEx(Screen, 3)
	}
	else if (Screen&1 != "")
	{
		Sysget, M, Monitor, %Screen%
		x := MLeft, y := MTop, w := MRight-MLeft, h := MBottom-MTop
	}
	else
	{
		StringSplit, S, Screen, |
		x := S1, y := S2, w := S3, h := S4
	}

	if (x = "") || (y = "") || (w = "") || (h = "")
		return -1

	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
	BitBlt(chdc, 0, 0, w, h, hhdc, x, y, Raster)
	ReleaseDC(hhdc)
	
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}

;#####################################################################################

; Function				Gdip_BitmapFromHWND
; Description			Uses PrintWindow to get a handle to the specified window and return a bitmap from it
;
; hwnd					handle to the window to get a bitmap from
;
; return				If the function succeeds, the return value is a pointer to a gdi+ bitmap
;
; notes					Window must not be not minimised in order to get a handle to it's client area

Gdip_BitmapFromHWND(hwnd)
{
	WinGetPos,,, Width, Height, ahk_id %hwnd%
	hbm := CreateDIBSection(Width, Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
	PrintWindow(hwnd, hdc)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	return pBitmap
}

;#####################################################################################

; Function    			CreateRectF
; Description			Creates a RectF object, containing a the coordinates and dimensions of a rectangle
;
; RectF       			Name to call the RectF object
; x            			x-coordinate of the upper left corner of the rectangle
; y            			y-coordinate of the upper left corner of the rectangle
; w            			Width of the rectangle
; h            			Height of the rectangle
;
; return      			No return value

CreateRectF(ByRef RectF, x, y, w, h)
{
   VarSetCapacity(RectF, 16)
   NumPut(x, RectF, 0, "float"), NumPut(y, RectF, 4, "float"), NumPut(w, RectF, 8, "float"), NumPut(h, RectF, 12, "float")
}

;#####################################################################################

; Function    			CreateRect
; Description			Creates a Rect object, containing a the coordinates and dimensions of a rectangle
;
; RectF       			Name to call the RectF object
; x            			x-coordinate of the upper left corner of the rectangle
; y            			y-coordinate of the upper left corner of the rectangle
; w            			Width of the rectangle
; h            			Height of the rectangle
;
; return      			No return value

CreateRect(ByRef Rect, x, y, w, h)
{
	VarSetCapacity(Rect, 16)
	NumPut(x, Rect, 0, "uint"), NumPut(y, Rect, 4, "uint"), NumPut(w, Rect, 8, "uint"), NumPut(h, Rect, 12, "uint")
}
;#####################################################################################

; Function		    	CreateSizeF
; Description			Creates a SizeF object, containing an 2 values
;
; SizeF         		Name to call the SizeF object
; w            			w-value for the SizeF object
; h            			h-value for the SizeF object
;
; return      			No Return value

CreateSizeF(ByRef SizeF, w, h)
{
   VarSetCapacity(SizeF, 8)
   NumPut(w, SizeF, 0, "float"), NumPut(h, SizeF, 4, "float")     
}
;#####################################################################################

; Function		    	CreatePointF
; Description			Creates a SizeF object, containing an 2 values
;
; SizeF         		Name to call the SizeF object
; w            			w-value for the SizeF object
; h            			h-value for the SizeF object
;
; return      			No Return value

CreatePointF(ByRef PointF, x, y)
{
   VarSetCapacity(PointF, 8)
   NumPut(x, PointF, 0, "float"), NumPut(y, PointF, 4, "float")     
}
;#####################################################################################

; Function				CreateDIBSection
; Description			The CreateDIBSection function creates a DIB (Device Independent Bitmap) that applications can write to directly
;
; w						width of the bitmap to create
; h						height of the bitmap to create
; hdc					a handle to the device context to use the palette from
; bpp					bits per pixel (32 = ARGB)
; ppvBits				A pointer to a variable that receives a pointer to the location of the DIB bit values
;
; return				returns a DIB. A gdi bitmap
;
; notes					ppvBits will receive the location of the pixels in the DIB

CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)
	
	NumPut(w, bi, 4, "uint")
	, NumPut(h, bi, 8, "uint")
	, NumPut(40, bi, 0, "uint")
	, NumPut(1, bi, 12, "ushort")
	, NumPut(0, bi, 16, "uInt")
	, NumPut(bpp, bi, 14, "ushort")
	
	hbm := DllCall("CreateDIBSection"
					, Ptr, hdc2
					, Ptr, &bi
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "uint*", ppvBits
					, Ptr, 0
					, "uint", 0, Ptr)

	if !hdc
		ReleaseDC(hdc2)
	return hbm
}

;#####################################################################################

; Function				PrintWindow
; Description			The PrintWindow function copies a visual window into the specified device context (DC), typically a printer DC
;
; hwnd					A handle to the window that will be copied
; hdc					A handle to the device context
; Flags					Drawing options
;
; return				If the function succeeds, it returns a nonzero value
;
; PW_CLIENTONLY			= 1

PrintWindow(hwnd, hdc, Flags=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("PrintWindow", Ptr, hwnd, Ptr, hdc, "uint", Flags)
}

;#####################################################################################

; Function				DestroyIcon
; Description			Destroys an icon and frees any memory the icon occupied
;
; hIcon					Handle to the icon to be destroyed. The icon must not be in use
;
; return				If the function succeeds, the return value is nonzero

DestroyIcon(hIcon)
{
	return DllCall("DestroyIcon", A_PtrSize ? "UPtr" : "UInt", hIcon)
}

;#####################################################################################

PaintDesktop(hdc)
{
	return DllCall("PaintDesktop", A_PtrSize ? "UPtr" : "UInt", hdc)
}

;#####################################################################################

CreateCompatibleBitmap(hdc, w, h)
{
	return DllCall("gdi32\CreateCompatibleBitmap", A_PtrSize ? "UPtr" : "UInt", hdc, "int", w, "int", h)
}

;#####################################################################################

; Function				CreateCompatibleDC
; Description			This function creates a memory device context (DC) compatible with the specified device
;
; hdc					Handle to an existing device context					
;
; return				returns the handle to a device context or 0 on failure
;
; notes					If this handle is 0 (by default), the function creates a memory device context compatible with the application's current screen

CreateCompatibleDC(hdc=0)
{
   return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}

;#####################################################################################

; Function				SelectObject
; Description			The SelectObject function selects an object into the specified device context (DC). The new object replaces the previous object of the same type
;
; hdc					Handle to a DC
; hgdiobj				A handle to the object to be selected into the DC
;
; return				If the selected object is not a region and the function succeeds, the return value is a handle to the object being replaced
;
; notes					The specified object must have been created by using one of the following functions
;						Bitmap - CreateBitmap, CreateBitmapIndirect, CreateCompatibleBitmap, CreateDIBitmap, CreateDIBSection (A single bitmap cannot be selected into more than one DC at the same time)
;						Brush - CreateBrushIndirect, CreateDIBPatternBrush, CreateDIBPatternBrushPt, CreateHatchBrush, CreatePatternBrush, CreateSolidBrush
;						Font - CreateFont, CreateFontIndirect
;						Pen - CreatePen, CreatePenIndirect
;						Region - CombineRgn, CreateEllipticRgn, CreateEllipticRgnIndirect, CreatePolygonRgn, CreateRectRgn, CreateRectRgnIndirect
;
; notes					If the selected object is a region and the function succeeds, the return value is one of the following value
;
; SIMPLEREGION			= 2 Region consists of a single rectangle
; COMPLEXREGION			= 3 Region consists of more than one rectangle
; NULLREGION			= 1 Region is empty

SelectObject(hdc, hgdiobj)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}

;#####################################################################################

; Function				DeleteObject
; Description			This function deletes a logical pen, brush, font, bitmap, region, or palette, freeing all system resources associated with the object
;						After the object is deleted, the specified handle is no longer valid
;
; hObject				Handle to a logical pen, brush, font, bitmap, region, or palette to delete
;
; return				Nonzero indicates success. Zero indicates that the specified handle is not valid or that the handle is currently selected into a device context

DeleteObject(hObject)
{
   return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}

;#####################################################################################

; Function				GetDC
; Description			This function retrieves a handle to a display device context (DC) for the client area of the specified window.
;						The display device context can be used in subsequent graphics display interface (GDI) functions to draw in the client area of the window. 
;
; hwnd					Handle to the window whose device context is to be retrieved. If this value is NULL, GetDC retrieves the device context for the entire screen					
;
; return				The handle the device context for the specified window's client area indicates success. NULL indicates failure

GetDC(hwnd=0)
{
	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}

;#####################################################################################

; DCX_CACHE = 0x2
; DCX_CLIPCHILDREN = 0x8
; DCX_CLIPSIBLINGS = 0x10
; DCX_EXCLUDERGN = 0x40
; DCX_EXCLUDEUPDATE = 0x100
; DCX_INTERSECTRGN = 0x80
; DCX_INTERSECTUPDATE = 0x200
; DCX_LOCKWINDOWUPDATE = 0x400
; DCX_NORECOMPUTE = 0x100000
; DCX_NORESETATTRS = 0x4
; DCX_PARENTCLIP = 0x20
; DCX_VALIDATE = 0x200000
; DCX_WINDOW = 0x1

GetDCEx(hwnd, flags=0, hrgnClip=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
    return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
}

;#####################################################################################

; Function				ReleaseDC
; Description			This function releases a device context (DC), freeing it for use by other applications. The effect of ReleaseDC depends on the type of device context
;
; hdc					Handle to the device context to be released
; hwnd					Handle to the window whose device context is to be released
;
; return				1 = released
;						0 = not released
;
; notes					The application must call the ReleaseDC function for each call to the GetWindowDC function and for each call to the GetDC function that retrieves a common device context
;						An application cannot use the ReleaseDC function to release a device context that was created by calling the CreateDC function; instead, it must use the DeleteDC function. 

ReleaseDC(hdc, hwnd=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}

;#####################################################################################

; Function				DeleteDC
; Description			The DeleteDC function deletes the specified device context (DC)
;
; hdc					A handle to the device context
;
; return				If the function succeeds, the return value is nonzero
;
; notes					An application must not delete a DC whose handle was obtained by calling the GetDC function. Instead, it must call the ReleaseDC function to free the DC

DeleteDC(hdc)
{
   return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
;#####################################################################################

; Function				Gdip_LibraryVersion
; Description			Get the current library version
;
; return				the library version
;
; notes					This is useful for non compiled programs to ensure that a person doesn't run an old version when testing your scripts

Gdip_LibraryVersion()
{
	return 1.45
}

;#####################################################################################

; Function:    			Gdip_BitmapFromBRA
; Description: 			Gets a pointer to a gdi+ bitmap from a BRA file
;
; BRAFromMemIn			The variable for a BRA file read to memory
; File					The name of the file, or its number that you would like (This depends on alternate parameter)
; Alternate				Changes whether the File parameter is the filename or its number
;
; return      			If the function succeeds, the return value is a pointer to a gdi+ bitmap
;						-1 = The BRA variable is empty
;						-2 = The BRA has an incorrect header
;						-3 = The BRA has information missing
;						-4 = Could not find file inside the BRA

Gdip_BitmapFromBRA(ByRef BRAFromMemIn, File, Alternate=0)
{
	Static FName = "ObjRelease"
	
	if !BRAFromMemIn
		return -1
	Loop, Parse, BRAFromMemIn, `n
	{
		if (A_Index = 1)
		{
			StringSplit, Header, A_LoopField, |
			if (Header0 != 4 || Header2 != "BRA!")
				return -2
		}
		else if (A_Index = 2)
		{
			StringSplit, Info, A_LoopField, |
			if (Info0 != 3)
				return -3
		}
		else
			break
	}
	if !Alternate
		StringReplace, File, File, \, \\, All
	RegExMatch(BRAFromMemIn, "mi`n)^" (Alternate ? File "\|.+?\|(\d+)\|(\d+)" : "\d+\|" File "\|(\d+)\|(\d+)") "$", FileInfo)
	if !FileInfo
		return -4
	
	hData := DllCall("GlobalAlloc", "uint", 2, Ptr, FileInfo2, Ptr)
	pData := DllCall("GlobalLock", Ptr, hData, Ptr)
	DllCall("RtlMoveMemory", Ptr, pData, Ptr, &BRAFromMemIn+Info2+FileInfo1, Ptr, FileInfo2)
	DllCall("GlobalUnlock", Ptr, hData)
	DllCall("ole32\CreateStreamOnHGlobal", Ptr, hData, "int", 1, A_PtrSize ? "UPtr*" : "UInt*", pStream)
	DllCall("gdiplus\GdipCreateBitmapFromStream", Ptr, pStream, A_PtrSize ? "UPtr*" : "UInt*", pBitmap)
	If (A_PtrSize)
		%FName%(pStream)
	Else
		DllCall(NumGet(NumGet(1*pStream)+8), "uint", pStream)
	return pBitmap
}

;#####################################################################################

; Function				Gdip_DrawRectangle
; Description			This function uses a pen to draw the outline of a rectangle into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rectangle
; y						y-coordinate of the top left of the rectangle
; w						width of the rectanlge
; h						height of the rectangle
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawRectangle", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_DrawRoundedRectangle
; Description			This function uses a pen to draw the outline of a rounded rectangle into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rounded rectangle
; y						y-coordinate of the top left of the rounded rectangle
; w						width of the rectanlge
; h						height of the rectangle
; r						radius of the rounded corners
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r)
{
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	E := Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
	Gdip_ResetClip(pGraphics)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_DrawEllipse(pGraphics, pPen, x, y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x, y+h-(2*r), 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_ResetClip(pGraphics)
	return E
}

;#####################################################################################

; Function				Gdip_DrawEllipse
; Description			This function uses a pen to draw the outline of an ellipse into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rectangle the ellipse will be drawn into
; y						y-coordinate of the top left of the rectangle the ellipse will be drawn into
; w						width of the ellipse
; h						height of the ellipse
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawEllipse", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_DrawBezier
; Description			This function uses a pen to draw the outline of a bezier (a weighted curve) into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x1					x-coordinate of the start of the bezier
; y1					y-coordinate of the start of the bezier
; x2					x-coordinate of the first arc of the bezier
; y2					y-coordinate of the first arc of the bezier
; x3					x-coordinate of the second arc of the bezier
; y3					y-coordinate of the second arc of the bezier
; x4					x-coordinate of the end of the bezier
; y4					y-coordinate of the end of the bezier
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawBezier(pGraphics, pPen, x1, y1, x2, y2, x3, y3, x4, y4)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawBezier"
					, Ptr, pgraphics
					, Ptr, pPen
					, "float", x1
					, "float", y1
					, "float", x2
					, "float", y2
					, "float", x3
					, "float", y3
					, "float", x4
					, "float", y4)
}

;#####################################################################################

; Function				Gdip_DrawArc
; Description			This function uses a pen to draw the outline of an arc into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the start of the arc
; y						y-coordinate of the start of the arc
; w						width of the arc
; h						height of the arc
; StartAngle			specifies the angle between the x-axis and the starting point of the arc
; SweepAngle			specifies the angle between the starting and ending points of the arc
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawArc"
					, Ptr, pGraphics
					, Ptr, pPen
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "float", StartAngle
					, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_DrawPie
; Description			This function uses a pen to draw the outline of a pie into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the start of the pie
; y						y-coordinate of the start of the pie
; w						width of the pie
; h						height of the pie
; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; SweepAngle			specifies the angle between the starting and ending points of the pie
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawPie", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_DrawLine
; Description			This function uses a pen to draw a line into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x1					x-coordinate of the start of the line
; y1					y-coordinate of the start of the line
; x2					x-coordinate of the end of the line
; y2					y-coordinate of the end of the line
;
; return				status enumeration. 0 = success		

Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawLine"
					, Ptr, pGraphics
					, Ptr, pPen
					, "float", x1
					, "float", y1
					, "float", x2
					, "float", y2)
}

;#####################################################################################

; Function				Gdip_DrawLines
; Description			This function uses a pen to draw a series of joined lines into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
;
; return				status enumeration. 0 = success				

Gdip_DrawLines(pGraphics, pPen, Points)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}
	return DllCall("gdiplus\GdipDrawLines", Ptr, pGraphics, Ptr, pPen, Ptr, &PointF, "int", Points0)
}

;#####################################################################################

; Function				Gdip_FillRectangle
; Description			This function uses a brush to fill a rectangle in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the rectangle
; y						y-coordinate of the top left of the rectangle
; w						width of the rectanlge
; h						height of the rectangle
;
; return				status enumeration. 0 = success

Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillRectangle"
					, Ptr, pGraphics
					, Ptr, pBrush
					, "float", x
					, "float", y
					, "float", w
					, "float", h)
}

;#####################################################################################

; Function				Gdip_FillRoundedRectangle
; Description			This function uses a brush to fill a rounded rectangle in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the rounded rectangle
; y						y-coordinate of the top left of the rounded rectangle
; w						width of the rectanlge
; h						height of the rectangle
; r						radius of the rounded corners
;
; return				status enumeration. 0 = success

Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r)
{
	Region := Gdip_GetClipRegion(pGraphics)
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	E := Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_FillEllipse(pGraphics, pBrush, x, y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x, y+h-(2*r), 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_DeleteRegion(Region)
	return E
}

;#####################################################################################

; Function				Gdip_FillPolygon
; Description			This function uses a brush to fill a polygon in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
;
; return				status enumeration. 0 = success
;
; notes					Alternate will fill the polygon as a whole, wheras winding will fill each new "segment"
; Alternate 			= 0
; Winding 				= 1

Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}   
	return DllCall("gdiplus\GdipFillPolygon", Ptr, pGraphics, Ptr, pBrush, Ptr, &PointF, "int", Points0, "int", FillMode)
}

;#####################################################################################

; Function				Gdip_FillPie
; Description			This function uses a brush to fill a pie in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the pie
; y						y-coordinate of the top left of the pie
; w						width of the pie
; h						height of the pie
; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; SweepAngle			specifies the angle between the starting and ending points of the pie
;
; return				status enumeration. 0 = success

Gdip_FillPie(pGraphics, pBrush, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillPie"
					, Ptr, pGraphics
					, Ptr, pBrush
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "float", StartAngle
					, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_FillEllipse
; Description			This function uses a brush to fill an ellipse in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the ellipse
; y						y-coordinate of the top left of the ellipse
; w						width of the ellipse
; h						height of the ellipse
;
; return				status enumeration. 0 = success

Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillEllipse", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_FillRegion
; Description			This function uses a brush to fill a region in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Region				Pointer to a Region
;
; return				status enumeration. 0 = success
;
; notes					You can create a region Gdip_CreateRegion() and then add to this

Gdip_FillRegion(pGraphics, pBrush, Region)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillRegion", Ptr, pGraphics, Ptr, pBrush, Ptr, Region)
}

;#####################################################################################

; Function				Gdip_FillPath
; Description			This function uses a brush to fill a path in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Region				Pointer to a Path
;
; return				status enumeration. 0 = success

Gdip_FillPath(pGraphics, pBrush, Path)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillPath", Ptr, pGraphics, Ptr, pBrush, Ptr, Path)
}

;#####################################################################################

; Function				Gdip_DrawImagePointsRect
; Description			This function draws a bitmap into the Graphics of another bitmap and skews it
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBitmap				Pointer to a bitmap to be drawn
; Points				Points passed as x1,y1|x2,y2|x3,y3 (3 points: top left, top right, bottom left) describing the drawing of the bitmap
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source rectangle
; sh					height of source rectangle
; Matrix				a matrix used to alter image attributes when drawing
;
; return				status enumeration. 0 = success
;
; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
;						Matrix can be omitted to just draw with no alteration to ARGB
;						Matrix may be passed as a digit from 0 - 1 to change just transparency
;						Matrix can be passed as a matrix with any delimiter

Gdip_DrawImagePointsRect(pGraphics, pBitmap, Points, sx="", sy="", sw="", sh="", Matrix=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}

	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
		
	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		sx := 0, sy := 0
		sw := Gdip_GetImageWidth(pBitmap)
		sh := Gdip_GetImageHeight(pBitmap)
	}

	E := DllCall("gdiplus\GdipDrawImagePointsRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, Ptr, &PointF
				, "int", Points0
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}

;#####################################################################################

; Function				Gdip_DrawImage
; Description			This function draws a bitmap into the Graphics of another bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBitmap				Pointer to a bitmap to be drawn
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of destination image
; dh					height of destination image
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source image
; sh					height of source image
; Matrix				a matrix used to alter image attributes when drawing
;
; return				status enumeration. 0 = success
;
; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
;						Gdip_DrawImage performs faster
;						Matrix can be omitted to just draw with no alteration to ARGB
;						Matrix may be passed as a digit from 0 - 1 to change just transparency
;						Matrix can be passed as a matrix with any delimiter. For example:
;						MatrixBright=
;						(
;						1.5		|0		|0		|0		|0
;						0		|1.5	|0		|0		|0
;						0		|0		|1.5	|0		|0
;						0		|0		|0		|1		|0
;						0.05	|0.05	|0.05	|0		|1
;						)
;
; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|0|0|0|0|1

Gdip_DrawImage(pGraphics, pBitmap, dx="", dy="", dw="", dh="", sx="", sy="", sw="", sh="", Matrix=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		if (dx = "" && dy = "" && dw = "" && dh = "")
		{
			sx := dx := 0, sy := dy := 0
			sw := dw := Gdip_GetImageWidth(pBitmap)
			sh := dh := Gdip_GetImageHeight(pBitmap)
		}
		else
		{
			sx := sy := 0
			sw := Gdip_GetImageWidth(pBitmap)
			sh := Gdip_GetImageHeight(pBitmap)
		}
	}

	E := DllCall("gdiplus\GdipDrawImageRectRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, "float", dx
				, "float", dy
				, "float", dw
				, "float", dh
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}

;#####################################################################################

; Function				Gdip_SetImageAttributesColorMatrix
; Description			This function creates an image matrix ready for drawing
;
; Matrix				a matrix used to alter image attributes when drawing
;						passed with any delimeter
;
; return				returns an image matrix on sucess or 0 if it fails
;
; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|0|0|0|0|1

Gdip_SetImageAttributesColorMatrix(Matrix)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	VarSetCapacity(ColourMatrix, 100, 0)
	Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", "", 1), "[^\d-\.]+", "|")
	StringSplit, Matrix, Matrix, |
	Loop, 25
	{
		Matrix := (Matrix%A_Index% != "") ? Matrix%A_Index% : Mod(A_Index-1, 6) ? 0 : 1
		NumPut(Matrix, ColourMatrix, (A_Index-1)*4, "float")
	}
	DllCall("gdiplus\GdipCreateImageAttributes", A_PtrSize ? "UPtr*" : "uint*", ImageAttr)
	DllCall("gdiplus\GdipSetImageAttributesColorMatrix", Ptr, ImageAttr, "int", 1, "int", 1, Ptr, &ColourMatrix, Ptr, 0, "int", 0)
	return ImageAttr
}

;#####################################################################################

; Function				Gdip_GraphicsFromImage
; Description			This function gets the graphics for a bitmap used for drawing functions
;
; pBitmap				Pointer to a bitmap to get the pointer to its graphics
;
; return				returns a pointer to the graphics of a bitmap
;
; notes					a bitmap can be drawn into the graphics of another bitmap

Gdip_GraphicsFromImage(pBitmap)
{
	DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
	return pGraphics
}

;#####################################################################################

; Function				Gdip_GraphicsFromHDC
; Description			This function gets the graphics from the handle to a device context
;
; hdc					This is the handle to the device context
;
; return				returns a pointer to the graphics of a bitmap
;
; notes					You can draw a bitmap into the graphics of another bitmap

Gdip_GraphicsFromHDC(hdc)
{
    DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
    return pGraphics
}

;#####################################################################################

; Function				Gdip_GetDC
; Description			This function gets the device context of the passed Graphics
;
; hdc					This is the handle to the device context
;
; return				returns the device context for the graphics of a bitmap

Gdip_GetDC(pGraphics)
{
	DllCall("gdiplus\GdipGetDC", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", hdc)
	return hdc
}

;#####################################################################################

; Function				Gdip_ReleaseDC
; Description			This function releases a device context from use for further use
;
; pGraphics				Pointer to the graphics of a bitmap
; hdc					This is the handle to the device context
;
; return				status enumeration. 0 = success

Gdip_ReleaseDC(pGraphics, hdc)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipReleaseDC", Ptr, pGraphics, Ptr, hdc)
}

;#####################################################################################

; Function				Gdip_GraphicsClear
; Description			Clears the graphics of a bitmap ready for further drawing
;
; pGraphics				Pointer to the graphics of a bitmap
; ARGB					The colour to clear the graphics to
;
; return				status enumeration. 0 = success
;
; notes					By default this will make the background invisible
;						Using clipping regions you can clear a particular area on the graphics rather than clearing the entire graphics

Gdip_GraphicsClear(pGraphics, ARGB=0x00ffffff)
{
    return DllCall("gdiplus\GdipGraphicsClear", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", ARGB)
}

;#####################################################################################

; Function				Gdip_BlurBitmap
; Description			Gives a pointer to a blurred bitmap from a pointer to a bitmap
;
; pBitmap				Pointer to a bitmap to be blurred
; Blur					The Amount to blur a bitmap by from 1 (least blur) to 100 (most blur)
;
; return				If the function succeeds, the return value is a pointer to the new blurred bitmap
;						-1 = The blur parameter is outside the range 1-100
;
; notes					This function will not dispose of the original bitmap

Gdip_BlurBitmap(pBitmap, Blur)
{
	if (Blur > 100) || (Blur < 1)
		return -1	
	
	sWidth := Gdip_GetImageWidth(pBitmap), sHeight := Gdip_GetImageHeight(pBitmap)
	dWidth := sWidth//Blur, dHeight := sHeight//Blur

	pBitmap1 := Gdip_CreateBitmap(dWidth, dHeight)
	G1 := Gdip_GraphicsFromImage(pBitmap1)
	Gdip_SetInterpolationMode(G1, 7)
	Gdip_DrawImage(G1, pBitmap, 0, 0, dWidth, dHeight, 0, 0, sWidth, sHeight)

	Gdip_DeleteGraphics(G1)

	pBitmap2 := Gdip_CreateBitmap(sWidth, sHeight)
	G2 := Gdip_GraphicsFromImage(pBitmap2)
	Gdip_SetInterpolationMode(G2, 7)
	Gdip_DrawImage(G2, pBitmap1, 0, 0, sWidth, sHeight, 0, 0, dWidth, dHeight)

	Gdip_DeleteGraphics(G2)
	Gdip_DisposeImage(pBitmap1)
	return pBitmap2
}

;#####################################################################################

; Function:     		Gdip_SaveBitmapToFile
; Description:  		Saves a bitmap to a file in any supported format onto disk
;   
; pBitmap				Pointer to a bitmap
; sOutput      			The name of the file that the bitmap will be saved to. Supported extensions are: .BMP,.DIB,.RLE,.JPG,.JPEG,.JPE,.JFIF,.GIF,.TIF,.TIFF,.PNG
; Quality      			If saving as jpg (.JPG,.JPEG,.JPE,.JFIF) then quality can be 1-100 with default at maximum quality
;
; return      			If the function succeeds, the return value is zero, otherwise:
;						-1 = Extension supplied is not a supported file format
;						-2 = Could not get a list of encoders on system
;						-3 = Could not find matching encoder for specified file format
;						-4 = Could not get WideChar name of output file
;						-5 = Could not save file to disk
;
; notes					This function will use the extension supplied from the sOutput parameter to determine the output format

Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality=75)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	SplitPath, sOutput,,, Extension
	if Extension not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
		return -1
	Extension := "." Extension

	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
	if !(nCount && nSize)
		return -2
	
	If (A_IsUnicode){
		StrGet_Name := "StrGet"
		Loop, %nCount%
		{
			sString := %StrGet_Name%(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
			if !InStr(sString, "*" Extension)
				continue
			
			pCodec := &ci+idx
			break
		}
	} else {
		Loop, %nCount%
		{
			Location := NumGet(ci, 76*(A_Index-1)+44)
			nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
			VarSetCapacity(sString, nSize)
			DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)
			if !InStr(sString, "*" Extension)
				continue
			
			pCodec := &ci+76*(A_Index-1)
			break
		}
	}
	
	if !pCodec
		return -3

	if (Quality != 75)
	{
		Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
		if Extension in .JPG,.JPEG,.JPE,.JFIF
		{
			DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
			VarSetCapacity(EncoderParameters, nSize, 0)
			DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
			Loop, % NumGet(EncoderParameters, "UInt")      ;%
			{
				elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
				if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
				{
					p := elem+&EncoderParameters-pad-4
					NumPut(Quality, NumGet(NumPut(4, NumPut(1, p+0)+20, "UInt")), "UInt")
					break
				}
			}      
		}
	}

	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wOutput, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, &wOutput, "int", nSize)
		VarSetCapacity(wOutput, -1)
		if !VarSetCapacity(wOutput)
			return -4
		E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &wOutput, Ptr, pCodec, "uint", p ? p : 0)
	}
	else
		E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &sOutput, Ptr, pCodec, "uint", p ? p : 0)
	return E ? -5 : 0
}

;#####################################################################################

; Function				Gdip_GetPixel
; Description			Gets the ARGB of a pixel in a bitmap
;
; pBitmap				Pointer to a bitmap
; x						x-coordinate of the pixel
; y						y-coordinate of the pixel
;
; return				Returns the ARGB value of the pixel

Gdip_GetPixel(pBitmap, x, y)
{
	DllCall("gdiplus\GdipBitmapGetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "uint*", ARGB)
	return ARGB
}

;#####################################################################################

; Function				Gdip_SetPixel
; Description			Sets the ARGB of a pixel in a bitmap
;
; pBitmap				Pointer to a bitmap
; x						x-coordinate of the pixel
; y						y-coordinate of the pixel
;
; return				status enumeration. 0 = success

Gdip_SetPixel(pBitmap, x, y, ARGB)
{
   return DllCall("gdiplus\GdipBitmapSetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "int", ARGB)
}

;#####################################################################################

; Function				Gdip_GetImageWidth
; Description			Gives the width of a bitmap
;
; pBitmap				Pointer to a bitmap
;
; return				Returns the width in pixels of the supplied bitmap

Gdip_GetImageWidth(pBitmap)
{
   DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
   return Width
}

;#####################################################################################

; Function				Gdip_GetImageHeight
; Description			Gives the height of a bitmap
;
; pBitmap				Pointer to a bitmap
;
; return				Returns the height in pixels of the supplied bitmap

Gdip_GetImageHeight(pBitmap)
{
   DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
   return Height
}

;#####################################################################################

; Function				Gdip_GetDimensions
; Description			Gives the width and height of a bitmap
;
; pBitmap				Pointer to a bitmap
; Width					ByRef variable. This variable will be set to the width of the bitmap
; Height				ByRef variable. This variable will be set to the height of the bitmap
;
; return				No return value
;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

Gdip_GetImageDimensions(pBitmap, ByRef Width, ByRef Height)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	DllCall("gdiplus\GdipGetImageWidth", Ptr, pBitmap, "uint*", Width)
	DllCall("gdiplus\GdipGetImageHeight", Ptr, pBitmap, "uint*", Height)
}

;#####################################################################################

Gdip_GetDimensions(pBitmap, ByRef Width, ByRef Height)
{
	Gdip_GetImageDimensions(pBitmap, Width, Height)
}

;#####################################################################################

Gdip_GetImagePixelFormat(pBitmap)
{
	DllCall("gdiplus\GdipGetImagePixelFormat", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", Format)
	return Format
}

;#####################################################################################

; Function				Gdip_GetDpiX
; Description			Gives the horizontal dots per inch of the graphics of a bitmap
;
; pBitmap				Pointer to a bitmap
; Width					ByRef variable. This variable will be set to the width of the bitmap
; Height				ByRef variable. This variable will be set to the height of the bitmap
;
; return				No return value
;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

Gdip_GetDpiX(pGraphics)
{
	DllCall("gdiplus\GdipGetDpiX", A_PtrSize ? "UPtr" : "uint", pGraphics, "float*", dpix)
	return Round(dpix)
}

;#####################################################################################

Gdip_GetDpiY(pGraphics)
{
	DllCall("gdiplus\GdipGetDpiY", A_PtrSize ? "UPtr" : "uint", pGraphics, "float*", dpiy)
	return Round(dpiy)
}

;#####################################################################################

Gdip_GetImageHorizontalResolution(pBitmap)
{
	DllCall("gdiplus\GdipGetImageHorizontalResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float*", dpix)
	return Round(dpix)
}

;#####################################################################################

Gdip_GetImageVerticalResolution(pBitmap)
{
	DllCall("gdiplus\GdipGetImageVerticalResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float*", dpiy)
	return Round(dpiy)
}

;#####################################################################################

Gdip_BitmapSetResolution(pBitmap, dpix, dpiy)
{
	return DllCall("gdiplus\GdipBitmapSetResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float", dpix, "float", dpiy)
}

;#####################################################################################

Gdip_CreateBitmapFromFile(sFile, IconNumber=1, IconSize="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"
	
	SplitPath, sFile,,, ext
	if ext in exe,dll
	{
		Sizes := IconSize ? IconSize : 256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
		BufSize := 16 + (2*(A_PtrSize ? A_PtrSize : 4))
		
		VarSetCapacity(buf, BufSize, 0)
		Loop, Parse, Sizes, |
		{
			DllCall("PrivateExtractIcons", "str", sFile, "int", IconNumber-1, "int", A_LoopField, "int", A_LoopField, PtrA, hIcon, PtrA, 0, "uint", 1, "uint", 0)
			
			if !hIcon
				continue

			if !DllCall("GetIconInfo", Ptr, hIcon, Ptr, &buf)
			{
				DestroyIcon(hIcon)
				continue
			}
			
			hbmMask  := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4))
			hbmColor := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4) + (A_PtrSize ? A_PtrSize : 4))
			if !(hbmColor && DllCall("GetObject", Ptr, hbmColor, "int", BufSize, Ptr, &buf))
			{
				DestroyIcon(hIcon)
				continue
			}
			break
		}
		if !hIcon
			return -1

		Width := NumGet(buf, 4, "int"), Height := NumGet(buf, 8, "int")
		hbm := CreateDIBSection(Width, -Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
		if !DllCall("DrawIconEx", Ptr, hdc, "int", 0, "int", 0, Ptr, hIcon, "uint", Width, "uint", Height, "uint", 0, Ptr, 0, "uint", 3)
		{
			DestroyIcon(hIcon)
			return -2
		}
		
		VarSetCapacity(dib, 104)
		DllCall("GetObject", Ptr, hbm, "int", A_PtrSize = 8 ? 104 : 84, Ptr, &dib) ; sizeof(DIBSECTION) = 76+2*(A_PtrSize=8?4:0)+2*A_PtrSize
		Stride := NumGet(dib, 12, "Int"), Bits := NumGet(dib, 20 + (A_PtrSize = 8 ? 4 : 0)) ; padding
		DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", Stride, "int", 0x26200A, Ptr, Bits, PtrA, pBitmapOld)
		pBitmap := Gdip_CreateBitmap(Width, Height)
		G := Gdip_GraphicsFromImage(pBitmap)
		, Gdip_DrawImage(G, pBitmapOld, 0, 0, Width, Height, 0, 0, Width, Height)
		SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
		Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmapOld)
		DestroyIcon(hIcon)
	}
	else
	{
		if (!A_IsUnicode)
		{
			VarSetCapacity(wFile, 1024)
			DllCall("kernel32\MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sFile, "int", -1, Ptr, &wFile, "int", 512)
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &wFile, PtrA, pBitmap)
		}
		else
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &sFile, PtrA, pBitmap)
	}
	
	return pBitmap
}

;#####################################################################################

Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", Ptr, hBitmap, Ptr, Palette, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_CreateHBITMAPFromBitmap(pBitmap, Background=0xffffffff)
{
	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hbm, "int", Background)
	return hbm
}

;#####################################################################################

Gdip_CreateBitmapFromHICON(hIcon)
{
	DllCall("gdiplus\GdipCreateBitmapFromHICON", A_PtrSize ? "UPtr" : "UInt", hIcon, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_CreateHICONFromBitmap(pBitmap)
{
	DllCall("gdiplus\GdipCreateHICONFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hIcon)
	return hIcon
}

;#####################################################################################

Gdip_CreateBitmap(Width, Height, Format=0x26200A)
{
    DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
    Return pBitmap
}

;#####################################################################################

Gdip_CreateBitmapFromClipboard()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if !DllCall("OpenClipboard", Ptr, 0)
		return -1
	if !DllCall("IsClipboardFormatAvailable", "uint", 8)
		return -2
	if !hBitmap := DllCall("GetClipboardData", "uint", 2, Ptr)
		return -3
	if !pBitmap := Gdip_CreateBitmapFromHBITMAP(hBitmap)
		return -4
	if !DllCall("CloseClipboard")
		return -5
	DeleteObject(hBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_SetBitmapToClipboard(pBitmap)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	off1 := A_PtrSize = 8 ? 52 : 44, off2 := A_PtrSize = 8 ? 32 : 24
	
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	DllCall("GetObject", Ptr, hBitmap, "int", VarSetCapacity(oi, A_PtrSize = 8 ? 96 : 84, 0), Ptr, &oi)
	hdib := DllCall("GlobalAlloc", "uint", 2, Ptr, off1+NumGet(oi, off1, "UInt")-4, Ptr)
	pdib := DllCall("GlobalLock", Ptr, hdib, Ptr)
	DllCall("RtlMoveMemory", Ptr, pdib, "uint", &oi+off2, Ptr, 40)
	DllCall("RtlMoveMemory", Ptr, pdib+40, Ptr, NumGet(oi, off2 - (A_PtrSize ? A_PtrSize : 4)), Ptr, NumGet(oi, off1, "UInt"))
	DllCall("GlobalUnlock", Ptr, hdib)
	DllCall("DeleteObject", Ptr, hBitmap)
	DllCall("OpenClipboard", Ptr, 0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "uint", 8, Ptr, hdib)
	DllCall("CloseClipboard")
}

;#####################################################################################

Gdip_CloneBitmapArea(pBitmap, x, y, w, h, Format=0x26200A)
{
	DllCall("gdiplus\GdipCloneBitmapArea"
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "int", Format
					, A_PtrSize ? "UPtr" : "UInt", pBitmap
					, A_PtrSize ? "UPtr*" : "UInt*", pBitmapDest)
	return pBitmapDest
}

;#####################################################################################
; Create resources
;#####################################################################################

Gdip_CreatePen(ARGB, w)
{
   DllCall("gdiplus\GdipCreatePen1", "UInt", ARGB, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
   return pPen
}

;#####################################################################################

Gdip_CreatePenFromBrush(pBrush, w)
{
	DllCall("gdiplus\GdipCreatePen2", A_PtrSize ? "UPtr" : "UInt", pBrush, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
	return pPen
}

;#####################################################################################

Gdip_BrushCreateSolid(ARGB=0xff000000)
{
	DllCall("gdiplus\GdipCreateSolidFill", "UInt", ARGB, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}

;#####################################################################################

; HatchStyleHorizontal = 0
; HatchStyleVertical = 1
; HatchStyleForwardDiagonal = 2
; HatchStyleBackwardDiagonal = 3
; HatchStyleCross = 4
; HatchStyleDiagonalCross = 5
; HatchStyle05Percent = 6
; HatchStyle10Percent = 7
; HatchStyle20Percent = 8
; HatchStyle25Percent = 9
; HatchStyle30Percent = 10
; HatchStyle40Percent = 11
; HatchStyle50Percent = 12
; HatchStyle60Percent = 13
; HatchStyle70Percent = 14
; HatchStyle75Percent = 15
; HatchStyle80Percent = 16
; HatchStyle90Percent = 17
; HatchStyleLightDownwardDiagonal = 18
; HatchStyleLightUpwardDiagonal = 19
; HatchStyleDarkDownwardDiagonal = 20
; HatchStyleDarkUpwardDiagonal = 21
; HatchStyleWideDownwardDiagonal = 22
; HatchStyleWideUpwardDiagonal = 23
; HatchStyleLightVertical = 24
; HatchStyleLightHorizontal = 25
; HatchStyleNarrowVertical = 26
; HatchStyleNarrowHorizontal = 27
; HatchStyleDarkVertical = 28
; HatchStyleDarkHorizontal = 29
; HatchStyleDashedDownwardDiagonal = 30
; HatchStyleDashedUpwardDiagonal = 31
; HatchStyleDashedHorizontal = 32
; HatchStyleDashedVertical = 33
; HatchStyleSmallConfetti = 34
; HatchStyleLargeConfetti = 35
; HatchStyleZigZag = 36
; HatchStyleWave = 37
; HatchStyleDiagonalBrick = 38
; HatchStyleHorizontalBrick = 39
; HatchStyleWeave = 40
; HatchStylePlaid = 41
; HatchStyleDivot = 42
; HatchStyleDottedGrid = 43
; HatchStyleDottedDiamond = 44
; HatchStyleShingle = 45
; HatchStyleTrellis = 46
; HatchStyleSphere = 47
; HatchStyleSmallGrid = 48
; HatchStyleSmallCheckerBoard = 49
; HatchStyleLargeCheckerBoard = 50
; HatchStyleOutlinedDiamond = 51
; HatchStyleSolidDiamond = 52
; HatchStyleTotal = 53
Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle=0)
{
	DllCall("gdiplus\GdipCreateHatchBrush", "int", HatchStyle, "UInt", ARGBfront, "UInt", ARGBback, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}

;#####################################################################################

Gdip_CreateTextureBrush(pBitmap, WrapMode=1, x=0, y=0, w="", h="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"
	
	if !(w && h)
		DllCall("gdiplus\GdipCreateTexture", Ptr, pBitmap, "int", WrapMode, PtrA, pBrush)
	else
		DllCall("gdiplus\GdipCreateTexture2", Ptr, pBitmap, "int", WrapMode, "float", x, "float", y, "float", w, "float", h, PtrA, pBrush)
	return pBrush
}

;#####################################################################################

; WrapModeTile = 0
; WrapModeTileFlipX = 1
; WrapModeTileFlipY = 2
; WrapModeTileFlipXY = 3
; WrapModeClamp = 4
Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
	DllCall("gdiplus\GdipCreateLineBrush", Ptr, &PointF1, Ptr, &PointF2, "Uint", ARGB1, "Uint", ARGB2, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}

;#####################################################################################

; LinearGradientModeHorizontal = 0
; LinearGradientModeVertical = 1
; LinearGradientModeForwardDiagonal = 2
; LinearGradientModeBackwardDiagonal = 3
Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode=1, WrapMode=1)
{
	CreateRectF(RectF, x, y, w, h)
	DllCall("gdiplus\GdipCreateLineBrushFromRect", A_PtrSize ? "UPtr" : "UInt", &RectF, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}

;#####################################################################################

Gdip_CloneBrush(pBrush)
{
	DllCall("gdiplus\GdipCloneBrush", A_PtrSize ? "UPtr" : "UInt", pBrush, A_PtrSize ? "UPtr*" : "UInt*", pBrushClone)
	return pBrushClone
}

;#####################################################################################
; Delete resources
;#####################################################################################

Gdip_DeletePen(pPen)
{
   return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
}

;#####################################################################################

Gdip_DeleteBrush(pBrush)
{
   return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
}

;#####################################################################################

Gdip_DisposeImage(pBitmap)
{
   return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}

;#####################################################################################

Gdip_DeleteGraphics(pGraphics)
{
   return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

;#####################################################################################

Gdip_DisposeImageAttributes(ImageAttr)
{
	return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
}

;#####################################################################################

Gdip_DeleteFont(hFont)
{
   return DllCall("gdiplus\GdipDeleteFont", A_PtrSize ? "UPtr" : "UInt", hFont)
}

;#####################################################################################

Gdip_DeleteStringFormat(hFormat)
{
   return DllCall("gdiplus\GdipDeleteStringFormat", A_PtrSize ? "UPtr" : "UInt", hFormat)
}

;#####################################################################################

Gdip_DeleteFontFamily(hFamily)
{
   return DllCall("gdiplus\GdipDeleteFontFamily", A_PtrSize ? "UPtr" : "UInt", hFamily)
}

;#####################################################################################

Gdip_DeleteMatrix(Matrix)
{
   return DllCall("gdiplus\GdipDeleteMatrix", A_PtrSize ? "UPtr" : "UInt", Matrix)
}

;#####################################################################################
; Text functions
;#####################################################################################

Gdip_TextToGraphics(pGraphics, Text, Options, Font="Arial", Width="", Height="", Measure=0)
{
	IWidth := Width, IHeight:= Height
	
	RegExMatch(Options, "i)X([\-\d\.]+)(p*)", xpos)
	RegExMatch(Options, "i)Y([\-\d\.]+)(p*)", ypos)
	RegExMatch(Options, "i)W([\-\d\.]+)(p*)", Width)
	RegExMatch(Options, "i)H([\-\d\.]+)(p*)", Height)
	RegExMatch(Options, "i)C(?!(entre|enter))([a-f\d]+)", Colour)
	RegExMatch(Options, "i)Top|Up|Bottom|Down|vCentre|vCenter", vPos)
	RegExMatch(Options, "i)NoWrap", NoWrap)
	RegExMatch(Options, "i)R(\d)", Rendering)
	RegExMatch(Options, "i)S(\d+)(p*)", Size)

	if !Gdip_DeleteBrush(Gdip_CloneBrush(Colour2))
		PassBrush := 1, pBrush := Colour2
	
	if !(IWidth && IHeight) && (xpos2 || ypos2 || Width2 || Height2 || Size2)
		return -1

	Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
	Loop, Parse, Styles, |
	{
		if RegExMatch(Options, "\b" A_loopField)
		Style |= (A_LoopField != "StrikeOut") ? (A_Index-1) : 8
	}
  
	Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
	Loop, Parse, Alignments, |
	{
		if RegExMatch(Options, "\b" A_loopField)
			Align |= A_Index//2.1      ; 0|0|1|1|2|2
	}

	xpos := (xpos1 != "") ? xpos2 ? IWidth*(xpos1/100) : xpos1 : 0
	ypos := (ypos1 != "") ? ypos2 ? IHeight*(ypos1/100) : ypos1 : 0
	Width := Width1 ? Width2 ? IWidth*(Width1/100) : Width1 : IWidth
	Height := Height1 ? Height2 ? IHeight*(Height1/100) : Height1 : IHeight
	if !PassBrush
		Colour := "0x" (Colour2 ? Colour2 : "ff000000")
	Rendering := ((Rendering1 >= 0) && (Rendering1 <= 5)) ? Rendering1 : 4
	Size := (Size1 > 0) ? Size2 ? IHeight*(Size1/100) : Size1 : 12

	hFamily := Gdip_FontFamilyCreate(Font)
	hFont := Gdip_FontCreate(hFamily, Size, Style)
	FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
	hFormat := Gdip_StringFormatCreate(FormatStyle)
	pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
	if !(hFamily && hFont && hFormat && pBrush && pGraphics)
		return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0
   
	CreateRectF(RC, xpos, ypos, Width, Height)
	Gdip_SetStringFormatAlign(hFormat, Align)
	Gdip_SetTextRenderingHint(pGraphics, Rendering)
	ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)

	if vPos
	{
		StringSplit, ReturnRC, ReturnRC, |
		
		if (vPos = "vCentre") || (vPos = "vCenter")
			ypos += (Height-ReturnRC4)//2
		else if (vPos = "Top") || (vPos = "Up")
			ypos := 0
		else if (vPos = "Bottom") || (vPos = "Down")
			ypos := Height-ReturnRC4
		
		CreateRectF(RC, xpos, ypos, Width, ReturnRC4)
		ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
	}

	if !Measure
		E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)

	if !PassBrush
		Gdip_DeleteBrush(pBrush)
	Gdip_DeleteStringFormat(hFormat)   
	Gdip_DeleteFont(hFont)
	Gdip_DeleteFontFamily(hFamily)
	return E ? E : ReturnRC
}

;#####################################################################################

Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}
	
	return DllCall("gdiplus\GdipDrawString"
					, Ptr, pGraphics
					, Ptr, A_IsUnicode ? &sString : &wString
					, "int", -1
					, Ptr, hFont
					, Ptr, &RectF
					, Ptr, hFormat
					, Ptr, pBrush)
}

;#####################################################################################

Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	VarSetCapacity(RC, 16)
	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wString, nSize*2)   
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}
	
	DllCall("gdiplus\GdipMeasureString"
					, Ptr, pGraphics
					, Ptr, A_IsUnicode ? &sString : &wString
					, "int", -1
					, Ptr, hFont
					, Ptr, &RectF
					, Ptr, hFormat
					, Ptr, &RC
					, "uint*", Chars
					, "uint*", Lines)
	
	return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
}

; Near = 0
; Center = 1
; Far = 2
Gdip_SetStringFormatAlign(hFormat, Align)
{
   return DllCall("gdiplus\GdipSetStringFormatAlign", A_PtrSize ? "UPtr" : "UInt", hFormat, "int", Align)
}

; StringFormatFlagsDirectionRightToLeft    = 0x00000001
; StringFormatFlagsDirectionVertical       = 0x00000002
; StringFormatFlagsNoFitBlackBox           = 0x00000004
; StringFormatFlagsDisplayFormatControl    = 0x00000020
; StringFormatFlagsNoFontFallback          = 0x00000400
; StringFormatFlagsMeasureTrailingSpaces   = 0x00000800
; StringFormatFlagsNoWrap                  = 0x00001000
; StringFormatFlagsLineLimit               = 0x00002000
; StringFormatFlagsNoClip                  = 0x00004000 
Gdip_StringFormatCreate(Format=0, Lang=0)
{
   DllCall("gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, A_PtrSize ? "UPtr*" : "UInt*", hFormat)
   return hFormat
}

; Regular = 0
; Bold = 1
; Italic = 2
; BoldItalic = 3
; Underline = 4
; Strikeout = 8
Gdip_FontCreate(hFamily, Size, Style=0)
{
   DllCall("gdiplus\GdipCreateFont", A_PtrSize ? "UPtr" : "UInt", hFamily, "float", Size, "int", Style, "int", 0, A_PtrSize ? "UPtr*" : "UInt*", hFont)
   return hFont
}

Gdip_FontFamilyCreate(Font)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wFont, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, Ptr, &wFont, "int", nSize)
	}
	
	DllCall("gdiplus\GdipCreateFontFamilyFromName"
					, Ptr, A_IsUnicode ? &Font : &wFont
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "UInt*", hFamily)
	
	return hFamily
}

;#####################################################################################
; Matrix functions
;#####################################################################################

Gdip_CreateAffineMatrix(m11, m12, m21, m22, x, y)
{
   DllCall("gdiplus\GdipCreateMatrix2", "float", m11, "float", m12, "float", m21, "float", m22, "float", x, "float", y, A_PtrSize ? "UPtr*" : "UInt*", Matrix)
   return Matrix
}

Gdip_CreateMatrix()
{
   DllCall("gdiplus\GdipCreateMatrix", A_PtrSize ? "UPtr*" : "UInt*", Matrix)
   return Matrix
}

;#####################################################################################
; GraphicsPath functions
;#####################################################################################

; Alternate = 0
; Winding = 1
Gdip_CreatePath(BrushMode=0)
{
	DllCall("gdiplus\GdipCreatePath", "int", BrushMode, A_PtrSize ? "UPtr*" : "UInt*", Path)
	return Path
}

Gdip_AddPathEllipse(Path, x, y, w, h)
{
	return DllCall("gdiplus\GdipAddPathEllipse", A_PtrSize ? "UPtr" : "UInt", Path, "float", x, "float", y, "float", w, "float", h)
}

Gdip_AddPathPolygon(Path, Points)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}   

	return DllCall("gdiplus\GdipAddPathPolygon", Ptr, Path, Ptr, &PointF, "int", Points0)
}

Gdip_DeletePath(Path)
{
	return DllCall("gdiplus\GdipDeletePath", A_PtrSize ? "UPtr" : "UInt", Path)
}

;#####################################################################################
; Quality functions
;#####################################################################################

; SystemDefault = 0
; SingleBitPerPixelGridFit = 1
; SingleBitPerPixel = 2
; AntiAliasGridFit = 3
; AntiAlias = 4
Gdip_SetTextRenderingHint(pGraphics, RenderingHint)
{
	return DllCall("gdiplus\GdipSetTextRenderingHint", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", RenderingHint)
}

; Default = 0
; LowQuality = 1
; HighQuality = 2
; Bilinear = 3
; Bicubic = 4
; NearestNeighbor = 5
; HighQualityBilinear = 6
; HighQualityBicubic = 7
Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
{
   return DllCall("gdiplus\GdipSetInterpolationMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", InterpolationMode)
}

; Default = 0
; HighSpeed = 1
; HighQuality = 2
; None = 3
; AntiAlias = 4
Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
{
   return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", SmoothingMode)
}

; CompositingModeSourceOver = 0 (blended)
; CompositingModeSourceCopy = 1 (overwrite)
Gdip_SetCompositingMode(pGraphics, CompositingMode=0)
{
   return DllCall("gdiplus\GdipSetCompositingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", CompositingMode)
}

;#####################################################################################
; Extra functions
;#####################################################################################

Gdip_Startup()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}

Gdip_Shutdown(pToken)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("FreeLibrary", Ptr, hModule)
	return 0
}

; Prepend = 0; The new operation is applied before the old operation.
; Append = 1; The new operation is applied after the old operation.
Gdip_RotateWorldTransform(pGraphics, Angle, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipRotateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", Angle, "int", MatrixOrder)
}

Gdip_ScaleWorldTransform(pGraphics, x, y, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipScaleWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_TranslateWorldTransform(pGraphics, x, y, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipTranslateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_ResetWorldTransform(pGraphics)
{
	return DllCall("gdiplus\GdipResetWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_GetRotatedTranslation(Width, Height, Angle, ByRef xTranslation, ByRef yTranslation)
{
	pi := 3.14159, TAngle := Angle*(pi/180)	

	Bound := (Angle >= 0) ? Mod(Angle, 360) : 360-Mod(-Angle, -360)
	if ((Bound >= 0) && (Bound <= 90))
		xTranslation := Height*Sin(TAngle), yTranslation := 0
	else if ((Bound > 90) && (Bound <= 180))
		xTranslation := (Height*Sin(TAngle))-(Width*Cos(TAngle)), yTranslation := -Height*Cos(TAngle)
	else if ((Bound > 180) && (Bound <= 270))
		xTranslation := -(Width*Cos(TAngle)), yTranslation := -(Height*Cos(TAngle))-(Width*Sin(TAngle))
	else if ((Bound > 270) && (Bound <= 360))
		xTranslation := 0, yTranslation := -Width*Sin(TAngle)
}

Gdip_GetRotatedDimensions(Width, Height, Angle, ByRef RWidth, ByRef RHeight)
{
	pi := 3.14159, TAngle := Angle*(pi/180)
	if !(Width && Height)
		return -1
	RWidth := Ceil(Abs(Width*Cos(TAngle))+Abs(Height*Sin(TAngle)))
	RHeight := Ceil(Abs(Width*Sin(TAngle))+Abs(Height*Cos(Tangle)))
}

; RotateNoneFlipNone   = 0
; Rotate90FlipNone     = 1
; Rotate180FlipNone    = 2
; Rotate270FlipNone    = 3
; RotateNoneFlipX      = 4
; Rotate90FlipX        = 5
; Rotate180FlipX       = 6
; Rotate270FlipX       = 7
; RotateNoneFlipY      = Rotate180FlipX
; Rotate90FlipY        = Rotate270FlipX
; Rotate180FlipY       = RotateNoneFlipX
; Rotate270FlipY       = Rotate90FlipX
; RotateNoneFlipXY     = Rotate180FlipNone
; Rotate90FlipXY       = Rotate270FlipNone
; Rotate180FlipXY      = RotateNoneFlipNone
; Rotate270FlipXY      = Rotate90FlipNone 

Gdip_ImageRotateFlip(pBitmap, RotateFlipType=1)
{
	return DllCall("gdiplus\GdipImageRotateFlip", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", RotateFlipType)
}

; Replace = 0
; Intersect = 1
; Union = 2
; Xor = 3
; Exclude = 4
; Complement = 5
Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode=0)
{
   return DllCall("gdiplus\GdipSetClipRect",  A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode)
}

Gdip_SetClipPath(pGraphics, Path, CombineMode=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipSetClipPath", Ptr, pGraphics, Ptr, Path, "int", CombineMode)
}

Gdip_ResetClip(pGraphics)
{
   return DllCall("gdiplus\GdipResetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_GetClipRegion(pGraphics)
{
	Region := Gdip_CreateRegion()
	DllCall("gdiplus\GdipGetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", Region)
	return Region
}

Gdip_SetClipRegion(pGraphics, Region, CombineMode=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipSetClipRegion", Ptr, pGraphics, Ptr, Region, "int", CombineMode)
}

Gdip_CreateRegion()
{
	DllCall("gdiplus\GdipCreateRegion", A_PtrSize ? "UPtr*" : "UInt*", Region)
	return Region
}

Gdip_DeleteRegion(Region)
{
	return DllCall("gdiplus\GdipDeleteRegion", A_PtrSize ? "UPtr" : "UInt", Region)
}

;#####################################################################################
; BitmapLockBits
;#####################################################################################

Gdip_LockBits(pBitmap, x, y, w, h, ByRef Stride, ByRef Scan0, ByRef BitmapData, LockMode = 3, PixelFormat = 0x26200a)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	CreateRect(Rect, x, y, w, h)
	VarSetCapacity(BitmapData, 16+2*(A_PtrSize ? A_PtrSize : 4), 0)
	E := DllCall("Gdiplus\GdipBitmapLockBits", Ptr, pBitmap, Ptr, &Rect, "uint", LockMode, "int", PixelFormat, Ptr, &BitmapData)
	Stride := NumGet(BitmapData, 8, "Int")
	Scan0 := NumGet(BitmapData, 16, Ptr)
	return E
}

;#####################################################################################

Gdip_UnlockBits(pBitmap, ByRef BitmapData)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("Gdiplus\GdipBitmapUnlockBits", Ptr, pBitmap, Ptr, &BitmapData)
}

;#####################################################################################

Gdip_SetLockBitPixel(ARGB, Scan0, x, y, Stride)
{
	Numput(ARGB, Scan0+0, (x*4)+(y*Stride), "UInt")
}

;#####################################################################################

Gdip_GetLockBitPixel(Scan0, x, y, Stride)
{
	return NumGet(Scan0+0, (x*4)+(y*Stride), "UInt")
}

;#####################################################################################

Gdip_PixelateBitmap(pBitmap, ByRef pBitmapOut, BlockSize)
{
	static PixelateBitmap
	
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (!PixelateBitmap)
	{
		if A_PtrSize != 8 ; x86 machine code
		MCode_PixelateBitmap =
		(LTrim Join
		558BEC83EC3C8B4514538B5D1C99F7FB56578BC88955EC894DD885C90F8E830200008B451099F7FB8365DC008365E000894DC88955F08945E833FF897DD4
		397DE80F8E160100008BCB0FAFCB894DCC33C08945F88945FC89451C8945143BD87E608B45088D50028BC82BCA8BF02BF2418945F48B45E02955F4894DC4
		8D0CB80FAFCB03CA895DD08BD1895DE40FB64416030145140FB60201451C8B45C40FB604100145FC8B45F40FB604020145F883C204FF4DE475D6034D18FF
		4DD075C98B4DCC8B451499F7F98945148B451C99F7F989451C8B45FC99F7F98945FC8B45F899F7F98945F885DB7E648B450C8D50028BC82BCA83C103894D
		C48BC82BCA41894DF48B4DD48945E48B45E02955E48D0C880FAFCB03CA895DD08BD18BF38A45148B7DC48804178A451C8B7DF488028A45FC8804178A45F8
		8B7DE488043A83C2044E75DA034D18FF4DD075CE8B4DCC8B7DD447897DD43B7DE80F8CF2FEFFFF837DF0000F842C01000033C08945F88945FC89451C8945
		148945E43BD87E65837DF0007E578B4DDC034DE48B75E80FAF4D180FAFF38B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945CC0F
		B6440E030145140FB60101451C0FB6440F010145FC8B45F40FB604010145F883C104FF4DCC75D8FF45E4395DE47C9B8B4DF00FAFCB85C9740B8B451499F7
		F9894514EB048365140033F63BCE740B8B451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB
		038975F88975E43BDE7E5A837DF0007E4C8B4DDC034DE48B75E80FAF4D180FAFF38B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955CC8A55
		1488540E038A551C88118A55FC88540F018A55F888140183C104FF4DCC75DFFF45E4395DE47CA68B45180145E0015DDCFF4DC80F8594FDFFFF8B451099F7
		FB8955F08945E885C00F8E450100008B45EC0FAFC38365DC008945D48B45E88945CC33C08945F88945FC89451C8945148945103945EC7E6085DB7E518B4D
		D88B45080FAFCB034D108D50020FAF4D18034DDC8BF08BF88945F403CA2BF22BFA2955F4895DC80FB6440E030145140FB60101451C0FB6440F010145FC8B
		45F40FB604080145F883C104FF4DC875D8FF45108B45103B45EC7CA08B4DD485C9740B8B451499F7F9894514EB048365140033F63BCE740B8B451C99F7F9
		89451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975103975EC7E5585DB7E468B4DD88B450C
		0FAFCB034D108D50020FAF4D18034DDC8BF08BF803CA2BF22BFA2BC2895DC88A551488540E038A551C88118A55FC88540F018A55F888140183C104FF4DC8
		75DFFF45108B45103B45EC7CAB8BC3C1E0020145DCFF4DCC0F85CEFEFFFF8B4DEC33C08945F88945FC89451C8945148945103BC87E6C3945F07E5C8B4DD8
		8B75E80FAFCB034D100FAFF30FAF4D188B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945C80FB6440E030145140FB60101451C0F
		B6440F010145FC8B45F40FB604010145F883C104FF4DC875D833C0FF45108B4DEC394D107C940FAF4DF03BC874068B451499F7F933F68945143BCE740B8B
		451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975083975EC7E63EB0233F639
		75F07E4F8B4DD88B75E80FAFCB034D080FAFF30FAF4D188B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955108A551488540E038A551C8811
		8A55FC88540F018A55F888140883C104FF4D1075DFFF45088B45083B45EC7C9F5F5E33C05BC9C21800
		)
		else ; x64 machine code
		MCode_PixelateBitmap =
		(LTrim Join
		4489442418488954241048894C24085355565741544155415641574883EC28418BC1448B8C24980000004C8BDA99488BD941F7F9448BD0448BFA8954240C
		448994248800000085C00F8E9D020000418BC04533E4458BF299448924244C8954241041F7F933C9898C24980000008BEA89542404448BE889442408EB05
		4C8B5C24784585ED0F8E1A010000458BF1418BFD48897C2418450FAFF14533D233F633ED4533E44533ED4585C97E5B4C63BC2490000000418D040A410FAF
		C148984C8D441802498BD9498BD04D8BD90FB642010FB64AFF4403E80FB60203E90FB64AFE4883C2044403E003F149FFCB75DE4D03C748FFCB75D0488B7C
		24188B8C24980000004C8B5C2478418BC59941F7FE448BE8418BC49941F7FE448BE08BC59941F7FE8BE88BC69941F7FE8BF04585C97E4048639C24900000
		004103CA4D8BC1410FAFC94863C94A8D541902488BCA498BC144886901448821408869FF408871FE4883C10448FFC875E84803D349FFC875DA8B8C249800
		0000488B5C24704C8B5C24784183C20448FFCF48897C24180F850AFFFFFF8B6C2404448B2424448B6C24084C8B74241085ED0F840A01000033FF33DB4533
		DB4533D24533C04585C97E53488B74247085ED7E42438D0C04418BC50FAF8C2490000000410FAFC18D04814863C8488D5431028BCD0FB642014403D00FB6
		024883C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC17CB28BCD410FAFC985C9740A418BC299F7F98BF0EB0233F685C9740B418BC3
		99F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585C97E4D4C8B74247885ED7E3841
		8D0C14418BC50FAF8C2490000000410FAFC18D04814863C84A8D4431028BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2413BD17CBD
		4C8B7424108B8C2498000000038C2490000000488B5C24704503E149FFCE44892424898C24980000004C897424100F859EFDFFFF448B7C240C448B842480
		000000418BC09941F7F98BE8448BEA89942498000000896C240C85C00F8E3B010000448BAC2488000000418BCF448BF5410FAFC9898C248000000033FF33
		ED33F64533DB4533D24533C04585FF7E524585C97E40418BC5410FAFC14103C00FAF84249000000003C74898488D541802498BD90FB642014403D00FB602
		4883C2044403D80FB642FB03F00FB642FA03E848FFCB75DE488B5C247041FFC0453BC77CAE85C9740B418BC299F7F9448BE0EB034533E485C9740A418BC3
		99F7F98BD8EB0233DB85C9740A8BC699F7F9448BD8EB034533DB85C9740A8BC599F7F9448BD0EB034533D24533C04585FF7E4E488B4C24784585C97E3541
		8BC5410FAFC14103C00FAF84249000000003C74898488D540802498BC144886201881A44885AFF448852FE4883C20448FFC875E941FFC0453BC77CBE8B8C
		2480000000488B5C2470418BC1C1E00203F849FFCE0F85ECFEFFFF448BAC24980000008B6C240C448BA4248800000033FF33DB4533DB4533D24533C04585
		FF7E5A488B7424704585ED7E48418BCC8BC5410FAFC94103C80FAF8C2490000000410FAFC18D04814863C8488D543102418BCD0FB642014403D00FB60248
		83C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC77CAB418BCF410FAFCD85C9740A418BC299F7F98BF0EB0233F685C9740B418BC399
		F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585FF7E4E4585ED7E42418BCC8BC541
		0FAFC903CA0FAF8C2490000000410FAFC18D04814863C8488B442478488D440102418BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2
		413BD77CB233C04883C428415F415E415D415C5F5E5D5BC3
		)
		
		VarSetCapacity(PixelateBitmap, StrLen(MCode_PixelateBitmap)//2)
		Loop % StrLen(MCode_PixelateBitmap)//2		;%
			NumPut("0x" SubStr(MCode_PixelateBitmap, (2*A_Index)-1, 2), PixelateBitmap, A_Index-1, "UChar")
		DllCall("VirtualProtect", Ptr, &PixelateBitmap, Ptr, VarSetCapacity(PixelateBitmap), "uint", 0x40, A_PtrSize ? "UPtr*" : "UInt*", 0)
	}

	Gdip_GetImageDimensions(pBitmap, Width, Height)
	
	if (Width != Gdip_GetImageWidth(pBitmapOut) || Height != Gdip_GetImageHeight(pBitmapOut))
		return -1
	if (BlockSize > Width || BlockSize > Height)
		return -2

	E1 := Gdip_LockBits(pBitmap, 0, 0, Width, Height, Stride1, Scan01, BitmapData1)
	E2 := Gdip_LockBits(pBitmapOut, 0, 0, Width, Height, Stride2, Scan02, BitmapData2)
	if (E1 || E2)
		return -3

	E := DllCall(&PixelateBitmap, Ptr, Scan01, Ptr, Scan02, "int", Width, "int", Height, "int", Stride1, "int", BlockSize)
	
	Gdip_UnlockBits(pBitmap, BitmapData1), Gdip_UnlockBits(pBitmapOut, BitmapData2)
	return 0
}

;#####################################################################################

Gdip_ToARGB(A, R, G, B)
{
	return (A << 24) | (R << 16) | (G << 8) | B
}

;#####################################################################################

Gdip_FromARGB(ARGB, ByRef A, ByRef R, ByRef G, ByRef B)
{
	A := (0xff000000 & ARGB) >> 24
	R := (0x00ff0000 & ARGB) >> 16
	G := (0x0000ff00 & ARGB) >> 8
	B := 0x000000ff & ARGB
}

;#####################################################################################

Gdip_AFromARGB(ARGB)
{
	return (0xff000000 & ARGB) >> 24
}

;#####################################################################################

Gdip_RFromARGB(ARGB)
{
	return (0x00ff0000 & ARGB) >> 16
}

;#####################################################################################

Gdip_GFromARGB(ARGB)
{
	return (0x0000ff00 & ARGB) >> 8
}

;#####################################################################################

Gdip_BFromARGB(ARGB)
{
	return 0x000000ff & ARGB
}

;#####################################################################################

StrGetB(Address, Length=-1, Encoding=0)
{
	; Flexible parameter handling:
	if Length is not integer
	Encoding := Length,  Length := -1

	; Check for obvious errors.
	if (Address+0 < 1024)
		return

	; Ensure 'Encoding' contains a numeric identifier.
	if Encoding = UTF-16
		Encoding = 1200
	else if Encoding = UTF-8
		Encoding = 65001
	else if SubStr(Encoding,1,2)="CP"
		Encoding := SubStr(Encoding,3)

	if !Encoding ; "" or 0
	{
		; No conversion necessary, but we might not want the whole string.
		if (Length == -1)
			Length := DllCall("lstrlen", "uint", Address)
		VarSetCapacity(String, Length)
		DllCall("lstrcpyn", "str", String, "uint", Address, "int", Length + 1)
	}
	else if Encoding = 1200 ; UTF-16
	{
		char_count := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0x400, "uint", Address, "int", Length, "uint", 0, "uint", 0, "uint", 0, "uint", 0)
		VarSetCapacity(String, char_count)
		DllCall("WideCharToMultiByte", "uint", 0, "uint", 0x400, "uint", Address, "int", Length, "str", String, "int", char_count, "uint", 0, "uint", 0)
	}
	else if Encoding is integer
	{
		; Convert from target encoding to UTF-16 then to the active code page.
		char_count := DllCall("MultiByteToWideChar", "uint", Encoding, "uint", 0, "uint", Address, "int", Length, "uint", 0, "int", 0)
		VarSetCapacity(String, char_count * 2)
		char_count := DllCall("MultiByteToWideChar", "uint", Encoding, "uint", 0, "uint", Address, "int", Length, "uint", &String, "int", char_count * 2)
		String := StrGetB(&String, char_count, 1200)
	}
	return String
}
;}
;end gdip--------------------------------------------------------------
return
DuplicateExistsTestScreen:
IfWinExist,ahk_id %DuplicateExistsTestScreenID%
 {
  WinRestore,ahk_id %DuplicateExistsTestScreenID%
  WinActivate,ahk_id %DuplicateExistsTestScreenID%
  return
 }
    FormatTime, SavedTime1 ,   , %DateTimeFormatDuplicates%
    FormatTime, SavedTime2 ,   , %DateTimeFormatDuplicates%
    
    ;NewFileName = %A_ScriptDir%\SpaImage.jpg
    NewFileName := ( A_ScriptDir "\SpaImage.jpg" )
    SplitPath,NewFileName,,,Ext,NewFileNameNoExt
    Gui 58: -dpiscale     
    IniRead,DuplicateExistsGuiColor,spaconfig.ini,SystemColors,DuplicateExistsGuiColor,c0c0c0
    IniRead,DuplicateExistsGuiTextColor,spaconfig.ini,SystemColors,DuplicateExistsGuiTextColor,000000

    Gui 58: Default
    Gui 58:  -SysMenu
    
    Gui 58: font, 
    Gui 58: font, s11 c%DuplicateExistsGuiTextColor%
    
    Gui 58: Add, Text, x15 y9 w760 h20                       , A duplicate filename was found in your "Save To" folder.
    Gui 58: Add, Text, x15 y39 w760 h20                      , What would you like to do?
        
    Gui 58: Add, Picture, x36 y145 w380 h-1, %A_ScriptDir%\SpaImage.jpg ;Original
    
    Gui 58: font, 
    Gui 58: font, s9 c%DuplicateExistsGuiTextColor%    
    
    Gui 58: Add, Radio, x36  y520 w140 h20  Group , Enter New Name
    Gui 58: Add, Radio, x36  y540 w200 h20        , Add Date && Time to filename
    Gui 58: Add, Radio, x36  y560 w380 h20        , Delete this picture
    Gui 58: Add, Radio, x36  y580 w380 h20        , Keep with same filename

    Gui 58: Add, Edit, x190 y520 w190 h19 , %NewFilenameNoExt%
    Gui 58: Add, Edit, x236 y540 w144 h19 , %NewFilenameNoExt%-%SavedTime1%
    ;-------------------------------------------------------------------------------------------------------------------------
    Gui 58: Add, Picture, x475 y145 w380 h-1, %A_ScriptDir%\SpaImage.jpg ;Duplicate
 
    Gui 58: Add, Radio, x476 y520 w140 h20 Group , Enter New Name
    Gui 58: Add, Radio, x476 y540 w200 h20 , Add Date && Time to filename
    Gui 58: Add, Radio, x476 y560 w380 h20 , Delete this picture 
    Gui 58: Add, Radio, x476 y580 w380 h20 , Keep with same filename
        
    Gui 58: Add, Edit, x630 y520 w190 h19  , %NewFilenameNoExt%
    Gui 58: Add, Edit, x676 y540 w144 h19  , %NewFilenameNoExt%-%SavedTime2%
    
    Gui 58: font, 
    Gui 58: font, s9 c000000
    Gui 58: Add,  text, x382 y522 ,.
    Gui 58: Add,  Edit, x387 y520 w34 h19 vExtEditboxTesting1 ReadOnly,%ext%
    Control_Colors("ExtEditboxTesting1", "Set", "0xC0C0C0", "0x000000")
   
    Gui 58: Add,  text, x382 y542 ,.
    Gui 58: Add,  Edit, x387 y540 w34 h19 vExtEditboxTesting2 ReadOnly,%ext%
    Control_Colors("ExtEditboxTesting2", "Set", "0xC0C0C0", "0x000000")

    Gui 58: Add,  text, x821 y522 ,.
    Gui 58: Add,  Edit, x826 y520 w34 h19 vExtEditboxTesting3 ReadOnly,%ext%
    Control_Colors("ExtEditboxTesting3", "Set", "0xC0C0C0", "0x000000")

    Gui 58: Add,  text, x821 y542 ,.
    Gui 58: Add,  Edit, x826 y540 w34 h19 vExtEditboxTesting4 ReadOnly,%ext%
    Control_Colors("ExtEditboxTesting4", "Set", "0xC0C0C0", "0x000000")
        
    Gui 58: Add, GroupBox, x16 y80 w420 h525  , Original
    Gui 58: Add, GroupBox, x456 y80 w420 h525 , Duplicate
    
    Gui 58: Add, Button, x756 y630 w120 h20 , Apply && Close
    Gui 58: font, 
    Gui 58: font, s9 c%DuplicateExistsGuiTextColor% 
    Gui 58: Add, text, x17 y610 ,How To Handle Duplicates is set for "Ask What To Do When Duplicates Are Found"
    Gui 58: Add, text, x17 y630 vClickHereTestGui ,This setting can be changed via the System tray icon, Settings, then Additional Settings or click
    
    Gui 58: Add, text, x470 y630 hwndHWND_HowToHandleDuplicatesClickHereTesting cblue,HERE

    Gui 58: color,%DuplicateExistsGuiColor%                                                      
    
    Gui 58: Show, w899 h670, Duplicate Exists
    WinGet,DuplicateExistsTestScreenID,ID,Duplicate Exists 
    
    GuiControlGet,HowToHandleDuplicatesClickHere,Pos,ClickHereTestGui
    
    if Dpi <> 96
     ControlMove,,HowToHandleDuplicatesClickHereW+25,HowToHandleDuplicatesClickHereY+30,,,ahk_id %HWND_HowToHandleDuplicatesClickHereTesting% ;move Here text
    else
     {
      if a_osversion = win_xp ;for some reason 96 dpi on winxp put "Here" higher up on the screen then 96 dpi on vista or win7
        ControlMove,,HowToHandleDuplicatesClickHereW+25,HowToHandleDuplicatesClickHereY+30,,,ahk_id %HWND_HowToHandleDuplicatesClickHereTesting%
      else
        ControlMove,,HowToHandleDuplicatesClickHereW+25,HowToHandleDuplicatesClickHereY+25,,,ahk_id %HWND_HowToHandleDuplicatesClickHereTesting%
     }
    return
;--------TheEnd---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

