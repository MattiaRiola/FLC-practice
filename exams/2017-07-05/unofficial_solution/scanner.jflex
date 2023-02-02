import java_cup.runtime.*;
%%



%class scanner
%unicode
%cup
%line
%column


%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
	
  }
%}

separator = \$\$
comment   = \%.*

tok1even  = (-(12[024]|1[0-1][02468]|[1-9][02468]|[02468])|[02468]|[1-7][02468]|8[0246])
tok1odd   = ([a-zA-Z]{5}([a-zA-Z]{2})*)
tok1      = {tok1even}{tok1odd}?(ABC|([XY][XY]){3}([XY][XY])*);

tok2bin   = (10|1[01]|1[01][01]|1[01][01]|1[01][01][01]|10[01][01][01]|11110)
tok2      = ({tok2bin}[*-]){4}{tok2bin}([*-]{tok2bin}[*-]{tok2bin})*;

tok3      = (08:12:3[4-9]|08:12:[4-5][0-9]|08:1[3-9]:[0-5][0-9]|08:[2-5][0-9]:[0-5][0-9]|(09|1[0-6]):[0-5][0-9]:[0-5][0-9]|17:[0-1][0-9]:[0-5][0-9]|17:20:[0-5][0-9]|17:21:[0-2][0-9]|17:21:3[0-7]);




id        = [a-zA-Z][a-zA-Z0-9]*
integer   = [1-9][0-9]*|0

nl        = \r|\n|\r\n
ws        = [ \t]

%%  
    


{separator} {return symbol(sym.SEP);}
{tok1} {return symbol(sym.T1);}
{tok2} {return symbol(sym.T2);}
{tok3} {return symbol(sym.T3);}

set {return symbol(sym.SET);}
position {return symbol(sym.POS);}
fuel {return symbol(sym.FUEL);}
increases {return symbol(sym.INC);}
decreases {return symbol(sym.DEC);}

\+ {return symbol(sym.PLUS);}
\- {return symbol(sym.MINUS);}

declare {return symbol(sym.DECL);}
\? {return symbol(sym.IF);}
else {return symbol(sym.ELSE);}

and {return symbol(sym.AND);}
or {return symbol(sym.OR);}
not {return symbol(sym.NOT);}

mv {return symbol(sym.MV);}

min {return symbol(sym.MIN);}
max {return symbol(sym.MAX);}

\( {return symbol(sym.RO);}
\) {return symbol(sym.RC);}
\{ {return symbol(sym.BO);}
\} {return symbol(sym.BC);}

\. {return symbol(sym.PT);}
= {return symbol(sym.EQ);}
, {return symbol(sym.CM);}
; {return symbol(sym.S);}
: {return symbol(sym.C);}

{id}  {return symbol(sym.ID, yytext());}
{integer} {return symbol(sym.INT, yytext());}

{nl}|{ws}|{comment} {;}   
. {System.err.println("SCANNER ERROR: " + yytext() + " " + yyline + " " + yycolumn);}