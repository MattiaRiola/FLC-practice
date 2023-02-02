default: scanner parser
	javac *.java

nick: 	scanner parserNick
	javac *.java

scanner:
	jflex scanner.flex

parser:
	java java_cup.Main -dump_grammar -parser parser parser.cup

parserNick:
	cup parser.cup

clean:
	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
