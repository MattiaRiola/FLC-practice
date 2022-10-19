# How to debug parse debugger

In Main.java use this code:


Normal mode:
```
Yylex l = new Yylex(new FileReader(file));
parser p = new parser(l);
Object result = p.parse();
```
Debug mode:
```
Yylex l = new Yylex(new FileReader(file));
parser p = new parser(l);
Object result = p.debug_parse();
```


A series of option are available in Cup to visualize the parser’s
internal structures (use them like in this example: `java java_cup.Main -dump_grammar`):
- `-dump_grammar` : Prints the list of terminals, non-terminals and productions **important: this is useful to refer the symbols and productions to the output of debug_parse() function**
- (`-dump_states` : Prints the state graph)
- (`-dump_table `: Prints the ACTION TABLE and the REDUCE TABLE)
- (`-dump` : Prints all information)
