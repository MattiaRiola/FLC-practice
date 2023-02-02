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

nl = \r|\n|\r\n
ws = [ \t]
separator = "##"
comment1="$$".*{nl}
comment2="??".*{nl}
comment={comment1}|{comment2} 


alt="!"{3}|"!"{30}|"!"{300}
lower=[a-z]{5}([a-z]{2})*
upper=[A-Z]{6}([A-Z]{2})*
bin=1[01]|1[01][01]|1[01][01][01]|1[01][01][01][01]|100[01][01][01]|1010[01][01]|101100|101101|101110
token1={alt}({lower}|{upper})({bin})?" "?";"


xy=xx|xy|yx|yy
word={xy}{2}|{xy}{4}|{xy}{7}
wSep="*"|"$"|"%"
words=({word}{wSep}){2}{word}(({wSep}{word}){2})*
token2={words}" "?";"

ndate06=2018"/"06"/"(1[3-9]|2[0-9]|30)
ndate07=2018"/"07"/"(0[13-9]|[12][0-9]|3[01])
ndate0809=2018"/"0[89]"/"(0[1-9]|[12][0-9]|3[0])|2018"/"08"/"31
ndate10=2018"/"10"/"(0[0-9]|1[0-9]|2[0-3])
ndate={ndate06}|{ndate07}|{ndate0809}|{ndate10}

mdate06=("june "|"June ")(1[3-9]|2[0-9]|30)", 2018"
mdate07=("july "|"July ")(01|0[3-9]|[12][0-9]|3[01])", 2018"
mdate08=("august "|"August ")(0[1-9]|[12][0-9]|3[01])", 2018"
mdate09=("september "|"September ")(0[1-9]|[12][0-9]|3[0])", 2018"
mdate10=("october "|"October ")(0[0-9]|1[0-9]|2[0-3])", 2018"
mdate={mdate06}|{mdate07}|{mdate08}|{mdate09}|{mdate10}

date={mdate}|{ndate}
token3={date}" "?";"


sigInt=("-"|"+")?(0|[1-9][0-9]*)

%%

{token3}	{return symbol(sym.TOK3);}
{token2}	{return symbol(sym.TOK2);}
{token1}	{return symbol(sym.TOK1);}
{separator}	{return symbol(sym.SEP);}
SET		{return symbol(sym.SET);}
POS		{return symbol(sym.POS);}
BATTERY		{return symbol(sym.BATTERY);}
PRINT		{return symbol(sym.PRINT);}
\"~\"		{return symbol(sym.QSTR, new String(yytext()));}
CHANGE		{return symbol(sym.CHANGE);}
COMPUTE		{return symbol(sym.COMPUTE);}
AVG		{return symbol(sym.AVG);}
MAX		{return symbol(sym.MAX);}
IN_CASE		{return symbol(sym.IN_CASE);}
DO		{return symbol(sym.DO);}
DONE		{return symbol(sym.DONE);}
BETWEEN		{return symbol(sym.BETWEEN);}
LOWER		{return symbol(sym.LOWER);}
HIGHER		{return symbol(sym.HIGHER);}
AND 		{return symbol(sym.AND);}
X		{return symbol(sym.X);}
Y		{return symbol(sym.Y);}
Z		{return symbol(sym.Z);}
{sigInt}	{return symbol(sym.INT, new Integer(yytext()));}

"."		{return symbol(sym.DOT);}
"-"		{return symbol(sym.MINUS);}
","	        {return symbol(sym.CM);}
";"       	{return symbol(sym.S);}
"("     	{return symbol(sym.RO);}
")"     	{return symbol(sym.RC);}

{comment}		{;}
{ws}|{nl}|" "   	{;}
. {System.out.println("SCANNER ERROR: "+yytext());}

 