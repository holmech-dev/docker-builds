#!/bin/bash
xhost +
docker exec -it --env="uid=$UID" --user="docker" carla-ros-container $SHELL