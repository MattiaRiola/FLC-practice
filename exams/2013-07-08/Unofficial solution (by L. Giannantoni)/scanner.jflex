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

comment 	= 	"//".*|"\/*" ~ "*\/"
nl 			= 	\r|\n|\r\n
ws 			= 	[ \t]
id 			= 	[a-zA-Z_][a-zA-Z0-9_]*
num 		= 	[+-]?[0-9]+
ip_num		=	(2(([0-4][0-9])|(5[0-5])))|(1[0-9][0-9])|([1-9][0-9])|([0-9])
ip			=	{ip_num}"."{ip_num}"."{ip_num}"."{ip_num}
//string 		=	"\"" ~ "\""
//float 		= 	[-+]?( ([0-9]*[.])?[0-9]+ | [0-9]+[.]([0-9]+)? )
//real		=	('+'|'-')?(([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?
//hex 		=	([0-9]|[A-Fa-f]){2}|([(0-9]|[A-Fa-f]){4}
//email		=	[a-zA-Z0-9_.]+"@"[a-zA-Z0-9.]+"."("it"|"com"|"net")
hour_token	=	(08:(3[5-9]|[45][0-9])(am)?)|
				((09|10|11):[0-5][0-9](am)?)|
				(12:[0-5][0-9](pm)?)|
				(1[3-6]:[0-5][0-9])|(0[1-4]:[0-5][0-9]pm)|
				(17:[0-4][0-9])|(05:[0-4][0-9]pm)
code_token	=	"?"( ( [a-z]{4} ([a-z]{2})* ) | ( [A-Z]{3} ([A-Z]{2})* ) ) "?" ( [xy]{3} [xy]* )?
ip_token 	= 	{ip}":"(-[642]|[0-9]?[02468]|1[12][02468])

%%

/*{identifier} {if(printdebug==1) System.out.print("IDENT"+yytext());
					return symbol(sym.IDENT, new String(yytext()) );}*/

"PRINT" 	{if(printdebug==1) System.out.print("PRINT "); return symbol(sym.PRINT);}
"IF" 		{if(printdebug==1) System.out.print("IF "); return symbol(sym.IF);}
"STATE"		{if(printdebug==1) System.out.print("STATE "); return symbol(sym.STATE);}
"THEN"		{if(printdebug==1) System.out.print("THEN "); return symbol(sym.THEN);}
"ELSE"		{if(printdebug==1) System.out.print("ELSE "); return symbol(sym.ELSE);}
"START"		{if(printdebug==1) System.out.print("START "); return symbol(sym.START);}
"TRUE"		{if(printdebug==1) System.out.print("TRUE "); return symbol(sym.TRUE);}
"FALSE"		{if(printdebug==1) System.out.print("FALSE "); return symbol(sym.FALSE);}

"%%"	{if(printdebug==1) System.out.print("SEPARATOR "); return symbol(sym.SEPARATOR);}
"#"		{if(printdebug==1) System.out.print("CRUNCH "); return symbol(sym.CRUNCH);}
"."     {if(printdebug==1) System.out.print("DOT "); return symbol(sym.DOT);}
//":"		{if(printdebug==1) System.out.print("COLON "); return symbol(sym.COLON);}
";"		{if(printdebug==1) System.out.print("SEMICOLON "); return symbol(sym.SEMICOLON);}
//","		{if(printdebug==1) System.out.print("COMMA "); return symbol(sym.COMMA);}
"="		{if(printdebug==1) System.out.print("EQ "); return symbol(sym.EQ);}
//"("     {if(printdebug==1) System.out.print("RO "); return symbol(sym.RO);}
//")"     {if(printdebug==1) System.out.print("RC "); return symbol(sym.RC);}
"{"     {if(printdebug==1) System.out.print("CO "); return symbol(sym.CO);}
"}"		{if(printdebug==1) System.out.print("CC "); return symbol(sym.CC);}
"||"	{if(printdebug==1) System.out.print("OR "); return symbol(sym.OR);}
"&&"	{if(printdebug==1) System.out.print("AND "); return symbol(sym.AND);}
"=="	{if(printdebug==1) System.out.print("EQEQ "); return symbol(sym.EQEQ);}

{hour_token}	{if(printdebug==1) System.out.print("HOUR_TOKEN "); return symbol(sym.HOUR_TOKEN);}

{id}	{if(printdebug==1) System.out.print("ID "); return symbol(sym.ID, new String(yytext()));}

{ip_token}		{if(printdebug==1) System.out.print("IP_TOKEN "); return symbol(sym.IP_TOKEN);}
{code_token}	{if(printdebug==1) System.out.print("CODE_TOKEN "); return symbol(sym.CODE_TOKEN);}

{num}	{if(printdebug==1) System.out.print("NUM "); return symbol(sym.NUM, new Integer(yytext()));}

{comment} {if(printdebug==1) System.out.print("COMMENT ");}
{nl}|{ws} {if(printdebug==1) System.out.print("BLANK ");}
. {if(printdebug==1) System.out.print("ERROR ");}
