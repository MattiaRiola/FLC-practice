import java_cup.runtime.*;

%%

%unicode
%cup
%line
%column
%{
	private Symbol sym(int type) {
//		System.out.println("FOUND: " + yytext());
		return new Symbol(type, yyline, yycolumn);
	}
	
	private Symbol sym(int type, Object value) {
//		System.out.println("FOUND: " + yytext());
		return new Symbol(type, yyline, yycolumn, value);
	}
	
%}

nl = \r|\n|\r\n
ws = [ \t]
id = [A-Za-z_][A-Za-z0-9_]*
integer =  ([1-9][0-9]*|0)
double = (([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?

%%

"("     {return sym(sym.RO);}
")"     {return sym(sym.RC);}
"{"     {return sym(sym.BO);}
"}"     {return sym(sym.BC);}
"="     {return sym(sym.EQ);}
"+"     {return sym(sym.PLUS);}
"-"     {return sym(sym.MINUS);}
"*"     {return sym(sym.STAR);}
"/"     {return sym(sym.DIV);}
"<"     {return sym(sym.MIN);}
">"     {return sym(sym.MAJ);}
"<="    {return sym(sym.MIN_EQ);}
"=<"    {return sym(sym.EQ_MIN);}
">="    {return sym(sym.MAJ_EQ);}
"=>"    {return sym(sym.EQ_MAJ);}
"&"     {return sym(sym.AND);}
"|"     {return sym(sym.OR);}
"!"     {return sym(sym.NOT);}

"["     {return sym(sym.SO);}
"]"     {return sym(sym.SC);}

"int"   {return sym(sym.INT_TYPE);}
"double" {return sym(sym.DOUBLE_TYPE);}

print   {return sym(sym.PRINT);}
if      {return sym(sym.IF);}
while   {return sym(sym.WHILE);}
else    {return sym(sym.ELSE);}
;       {return sym(sym.S);}
,       {return sym(sym.CM);}

{id}      {return sym(sym.ID, yytext());}
{integer} {return sym(sym.INT, new Integer(yytext()));}
{double}  {return sym(sym.DOUBLE, new Double(yytext()));}

"/*" ~ "*/"     {;}

{ws}|{nl}       {;}

. {System.out.println("SCANNER ERROR: "+yytext());}

