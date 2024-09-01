default: build

test: 
	go test ./...

build: 
	mkdir -p dist
	go build -v -o dist/aircraft-lookup

# example make run $ARGS="-addr="sub.domain.com"
run: 
	go run ./... $(ARGS)

clean:
	rm -rf dist/
