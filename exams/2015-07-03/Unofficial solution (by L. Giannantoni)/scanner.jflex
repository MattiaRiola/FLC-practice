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

comment = "//".*
nl 			= 	\r|\n|\r\n
ws 			= 	[ \t]
//id 			= 	[a-zA-Z_][a-zA-Z0-9_]*
//word 		= 	[a-zA-Z]+
_int 		= 	[0-9]+
_float 		= 	[-+]?([0-9]*[.])?[0-9]+
hex			=	([0-9]|[ABCDEFabcdef]){2}|([(0-9]|[ABCDEFabcdef]){4}
//date		=	((0[1-9])|([1-2][0-9])|(3(0|1)))"/"((0[1-9])|(1(0|1|2)))"/"(2[0-9][0-9][0-9])
//hour		=	(((0|1)[0-9])|(2[0-3]))":"([0-5][0-9])
//mp3	    	=	[a-zA-Z][_a-zA-Z0-9]*".mp3"
//ip_num		=	(2(([0-4][0-9])|(5[0-5])))|(1[0-9][0-9])|([1-9][0-9])|([0-9])
//ip			=	{ip_num}"."{ip_num}"."{ip_num}"."{ip_num}
//string 		=	"\"" ~ "\""
separator 	=	"$$$"("$$")*
code1		=	"#"[a-zA-Z]{4}([a-zA-Z]{2})*("-"[321]|[1-9]?[0-9]|1([01][0-9]|2[0-3]))("IJK"|"XY"("Z"("ZZ")*)?)?
code2		=	{hex}[:-]{hex}([:-]{hex}[:-]{hex})*

%%

/*{identifier} {if(printdebug==1) System.out.print("IDENT"+yytext());
					return symbol(sym.IDENT, new String(yytext()) );}*/

"OXYGEN"		{if(printdebug==1) System.out.print("OXYGEN "); return symbol(sym.OXYGEN, new String(yytext()));}
"CELLS"			{if(printdebug==1) System.out.print("CELLS "); return symbol(sym.CELLS, new String(yytext()));}
"TEMP"			{if(printdebug==1) System.out.print("TEMP "); return symbol(sym.TEMP);}
"FOOD"			{if(printdebug==1) System.out.print("FOOD "); return symbol(sym.FOOD);}
"MAX"			{if(printdebug==1) System.out.print("MAX "); return symbol(sym.MAX);}
"MOD_STATE1"	{if(printdebug==1) System.out.print("MOD_STATE1 "); return symbol(sym.MOD_STATE1);}
"MOD_STATE2"	{if(printdebug==1) System.out.print("MOD_STATE2 "); return symbol(sym.MOD_STATE2);}
{separator}	{if(printdebug==1) System.out.print("SEPARATOR "); return symbol(sym.SEPARATOR);}
":"		{if(printdebug==1) System.out.print("COLON "); return symbol(sym.COLON);}
";"		{if(printdebug==1) System.out.print("SEMICOLON "); return symbol(sym.SEMICOLON);}
","		{if(printdebug==1) System.out.print("COMMA "); return symbol(sym.COMMA);}
"("     {if(printdebug==1) System.out.print("RO "); return symbol(sym.RO);}
")"     {if(printdebug==1) System.out.print("RC "); return symbol(sym.RC);}
"+"     {if(printdebug==1) System.out.print("PLUS "); return symbol(sym.PLUS);}
"-"     {if(printdebug==1) System.out.print("MINUS "); return symbol(sym.MINUS);}
{_int}	{if(printdebug==1) System.out.print("INT "); return symbol(sym.INT, new Integer(yytext()));}
{_float}	{if(printdebug==1) System.out.print("FLOAT "); return symbol(sym.FLOAT, new Float(yytext()));}
{code1} {if(printdebug==1) System.out.print("CODE1 "); return symbol(sym.CODE1);}
{code2}	{if(printdebug==1) System.out.print("CODE2 "); return symbol(sym.CODE2);}

{comment} {if(printdebug==1) System.out.print("COMMENT ");}
{nl}|{ws} {if(printdebug==1) System.out.print("BLANK ");}
. {if(printdebug==1) System.out.print("ERROR ");}
