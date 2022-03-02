#!/bin/bash

# setup ros enviroment
source /home/hitachi/hitGit/had-sim/catkin_ws/devel/setup.bash
export PYTHONPATH=$PYTHONPATH:${CARLA_ROOT}/PythonAPI/carla/dist/carla-0.9.11-py2.7-linux-x86_64.egg:${CARLA_ROOT}/PythonAPI/carla/:${SCENARIO_RUNNER_PATH}:/home/hitachi/hitGit/had-sim/ext_repos/carla-ros-bridge/carla_ros_bridge/src/carla_ros_bridge/