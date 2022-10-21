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
		System.out.println("FOUND: " + yytext());
		return new Symbol(type, yyline, yycolumn);
	}
	
	private Symbol sym(int type, Object value) {
		System.out.println("FOUND: " + yytext());
		return new Symbol(type, yyline, yycolumn, value);
	}
	
%}

comment = "{++" ~ "++}"
octal_number = -[1-7][0-7] | -[1-7][0-7] | -[1][0-2][0-7]
		| [0-7] | [1-7][0-7] | [1-2][0-7][0-7] | 3[0-2][0-3]
words = ("xx"|"yy"|"zz"){4}("xx"|"yy"|"zz")* 
tk1 = "?"[A-Z]{6}([A-Z][A-Z])* {octal_number} ({words})?

email = ([0-9a-zA-Z]|"_"|".")+"@"[0-9a-zA-Z]+"."("org"|"it"|"com"|"net")
tk2 = {email}("!"|"/"){email} 
	| ({email}("!"|"/")){11}{email}
	| ({email}("!"|"/")){14}{email}
id = [a-zA-Z][a-zA-Z0-9_]*
%%

"$$$" 				{return sym(sym.SEP);}
";" 				{return sym(sym.S);}
"=" 				{return sym(sym.EQ);}
"OR" 				{return sym(sym.OR);}
"NOT" 				{return sym(sym.NOT);}
"AND" 				{return sym(sym.AND);}
"T" 				{return sym(sym.TRUE,new Boolean(true));}
"F" 				{return sym(sym.FALSE,new Boolean(false));}

"tk3" 				{return sym(sym.TK3);}
{tk2} 				{return sym(sym.TK2);}
{tk1} 				{return sym(sym.TK1);}
{id}				{return sym(sym.ID,new String(yytext()));}
{comment} 			{;}

\r | \n | \r\n | " " | \t	{;}

.				{ System.out.println("Scanner Error: " + yytext()); }
