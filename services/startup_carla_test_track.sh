#!/bin/bash

# process 1: start carla server
cd /home/chris/carla
SDL_VIDEODRIVER=offscreen ./CarlaUE4.sh -opengl & \

# process 2: simulation settings
# see: https://carla.readthedocs.io/en/latest/start_quickstart/#running-carla
#sleep 5 && cd /opt/carla-simulator/PythonAPI/util \
#&& ./config.py \
#	--weather HardRainNoon \

# process 3: start carla example
sleep 5 && export PYTHONPATH=$PYTHONPATH:${CARLA_ROOT}/PythonAPI/carla/dist/carla-0.9.9-py2.7-linux-x86_64.egg:${CARLA_ROOT}/PythonAPI/carla/ \
&& cd /opt/carla-simulator/PythonAPI/examples/ \
&& python manual_control.py --filter vehicle.nissan.leaf & \
#&& python manual_control.py --filter vehicle.nissan.micra & \

# process 4: pawn some life into the city
# see: https://carla.readthedocs.io/en/latest/start_quickstart/#running-carla
sleep 5 && export PYTHONPATH=$PYTHONPATH:${CARLA_ROOT}/PythonAPI/carla/dist/carla-0.9.9-py2.7-linux-x86_64.egg:${CARLA_ROOT}/PythonAPI/carla/ \
&& cd /opt/carla-simulator/PythonAPI/examples/ \
&& python spawn_npc.py