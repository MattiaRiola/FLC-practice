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


id = [_a-zA-Z][_a-zA-Z0-9]*

integer = ([1-9][0-9]*|0)

separator = "$$$$"("$$")*

//TOKEN2: 
//between 2022/11/15 and 2023/03/30
//exclusion of 2022/12/13 and 2023/02/14
dayDec 		= 	0[0-9] | 1[0-2] | 1[4-9] | 2[0-9]|3[0-1]
day31 		= 	[0-2][0-9] | 3[0-1]
dayFeb 		= 	0[0-9] | 1[0-3] | 1[5-9] | 2[0-8]
day30 		= 	[0-2][0-9] | 30
dateok 	= 2022"/"11"/"1[5-9] 
	   	| 2022"/"11"/"2[0-9] | 2022"/"11"/"30
		| 2022"/"12"/"{dayDec}
		| 2023"/"01"/"{day31}
		| 2023"/"02"/"{dayFeb}
		| 2023"/"03"/"{day30}
// bin between 1011 and 10111.
binok 	= 	10[0-1]{3}
//			10xxx
		| 	11[0-1]{2}
//			_11xx
		|   1011

tok2 = {dateok}("$"|"%"){dateok}("$"|"%"){dateok}("-"{binok})?

hex = [0-9a-fA-F] 
hexnum = {hex}{2} | {hex}{3} | {hex}{6}
tok1hex = ({hexnum}"+"){2}{hexnum} | ({hexnum}"+"){5}{hexnum}  
tok1 = ("%%"|"%*"|"*%"){6,17}{tok1hex}
double = (([0-9]+\.[0-9]{2}) | ([0-9]*\.[0-9]{2}))
//FOODSECTION:

string = \" ~ \"
//"
%%

{tok2}		{return symAndPrint(" TOK2",sym.TOK2);}
{tok1}		{return symAndPrint(" TOK1",sym.TOK1);}
";"			{return symAndPrint( "S",sym.S);}
","			{return symAndPrint( "C",sym.C);}
"."			{return symAndPrint( "D",sym.D);}
":"			{return symAndPrint( "DD",sym.DD);}
"["			{return symAndPrint(" SO",sym.SO);}
"]"			{return symAndPrint(" SC",sym.SC);}



{integer}		{return symAndPrint(" INT",sym.INT,new Integer(yytext()));}

//{id}			{return symAndPrint(" ID",sym.ID, new String(yytext()));}
{string} 		{return symAndPrint(" STRING",sym.STRING, new String(yytext()));}
{double} 		{return symAndPrint(" DOUBLE",sym.DOUBLE,new Double(yytext()));}
"EURO/kg"		{return symAndPrint(" EUROKG",sym.EUROKG);}
"kg"			{return symAndPrint(" KG",sym.KG);}
{separator}			{return symAndPrint(" SEP",sym.SEP);}

"(*-" ~ "-*)"     {if(visualization) System.out.println(yytext());}

\r | \n | \r\n | " " | \t	{if(visualization) System.out.print(yytext());}

.				{ System.out.println("Scanner Error: " + yytext()); }