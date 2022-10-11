.PHONY: default
default: run

.PHONY: build
build:
	cargo build --release

.PHONY: run
run: build
	./target/release/burning_ship > burning_ship.ppm
	convert burning_ship.ppm burning_ship.png
	rm burning_ship.ppm

burning_ship.png: run
