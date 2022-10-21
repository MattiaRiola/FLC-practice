import java.io.*;
import java_cup.runtime.*;

%%

%unicode
%cup

nl = \n|\r|\n\r
typo = void|byte|int|char|float|double
id = [A-Za-z]([A-Za-z_]|[0-9])*

%%

";" {System.out.println("SEMICOLON: "+yytext());return new Symbol(sym.S);}
"," {System.out.println("COMMAN "+yytext());return new Symbol(sym.C);}
"(" {System.out.println("ROUND BRACKET OPEN: "+yytext());return new Symbol(sym.RO);}
")" {System.out.println("ROUND BRACKET CLOSE: "+yytext());return new Symbol(sym.RC);}
"{" {System.out.println("BRACE OPEN: "+yytext());return new Symbol(sym.BO);}
"}" {System.out.println("BRACE CLOSE: "+yytext());return new Symbol(sym.BC);}

{typo} {System.out.println("TYPE: "+yytext());return new Symbol(sym.TYPE);}


{id} {System.out.println("ID: "+yytext());return new Symbol(sym.ID);}

{nl}|" " {;} 
