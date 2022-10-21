default: scanner parser

	javac *.java

scanner:
	jflex scanner.jflex

parser:
	java java_cup.Main parser.cup

clean:
	rm -fr parser.java Yylex.java sym.java
	rm -vfr *.class
	rm -vfr *.*~

init:
	mkdir source build

run:
	java Main example.c

new: default run
