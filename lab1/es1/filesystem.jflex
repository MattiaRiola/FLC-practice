
%%

%standalone
%class FileSystem

nl = \n|\r|\r\n
/* ciao */

Id = [0-9a-zA-Z]+
Drive = [a-zA-Z]
FileType = .[a-zA-Z]
FileName = {Id}
PathName = {Id}
AcceptedLetter = [^\n\r\\/:*?\"<> | 0-9]
Path = ({Drive}:)?(\\)?({PathName}\\)*{FileName}(.{FileType})?

letter = [^\n\r\\/:*?\"<> | 0-9]
digit = [0-9]
id = ({letter}|{digit})+

%%

id* {
    System.out.println("test: " +yytext());
    
}

^({letter}:)?(\\)?({id}\\)*{id}(\.{id})?$ {
    System.out.println("path: " +yytext());
}

^.+$ {
  System.out.println("Path with Error: " + yytext());
}


{nl} 	{;}

