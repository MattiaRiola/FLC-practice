/************************************************
 *			
 *  EXAM OF FORMAL LANGUAGES AND COMPILERS  
 *  JULY 1ST 2014	
 *					
 *  SCANNER		
 *				
 ************************************************/

import java_cup.runtime.*;

%%

%class scanner
%unicode
%cup
%line
%column



%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
	
  }
%}

nl 		= \r|\n|\r\n
ws 		= [ \t]

lowwov		= [aeiou]
caplet_		= [A-Z_]
score		= [0-9]|([1-2][0-9])|"30"

/* even numbers between -12 and 136 */
evnNum		= ( ("-"(1[02]|[02468])) | ( (1[0-2][02468] | 13[0246])|([0-9][02468])|([02468]) ) )

tok1		= {lowwov}{4}({lowwov}{2})* {evnNum}? ( ({caplet_}{4}) | ({caplet_}{7}) )

datea		= ("2014/12/"((1[2-9])|(2[0-46-9])|(3[0-1]))) 
dateb		= ("2015/0"[1356]"/"( (0[0-9])|(1[0-9])|(2[0-9])|3[0-1]))
datec		= ("2015/02/"( (0[0-9])|(1[0-9])|(2[0-8]) )) | ("2015/05/"( (0[0-9])|(1[0-9])|(2[0-9])|30))
date		= {datea}|{dateb}|{datec}

scalar 		= ([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+) | ([0-9]+)

divider		= "#"{3}"#"* 

%%

{tok1}			{return symbol(sym.TOK1);}
{date}			{return symbol(sym.DATE);}

"EXAM"			{return symbol(sym.EXAM);}

"SCORES"		{return symbol(sym.SCORES);}
{score}			{return symbol(sym.SCORE_VAL, new Integer(yytext()));}

":"			{return symbol(sym.CL);}
","			{return symbol(sym.CM);}
";"			{return symbol(sym.S);}
"."			{return symbol(sym.PT);}
"-"			{return symbol(sym.MINUS);}
"_"			{return symbol(sym.DASH);}

"IF"			{return symbol(sym.IF);}
"THEN"			{return symbol(sym.THEN);}
"ELSE"			{return symbol(sym.ELSE);}
"END_IF"		{return symbol(sym.END_IF);}

"("			{return symbol(sym.RO);}
")"			{return symbol(sym.RC);}
"<"			{return symbol(sym.MIN, yytext());}
">"			{return symbol(sym.MAJ, yytext());}
"AND"			{return symbol(sym.AND, yytext());}
"OR"			{return symbol(sym.OR, yytext());}

"avg"			{return symbol(sym.AVG_OP);}
"min"			{return symbol(sym.MIN_OP);}
"max"			{return symbol(sym.MAX_OP);}
{scalar}		{return symbol(sym.SCALAR, new Double(yytext()) );}

"PRINT"			{return symbol(sym.PRINT);}

{divider}		{return symbol(sym.DIVIDER);}


"/*" ~ "*/"     {;}
"\"" ~ "\"" {return symbol(sym.STR_GEN, new String(yytext())); }
"//" ~ {nl} {;}

{ws}|{nl}       {;}

. {System.out.println("SCANNER ERROR: "+yytext());}
