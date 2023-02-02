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

separator = \#\#

hex = [0-9a-fA-F]
hexnum = (-(2[0-7]|1{hex}|[1-9a-fA-F])|[1-9a-fA-F]?{hex})|[1-9a-fA-F]{hex}{hex}|1{hex}{hex}{hex}|2[0-4]{hex}{hex}|25[0-5]{hex}|256[0-9a-cA-C]
tok1 = {hexnum}_[a-zA-Z]{5}[a-zA-Z]*_(SOS|XY(YY)*(ZZ)+X)?

tok29 = (09:21(:1[2-9]|:[2-5][0-9])?|09:(2[2-9]|[3-5][0-9])(:[0-5][0-9])?)
tok2101 = (1[01]:[0-5][0-9](:[0-5][0-9])?)
tok2pm = ((12|[0-4]):[0-5][0-9](:[0-5][0-9])?)
tok25m = :[0-3][0-9](:[0-5][0-9])?|:4[0-2](:[0-5][0-9])?|:43(:([0-2][0-9]|3[0-4]))?

tok224 = {tok29}|1[0-6]:[0-5][0-9](:[0-5][0-9])?|(17{tok25m})
tok212 = {tok29}am|{tok2101}am|{tok2pm}pm|(05{tok25m})pm
tok2 = {tok224}|{tok212}

tok3 = \$\$0*10*10*10*(10*10*)?|&&X?(OX)*O?

integer   = [1-9][0-9]*|0
twodigit  = {integer}\.[0-9]{2}
real      = ((({integer})\.[0-9]*)|([0-9]*\.[0-9]+))(e|E('+'|'-')?[0-9]+)?

nl        = \r|\n|\r\n
ws        = [ \t]

%%
<YYINITIAL> {    
    
    \/\- {yybegin(COMMENT);}

    {separator} {return symbol(sym.SEP);}
    {tok1} {return symbol(sym.T1);}
    {tok2} {return symbol(sym.T2);}
    {tok3} {return symbol(sym.T3);}
    
    "->" {return symbol(sym.ARROW);}
    ; {return symbol(sym.S);}
    , {return symbol(sym.CM);}
    : {return symbol(sym.C);}
    % {return symbol(sym.PERC);}
    
    km {return symbol(sym.KM);}
    km\/h {return symbol(sym.KMH);}
    
    TIME {return symbol(sym.TIME);}
    EXPENSE {return symbol(sym.EXPENSE);}
    EXTRA {return symbol(sym.EXTRA);}
    
    COMPUTE {return symbol(sym.COMPUTE);}
    TO {return symbol(sym.TO);}
    \- {return symbol(sym.DASH);}
    euro\/km {return symbol(sym.EKM);}
    
    DISC {return symbol(sym.DISC);}
    euro {return symbol(sym.E);}    
    
    \" ~ \" {return symbol(sym.QUOTED, yytext());}
    {twodigit} {return symbol(sym.TWOD, yytext());}
    {integer} {return symbol(sym.INT, yytext());}
    {real} {return symbol(sym.REAL, yytext());}
    
    {nl}|{ws} {;}   
    . {System.err.println("SCANNER ERROR: " + yytext() + " " + yyline + " " + yycolumn);}
}

<COMMENT> {
    
    \-\/ {yybegin(YYINITIAL);}
    
    .|{nl}|{ws} {;}
    
}
