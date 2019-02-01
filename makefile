all: makepic.o
	ld makepic.o -o makepic
makepic.o: makepic.S
	gcc -c makepic.S -g
run: all
	convert image.ppm image.png
fine.o: fine.c
	gcc -c fine.c



