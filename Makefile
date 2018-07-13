GOOS?=linux
GOARCH?=amd64
BINARY?=dist
OUTPUT?=main

.PHONY: all clean

all: package publish clean

package: test build

test:
	go test -cover -race ./...

build:
	GOOS=${GOOS} GOARCH=${GOARCH} go build -o ${BINARY}/${OUTPUT} .
	docker build -t softleader/gpm .

publish:
	docker push softleader/gpm

clean:
	rm -rf ${BINARY}/