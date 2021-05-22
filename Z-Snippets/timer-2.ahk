;

#SingleInstance, Force
SetTitleMatchMode, 2                ; 1 = Starts with, 2 = Anywhere, 3 = Exact

Script_Name = ScriptName

eta := 1	; set in minutes
eta *= 60	; convert to seconds
time := a_tickcount	; time is now
gosub eggtimer
return

eggtimer:
	eta -= (a_tickcount - time) / 1000
	time := a_tickcount
	tooltip % floor(eta / 60) ":" substr( "0" . mod(round(eta), 60), -1)
	if (eta > 0)
		settimer,, -1000
return