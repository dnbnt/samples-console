# makefile variables
IMAGE_NAME=dnbnt/samples-console
IMAGE_VERSION=1.0
IMAGE_FULLNAME=${IMAGE_NAME}:${IMAGE_VERSION}

.PHONY: help all

help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo "bash"
		@echo "go"
		@echo "java"
		@echo "net"
		@echo "powershell"
		@echo "python"
		@echo "build"
		@echo "test"
	    @echo "all"

.DEFAULT_GOAL := all

bash-build:
		@echo "\n===== docker build: bash"
		@docker build --no-cache --pull --build-arg BASE_IMAGE=alpine --build-arg BASE_VERSION=3.17.0 -t "${IMAGE_FULLNAME}-bash" ./bash

bash-test:
		@echo "\n===== test: bash"; \
		export ECHO="$(shell docker run --rm "${IMAGE_FULLNAME}-bash" -text "hello bash")"; \
		export RAND="$(shell docker run --rm "${IMAGE_FULLNAME}-bash" -mode random)"; \
		echo "echo: $$ECHO"; \
		echo "rand: $$RAND"

bash:	bash-build bash-test

go-build:
		@echo "\n===== docker build: go"
		@docker build --no-cache --pull --build-arg BASE_IMAGE=golang --build-arg BASE_VERSION=1.19.4-alpine3.17 -t "${IMAGE_FULLNAME}-go" ./go

go-test:
		@echo "\n===== test: go"; \
		export ECHO="$(shell docker run --rm "${IMAGE_FULLNAME}-go" -text "hello go")"; \
		export RAND="$(shell docker run --rm "${IMAGE_FULLNAME}-go" -mode random)"; \
		echo "echo: $$ECHO"; \
		echo "rand: $$RAND"

go: go-build go-test

java-build:
		@echo "\n===== docker build: java"
		@docker build --no-cache --pull -t "${IMAGE_FULLNAME}-java" ./java

java-test:
		@echo "\n===== test: java"; \
		export ECHO="$(shell docker run --rm "${IMAGE_FULLNAME}-java" -t="hello java")"; \
		export RAND="$(shell docker run --rm "${IMAGE_FULLNAME}-java" --mode=random)"; \
		echo "echo: $$ECHO"; \
		echo "rand: $$RAND"

java: java-build java-test

net-build:
		@echo "\n===== docker build: net"
		@docker build --no-cache --pull -t "${IMAGE_FULLNAME}-net" ./net

net-test:
		@echo "\n===== test: net"; \
		export ECHO="$(shell docker run --rm "${IMAGE_FULLNAME}-net" --text="hello .net")"; \
		export RAND="$(shell docker run --rm "${IMAGE_FULLNAME}-net" --mode=random)"; \
		echo "echo: $$ECHO"; \
		echo "rand: $$RAND"

net: net-build net-test

powershell-build:
		@echo "\n===== docker build: powershell"
		@docker build --no-cache --pull -t "${IMAGE_FULLNAME}-powershell" ./powershell

powershell-test:
		@echo "\n===== test: powershell"; \
		export ECHO="$(shell docker run --rm "${IMAGE_FULLNAME}-powershell" -text "hello powershell")"; \
		export RAND="$(shell docker run --rm "${IMAGE_FULLNAME}-powershell" -mode random)"; \
		echo "echo: $$ECHO"; \
		echo "rand: $$RAND"

powershell: powershell-build powershell-test

python-build:
		@echo "\n===== docker build: python"
		@docker build --no-cache --pull -t "${IMAGE_FULLNAME}-python" ./python

python-test:
		@echo "\n===== test: python"; \
		export ECHO="$(shell docker run --rm "${IMAGE_FULLNAME}-python" --text "hello python")"; \
		export RAND="$(shell docker run --rm "${IMAGE_FULLNAME}-python" --mode random)"; \
		echo "echo: $$ECHO"; \
		echo "rand: $$RAND"		

python: python-build python-test

build: bash-build go-build java-build net-build powershell-build python-build

test: bash-test go-test java-test net-test powershell-test python-test

all: build test