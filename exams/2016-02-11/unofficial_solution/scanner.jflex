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

separator = (\%{4}(\%{2})*)|(\#(\#{2})*)
comment   = \/\/.*

codenum   = (-(2[024]|1?[02468])|[1-9]?[02468]|[1-9][0-9][02468]|1[0-9][0-9][02468]|2[0-3][0-9][02468]|24[0-6][02468]|247[02])
codealpha = ([$?]{5}([$?]{2})*|[a-zA-Z]{4}([a-zA-Z]{2}([a-zA-Z]{3})?)?)
code      = {codenum}{codealpha}

dec       = (2015\/12\/(0[6-9]|[12][0-9]|3[01]))
janmar    = (2016\/0[1-3]\/(0[1-9]|[12][0-9]|3[01]))
febr      = (2016\/0[1-3]\/(0[1-9]|[12][0-9]))
hour      = (04:3[2-9]|04:[45][0-9]|(0[5-9]|1[0-4]):[0-5][0-9]|15:[0-3][0-9]|15:4[0-7])
date      = ({dec}|{janmar}|{febr})(:{hour})?

id        = [a-zA-Z]+[0-9]*
integer   = [1-9][0-9]*|0
coord     = [+-]([1-9][0-9]*|0)

nl        = \r|\n|\r\n
ws        = [ \t]

%%  
    
{separator} {return symbol(sym.SEP);}
{code} {return symbol(sym.CODE);}
{date} {return symbol(sym.DATE);}

START {return symbol(sym.START);}

; {return symbol(sym.S);}
: {return symbol(sym.C);}
, {return symbol(sym.CM);}
\. {return symbol(sym.DOT);}
\{ {return symbol(sym.BO);}
\} {return symbol(sym.BC);}

VAR {return symbol(sym.VAR);}
MOVE {return symbol(sym.MOVE);}
WHEN {return symbol(sym.WHEN);}
THEN {return symbol(sym.THEN);}
DONE {return symbol(sym.DONE);}

AND {return symbol(sym.AND);}
OR {return symbol(sym.OR);}
NOT {return symbol(sym.NOT);}
== {return symbol(sym.EQ);}
\!= {return symbol(sym.NEQ);}

{id}  {return symbol(sym.ID, yytext());}
{integer} {return symbol(sym.INT, yytext());}
{coord} {return symbol(sym.COORD, yytext());}

{nl}|{ws}|{comment} {;}   
. {System.err.println("SCANNER ERROR: " + yytext() + " " + yyline + " " + yycolumn);}