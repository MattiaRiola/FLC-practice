default: run

clean: 
	rm -fr FileSystem.java
	rm -vfr *.class
	rm -vfr *.*~

scanner: clean
	jflex filesystem.jflex

compile: scanner
	javac *.java

run: compile
	java FileSystem example.txt
