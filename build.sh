#!/bin/bash

nvidia-docker build -t holmech:kinetic-base -f Dockerfile.base .
nvidia-docker build -t holmech:kinetic-cuda -f Dockerfile.cuda .
nvidia-docker build -t holmech:kinetic-latest -f Dockerfile.kinetic .
