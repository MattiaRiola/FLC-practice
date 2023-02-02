import java_cup.runtime.*;

%%

%unicode
%cup
%line
%column
%{
	private Symbol symbol(int type)
	{
		return new Symbol(type,yyline,yycolumn);
	}
	private Symbol symbol(int type,Object value)
	{
		return new Symbol(type,yyline,yycolumn,value);
	}
%}

date             =2014 "/" 12 "/" (1[2-9]|2([0-4]|[6-9])|3[0-1]) | 2015"/" 0[135] "/" ((0[1-9])|[1-2][0-9]|3[0-1]) | 2015 "/" 02 "/" ((0[1-9])|1[0-9]|2[0-8]) | 2015 "/" 04 "/" ((0[1-9])|[1-2][0-9]|30) 
sharp            = "#"{3}["#"]*
tokf             ={word}?{evennum}?{w}";"
toks             ={date}("-"|"_"){date}";"
evennum          =(-({even}|1[02]))|{even}|[1-9]{even}|[1-9][0-2]{even}|13[0246]
even             =0|2|4|6|8
word             =(a|o|u|i|e){4}((a|o|u|i|e)(a|o|u|i|e))*
w                =([A-Z_]|"_"){4}|([A-Z_]|"_"){7}
intnum           =[0-9]|[1-2][0-9]|30
name             =\"[^\"\n]+\"
floatnum         =([0-9]+\.[0-9])

%%

{tokf}            {return new Symbol(sym.TOKF);}
{toks}            {return new Symbol(sym.TOKS);}
{sharp}           {return new Symbol(sym.SH);}
EXAM              {return new Symbol(sym.EXAM);}
IF                {return new Symbol(sym.IF);}
ELSE              {return new Symbol(sym.ELSE);}
END_IF            {return new Symbol(sym.ENDIF);}
THEN              {return new Symbol(sym.THEN);}
avg               {return new Symbol(sym.AVG);}
min               {return new Symbol(sym.MIN);}
max               {return new Symbol(sym.MAX);}
"<"               {return new Symbol(sym.LE);}
">"               {return new Symbol(sym.GE);}
AND               {return new Symbol(sym.AND);}
OR                {return new Symbol(sym.OR);}
PRINT             {return new Symbol(sym.PRINT);}
SCORES            {return new Symbol(sym.SCORES);}
{intnum}          {return new Symbol(sym.INT, new Integer(yytext()));}
{name}            {return new Symbol(sym.NAME, new String(yytext()));}
{floatnum}        {return new Symbol(sym.FLOAT,new Double(yytext()));}
";"               {return new Symbol(sym.SYM);}
":"               {return new Symbol(sym.COLON);}
","               {return new Symbol(sym.COMA);}
"("               {return new Symbol(sym.OP);}
")"               {return new Symbol(sym.CP);}
"."               {return new Symbol(sym.DOT);}
[ \t] 	          {;}
\r | \n | \r\n    {;}
"/*" ~ "*/"       {;}
