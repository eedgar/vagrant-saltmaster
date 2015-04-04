NAME = phusion/baseimage-1410-salt
VERSION = 0.9.16

.PHONY: all build test tag_latest release ssh

all: tag_latest

build:
	docker build -t $(NAME):$(VERSION) --rm image

tag_latest: build
	docker tag -f $(NAME):$(VERSION) $(NAME):latest
