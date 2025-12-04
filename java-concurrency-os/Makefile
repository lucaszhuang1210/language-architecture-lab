def: testOneThread

dist: all.tar clean
	chmod a+r all.tar

gen: gen.cpp
	g++ gen.cpp -o gen

all.tar: gen
	./gen
	tar cf all.tar Makefile MANIFEST.MF USER* *.java

clean:
	/bin/rm -f gen *.class OS.jar USER* altOS.jar PRINTER* all.tar

OS.jar: ConcurrencyOS.java
	javac ConcurrencyOS.java
	jar cmvf MANIFEST.MF OS.jar  *.class

testOneThread: OS.jar	all.tar
	java -jar OS.jar -1 -1 -1

testAllThreads: OS.jar	all.tar
	java -jar OS.jar -26 -2 -3

altOS.jar: ConcurrencyOS.java
	javac ConcurrencyOS.java
	jar cvf altOS.jar *.class

alttest: altOS.jar
	java -cp altOS.jar MainClass
