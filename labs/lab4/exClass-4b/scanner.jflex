import java.io.*;
import java_cup.runtime.*;

%%

%unicode
%cup
%line
%column

    
nl = \n|\r|\n\r

%%

[a-zA-Z]+         { return new Symbol(sym.ID, yyline, yycolumn, new String(yytext())); }

[0-9]*\.[0-9][0-9] { return new Symbol(sym.EURO, yyline, yycolumn, new Float(yytext())); }

[1-9][0-9]*|0     { return new Symbol(sym.INT, yyline, yycolumn, new Integer(yytext())); }

","               { return new Symbol(sym.CM, yyline, yycolumn); }
";"               { return new Symbol(sym.S, yyline, yycolumn); }
":"               { return new Symbol(sym.C, yyline, yycolumn); }
"%"               { return new Symbol(sym.SEP, yyline, yycolumn); }

"/*" ~ "*/"       { ; }

{nl}|" "|\t       { ; } 
