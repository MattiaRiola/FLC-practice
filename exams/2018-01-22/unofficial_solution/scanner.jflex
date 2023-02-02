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

separator = "$$$"

tok1chars = [*#&]
even      = [02468]
tok1even  = ((-(2[024])|(1?{even}))|(1?[0-9]{0,2}{even}))
tok1      = (({tok1chars}{tok1chars}){3})({tok1chars}{tok1chars})*[a-zA_Z0-9]*[a-zA-Z]{2}{tok1even}?;

hexdigit  = [a-fA-F0-9]
tok2hex   = ({hexdigit}{3}({hexdigit}{2})?)
tok2      = ({tok2hex}[:-]){3}{tok2hex}(([:-]{tok2hex}){3}|([:-]{tok2hex}){15})?;

tok3min   = [0-5][0-9]
tok39min  = ((3[1-9])|([4-5][0-9]))
tok317min = (([0-3][0-9])|(4[0-6]))
tok324h   = ((09:{tok39min})|(1[0-6]:{tok3min})|(17:{tok317min}))
tok312h   = ((09:{tok39min}am)|(1[0-1]:{tok3min}am)|((12)|(0[0-4]):{tok3min}pm)|(05:{tok317min}pm))
tok3      = ({tok312h}|{tok324h});

id        = [a-zA-Z_][a-zA_Z0-9_]*
integer   = [0-9][1-9]*
double    = (([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+))(e|E('+'|'-')?[0-9]+)?
real      = {integer}|{double}

nl        = \r|\n|\r\n
ws        = [ \t]

%%
<YYINITIAL> {    
    
    \/\* {yybegin(COMMENT);}

    {separator} {return symbol(sym.SEP);}
    {tok1} {return symbol(sym.T1);}
    {tok2} {return symbol(sym.T2);}
    {tok3} {return symbol(sym.T3);}
    
    FZ     {return symbol(sym.FZ);}
    {id}   {return symbol(sym.ID, yytext());}
    {real} {return symbol(sym.REAL, yytext());}
    :      {return symbol(sym.C);}
    ;      {return symbol(sym.S);}
    =      {return symbol(sym.EQ);}
    PATH   {return symbol(sym.PATH);}
    MAX    {return symbol(sym.MAX);}
    \(     {return symbol(sym.RO);}
    \)     {return symbol(sym.RC);}
    \+     {return symbol(sym.PLUS);}
    \-     {return symbol(sym.MINUS);}
    \*     {return symbol(sym.TIMES);}
    \/     {return symbol(sym.DIV);}
    IF     {return symbol(sym.IF);}
    ,      {return symbol(sym.CM);}
    IN     {return symbol(sym.IN);}
    RANGE  {return symbol(sym.RANGE);}
    PRINT  {return symbol(sym.PRINT);}
    \" ~ \"  {return symbol(sym.QUOTED, yytext());}
    \[     {return symbol(sym.SO);}
    \]     {return symbol(sym.SC);}
    
    
    {nl}|{ws} {;}   
    . {System.err.println("SCANNER ERROR: " + yytext() + " " + yyline + " " + yycolumn);}
}

<COMMENT> {
    
    \*\/ {yybegin(YYINITIAL);}
    
    .|{nl}|{ws} {;}
    
}