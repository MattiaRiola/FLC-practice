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

date         = ((0[5-9]|[1-2][0-9])"/" 02 "/" 2012)|((0[1-9]|[1-2][0-9]|3[0-1])"/" 03 "/" 2012)|((0[1-9]|1[0-2])"/" 04 "/" 2012)
code         =(X|Y){2}[(X|Y){2}]*(([1-9]{int}|[1-9]{int}{4})|({charac}{3}({charac}{2})*))("++"("++")*)?
numb         =(-([1-9]|[1-2][0-9]|3[0-1]))|[0-9]|[1-9][0-9]|1[0-3][0-9]|14[0-5]
charac       =[a-z]
intp         =[1-9][0-9]*|0
int          =[1-9]|0
name         =[a-zA-Z][a-zA-Z0-9_]*
id           ="%"{numb}
%%

{date}         {return new Symbol(sym.DATE);}
{code}         {return new Symbol(sym.CODE);}
{intp}         {return new Symbol(sym.INTP,new Integer(yytext()));}
{name}         {return new Symbol(sym.NAME,new String(yytext()));}
{id}           {return new Symbol(sym.ID);}
";"            {return new Symbol(sym.SYM);}
"("            {return new Symbol(sym.OP);} 
")"            {return new Symbol(sym.CP);}
"+"            {return new Symbol(sym.PLUS);}
"-"            {return new Symbol(sym.MINUS);}
"*"            {return new Symbol(sym.STAR);}
"/"            {return new Symbol(sym.DIV);}
","            {return new Symbol(sym.COMA);}
":"            {return new Symbol(sym.COLON);}
"[["           {return new Symbol(sym.OB);}
"]]"           {return new Symbol(sym.CB);}
"->"           {return new Symbol(sym.ARROW);}
"###"          {return new Symbol(sym.SH);}
[ \t] 	          {;}
\r | \n | \r\n    {;}





