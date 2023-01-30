default: run

debug: rundebug

clean:
	rm -fr parser.java Yylex.java sym.java scanner.java
	rm -vfr *.class
	rm -vfr *.*~

scanner: clean
	jflex scanner.jflex
	
parser: scanner
	java java_cup.Main -expect 1 -parser parser parser.cup
	
compile: parser
	javac *.java
	
run: compile
	java Main bubble.c

new: default run

cupdebug: scanner
	java java_cup.Main -expect 1 -dump_grammar -parser parser parser.cup 

compiledebug: cupdebug
	javac *.java

rundebug: compiledebug
	java Main bubble.c -debug