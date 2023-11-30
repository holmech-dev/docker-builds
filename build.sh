#!/bin/bash

#nvidia-docker build -t holmec/kinetic-base -f Dockerfile.base .
#nvidia-docker build -t holmec/kinetic-cuda -f Dockerfile.cuda .
nvidia-docker build -t holmec/kinetic-latest -f Dockerfile.kinetic .
