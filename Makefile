NAME = lcidral/php
VERSION = 7.2.9-fpm-xdebug-alpine

.PHONY: all build push latest release

all: build

build:
	docker build -t $(NAME):$(VERSION) .

push:
	docker push $(NAME):$(VERSION)

release: latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)

latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest
