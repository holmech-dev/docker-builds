#!/bin/bash

xhost +

#docker run -it --rm --gpus all nvidia/cuda:11.0-base

# find current directory
#swd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

docker run -it --rm\
    --runtime=nvidia \
    --gpus all \
    --net=host \
    --env="DISPLAY" \
    --env=TERM="xterm-color" \
    --env=HOME="/home" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --workdir="/home/projects/" \
    --name="noetic-latest-test_0" \
    --privileged=True \
    holmec/noetic-base