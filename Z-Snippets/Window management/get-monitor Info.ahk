SysGet, MouseButtonCount, 43

SysGet, MonitorCount, MonitorCount            ; How Many
SysGet, MonitorPrimary, MonitorPrimary        ; Which one is primary

msgbox, Monitors: %monitorcount%`nPrimary:   %monitorprimary%


SysGet, VirtualScreenWidth, 78           ; width of all combined monitors
SysGet, VirtualScreenHeight, 79          ; height of all combined monitors

msgbox, VirtualScreen Command:`n`nWidth:  %virtualscreenwidth%`nHeight:%virtualscreenheight%


Loop, %MonitorCount%
{
    SysGet, MonitorName, MonitorName, %A_Index%
    SysGet, Monitor, Monitor, %A_Index%                   ; Monitor number
    SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
	
    MsgBox, 
	(
	Monitor:`t#%A_Index% values:`n
Name:`t%MonitorName%
Left:`t%MonitorLeft%
Work Left: %MonitorWorkAreaLeft%
Top:`t%MonitorTop% 
Work Top: %MonitorWorkAreaTop%
Right:`t%MonitorRight% 
Work Right: %MonitorWorkAreaRight%
Bottom:`t%MonitorBottom%
Work Bottom: %MonitorWorkAreaBottom%
	)
}