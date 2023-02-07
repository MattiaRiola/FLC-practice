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

	public final boolean visualization = false;

	private Symbol symAndPrint(String strType, int type) {
		if(visualization)
			System.out.print(strType);
		return new Symbol(type, yyline, yycolumn);
	}

	private Symbol symAndPrint(String strType, int type, Object value) {
		if(visualization)
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


\r | \n | \r\n | " " | \t	{if(visualization) System.out.print(yytext());}

"mp3_list" 		{return symAndPrint( "KEY1",sym.KEY1);}
":"				{return symAndPrint( "DD",sym.DD);}
"server"		{return symAndPrint( "KEY2",sym.KEY2);}
{integer}		{return symAndPrint( "INT",sym.INT, new Integer(yytext()));}
"Kb/s"			{return symAndPrint( "KBS",sym.KBS);}
{filename}		{return symAndPrint( "FILENAME",sym.FILENAME, new String( yytext()));}
","				{return symAndPrint( "C",sym.C);}
";"				{return symAndPrint( "S",sym.S);}
{date}			{return symAndPrint( "DATE",sym.DATE);}
{time}			{return symAndPrint( "TIME",sym.TIME);}
{ip}			{return symAndPrint( "IP",sym.IP, new String(yytext()));}
"data"			{return symAndPrint( "DATAK",sym.DATAK);}
"time"			{return symAndPrint( "TIMEK",sym.TIMEK);}
.				{ System.out.println("\nScanner Error: " + yytext()); }
