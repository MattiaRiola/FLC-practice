
%%

%standalone
%class Url

nl = \n|\r|\r\n

/* from pervious exercise */
FileType = "."[a-zA-Z]*
FileName = [0-9a-zA-Z]+
File = {FileName}{FileType}

/* this exercise */
number = [1-9][0-9]*
scheme = [a-zA-Z]+
subdomain = [a-zA-Z0-9]+
domain = {subdomain}.{subdomain}(.{subdomain})*
subip = [0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]
ip = ({subip}.){3}{subip}
port = [1-9][0-9]{0,5}
escape = %[A-F0-9][A-F0-9]
path = ([a-zA-Z]|{escape})+
anchor = {File}(#rif[1-9][0-9]*)?

url ={scheme}"://"({ip}|{domain})(":"{port})?("/"{path})*("/"|"/"{anchor})?

testurl ={scheme}://{domain}
%%

^{testurl} {
    System.out.println("testurl found: "+ yytext());
}

^{url}$ {
    System.out.println("url found: "+ yytext());
}

.* {
  System.out.println("Uncorrect URL: " + yytext()); 
}
