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

	public final boolean visualization = true;

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

id = [_a-zA-Z][_a-zA-Z0-9]*

integer = ([1-9][0-9]*|0)
string = \" ~ \"
//"

//TOK1:
day31 		= 	0[1-9] | [1-2][0-9] | 3[0-1]
day28 		= 	0[1-9] | 1[0-9] | 2[0-8]
day30 		= 	0[1-9] | [1-2][0-9] | 30
dayFrom05To32 = 0[5-9] | [1-2][0-9] | 3[0-1] 
date 		= 	{dayFrom05To32}"/"(July)"/"2022
			| {day31}"/"(August | October | December)"/"2022
			|	{day30}"/"(September | November)"/"2022
			| 	0[1-4]"/"(January)"/"2023

tok1 = "D-"{date}("-"{date})?

//TOK2:
xyz = (XX | YY | ZZ){4,15}("????"("??")*)?
tok2 = "R-"{xyz}

//TOK3:
hex = [a-fA-F0-9]
acceptedHex =	(b|B)(c|C)[0-3]
			|	(b|B)[0-9a-bA-B]{hex}
		  	|	([0-9]|a|A){hex}{hex}
			|   [3-9a-zA-Z]{hex}
			|	2[a-fA-F]
			
tok3 = "N-"({acceptedHex}("+"|"/"|"*"){acceptedHex}("+"|"/"|"*")){2}({acceptedHex}("+"|"/"|"*"){acceptedHex}("+"|"/"|"*"))*{acceptedHex}

%%

{tok1}			{return symAndPrint(" TOK1",sym.TOK1);}
{tok2}			{return symAndPrint(" TOK2",sym.TOK2);}
{tok3}			{return symAndPrint(" TOK3",sym.TOK3);}

";"				{return symAndPrint( "S",sym.S);}
"===="			{return symAndPrint(" SEP",sym.SEP);}



"="				{return symAndPrint(" EQ",sym.EQ);}
"!"				{return symAndPrint(" NOT",sym.NOT);}
"|"				{return symAndPrint(" OR",sym.OR);}
"&"				{return symAndPrint(" AND",sym.AND);}
"("				{return symAndPrint(" RO",sym.RO);}
")"				{return symAndPrint(" RC",sym.RC);}
"TRUE"			{return symAndPrint(" TRUE",sym.TRUE,true);}
"FALSE"			{return symAndPrint(" FALSE",sym.FALSE,false);}
"IF"			{return symAndPrint(" IF",sym.IF);}
"FI"			{return symAndPrint(" FI",sym.FI);}
"DONE"			{return symAndPrint(" DONE",sym.DONE);}
"DO"			{return symAndPrint(" DO",sym.DO);}
"PRINT"			{return symAndPrint(" PRINT",sym.PRINT);}


{id}			{return symAndPrint(" ID",sym.ID, new String(yytext()));}
{string}		{return symAndPrint(" STRING",sym.STRING,new String(yytext()));}

"[[--" ~ "--]]"     {if(visualization) System.out.println(yytext());}

\r | \n | \r\n | " " | \t	{if(visualization) System.out.print(yytext());}

.				{ System.out.println("Scanner Error: " + yytext()); }