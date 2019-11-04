.PHONY: build-python2 build-python3 build-all debug-python2 debug-python3 test-python2 test-python3 test-all

build-python2:
	docker build -t artsy/docker-preoomkiller:python2 -f Dockerfile.python2 .

build-python3:
	docker build -t artsy/docker-preoomkiller:python3 -f Dockerfile.python3 .

build-all:
	$(MAKE) build-python2
	$(MAKE) build-python3

debug-python2:
	docker run --name=preoomkiller_python2 -e PREOOMKILLER_DEBUG=1 --memory=64m --rm artsy/docker-preoomkiller:python2

debug-python3:
	docker run --name=preoomkiller_python3 -e PREOOMKILLER_DEBUG=1 --memory=64m --rm artsy/docker-preoomkiller:python3

test-python2:
	docker build -t artsy/docker-preoomkiller:python2-test -f Dockerfile.python2-test .
	docker run --name=preoomkiller_test_python2 --memory=64m artsy/docker-preoomkiller:python2-test || true
	bash ./test/test.sh preoomkiller_test_python2

test-python3:
	docker build -t artsy/docker-preoomkiller:python3-test -f Dockerfile.python3-test .
	docker run --name=preoomkiller_test_python3 --memory=64m artsy/docker-preoomkiller:python3-test || true
	bash ./test/test.sh preoomkiller_test_python3

test-all:
	$(MAKE) test-python2
	$(MAKE) test-python3
