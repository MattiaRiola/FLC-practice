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
exh = [a-fA-F0-9]
negToken1 = "-"(1?{exh} | 2[0-7])
posToken1 = 1?{exh}{0,3} | 2[0-4]{exh}{2} | 25[0-5]{exh} | 256[0-9a-cA-C]
token1_p1 = {negToken1} | {posToken1}
token1_p2 = ([a-zA-Z]{5})([a-zA-Z]{2})*
token1_p3 = SOS | XY([Y]{2})*([Z]{2})+X
token1 = {token1_p1}"_"{token1_p2}"_"({token1_p3})?

hours24 = [0-1][0-9] | 2[0-3]
hours12 = 1[0-2] | 0?[0-9]
minutes = [0-5][0-9]
time24 = {hours24}":"{minutes}(":"{minutes})?
time12 = {hours12}":"{minutes}("pm"|"am")

token2 = {time24} | {time12}
token3_bin = "$$"(0*10*){3}
token3_xo = "&&"X|"&&"O|"&&"("XO")+X? | "&&"("OX")+O?
token3 =  {token3_bin} | {token3_xo}
token = {token1} | {token2} | {token3}
string = \" ~ \"
//" <- useless comment, used to fix editor highligths
integer = ([1-9][0-9]*|0)
double = (([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+))
double2 = ([0-9]+\.[0-9]{2})
space = \r | \n | \r\n | " " | \t

%%

{space}	{if(visualization) System.out.print(yytext());}


{token1} 			{return symAndPrint(" TOKEN1", sym.TOKEN1);}
{token2} 			{return symAndPrint(" TOKEN2", sym.TOKEN2);}
{token3}			{return symAndPrint(" TOKEN3", sym.TOKEN3);}

"->"			{{return symAndPrint(" ARROW",sym.ARROW);}}

";"				{return symAndPrint(" S", sym.S);}

","				{return symAndPrint(" C", sym.C);}

":"				{return symAndPrint(" DD", sym.DD);}

"%"				{return symAndPrint(" PERCENT", sym.PERCENT);}
"-"				{return symAndPrint(" MINUS", sym.MINUS);}


"TO"			{return symAndPrint(" TO",sym.TO);}

"TIME" 			{return symAndPrint(" TIMEKEYW",sym.TIMEKEYW);}
"EXPENSE"		{return symAndPrint(" EXPENSEKEYW",sym.EXPENSEKEYW);}
"EXTRA"			{return symAndPrint(" EXTRA",sym.EXTRA);}
"DISC"			{return symAndPrint(" DISC",sym.DISC);}

"##"			{return symAndPrint(" SEP",sym.SEP);}

{integer}		{return symAndPrint(" INT",sym.INT,new Integer(yytext()));}
//{double2}		{return symAndPrint(" DOUBLE2",sym.DOUBLE2,new Double(yytext()));}
{double}			{return symAndPrint(" DOUBLE",sym.DOUBLE,new Double(yytext()));}

"euro"			{return symAndPrint(" EURO", sym.EURO);}
"km/h"			{return symAndPrint(" KMH",sym.KMH);}
"euro/km"		{return symAndPrint(" EUROKM",sym.EUROKM);}

"km"			{return symAndPrint(" KM",sym.KM);}

"COMPUTE"		{return symAndPrint(" COMPUTEKEYW",sym.COMPUTEKEYW);}

{string}		{return symAndPrint(" STRING",sym.STRING, new String(yytext()));}

"/-" ~ "-/"      {if(visualization) System.out.println(yytext());}

.				{ System.out.println("Scanner Error: " + yytext()); }
