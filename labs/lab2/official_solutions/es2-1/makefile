default: run

clean: 
	rm -fr Lexer.java
	rm -vfr *.class
	rm -vfr *.*~

scanner: clean
	jflex scanner.jflex

compile: scanner
	javac *.java

run: compile
	java Lexer bubble.c
