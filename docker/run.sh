#!/bin/bash

#--env="SMLL_DIR=/home/hitachi/CARLA_waypoints_hack/" \

xhost +
nvidia-docker run -it --rm\
    --net=host \
    --env="uid=$UID" \
    --env="DISPLAY" \
    --env=TERM="xterm-color"\
    --env="QT_X11_NO_MITSHM=1" \
    --env="TestTrack_DIR=/home/chris/carla" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$HOME:/home/chris:rw"\
    --workdir="/home/chris/hitGit/had-sim/utils"\
    --name="carla-ros-container"\
    servcity2020/had_sim:latest $SHELL