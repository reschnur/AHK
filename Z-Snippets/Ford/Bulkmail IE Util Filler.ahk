SetTitleMatchMode, 2

comma = ,
parenthesis = (

numTo := 3
ToCDS1 = kshackle
ToCDS2 = bbarritt
ToCDS3 = sharrowe
LL4CDS = jkoselan
Cc = autoops;jmalaney;gchris40;mshelt29;rschnur2;bwirsing;

^+p::

Run, http://bulkmail.ford.com/~bulkmail/test/BKUTIL
WinWaitActive, Utility
MouseMove, 700, 400
MouseClick
Send {Tab}{Enter}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}{Tab}{Tab}{Tab}
Send %ToCDS1%{Tab}%LL4CDS%

return

^+m::

Send %ToCDS1%;!k
Send ^a
Send ^c
StringGetPos, commaPos, clipboard, %comma%
StringGetPos, parenthesisPos, clipboard, %parenthesis%
StringMid, ToName1, clipboard, commaPos + 2, parenthesisPos - commaPos - 2



Send {Tab}%LL4CDS%;%Cc%!k{TAB}{TAB}
Send Hello %ToName1%,{ENTER}{ENTER}

Run, C:\Users\bwirsing\Documents\BulkmailAdd.docx

WinWaitActive, BulkmailAdd
Sleep, 100
Send ^a
Send ^c
WinClose, BulkmailAdd

WinWaitActive, Message
Sleep, 100
Send ^v

return