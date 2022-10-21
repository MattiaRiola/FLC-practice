import java_cup.runtime.*;

%%
%cup
%unicode

nl = \n | \r | \r\n
id = [a-zA-Z][a-zA-Z0-9_]*
type = int | float | char | double

%%

"," { return new Symbol(sym.CM);}
";" { return new Symbol(sym.S);}
{type} { return new Symbol(sym.TYPE, new String(yytext())); }
{id} { return new Symbol(sym.ID, new String(yytext())); }
{nl} | " " | \t { ; }
