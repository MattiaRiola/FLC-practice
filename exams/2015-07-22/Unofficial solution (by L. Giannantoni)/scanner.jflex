import java_cup.runtime.*;

%%

%class scanner
/*%standalone*/
%unicode
%cup
%line
%column

%{
	public int printdebug = 0;
	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
%}

comment = "//".*|"/*" ~ "*/"
nl 			= 	\r|\n|\r\n
ws 			= 	[ \t]
id 			= 	[a-zA-Z_][a-zA-Z0-9_]*
word 		= 	[a-zA-Z]+
num 		= 	"-"?[0-9]+
date		=	((0[1-9])|([1-2][0-9])|(3(0|1)))"/"((0[1-9])|(1(0|1|2)))"/"(2[0-9][0-9][0-9])
token1		=   11":"([45][0-9]|3[5-9])(am)?|12":"[0-5][0-9](pm)?|13":"([0-4][0-9]|5[0-1])|01":"([0-4][0-9]|5[0-1])(pm)?
token2		=	{str}":"{ip}
ip_num		=	(2(([0-4][0-9])|(5[0-5])))|(1[0-9][0-9])|([1-9][0-9])|([0-9])
ip			=	{ip_num}"."{ip_num}"."{ip_num}"."{ip_num}
str 		=	"\"" ~ "\""
token3		=	"%"[a-zA-Z]{4}([a-zA-Z]{2})*("-"3[531]|"-"[21][97531]|"-"?[97531]|[1-9][13579]|1[0-9][13579]|2[0-5][13])("*"{4}"*"*|YX(XX)*Y)?
%%


"FALSE"			{if(printdebug==1) System.out.print("FALSE "); return symbol(sym.FALSE);}
"TRUE"			{if(printdebug==1) System.out.print("TRUE "); return symbol(sym.TRUE);}
"EVALUATE"		{if(printdebug==1) System.out.print("EVALUATE "); return symbol(sym.EVALUATE);}
"SAVE"			{if(printdebug==1) System.out.print("SAVE "); return symbol(sym.SAVE);}
"CASE_TRUE"		{if(printdebug==1) System.out.print("CASE_TRUE "); return symbol(sym.CASE_TRUE);}
"CASE_FALSE"	{if(printdebug==1) System.out.print("CASE_FALSE "); return symbol(sym.CASE_FALSE);}
"o"				{if(printdebug==1) System.out.print("O "); return symbol(sym.O);}
{comment}		{if(printdebug==1) System.out.print("COMMENT ");}	
{token1} 		{if(printdebug==1) System.out.print("TOKEN1 "); return symbol(sym.TOKEN1);}
{token2} 		{if(printdebug==1) System.out.print("TOKEN2 "); return symbol(sym.TOKEN2);}
{token3} 		{if(printdebug==1) System.out.print("TOKEN3 "); return symbol(sym.TOKEN3);}
{num}			{if(printdebug==1) System.out.print("NUM "); return symbol(sym.NUM, new Integer(yytext()));}
{id}			{if(printdebug==1) System.out.print("ID "); return symbol(sym.ID, new String(yytext()));}
"##"	{if(printdebug==1) System.out.print("SEPARATOR "); return symbol(sym.SEPARATOR);}
";"		{if(printdebug==1) System.out.print("SEMICOLON "); return symbol(sym.SEMICOLON);}
","		{if(printdebug==1) System.out.print("COMMA "); return symbol(sym.COMMA);}
"="		{if(printdebug==1) System.out.print("EQ "); return symbol(sym.EQ);}
"("     {if(printdebug==1) System.out.print("RO "); return symbol(sym.RO);}
")"     {if(printdebug==1) System.out.print("RC "); return symbol(sym.RC);}
"*"     {if(printdebug==1) System.out.print("STAR "); return symbol(sym.STAR);}
"+"     {if(printdebug==1) System.out.print("PLUS "); return symbol(sym.PLUS);}
"["     {if(printdebug==1) System.out.print("SO "); return symbol(sym.SO);}
"]"		{if(printdebug==1) System.out.print("SC "); return symbol(sym.SC);}
"||"	{if(printdebug==1) System.out.print("OR "); return symbol(sym.OR);}
"&&"	{if(printdebug==1) System.out.print("AND "); return symbol(sym.AND);}
"!"		{if(printdebug==1) System.out.print("NOT "); return symbol(sym.NOT);}
"=="	{if(printdebug==1) System.out.print("EQEQ "); return symbol(sym.EQEQ);}

{nl}|{ws} {if(printdebug==1) System.out.print("BLANK ");}
. {if(printdebug==1) System.out.print("ERROR ");}
