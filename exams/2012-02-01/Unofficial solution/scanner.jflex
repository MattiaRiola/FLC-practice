import java_cup.runtime.*;

%%

%unicode
%cup
%line
%column
%{
	private Symbol symbol(int type)
	{
		return new Symbol(type,yyline,yycolumn);
	}
	private Symbol symbol(int type,Object value)
	{
		return new Symbol(type,yyline,yycolumn,value);
	}
%}

date             = ((0[3-9]|[1-2][0-9]|3[0-1])"/" 07 "/" 2011)|((0[1-9]|[1-2][0-9]|3[0-1])"/" (08|10|12)"/" 2011)|((0[1-9]|[1-2][0-9]|30)"/"(09|11)"/" 2011)
sharp            = "#"{3}["#"{2}]*
code             ={oddnum}("*"|"+"|"-"){4}(("*"|"+"|"-")("*"|"+"|"-"))*({word})?
oddnum           =(-({odd}|1{odd}|21))|{odd}|[1-9]{odd}|[1-9][0-9]{odd}|1[0-1]{odd}|12[0-2]{odd}|1231
odd              =1|3|5|7|9
word             =[0-9][a-zA-Z0-9]+
codicet          =IT{nums}
nums             =[1-9][0-9]{5}
titlename        =\"[^\"\n]+\"
year             =[1-2][0-9][0-9][0-9]
floatsdnum       =([0-9]+\.[0-9][0-9])
floatnum         =([0-9]+\.[0-9])
%%

{date}            {return new Symbol(sym.DATE);}
{sharp}           {return new Symbol(sym.SH);}
{code}            {return new Symbol(sym.CODE);}
{codicet}         {return new Symbol(sym.CODICET, new String(yytext()));}
{titlename}       {return new Symbol(sym.TITLENAME);}
{year}            {return new Symbol(sym.YEAR, new Integer(yytext()));} 
{floatnum}        {return new Symbol(sym.FLOAT,new Double(yytext()));}
{floatsdnum}      {return new Symbol(sym.FLOATS,new Double(yytext()));}
";"               {return new Symbol(sym.SYM);}
":"               {return new Symbol(sym.COLON);}
","               {return new Symbol(sym.COMA);}
"%"               {return new Symbol(sym.P);}
euro              {return new Symbol(sym.EURO);}
[ \t] 	          {;}
\r | \n | \r\n    {;}
