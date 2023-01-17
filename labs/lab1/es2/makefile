default: run

clean: 
	rm -fr Url.java
	rm -vfr *.class
	rm -vfr *.*~

scanner: clean
	jflex Url.jflex

compile: scanner
	javac *.java

run: compile
	java Url example.txt
