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

firsthour        = 08\: ((31 (\: 1[2-9] | [2-5][0-9])?)| 3[2-9]{allsecond}|[4-5][0-9]{allsecond})
otherhour        =(09 |1[0-9] | 2[0-2]) {allminut}{allsecond}
lasthour         =(23\:(([0-1][0-9]|20){allsecond})|21(0[0-9]|10)?)
allminut         = (\:[0-5][0-9])
allsecond        = ((\:[0-5][0-9])?)
hour             ={firsthour}|{otherhour}|{lasthour}
code             =((X|Y){3}[(X|Y){2}]*)? {evennum}
evennum          =(-(1[0-3]{even}|[2468]|[1-9]{even}))|{even}|[1-9]{even}|[1-7][0-9]{even}|8[01]{even}|82[024]
even             =0|2|4|6|8
floatnum         =([0-9]+\.[0-9][0-9])
str              =[a-zA-Z]+
usercode         =[a-zA-Z]{3}[a-zA-Z]*(\.{num}\.{num})+
num              =1[2-9]|[2-9][0-9]|1[0-2][0-9]|13[0-2]
int              =[1-9][0-9]*
product          =\"([a-zA-Z*0-9 ]+)\"
%%

{hour}    	{return new Symbol(sym.HOUR);}
{code}          {return new Symbol(sym.CODE,new String(yytext()));}
{floatnum}      {return new Symbol(sym.FLOAT,new Double(yytext()));}
{usercode}      {return new Symbol(sym.USERCODE, new String(yytext()));}
{int}           {return new Symbol(sym.INTEGER, new Integer(yytext()));}
{product}       {return new Symbol(sym.PRODUCT);}
";"             {return new Symbol(sym.SYM);}
":"             {return new Symbol(sym.COLON);}
","             {return new Symbol(sym.COMA);}
Auction\ {int}  {return new Symbol(sym.AUCTIONINT,new String(yytext()));}
{int}\ min      {return new Symbol(sym.DURATION,new String(yytext()));}
"->"            {return new Symbol(sym.ARROW);}
euro            {return new Symbol(sym.EURO);}
{str}           {return new Symbol(sym.STRING);}
"*****"         {return new Symbol(sym.STARS);}
[ \t] 	        {;}
\r | \n | \r\n  {;}
