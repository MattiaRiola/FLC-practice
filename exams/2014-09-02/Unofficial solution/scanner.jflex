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
sep = ("###"("#")*)|("****"("**")*)
codechar = "-"|"%"|"+"
codestart = {codechar}{5}({codechar}{2})*
codeword = [0-9a-zA-Z]*[a-zA-Z]
oddseq = [13579]
codenumber = -43|-41|-[0-3]{oddseq}|{oddseq}|[1-9]{oddseq}|1[01]{oddseq}|121|123
sixties = [0-5][0-9]
real = ([1-9][0-9]*|0)?"."?([0-9]+)?

hour1 = 10:45:(1[2-9]|[2-5][0-9])
hour2 = 10:(4[6-9]|5[0-9]):{sixties}
hour3 = 1[12]:{sixties}:{sixties}
hour4 = 13:[01][0-9]:{sixties}
hour5 = 13:20:(0[0-9]|10)
coderow = {codestart}{codeword}({codenumber})?
pointname = [_a-zA-Z][_a-zA-Z0-9]+

%%
// RULES SECTION
// Actions are lines of Java code associated to a regular expression
";" {return symbol(sym.SC);}
"=" {return symbol(sym.EQ);}
"[" {return symbol(sym.LSB);}
"]" {return symbol(sym.RSB);}
"(" {return symbol(sym.LRB);}
")" {return symbol(sym.RRB);}
"," {return symbol(sym.CM);}
":" {return symbol(sym.CL);}
"." {return symbol(sym.DT);}
">" {return symbol(sym.GT);}
"<" {return symbol(sym.LS);}
"AND" {return symbol(sym.AND);}
"OR" {return symbol(sym.OR);}
"NOT" {return symbol(sym.NOT);}
"Z_STATS" {return symbol(sym.ZSTAT);}
"WHEN" {return symbol(sym.WHEN);}
"IS" {return symbol(sym.IS);}
"TRUE"|"FALSE" {return symbol(sym.CVAL, yytext().equals("TRUE"));}
"PRINT" {return symbol(sym.PRINT);}
{sep} {return symbol(sym.SEP);}

{hour1} {return symbol(sym.HOUR);}
{hour2} {return symbol(sym.HOUR);}
{hour3} {return symbol(sym.HOUR);}
{hour4} {return symbol(sym.HOUR);}
{hour5} {return symbol(sym.HOUR);}
{coderow} {return symbol(sym.CODEROW);}
{pointname} {return symbol(sym.POINTNAME, new Point(yytext()));}
[zxy] {return symbol(sym.ATTNAME, yytext());}
{real} {return symbol(sym.REAL, new Double(yytext()));}
\" ~ \" {return symbol(sym.QUOTEDSTRING, yytext());}

{emptyspace} {;}
"/*" ~ "*/" {;}
