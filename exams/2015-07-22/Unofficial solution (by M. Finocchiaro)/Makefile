default: scanner parser

	javac *.java

scanner:
	jflex scanner.jflex
	
parser:
	java java_cup.Main -expect 2 -parser parser parser.cup
	
clean:

	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
	
init:
	mkdir source build
	
run:
	java Main exam_20150722.txt

new: default run
