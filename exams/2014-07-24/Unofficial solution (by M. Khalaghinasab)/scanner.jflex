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

codf             ="="(({word}{3}({word}{word})*)|([a-z]{4}([a-z][a-z])*))"?"((xx|xy|yx|yy)(xx|xy|yx|yy)(xx|xy|yx|yy)(xx|xy|yx|yy)*)?";"
codes            =({exa}("."|":"){exa}("."|":"){exa}";")|({exa}("."|":"){exa}("."|":"){exa}("."|":"){exa}("."|":"){exa}";")|({exa}("."|":"){exa}("."|":"){exa}("."|":"){exa}("."|":"){exa}("."|":"){exa}("."|":"){exa}("."|":"){exa}";")
exa              =([0-9]|[ABCDEFabcdef]){2}|([(0-9]|[ABCDEFabcdef]){4}
email            ={str}"@"{st}"."("it"|"com"|"net")
str              =[a-zA-Z0-9_.]*
st               =[a-zA-Z0-9]*
id               =[a-zA-Z-][a-zA-Z0-9-]+
floatnum         =([0-9]+\.[0-9]*)
word             =[A-Z]
name             =\"[^\"\n]+\"

%%
DISTANCE              {return new Symbol(sym.DISTANCE);}
VALUE                 {return new Symbol(sym.VALUE);}
WRITE                 {return new Symbol(sym.WRITE);}
IN                    {return new Symbol(sym.IN);}
{codf}                {return new Symbol(sym.CODEF);}
{email}               {return new Symbol(sym.EMAIL);}
{codes}               {return new Symbol(sym.CODES);}
{id}                  {return new Symbol(sym.ID, new String(yytext()));}
{name}                {return new Symbol(sym.NAME,new String(yytext()));}
{floatnum}            {return new Symbol(sym.FLOAT,new Double(yytext()));}
"="                   {return new Symbol(sym.EQ);}
";"                   {return new Symbol(sym.SYM);}
"*"                   {return new Symbol(sym.STAR);} 
"+"                   {return new Symbol(sym.PLUS);}
"("                   {return new Symbol(sym.OP);} 
")"                   {return new Symbol(sym.CP);}
"["                   {return new Symbol(sym.OA);}
"]"                   {return new Symbol(sym.CA);}
":"                   {return new Symbol(sym.COLON);}
","                   {return new Symbol(sym.COMA);}
"##"                  {return new Symbol(sym.SH);}

"/*" ~ "*/"       {;}
[ \t] 	          {;}
\r | \n | \r\n    {;}
