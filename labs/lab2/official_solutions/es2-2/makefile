default: run

clean: 
	rm -fr Lexer.java
	rm -vfr *.class
	rm -vfr *.*~
	rm -vfr *output.*

scanner: clean
	jflex scanner.jflex

compile: scanner
	javac *.java

run: compile
	java Lexer input.html
