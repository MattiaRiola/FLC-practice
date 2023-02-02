import java_cup.runtime.*;
%%

%state COMMENT

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

separator = (\#){3}\#*

tok1bin   = (0*10*10*(10*10*)?)
tok1alph  = (y?(xy)*x?)
tok1      = \?({tok1bin}|{tok1alph});

monthday  = (01\/1[8-9]|0[1-6]\/(2[0-8])|0[2-6]\/(0[1-9]|1[0-9])|0(1|[3-6])\/30|(01|03|05)\/31|07\/0[1-2])
hour      = (01:1[2-9]|01:[2-5][0-9]|(0[2-9]|10):[0-5][0-9]|11:([0-2][0-9]|3[0-7]))
tok2      = 2017\/{monthday}(:{hour})?;

tok3word  = (1[579]|[2-9][579]|[1-9][0-9][13579]|1[0-4][0-9][13579]|15[0-6][13579]|157[13])
tok3      = ({tok3word}[/$+]){5}{tok3word}([/$+]{tok3word}[/$+]{tok3word})*;

id        = [a-zA-Z_][a-zA-Z0-9_]*
integer   = [1-9][0-9]*|0

nl        = \r|\n|\r\n
ws        = [ \t]

%%
<YYINITIAL> {    
    
    \/\* {yybegin(COMMENT);}

    {separator} {return symbol(sym.SEP);}
    {tok1} {return symbol(sym.T1);}
    {tok2} {return symbol(sym.T2);}
    {tok3} {return symbol(sym.T3);}
    
    CONFIGURE {return symbol(sym.CONF);}
    HUMIDITY  {return symbol(sym.HUM);}
    TEMPERATURE {return symbol(sym.TEMP);}
    
    STORE {return symbol(sym.STORE);}
    =     {return symbol(sym.EQ);}
    
    \+ {return symbol(sym.PLUS);}
    \- {return symbol(sym.MINUS);}
    \* {return symbol(sym.TIMES);}
    \/ {return symbol(sym.DIV);}
    \^ {return symbol(sym.POW);}
    avg|AVG {return symbol(sym.AVG);}
    
    \( {return symbol(sym.RO);}
    \) {return symbol(sym.RC);}
    \{ {return symbol(sym.BO);}
    \} {return symbol(sym.BC);}
    
    , {return symbol(sym.CM);}
    ; {return symbol(sym.S);}
    
    CASE {return symbol(sym.CASE);}
    IS   {return symbol(sym.IS);}
    IN   {return symbol(sym.IN);}
    RANGE   {return symbol(sym.RANGE);}
    EQUAL   {return symbol(sym.EQUAL);}
    
    {id}  {return symbol(sym.ID, yytext());}
    {integer} {return symbol(sym.INT, yytext());}
    
    {nl}|{ws} {;}   
    . {System.err.println("SCANNER ERROR: " + yytext() + " " + yyline + " " + yycolumn);}
}

<COMMENT> {
    
    \*\/ {yybegin(YYINITIAL);}
    
    .|{nl}|{ws} {;}
    
}