all: makepic.o
	ld makepic.o -o makepic
makepic.o: makepic.S
	gcc -c makepic.S -g
run: all
	./makepic
	convert image.ppm image.png
	rm image.ppm
fine.o: fine.c
	gcc -c fine.c



