#!/bin/bash

# source: https://github.com/carla-simulator/ros-bridge#for-developers

# clean all
./clean_cache.sh
rm -rf ../catkin_ws



# create catkin workspace with links
mkdir -p /home/hitachi/hitGit/had-sim/catkin_ws
cd /home/hitachi/hitGit/had-sim/catkin_ws
mkdir -p src
cd src
ln -s /home/hitachi/hitGit/had-sim/ext_repos/carla-ros-bridge
ln -s /home/hitachi/hitGit/had-sim/hit_ros_bridge
ln -s /home/hitachi/hitGit/had-sim/ext_repos/autoware
rm -rf carla-ros-bridge/carla_msgs
ln -s /home/hitachi/hitGit/had-sim/ext_repos/ros-carla-msgs carla-ros-bridge/carla_msgs

# build carla ros bridge
cd /home/hitachi/hitGit/had-sim/catkin_ws

# overlay on hit-plan workspace
HIT_PLAN_WS_DIR="/home/hitachi/hitGit/hit-plan/hit_plan_ws/devel"
if [ -d "$HIT_PLAN_WS_DIR" ]; then
  echo "Sourcing hit-plan..."
  source "${HIT_PLAN_WS_DIR}/setup.bash"
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Error: ${$HIT_PLAN_WS_DIR} not found. Cannot source hit-plan workspace."
  exit 1
fi

catkin_make -DCMAKE_BUILD_TYPE=Release