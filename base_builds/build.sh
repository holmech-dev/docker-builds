#!/bin/bash

docker build -t holmec/noetic-base -f Dockerfile.base .
docker build -t holmec/noetic-externals_ws -f Dockerfile.externals_ws .
docker build -t holmec/noetic-latest -f Dockerfile.latest .