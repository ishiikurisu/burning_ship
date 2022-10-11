.PHONY: default
default: run

.PHONY: build
build:
	gcc src/main.c -Wall -O3 -o main.exe

.PHONY: run
run: build
	./main.exe > burning_ship.ppm
	convert burning_ship.ppm burning_ship.png
	rm burning_ship.ppm

