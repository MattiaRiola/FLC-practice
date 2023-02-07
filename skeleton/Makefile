default: run

debug: rundebug

run_scanner: scanner_only

clean:
	rm -fr parser.java Yylex.java sym.java scanner.java
	rm -vfr *.class
	rm -vfr *.*~

scanner: clean
	jflex scanner.jflex
	
parser: scanner
	java java_cup.Main -parser parser parser.cup
	
compile: parser
	javac *.java
	
run: compile
	java Main test.txt

new: default run

cupdebug: scanner
	java java_cup.Main -dump_grammar -parser parser parser.cup 

compiledebug: cupdebug
	javac *.java

rundebug: compiledebug
	java Main test.txt -debug


compile_scanner_only: scanner
	echo "Substitute manually the %cup with %standalone configuration in jflex file"
	javac Yylex.java

scanner_only: compile_scanner_only
	java Yylex test.txt