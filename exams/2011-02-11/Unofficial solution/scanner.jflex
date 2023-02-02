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

date         = ((0[3-9]|[1-2][0-9]|3[0-1])"/" 07 "/" 2010)|((0[1-9]|[1-2][0-9]|3[0-1])"/" (08|10|12)"/" 2010)|((0[1-9]|[1-2][0-9]|30)"/"(09|11)"/" 2010)|((0[1-9]|[1-2][0-9]|3[0-1])"/" 01 "/" 2011)|((0[1-9]|1[0-1])"/" 02 "/" 2011 )

codef        =("!"{4} ["!"{2}]* {numb})|"?"{5}("??")*
numb         =(-([1-9]|1[0-8]))|[0-9]|[1-9][0-9]|1[1-9][0-9]|2[1-7][0-9]|28[0-5]
codes        =X({charac}{4} |{charac}{7})?
charac       =[a-zA-Z0-9]
int          =[1-9][0-9]*|0
nl           = \n|\r|\r\n
%%

{date}         {return new Symbol(sym.DATE);}
{codef}        {return new Symbol(sym.CODEF);}
{codes}        {return new Symbol(sym.CODES);}
{int}          {return new Symbol(sym.INT,new Integer(yytext()));}
PUT            {return new Symbol(sym.PUT);}
EQ             {return new Symbol(sym.EQ);}
ADD            {return new Symbol(sym.ADD);}
"("            {return new Symbol(sym.OP);} 
")"            {return new Symbol(sym.CP);}
"+"            {return new Symbol(sym.PLUS);}
"-"            {return new Symbol(sym.MINUS);}
"*"            {return new Symbol(sym.STAR);}
","            {return new Symbol(sym.COMA);}
"##"           {return new Symbol(sym.SH);}
{nl}           {return new Symbol(sym.NLINE);}
[ \t] 	       {;}





