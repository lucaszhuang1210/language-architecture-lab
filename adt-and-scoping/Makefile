main: vectest.cpp vector.h
	g++ vectest.cpp -o vectest

run: vectest
	./vectest

test: vectest
	valgrind --tool=memcheck --leak-check=yes --show-reachable=yes --track-origins=yes ./vectest

clean:
	rm vectest