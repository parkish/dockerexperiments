#!/bin/sh

set -ex

go vet $(go list ./... | grep -v /vendor/)
go test $(go list ./... | grep -v /vendor/)

# builds a completely static go binary
CGO_ENABLED=0 go build -ldflags "-s"
