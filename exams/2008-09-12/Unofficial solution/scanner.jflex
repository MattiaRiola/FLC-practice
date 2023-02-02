// CODE SECTION
// Used for import lines and code that have to be ported as is to the output file
import java.io.*;
import java_cup.runtime.*;

%%
%cup
%line
%column
%class scanner
%{
	private Symbol symbol(int type){
		return new Symbol(type, yyline, yycolumn);
	}
	private Symbol symbol(int type, Object value){ //Semantic analysis
		return new Symbol(type, yyline, yycolumn,value);
	}
%}

// DECLARATION SECTION
// Used to declare identifiers for complex or ripetitive regular expressions
emptyspace = \n|\r|" "|\t
hour = [01][0-9]|2[0-3]
minutes = [0-5][0-9]
day = 0[1-9]|[12][0-9]|3[01]
month = 0[1-9]|1[0-2]
year = [0-9]{4}

lid = [a-z][a-zA-Z0-9_]*
uid = [A-Z][a-zA-Z0-9_]*
foodprice = [0-9]+"."[0-9]{2}
time = "("{hour}":"{minutes}")"
date = {year}.{month}.{day}
number = [0-9]+

%%
// RULES SECTION
// Actions are lines of Java code associated to a regular expression
"%%" {return symbol(sym.SEP);}
";" {return symbol(sym.SC);}
"hg" {return symbol(sym.HG);}
"euro/hg" {return symbol(sym.EUHG);}
"date" {return symbol(sym.DINTRO);}
"people" {return symbol(sym.PEOPLE);}
":" {return symbol(sym.CL);}
"," {return symbol(sym.CM);}

{lid} {return symbol(sym.LID, yytext());}
{uid} {return symbol(sym.UID, yytext());}
{foodprice} {return symbol(sym.FPRICE, new Double(yytext()));}
{time} {return symbol(sym.TIME);}
{date} {return symbol(sym.DATE);}
{number} {return symbol(sym.NUMB, new Integer(yytext()));}

{emptyspace} {;}