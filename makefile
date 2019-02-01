all: makepic.o
	ld makepic.o -o makepic -lc

makepic.o: makepic.S
	gcc -c makepic.S -g


