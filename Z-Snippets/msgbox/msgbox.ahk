
msgtext := "ok"
MsgBox, 0,Title,%msgtext%.
MsgBox, 16,Title,%msgtext%. Red X
MsgBox, 32,Title,%msgtext%. Question
MsgBox, 48,Title,%msgtext%. Exclamation
MsgBox, 64,Title,%msgtext%. I for Info

msgtext := "ok/cancel"
MsgBox, 1,Title,%msgtext%.
MsgBox, 17,Title,%msgtext%. Red X
MsgBox, 33,Title,%msgtext%. Question
MsgBox, 49,Title,%msgtext%. Excalamation
MsgBox, 65,Title,%msgtext%. I for Info

msgtext := "abort/retry/ignore"
MsgBox, 2,Title,%msgtext%.
MsgBox, 18,Title,%msgtext%. Red X
MsgBox, 34,Title,%msgtext%. Question
MsgBox, 50,Title,%msgtext%. Excalamation
MsgBox, 66,Title,%msgtext%. I for Info

msgtext := "yes/no/cancel"
MsgBox, 3,Title,%msgtext%.
MsgBox, 19,Title,%msgtext%. Red X
MsgBox, 35,Title,%msgtext%. Question
MsgBox, 51,Title,%msgtext%. Excalamation
MsgBox, 67,Title,%msgtext%. I for Info

msgtext := "yes/no"
MsgBox, 4,Title,%msgtext%.
MsgBox, 20,Title,%msgtext%. Red X
MsgBox, 36,Title,%msgtext%. Question
MsgBox, 52,Title,%msgtext%. Excalamation
MsgBox, 68,Title,%msgtext%. I for Info

; ok/cancel - cancel as default
msgtext = ok/cancel - cancel as default
MsgBox, 257,Title,%msgtext%.
MsgBox, 273,Title,%msgtext%. Red X
MsgBox, 289,Title,%msgtext%. Question
MsgBox, 305,Title,%msgtext%. Excalamation
MsgBox, 321,Title,%msgtext%. I for Info

; ok
msgtext = ok - always on top
MsgBox, 4096,Title,%msgtext%.
MsgBox, 4112,Title,%msgtext%. Red X
MsgBox, 4128,Title,%msgtext%. Question
MsgBox, 4144,Title,%msgtext%. Excalamation
MsgBox, 4160,Title,%msgtext%. I for Info


; ok
MsgBox, 2,Title,abort/retry/ignore
MsgBox, 3, Title,yes/no/cancel
MsgBox, 4,Title,yes/no
MsgBox, 5,Title,retry/cancel

MsgBox, 16384, Title,OK-Help Button
MsgBox, 16385, Title,OK/Cancel-Help Button
MsgBox, 16386, Title,Abort/Retry/Ignore-Help Button
MsgBox, 16387, Title,Yes/No/Cancel-Help Button
MsgBox, 16388, Title,Yes/No-Help Button
MsgBox, 16389, Title,Retry/cancel-Help Button