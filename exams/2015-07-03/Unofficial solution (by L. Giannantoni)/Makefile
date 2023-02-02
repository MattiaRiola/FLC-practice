default: scanner parser
	javac *.java

scanner:
	jflex scanner.jflex

parser:
	java java_cup.MainDrawTree -expect 0 -parser parser parser.cup
	#java java_cup.Main -expect 0 -parser parser parser.cup

clean:
	rm -f parser.java scanner.java sym.java
	rm -f *.class
	rm -f *.*~

