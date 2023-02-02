/**************************
 Scanner
***************************/

import java_cup.runtime.*;
import java.util.*;
import java.io.*;
%%

%standalone


nl = \n | \r | \r\n

%%

\r | \n | \r\n | " " | \t	{;}


.				{ System.out.println("Scanner Error: " + yytext()); }
