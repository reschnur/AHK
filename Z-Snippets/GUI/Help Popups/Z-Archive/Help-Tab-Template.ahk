

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Tab 7 - Cities - Skylines
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

gui, tab, Cities-Skylines			

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Block 1

t7block1title = 1-Lambda Expressions
t7block1rows = 7

t7block1x = 15
t7block1y = 40
t7block1w = 425

t7block1data= 
(
~~~~~~~~~~~~~~~~~~|~~~~~~|~~~~~~|~~~~~~~~~~|~~~~~~~
Consumer|accept()|1|no|yes
Supplier|get()|0|yes|no
Predicate|test()|1|yes-boolean|yes
Function|apply()|1|yes|yes
UnaryOperator|depends|1|yes-same type|yes
Note: most have bi version||||
)

; BUILD
Gui, Font, Verdana s12 cPurple bold underline
Gui, Add, Text, x%t7block1x% y%t7block1y%, %t7block1Title%
Gui, Font, Verdana s9 cBlack norm

Gui, Add, Listview, x%t7block1x% y+6 w%t7block1w% r%t7block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Interface|method|# inputs|outputs|chainable

Loop, Parse, t7block1data, `n, `r
	{
	 StringSplit, data, A_LoopField, | 
	 LV_Add("", data1, data2, data3, data4, data5)
	}

LV_ModifyCol()                               ; Auto width columns()
LV_ModifyCol(1, "AutoHdr") 
LV_ModifyCol(2, "AutoHdr") 
LV_ModifyCol(3, "AutoHdr") 
LV_ModifyCol(4, "AutoHdr") 
LV_ModifyCol(5, "AutoHdr") 


; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Block 2

t7block2title = 2-Stream Collection Interface
t7block2rows =16

t7block2x = 15
t7block2y = 220
t7block2w = 425

t7block2data= 
(
~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~
toList()|List<T>|Unmodifiable version better
toSet()|Set<T>|Unmodifiable version better
toMap()|Set<T>|Unmodifiable version better
toCollection()|Collection<T>|
counting()|Long|
summingint()|Long|
averagingInt()|Double|
joining()|String|
maxBy()|Optional<T>|
minBy()|Optional<T>|
reducing()|N/A|
groupingBy()|Map<K,List<T>>|
partitioningBy()|Map<Boolean, List<T>>|
collectingAndThen()|Collector<T>, Function<T>|
comparing()|?|
)


Gui, Font, Verdana s12 cBlue bold underline
Gui, Add, Text, x%t7block2x% y%t7block2y%, %t7block2Title%
Gui, Font, Verdana s9 cBlack norm

Gui, Add, Listview, x%t7block2x% y+6 w%t7block2w% r%t7block2rows% Hdr Grid NoSortHdr NoSort ReadOnly, Method|Return Type|Comments

Loop, Parse, t7block2data, `n, `r
	{
	 StringSplit, data, A_LoopField, | 
	 LV_Add("", data1, data2, data3)
	}

LV_ModifyCol()                               ; Auto width columns()
LV_ModifyCol(1, "AutoHdr") 
LV_ModifyCol(2, "AutoHdr") 
LV_ModifyCol(3, "AutoHdr") 
LV_ModifyCol(4, "AutoHdr") 
LV_ModifyCol(5, "AutoHdr") 


; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Block 3

t7block3title = 3-Stream Commands
t7block3rows = 20

t7block3x = 450
t7block3y = 220
t7block3w = 425

t7block3data = 
(
~~~~~~~~~~|~~~~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~
allMatch|Terminal|N/A|
anyMatch|Terminal|N/A|
collect|Terminal|See Collection Section|
count|Terminal|N/A|
distinct|Intermediate|N/A|
filter|Intermediate|N/A|
findAny|Terminal|N/A|
findFirst|Terminal|N/A|
flatMap|Intermediate|N/A|
forEach|Terminal|N/A|
limit|Intermediate|N/A|
map|Intermediate|N/A|
min, max|Terminal|N/A|
noneMatch|Terminal|N/A|
peek|Intermediate|N/A|
reduce|Terminal|N/A|
skip|Intermediate|N/A|
sorted|Intermediate|N/A|
toArray|Terminal|N/A|
)


Gui, Font, Verdana s12 cRed bold underline
Gui, Add, Text, x%t7block3x% y%t7block3y%, %t7block3Title%
Gui, Font, Verdana s9 cBlack norm

Gui, Add, Listview, x%t7block3x% y+6 w%t7block3w% r%t7block3rows% Hdr Grid NoSortHdr NoSort ReadOnly, Operation|Type|Output|Purpose

Loop, Parse, t7block3data, `n, `r
	{
	 StringSplit, data, A_LoopField, | 
	 LV_Add("", data1, data2, data3, data4)
	}

LV_ModifyCol()                               ; Auto width columns()
LV_ModifyCol(1, "AutoHdr") 
LV_ModifyCol(2, "AutoHdr") 
LV_ModifyCol(3, "AutoHdr") 
LV_ModifyCol(4, "AutoHdr") 
	

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Block 4

t7block1title = 4-Lambda Method References
t7block1rows = 7

t7block1x = 450
t7block1y = 40
t7block1w = 425

t7block1data= 
(
~~~~~~~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Class::staticMethod||||
object::instanceMethod||||
Class:: new|Constructor|||
)

; BUILD
Gui, Font, Verdana s12 cPurple bold underline
Gui, Add, Text, x%t7block1x% y%t7block1y%, %t7block1Title%
Gui, Font, Verdana s9 cBlack norm

Gui, Add, Listview, x%t7block1x% y+6 w%t7block1w% r%t7block1rows% Hdr Grid NoSortHdr NoSort ReadOnly, Interface|method

Loop, Parse, t7block1data, `n, `r
	{
	 StringSplit, data, A_LoopField, | 
	 LV_Add("", data1, data2)
	}

LV_ModifyCol()                               ; Auto width columns()
LV_ModifyCol(1, "AutoHdr") 
LV_ModifyCol(2, "AutoHdr") 

