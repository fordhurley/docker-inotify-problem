PHONY: build run

build:
	docker build -t docker-inotify-problem .

run: build
	docker run --rm -v ${PWD}:/app -ti docker-inotify-problem
