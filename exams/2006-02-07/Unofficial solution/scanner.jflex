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
%state COMMENT

firsthour        = 08\:( 3[5-9]|[4-5][0-9])
otherhour        =(09 |1[0-6])\: {allminut}
lasthour         =(17\:[0-4][0-9]
allminut         = (\:[0-5][0-9])
fh               =((08\:( 3[5-9]|[4-5][0-9]))|((09||1[0-2])\: {allminut})) am
lh               =(([0-4]\:{allminut})|(05\:[0-4][0-9])) pm
hour             =({firsthour}|{otherhour}|{lasthour}|{fh}|{lh})";"

code         ="?"({charac}{4}({charac}{2})*)|({uc}{3}({uc}{2})*)"?"((xx|xy|yx|yy)(xx|xy|yx|yy)(xx|xy|yx|yy)(xx|xy|yx|yy)*)?";"     
numb         =-[1-6]|[0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-8]
charac       =[a-z]
uc           =[A-Z]

intp         =(+|-)?[1-9][0-9]*|0

word         =[a-zA-Z_][a-zA-Z0-9_]*

ipaddresscomp = [0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]
ipaddress     = ({ipaddresscomp}.){3}{ipaddresscomp}":"{numb}";"

%%

{hour}         {return new Symbol(sym.HOUR);}
{code}         {return new Symbol(sym.CODE);}
{ipaddress}    {return new Symbol(sym.IP);}
{intp}         {return new Symbol(sym.INTP,new Integer(yytext()));}
{word}         {return new Symbol(sym.WORD,new String(yytext()));}
{id}           {return new Symbol(sym.ID);}
";"            {return new Symbol(sym.SYM);}
"=="           {return new Symbol(sym.EQEQ);}
","            {return new Symbol(sym.COMA);}
":"            {return new Symbol(sym.COLON);}
"{"           {return new Symbol(sym.OB);}
"}"           {return new Symbol(sym.CB);}
"="           {return new Symbol(sym.EQ);}
"#"            {return new Symbol(sym.SH);}
"IF"           {return new Symbol(sym.IF);}
"ELSE"         {return new Symbol(sym.ELSE);} 
"THEN"         {return new Symbol(sym.THEN);}
"PRINT"        {return new Symbol(sym.PRINT);}
"START"        {return new Symbol(sym.START);}
"STATE"        {return new Symbol(sym.STATE);}
"%%"          {return new Symbol(sym.P);}
[ \t] 	          {;}
\r | \n | \r\n    {;}
<COMMENT>{
	[^*]* 	{;}
	"*"+[^*/]* 	{;}
	"*"+"/" 	{yybegin(YYINITIAL);}
}




