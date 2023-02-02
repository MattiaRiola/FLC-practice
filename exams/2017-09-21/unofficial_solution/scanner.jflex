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

separator = \*+
comment   = \/\/.*
year      = 2017\/
month0110 = (0[1-9])
month1030 = (([1-2][0-9])|(30))
monthday  = (07\/0[2-9]|(0[7-9]|10)\/{month1030}|(0[8-9]|10)\/{month0110}|(0[7-8]|10)\/31)
date      = {year}{monthday}
tok1      = ({date}[#-]){2}{date}([#-]({date}))*;

vowel     = [aeiou]
consonant = [^aeiou]
tok2alpha = {consonant}*{vowel}{consonant}*{vowel}({consonant}*{vowel}{consonant}*{vowel}{consonant}*{vowel}{consonant}*)?
tok2bin   = ((1[01]{0,4})|(100[01]{3})|(101001))
tok2      = \$({tok2alpha}|{tok2bin});

tok3char  = [@%&]
odd       = [13579]
tok3odd   = ((-(4[13]|[1-3]{odd}|{odd}))|({odd}|[1-9]{odd}|[1-9][0-9]{odd}|1231|12[0-2]{odd}|1[0-1][0-9]{odd}))
tok3      = {tok3char}{4}({tok3char}{tok3char})*({tok3odd})?;

integer   = ([1-9][0-9]*|0)
id        = [a-zA-Z_][a-zA-Z0-9_]*

nl        = \r|\n|\r\n
ws        = [ \t]

%%

{tok1} {return symbol(sym.T1);}
{tok2} {return symbol(sym.T2);}
{tok3} {return symbol(sym.T3);}

{separator} {return symbol(sym.SEP);}

=    {return symbol(sym.EQ);}
\{   {return symbol(sym.BO);}
\}   {return symbol(sym.BC);}
;    {return symbol(sym.S);}
{integer} {return symbol(sym.INT, yytext());}

START {return symbol(sym.START);}
STATE {return symbol(sym.STATE);}
IF    {return symbol(sym.IF);}
FI    {return symbol(sym.FI);}
CASE  {return symbol(sym.CASE);}
DO    {return symbol(sym.DO);}
DONE  {return symbol(sym.DONE);}
\.    {return symbol(sym.PT);}
\(    {return symbol(sym.RO);}
\)    {return symbol(sym.RC);}
PRINT {return symbol(sym.PRINT);}
NEW   {return symbol(sym.NEW);}
&&    {return symbol(sym.AND);}
\|\|  {return symbol(sym.OR);}
\!     {return symbol(sym.NOT);}

{id} {return symbol(sym.ID, yytext());}
\" ~ \"  {return symbol(sym.QUOTED, yytext());}
    
{nl}|{ws}|{comment} {;}   
. {System.err.println("SCANNER ERROR: " + yytext() + " " + yyline + " " + yycolumn);}