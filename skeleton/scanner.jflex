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

//example:

id = [_a-zA-Z][_a-zA-Z0-9]*

integer = ([1-9][0-9]*|0)

%%



";"				{return symAndPrint( "S",sym.S);}



{integer}		{return symAndPrint(" INT",sym.INT,new Integer(yytext()));}

{id}			{return symAndPrint(" ID",sym.ID, new String(yytext()));}

"##"			{return symAndPrint(" SEP",sym.SEP);}

"/*" ~ "*/"     {if(visualization) System.out.println(yytext());}

\r | \n | \r\n | " " | \t	{if(visualization) System.out.print(yytext());}

.				{ System.out.println("Scanner Error: " + yytext()); }