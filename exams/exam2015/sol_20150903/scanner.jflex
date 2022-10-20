/**************************
 Scanner (exam 2015/09/03)
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

/* TOKEN1 regular expression */
token1     = (("%%%%%"("%%")*) | (("**" | "???"){2,3})) {odd_number}
odd_number = "-"(3[135] | [12][13579] | [13579]) | [13579] | [1-9][13579] | [12][0-9][13579] | 3([0-2][13579]|3[13])

/* TOKEN2 regular expression */
token2	= {date}("-" | "+"){date}
date	= 2015"/"12"/"(1[2-9] | 2[0-9] | 3[01]) | 2016"/"(01"/"(0[1-46-9] | [12][0-9] | 3[01]) | 02"/"(0[1-9] | [12][0-9]) | 03"/"(0[1-9] | 1[0-3]))

/* TOKEN3 regular expression */                        
token3	= "$"(101 | 110 | 111 | 1(0|1){3} | 1(0|1){4} | 10(1000|0(0|1){3}))

q_string = \" ~ \"

uint	= 0 | [1-9][0-9]*
                    
sep		= "##"("##")+

cpp_comment     = "//" .*

%%

{token1}			{ return sym(sym.TOKEN1);}
{token2}			{ return sym(sym.TOKEN2);}
{token3}			{ return sym(sym.TOKEN3);}

{q_string}			{ return sym(sym.QSTRING, yytext());}
{uint}				{ return sym(sym.UINT, new Integer(yytext()));}

{sep}				{ return sym(sym.SEP);}

"PRINT_MIN_MAX"	        	{ return sym(sym.MINMAX);}
"PART"				{ return sym(sym.PART);}
"m"				{ return sym(sym.M);}
"m/s"				{ return sym(sym.MS);}
"->"				{ return sym(sym.ARROW);}
"=" 				{ return sym(sym.EQ);}
"|" 				{ return sym(sym.PIPE);}
"," 				{ return sym(sym.CM);}
";" 				{ return sym(sym.S);}
":" 				{ return sym(sym.COL);}
"(" 				{ return sym(sym.RO);}
")" 				{ return sym(sym.RC);}
"{" 				{ return sym(sym.SO);}
"}" 				{ return sym(sym.SC);}

{cpp_comment}	 		{;}
\r | \n | \r\n | " " | \t	{;}

.				{ System.out.println("Scanner Error: " + yytext()); }
