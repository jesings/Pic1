all: fine.o
	gcc fine.o -o fine
run: all
	convert image.ppm image.png
fine.o: fine.c
	gcc -c fine.c



