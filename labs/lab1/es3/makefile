default: run

clean: 
	rm -fr Yylex.java
	rm -vfr *.class
	rm -vfr *.*~

scanner: clean
	jflex Es3.jflex

compile: scanner
	javac *.java

run: compile
	java Es3 example.c
