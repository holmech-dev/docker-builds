#!/bin/bash

# run Clion in docker with ROS env setup

# Assumes:
# you mapped host $HOME directory onto /home/hitachi
# and you installed clion into $HOME on your host (i.e. extracted files there)

export CLION_DIR=`find /home/hitachi -maxdepth 1 -iname 'clion-*' -type d`
echo "CLION_DIR=$PYCHARM_DIR"
export CLION_PREFS_DIR=`find /home/hitachi/.config/JetBrains/ -maxdepth 1 -iname 'CLion*' -type d`
echo "CLION_PREFS_DIR=$CLION_PREFS_DIR"
CLION_DIR_BASENAME=`basename $CLION_DIR`
CLION_PREFS_DIR_BASENAME=`basename $CLION_PREFS_DIR`
echo $CLION_PREFS_DIR_BASENAME
# CUDA location in docker (assuming your .profile do not set it up on the host)
export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export HOME=/home/hitachi
# source main ROS workspace -- always need it
echo "sourcing ROS workspace"
source /opt/ros/kinetic/setup.bash
# source our workspace so we can run ros python nodes in clion debug.
# caveat - if catkin_make have not been run yet, this will do nothing. and clion will have
# the right environment. in this case do catkin_make and restart clion
echo "sourcing had-sim ROS workspace"
source /home/hitachi/hitGit/had-sim/utils/env_setup.sh

# # make clion settings available in the container
# # Assumes you have already ran clion once outside container and entered registration details

echo "linking clion prefs directories"
mkdir -p /home/docker/.config/JetBrains
ln -s $CLION_PREFS_DIR "/home/docker/.config/JetBrains/$CLION_PREFS_DIR_BASENAME"
ln -s /home/hitachi/.java /home/docker/.java
$CLION_DIR/bin/clion.sh
