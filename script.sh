#!/bin/bash

reset_to_initial () {
  rm -rf go{1,2,3}/{bin,lib} 2>/dev/null || :
  rm -rf go{1,2,3}/src/github.com 2>/dev/null || :
  mv go1/src/_hello go1/src/hello 2>/dev/null || :
  mv go2/src/_hello go2/src/hello 2>/dev/null || :
}

run_all_greeters () {
  go run go1/src/greeter/main.go
  go run go2/src/greeter/main.go
  go run go3/src/greeter/main.go
}

reset_to_initial
export GOPATH=`pwd`/go1:`pwd`/go2:`pwd`/go3

echo
echo go getting from github:
go get github.com/deis/helloworld
find . | grep helloworld | head -1

echo
echo running all greeters:
run_all_greeters

echo
echo without first gopath:
mv go1/src/hello go1/src/_hello
run_all_greeters

echo
echo without second gopath:
mv go2/src/hello go2/src/_hello
run_all_greeters
