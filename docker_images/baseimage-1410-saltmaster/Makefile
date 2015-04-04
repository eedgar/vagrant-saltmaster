NAME = phusion/baseimage-1410-saltmaster
VERSION = 0.9.16

.PHONY: all build tag_latest 

all: tag_latest

build:
	docker build -t $(NAME):$(VERSION) --rm image

tag_latest: build
	docker tag -f $(NAME):$(VERSION) $(NAME):latest
