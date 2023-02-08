/**************************
 Scanner
***************************/

import java_cup.runtime.*;

%%

%unicode
%cup
%line
%column

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

//example:

// from 101 to 
// 1011011

bin = 101 | 11[0-1] | 
		1[0-1]{3,5} |
		100[0-1]{4} |
		1010[0-1]{3}|
		10110[0-1]{2}
word = ([xyz]{2}){3}([xyz]{2})*
wordsep = "#" | "$"
wordset = {word}("#"|"$"){word} | {word}(("#"|"$"){word}){4} 
day31 		= 	[0-2][0-9] | 3[0-1]
day28 		= 	[0-1][0-9] | 2[0-8]
day30 		= 	[0-2][0-9] | 30
date 		= 	2022"/"(10 | 12)"/"{day31}
			|	2022"/"(09 | 11)"/"{day30}
			| 	2023"/"(01 | 03)"/"{day31}

time 		= 09":"1[1-9] | 09":"[1-6][0-9]
			| 1[0-6]":"[0-5][0-9]
			| 17":"0[0-9] | 17":"1[0-3]

tok1 = "X_"({bin}("+"|"*")){3}|({bin}("+"|"*")){12}|({bin}("+"|"*")){15}
tok2 = "Y_"{wordset}
tok3 = "Z_"{date}(":"{time})?

string = \" ~ \"
//"
double = (([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+))
integer = ([1-9][0-9]*|0)
%%



";"				{return symAndPrint( "S",sym.S);}
":"				{return symAndPrint( "DD",sym.DD);}
","				{return symAndPrint( "C",sym.C);}

{tok1}			{return symAndPrint(" TOK1",sym.TOK1);}
{tok2}			{return symAndPrint(" TOK2",sym.TOK2);}
{tok3}			{return symAndPrint(" TOK3",sym.TOK3);}

"===="			{return symAndPrint(" SEP",sym.SEP);}
"km"			{return symAndPrint(" KM",sym.KM);}
"TO"			{return symAndPrint(" TO",sym.TO);}
"m"				{return symAndPrint(" M",sym.M);}
"kcal/km"		{return symAndPrint(" KCAL",sym.KCAL);}

{string}		{return symAndPrint(" STRING",sym.STRING, new String(yytext()));}

{double}		{return symAndPrint(" DOUBLE",sym.DOUBLE,new Double(yytext()));}
{integer}		{return symAndPrint(" INTEGER",sym.INTEGER,new Integer(yytext()));}
"ELEVATION"		{return symAndPrint(" ELEVATIONKW",sym.ELEVATIONKW);}
"ROUTE"			{return symAndPrint(" ROUTEKW",sym.ROUTEKW);}
"(+-" ~ "-+)"   {if(visualization) System.out.println(yytext());}

\r | \n | \r\n | " " | \t	{if(visualization) System.out.print(yytext());}

.				{ System.out.println("Scanner Error: " + yytext()); }