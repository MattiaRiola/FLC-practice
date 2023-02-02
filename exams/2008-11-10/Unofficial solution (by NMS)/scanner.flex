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

%state mathop

nl = \r|\n|\r\n
ws = [ \t]

fileName_str	= "File_Name"
date_str	= "Date"
time_str	= "Time"
email_str	= "E-mail"
let		= [a-zA-Z]
num		= [0-9]
fileName	= {let}({let}|num)*"."{let}{3}

dd		= ([0-2][0-9])|(3[0-1])
mm		= (0[1-9])|(1[1-2])
yyyy		= {num}{num}{num}{num}
date		= {dd}"/"{mm}"/"{yyyy} 

time		= ( ([0-1]{num})|(2[0-3]) )  ":"   ( [0-5]{num} )(" "|\t)+("am"|"pm")

user		= [0-9a-zA-Z\.\_]*
domain		= [a-zA-Z]+ "." [a-zA-Z]+
email 		= {user}"@"{domain}

id 		= [a-zA-Z\_][A-Za-z0-9\_]*
scalar 		= ([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+) | ([0-9]+)


%%

<mathop>"VAR"	{return symbol(sym.VAR);}

{fileName_str}	{ return symbol(sym.FN_STR);}
{date_str}	{return symbol(sym.DT_STR);}
{time_str}	{return symbol(sym.TM_STR);}
{email_str}	{return symbol(sym.EM_STR);}

{fileName}	{return symbol(sym.FN);}
{date}		{return symbol(sym.DT);}
{time}		{return symbol(sym.TM);}
{email}		{ yybegin(mathop); return symbol(sym.EM); }

";"" "*{nl}	{return symbol(sym.S);}



"("     {return symbol(sym.RO);}
")"     {return symbol(sym.RC);}
"+"     {return symbol(sym.PLUS);}
"-"     {return symbol(sym.MINUS);}
"*"     {return symbol(sym.STAR);}
"/"     {return symbol(sym.DIV);}
"^"     {return symbol(sym.POW);}

","	{return symbol(sym.CM);}
";"	{return symbol(sym.S);}
":"	{return symbol(sym.C);}

<mathop>
{
	{scalar} {return symbol(sym.SCAL, new Double(yytext()));}
	{id}	{return symbol(sym.IDD, new String(yytext()));}
}

{ws}|{nl}       {;}

. {System.out.println("SCANNER ERROR: "+yytext());}

"/*" ~ "*/"     {;}
"\"" ~ "\"" 	{;}


