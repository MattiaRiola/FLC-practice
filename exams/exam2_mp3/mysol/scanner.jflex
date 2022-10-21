/**************************
 Scanner
***************************/

import java_cup.runtime.*;

%%

%cup
%line
%column

%{
	private boolean DEBUG_MODE = false;
	private Symbol sym(int type) {
		if(DEBUG_MODE)
			System.out.println("FOUND: " + yytext());
		return new Symbol(type, yyline, yycolumn);
	}
	
	private Symbol sym(int type, Object value) {
		if(DEBUG_MODE)
			System.out.println("FOUND: " + yytext());
		return new Symbol(type, yyline, yycolumn, value);
	}
	
%}

song		= 	[a-zA-Z][_a-zA-Z0-9]*".mp3"
number		=	[0-9]+
day 		= 	[0-2][0-9] | 3[0-1]
month 		= 	0[0-9] | 1[0-2]
year		= 	[1-9][0-9]+
date 		= 	{day}"/"{month}"/"{year}
hours		=   [0-1][0-9] | 2[0-3]
minutes		= 	[0-5][0-9]
time 		= 	{hours}":"{minutes}
ip_num		=	(2(([0-4][0-9])|(5[0-5])))|(1[0-9][0-9])|([1-9][0-9])|([0-9])
ip			=	{ip_num}"."{ip_num}"."{ip_num}"."{ip_num}

%%

"mp3_list"    		{return sym(sym.STARTMP3);}
"server" 			{return sym(sym.SERVER);}
"Kb/s" 				{return sym(sym.KBPS);}
":" 				{return sym(sym.C);}
";" 				{return sym(sym.S);}
"," 				{return sym(sym.CM);}
"time"				{return sym(sym.TIMEW);}
{time}				{return sym(sym.TIME);}
"data"				{return sym(sym.DATEW);}
{date}				{return sym(sym.DATE);}
{number}			{return sym(sym.NUM, new Integer(yytext()));}
{song}				{return sym(sym.SONG, new String(yytext()));}
{ip}				{return sym(sym.IP, new String(yytext()));}

\n|\r|\r\n 	{;}
[ \t]		{;}