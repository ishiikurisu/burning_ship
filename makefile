.PHONY: default
default: run

.PHONY: build
build:
	cargo build

.PHONY: run
run: build
	./target/debug/burning_ship
