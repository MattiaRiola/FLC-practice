%%
%class Lexer
%unicode
%standalone

%state comment

nl = \r|\n|\r\n
ws = [\ \t]
id = [A-Za-z][A-Za-z0-9]*
integer = ([1-9][0-9]*|0)
double = (([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?


%%
"("     {System.out.print("RO ");}
")"     {System.out.print("RC ");}
"{"     {System.out.print("BO ");}
"}"     {System.out.print("BC ");}
"="     {System.out.print("EQ ");}
"+"     {System.out.print("PLUS ");}
"-"     {System.out.print("MINUS ");}
"*"     {System.out.print("STAR ");}
"/"     {System.out.print("DIV ");}
"<"     {System.out.print("MIN ");}
">"     {System.out.print("MAJ ");}
"<="    {System.out.print("MIN_EQ ");}
"=<"    {System.out.print("EQ_MIN ");}
">="    {System.out.print("MAJ_EQ ");}
"=>"    {System.out.print("EQ_MAJ ");}
"&"     {System.out.print("AND ");}
"|"     {System.out.print("OR ");}
"!"     {System.out.print("NOT ");}

"["     {System.out.print("SO ");}
"]"     {System.out.print("SC ");}

"int"    {System.out.print("INT_TYPE ");}
"double" {System.out.print("DOUBLE_TYPE ");}

print   {System.out.print("PRINT ");}
if      {System.out.print("IF ");}
while   {System.out.print("WHILE ");}
else    {System.out.print("ELSE ");}
;       {System.out.print("S ");}
,       {System.out.print("C ");}