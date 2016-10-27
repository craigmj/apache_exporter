#!/bin/bash
set -e
export GOPATH=`pwd`
for l in "github.com/prometheus/client_golang/prometheus" \
	"github.com/prometheus/log" \
	; do
	if [[ ! -d src/$l ]]; then
		go get $l
	fi
done
if [[ ! -d bin ]]; then 
	mkdir -p bin	
fi
go build -o bin/apache_exporter src/cmd/apache_exporter.go