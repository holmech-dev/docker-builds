#!/bin/bash

# run PyCharm in docker with ROS env setup

# Assumes:
# you mapped host $HOME directory onto /home/hitachi
# and you installed pycharm into $HOME on your host (i.e. extracted files there)

export PYCHARM_DIR=`find /home/hitachi -maxdepth 1 -iname 'pycharm-*' -type d`
echo "PYCHARM_DIR=$PYCHARM_DIR"
export PYCHARM_PREFS_DIR=`find /home/hitachi/.config/JetBrains/ -maxdepth 1 -iname 'PyCharm*' -type d`
echo "PYCHARM_PREFS_DIR=$PYCHARM_PREFS_DIR"
PYCHARM_DIR_BASENAME=`basename $PYCHARM_DIR`
PYCHARM_PREFS_DIR_BASENAME=`basename $PYCHARM_PREFS_DIR`
echo $PYCHARM_PREFS_DIR_BASENAME
# CUDA location in docker (assuming your .profile do not set it up on the host)
export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export HOME=/home/hitachi
# source main ROS workspace -- always need it
echo "sourcing ROS workspace"
source /opt/ros/kinetic/setup.bash
# source our workspace so we can run ros python nodes in pycharm debug.
# caveat - if catkin_make have not been run yet, this will do nothing. and pycharm will have
# the right environment. in this case do catkin_make and restart pycharm
echo "sourcing had-sim ROS workspace"
source /home/hitachi/hitGit/had-sim/utils/env_setup.sh

# # make pycharm settings available in the container
# # Assumes you have already ran pycharm once outside container and entered registration details

echo "linking pycharm prefs directories"
mkdir -p /home/docker/.config/JetBrains
ln -s $PYCHARM_PREFS_DIR "/home/docker/.config/JetBrains/$PYCHARM_PREFS_DIR_BASENAME"
ln -s /home/hitachi/.java /home/docker/.java
$PYCHARM_DIR/bin/pycharm.sh
