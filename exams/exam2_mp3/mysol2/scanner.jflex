/**************************
 Scanner
***************************/

import java_cup.runtime.*;

%%

%unicode
%line
%column
%cup

%{

	private Symbol symAndPrint(String strType, int type) {
		System.out.print(strType);
		return new Symbol(type, yyline, yycolumn);
	}

	private Symbol symAndPrint(String strType, int type, Object value) {
		System.out.print(strType + ":" + value.toString());
		return new Symbol(type, yyline, yycolumn, value);
	}
	private Symbol sym(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	
	private Symbol sym(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
	
%}


nl = \n | \r | \r\n

integer = ([1-9][0-9]*|0)
fname = [_a-zA-Z][_a-zA-Z0-9]*
extension = ".mp3"
filename = ({fname}{extension})
ip_num		=	(2(([0-4][0-9])|(5[0-5])))|(1[0-9][0-9])|([1-9][0-9])|([0-9])
ip			=	{ip_num}"."{ip_num}"."{ip_num}"."{ip_num}
day 		= 	[0-2][0-9] | 3[0-1]
month 		= 	0[0-9] | 1[0-2]
year		= 	[1-9][0-9]+
date 		= 	{day}"/"{month}"/"{year}
hours		=   [0-1][0-9] | 2[0-3]
minutes		= 	[0-5][0-9]
time 		= 	{hours}":"{minutes}
%%


\r | \n | \r\n | " " | \t	{}

"mp3_list" 		{return sym( sym.KEY1);}
":"				{return sym( sym.DD);}
"server"		{return sym( sym.KEY2);}
{integer}		{return sym( sym.INT, new Integer(yytext()));}
"Kb/s"			{return sym( sym.KBS);}
{filename}		{return sym( sym.FILENAME, new String( yytext()));}
","				{return sym( sym.C);}
";"				{return sym( sym.S);}
{date}			{return sym( sym.DATE);}
{time}			{return sym( sym.TIME);}
{ip}			{return sym( sym.IP, new String(yytext()));}
"data"			{return sym( sym.DATAK);}
"time"			{return sym( sym.TIMEK);}
.				{ System.out.println("\nScanner Error: " + yytext()); }
