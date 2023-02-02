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

%state COMMENT

separator = \#{2}

odd       = [13579bBdDfF]
tok1      = [xyz]{6}([xyz]{2})*\|(-(3[13579bB]|[12?]{odd})|[1-9a-fA-F]?{odd}|[1-9][0-9a-fA-F]{odd}|a[0-9aA]{odd}|abB[135])?

tok2      = 10:(11:(1[2-9]|[2-5][0-9])|(1[2-9]|[2-5][0-9]):[0-5][0-9])|1[2-4]:[0-5][0-9]:[0-5][0-9]|15:([0-2][0-9]:[0-5][0-9]|3[0-5]:[0-5][0-9]|36:[0-3][0-9]|36:4[0-7])

tok3num   = [01]{3}([01]{12})?
tok3      = ({tok3num}[.+-]){3}{tok3num}(([.+-]{tok3num}){2})?

integer   = 0|[1-9]*[0-9]
sname     = [A-Z][a-z0-9_]*
aname     = [a-z]+
nl        = \r|\n|\r\n
ws        = [ \t]

%%  
<YYINITIAL> {   
    \/\* {yybegin(COMMENT);}

    {separator} {return symbol(sym.SEP);}
    {tok1} {return symbol(sym.T1);}
    {tok2} {return symbol(sym.T2);}
    {tok3} {return symbol(sym.T3);}

    ; {return symbol(sym.S);}
    , {return symbol(sym.CM);}
    \. {return symbol(sym.PT);}
    = {return symbol(sym.EQ);}
    \( {return symbol(sym.RO);}
    \) {return symbol(sym.RC);}
    \[ {return symbol(sym.SO);}
    \] {return symbol(sym.SC);}
    \+ {return symbol(sym.PLUS);}
    \- {return symbol(sym.MINUS);}
    
    INIT {return symbol(sym.INIT);}
    DEFAULT {return symbol(sym.DEFAULT);}
    
    WHEN {return symbol(sym.WHEN);}
    DO {return symbol(sym.DO);}
    DONE {return symbol(sym.DONE);}
    
    && {return symbol(sym.AND);}
    \|\| {return symbol(sym.OR);}
    \! {return symbol(sym.NOT);}
    
    PRINT {return symbol(sym.PRINT);}
    CASE {return symbol(sym.CASE);}
    NEXT {return symbol(sym.NEXT);}
    
    \" ~ \" {return symbol(sym.QUOTED, yytext());}
    {integer}   {return symbol(sym.INT, yytext());}
    {sname}   {return symbol(sym.STATE, yytext());}
    {aname}   {return symbol(sym.ATTR, yytext());}

    {nl}|{ws} {;}   
    . {System.err.println("SCANNER ERROR: " + yytext() + " " + yyline + " " + yycolumn);}
}
<COMMENT> {
    
    \*\/ {yybegin(YYINITIAL);}
    
    .|{nl}|{ws} {;}
    
}