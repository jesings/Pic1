all: makepic.o byte2str.o
	ld makepic.o byte2str.o -o makepic
makepic.o: makepic.S
	gcc -c makepic.S -g
byte2str.o: utils/byte2str.S
	gcc -c utils/byte2str.S -g
run: all
	./makepic
	convert image.ppm image.png
	rm image.ppm



