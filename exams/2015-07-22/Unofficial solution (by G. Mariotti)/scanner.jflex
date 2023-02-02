
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

// definitions
int 	= "-"?[0-9]+

am 		= (11":"((3[5-9]) | [4-5][0-9]) | 12":"[0-5][0-9])"am"?
pm 		= 13":"([0-4][0-9] | 5[0-1]) | 0?1":"([0-4][0-9] | 5[0-1])"pm"
token1 	= {am} | {pm}

ip_num 	= 0 | [1-9][0-9]? | 1[0-9][0-9] | 2[0-4][0-9] | 25[0-5]
string 	= "\"" ~ "\""
token2 	= {string}":"{ip_num}"."{ip_num}"."{ip_num}"."{ip_num}

alp_c 	= [a-zA-Z]{4}([a-zA-Z]{2})*
token3 	= "%"{alp_c}("-"([12]?[13579] | 3[135]) | [1-9]?[13579] | 1[0-9][13579] | 2[0-4][13579] | 25[13])("*"{4}("*")* | "YX""XX"*"Y")?

var 	= [a-zA-Z_][a-zA-Z0-9_]*

%%

{token1} 			{ System.out.println(yytext());
return sym(sym.TOKEN1);}
{token2} 			{ System.out.println(yytext());
return sym(sym.TOKEN2);}
{token3} 			{ System.out.println(yytext());
return sym(sym.TOKEN3);}

"##" 				{ return sym(sym.HASHTAG);}

"EVALUATE" 			{ return sym(sym.EVAL);}
"SAVE" 				{ return sym(sym.SAVE);}
"CASE_TRUE"			{ return sym(sym.CASE_T);}
"CASE_FALSE" 		{ return sym(sym.CASE_F);}
"TRUE" 				{ return sym(sym.TRUE);}
"FALSE" 			{ return sym(sym.FALSE);}

"==" 				{ return sym(sym.CMP);}
"=" 				{ return sym(sym.EQ);}
"&&" 				{ return sym(sym.AND);}
"||" 				{ return sym(sym.OR);}
"!" 				{ return sym(sym.NOT);}
"+" 				{ return sym(sym.PLUS);}
"*" 				{ return sym(sym.STAR);}
"," 				{ return sym(sym.CM);}
";" 				{ return sym(sym.SCO);}
"(" 				{ return sym(sym.RO);}
")" 				{ return sym(sym.RC);}
"[" 				{ return sym(sym.SO);}
"]" 				{ return sym(sym.SC);}
"o" 				{ return sym(sym.O);}

{var} 				{ return sym(sym.VAR, yytext());}
{int} 				{ return sym(sym.INT, Integer.parseInt(yytext()));}

"/*" ~ "*/" 		{;}

[ \t] 				{;}
\r | \n | \r\n 		{;}

.					{ System.out.println("Scanner Error: " + yytext()); }
