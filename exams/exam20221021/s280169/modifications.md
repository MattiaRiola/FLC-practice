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