default: run

clean: 
	rm -fr *.java
	rm -vfr *.class
	rm -vfr *.*~

scanner: clean
	jflex lineCounter.jflex

compile: scanner
	javac *.java

run: compile
	java Yylex example.txt
