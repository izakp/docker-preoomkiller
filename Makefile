.PHONY: build

build:
	docker build -t artsy/docker-preoomkiller:python2 -f Dockerfile.python2 .
	docker build -t artsy/docker-preoomkiller:python3 -f Dockerfile.python3 .
