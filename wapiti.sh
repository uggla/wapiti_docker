#!/bin/sh

docker run --rm -ti -v $PWD/workdir:/workdir wapiti:3.0.0 $*
