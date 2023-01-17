
%%

%standalone

%xstate comment

%{
public int line_num = 1;
public int line_num_comment = 0;
%}
nl = \n|\r|\r\n

%%
{nl} {++line_num;}
"/*" {yybegin(comment);}
<comment> [^*\r\n]* {;}
<comment> "*"+[^\/\r\n]* {;}
<comment> {nl} {++line_num_comment;}
<comment> "*"+"/" {++line_num_comment; yybegin(YYINITIAL);}
<comment> <<EOF>> {System.out.println("ERROR: the file ended with unclosed comment\n # line of code: "+line_num+" # line of comments: "+line_num_comment);
return YYEOF;}
<<EOF>> {System.out.println("# line of code: "+line_num+" # line of comments: "+line_num_comment);
return YYEOF;}