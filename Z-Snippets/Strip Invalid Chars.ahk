varize(var)
{
   stringreplace,var,var,%A_space%,_,a
   chars = .,<>:;'"/|\(){}=-+!`%^&*~
   loop, parse, chars,
      stringreplace,var,var,%A_loopfield%,,a
   return var
}