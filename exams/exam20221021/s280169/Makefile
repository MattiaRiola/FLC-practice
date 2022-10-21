default: clean scanner parser compile

compile:
	javac *.java

scanner:
	jflex scanner.jflex
	
parser:
	java java_cup.Main -expect 1 -parser parser parser.cup
	
drawparser:
	java java_cup.MainDrawTree parser.cup

clean:

	rm -fr parser.java Yylex.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
	
init:
	mkdir source build
	
run:
	java Main test.txt

rundebug:
	java Main test.txt -debug
	
runtree:
	clean scanner drawparser compile run

new: default run

debug: clean scanner cupdebug compile rundebug

cupdebug:
	java java_cup.Main -dump_grammar -parser parser parser.cup 

