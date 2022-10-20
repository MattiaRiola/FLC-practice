default: clean scanner parser compile

compile:
	javac *.java

scanner:
	jflex scanner.jflex
	
parser:
	java java_cup.Main -parser parser parser.cup
	
clean:

	rm -fr parser.java Yylex.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
	
init:
	mkdir source build
	
run:
	java Main test.txt

new: default run

debug: clean scanner cupdebug compile run

cupdebug:
	java java_cup.Main -dump_grammar -parser parser parser.cup 

