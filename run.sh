#!/bin/bash

xhost +

#docker run -it --rm --gpus all nvidia/cuda:11.0-base

# find current directory
#swd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

nvidia-docker run -it --rm\
    --net=host \
    --env="DISPLAY" \
    --env=TERM="xterm-color" \
    --env=HOME="/home/chris" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="$ROS_DATA_DIR:/ROS_DATA_DIR:rw"\
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$HOME:/home/chris:rw" \
    --workdir="/home/chris/holmech-dev/pedestrian_interaction/Pedestrian-Interactions-ws" \
    --name="Kinetic-latest-test_0" \
    --privileged=True \
    holmech:kinetic-latest