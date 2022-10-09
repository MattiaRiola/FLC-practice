# Guide on example 2

## Steps

In this directory run the following commands

```bash
jflex scanner.jflex
java java_cup.MainDrawTree parser.cup
javac *.java
java Main example_expr.txt
```

1.  `jflex scanner.jflex`
    - it will generate a `Yylex.java` file 
2. `javac *.java`
    - compiles every java files in the directory
3. `java java_cup.MainDrawTree parser.cup`
4. `java Main example_expr.txt`
    - it opens a window with the DrawTree and you should see some output