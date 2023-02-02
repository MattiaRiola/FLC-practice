
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
	
	private void print(String text) {
		System.out.println(text);
	}
%}

code1 	= "#"[a-zA-Z]{4}([a-zA-Z][a-zA-Z])*("-"[123] | 0 | [1-9][0-9]? | 1[01][0-9] | 12[0-3])("IJK" | "XY"("Z"("ZZ")*)?)?

code2 	= [0-9a-fA-F]{2}([0-9a-fA-F]{2})?("-" | ":")[0-9a-fA-F]{2}([0-9a-fA-F]{2})?(("-" | ":")[0-9a-fA-F]{2}([0-9a-fA-F]{2})?("-" | ":")[0-9a-fA-F]{2}([0-9a-fA-F]{2})?)*

dollar 	= "$$$"("$$")*

uint 	= 0 | [1-9][0-9]*
float 	= ("+" | "-")?(([0-9]+"."[0-9]*) | ([0-9]*"."[0-9]+))(e|E("+"|"-")?[0-9]+)?

nl 		= \r | \n | \r\n
c_comm 	= "//" ~ {nl}

%%

{code1} 			{ return sym(sym.CODE1);}
{code2} 			{ return sym(sym.CODE2);}
{dollar} 			{ return sym(sym.SEPAR);}

"OXYGEN" 			{ return sym(sym.OXYG);}
"CELLS" 			{ return sym(sym.CELLS);}
{uint} 				{ return sym(sym.UINT, Integer.parseInt(yytext()));}
"MOD_STATE1" 		{ return sym(sym.MOD_ST1);}
"MOD_STATE2" 		{ return sym(sym.MOD_ST2);}
"MAX" 				{ return sym(sym.MAX);}
"TEMP" 				{ return sym(sym.TEMP);}
"FOOD" 				{ return sym(sym.FOOD);}
{float} 			{ return sym(sym.FLOAT, Float.parseFloat(yytext()));}

"," 				{ return sym(sym.CM);}
";" 				{ return sym(sym.SCO);}
":" 				{ return sym(sym.COL);}
"(" 				{ return sym(sym.RO);}
")" 				{ return sym(sym.RC);}

"+" 				{ return sym(sym.PLUS);}
"-" 				{ return sym(sym.MINUS);}

{c_comm} 			{;}

[ \t] 				{;}
\r | \n | \r\n 		{;}

.					{ System.out.println("Scanner Error: " + yytext()); }
