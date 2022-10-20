/**************************
 Scanner
***************************/

import java_cup.runtime.*;

%%

%cup
%line
%column

%{
	private Symbol sym(int type) {
		System.out.println("FOUND: " + yytext());
		return new Symbol(type, yyline, yycolumn);
	}
	
	private Symbol sym(int type, Object value) {
		System.out.println("FOUND: " + yytext());
		return new Symbol(type, yyline, yycolumn, value);
	}
	
%}

song		= 	[a-zA-Z][_a-zA-Z0-9]*".mp3"
number		=	[0-9]+

%%

"mp3_list"    		{
	System.out.println("FOUND: " + yytext());
	return new Symbol(sym.STARTMP3,	yyline, yycolumn);
	}
"server" 			{return sym(sym.STARTSERVER);}
"Kb/s" 				{return sym(sym.KBPS);}
":" 				{return sym(sym.C);}
";" 				{return sym(sym.S);}
"," 				{return sym(sym.CM);}
{number}			{return sym(sym.NUM);}
{song}				{return sym(sym.SONG);}

\n|\r|\r\n 	{;}
[ \t]		{;}