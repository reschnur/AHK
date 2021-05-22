
delay = (24*60*1000)+1

msgbox, %delay%

loop
{
if A_DD = 01
   {
   filecopydir C:\Program Files (x86)\IBM\SAIOM\logs, W:\GNCO\SA-IOM\Log Archive\%a_yyyy%\%a_mm%, 
   sleep,  %delay%
   }
}