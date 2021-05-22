;-----------------------------------------------------------------
; makes a listview of 20 rows of 11 columns
; The first column contaiuns the row count
; the rows are filled with incrementing numbers from 1 to 200

num := 1

k1 = 1 ; row counter
Loop 20
{ 
	k2 := 1 ; column counter
	Loop 11
	{ 
		if(k2 = 1) ; for first column, print the row number
			str := str k1 "|"
		else
			str := str num++ "|"
		k2++
	}
	str := str "`n"
	k1++
}

Gui, Add, Listview, x4 y5 w340 h390[/color],Row | 1 | 2 |
Loop, Parse, str, `n, `r
	{ 
	 StringSplit, z, A_LoopField, |
	 LV_Add(z0,z1)
	}
Gui, Show, H400 W350 center
listlines, on
Return

GuiClose:
ExitApp