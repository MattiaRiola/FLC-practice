# Modifications

## Precedences and conflicts

The parser didn't compile because I forgot to put the right precedence rules for the operators OR AND and NOT, so I added the precedences left

```
// Precedences and associativities
//low priority
precedence left OR;
precedence left AND;
precedence left NOT;
//high priority
```

## Value in boolean expression

Added a line in the boolean expression that identifies when a variable is used in a boolean expression (I've to take the value fromt he symbol_table populated before)
```
boolean_exp ::= [...]
    | ID:x {: RESULT=(Boolean) parser.symbol_table.get(x); :}
```

## Comment debug prints

In the assignment rule, in order to debug the code I added a `System.out.println("FOUND: "+ yytext())`, so I commented that and fixed the `System.out.println(x+y);` to allign the output with the one that was reqested (instead of `x1true` -> `x1 T`)

## missing Semicolon in assignment

Added the expected semicolon in the assignment rule