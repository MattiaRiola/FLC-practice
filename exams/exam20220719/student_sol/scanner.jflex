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
	private Symbol sym(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	
	private Symbol sym(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
	
%}

separator = "%%%%"("%%")*
comment1 = "(((-" ~ "-)))"
comment2 = "---".*
tok1part1 = 1*01*01*(01*01*01*)?
tok1part2 = "+"("*+")*"*"? | "*"("+*")*"+"? 
tok1 = "A_"({tok1part1} | {tok1part2})?
even = -(3[0-2] | [12][02468] | [2468]) | [02468] | [1-9][02468] | [1-9][0-9][02468] 
		| 1[01][0-9][02468] | 12[0-3][02468] | 124[0246]
septok2 =("*"|"$"|"+")
tok2 = "B_"(({even}{septok2}){3}{even})({septok2}{even}{septok2}{even})*
number = ("+"|"-")?([1-9][0-9]*"."[0-9]*) | ("."[0-9]+) | (0"."[0-9]*)



%%

";"			{ return sym(sym.S); }
"-"			{ return sym(sym.MINUS); }
","			{ return sym(sym.C); }
"("			{ return sym(sym.RO); }
")"			{ return sym(sym.RC); }
"MOD"		{ return sym(sym.MOD); }
"PLUS"		{ return sym(sym.PLUS); }
"STAR"		{ return sym(sym.STAR); }
"START"		{ return sym(sym.START); }
"BATTERY"	{ return sym(sym.BATTERY); }
"kWh"		{ return sym(sym.KWH); }
"USE"		{ return sym(sym.USE); }
"FUEL"		{ return sym(sym.FUEL); }
"DO"		{ return sym(sym.DO); }
"DONE"		{ return sym(sym.DONE); }
"liters"	{ return sym(sym.LITERS); }
"km"		{ return sym(sym.KM); }
"units/km"	{ return sym(sym.UNITSKM); }
"MAX"		{ return sym(sym.MAX); }

{tok1} 		{ return sym(sym.TOK1); }
{tok2} 		{ return sym(sym.TOK2); }
{separator} { return sym(sym.SEP); }
{number} 	{ return sym(sym.NUMBER, Double.valueOf(yytext())); }


{comment1} { ; }
{comment2} { ; }
\r | \n | \r\n | " " | \t	{;}

.				{ System.out.println("Scanner Error: " + yytext()); }
