import java_cup.runtime.*;

%%

%cup
%unicode
%line
%column
%class scanner

%{
	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}

	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
%}


integer		    = \-?[0-9]+
hour        	= 11\:([4-5][0-9]|3[5-9])(am)?|12\:[0-5][0-9](am)?|13\:([0-4][0-9]|5[0-1])|0?1\:([0-4][0-9]|5[0-1])(pm)
ip_byte     	= 0?0?[0-9]|0?[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]
ip_addr     	= {ip_byte}\.{ip_byte}\.{ip_byte}\.{ip_byte}
string		    = "\"" ~ "\""
token2		    = {string}\:{ip_addr}
token3		    = \%[a-zA-Z]{4}([a-zA-Z]{2})*((\-3[135]|\-[12]?[13579])|[01]?[0-9]?[13579]|2[0-4][13579]|25[13])(\*{4}|YX(XX)*Y)?
var          	= [a-zA-Z_][a-zA-Z0-9_]*
comment     	= "\/\*" ~ "\*\/"


%%

\#\#		    {return symbol(sym.SEPARATOR);}
\=\=		    {return symbol(sym.CMP);}
\=		        {return symbol(sym.EQ);}
\&\&		    {return symbol(sym.AND);}
\|\|		    {return symbol(sym.OR);}
\!		        {return symbol(sym.NOT);}
\+		        {return symbol(sym.PLUS);}
\*		        {return symbol(sym.STAR);}
TRUE		    {return symbol(sym.TRUE);}
FALSE		    {return symbol(sym.FALSE);}
EVALUATE	    {return symbol(sym.EVALUATE_KW);}
CASE_TRUE	    {return symbol(sym.CASET_KW);}
CASE_FALSE      {return symbol(sym.CASEF_KW);}
SAVE		    {return symbol(sym.SAVE_KW);}
\,		        {return symbol(sym.COMMA);}
\;		        {return symbol(sym.SEMI_COL);}
\(		        {return symbol(sym.ROUND_OPEN);}
\)		        {return symbol(sym.ROUND_CLOSED);}
\[		        {return symbol(sym.SQUARE_OPEN);}
\]		        {return symbol(sym.SQUARE_CLOSED);}
\o		        {return symbol(sym.O);}
{hour}		    {return symbol(sym.TOKEN1);}
{token2}	    {return symbol(sym.TOKEN2);}
{token3}	    {return symbol(sym.TOKEN3);}
{integer}	    {return symbol(sym.INT, Integer.parseInt(yytext()));}
{var}           {return symbol(sym.VAR, yytext());}
{comment}	    {;}
[ \t\n\r]	    {;}
