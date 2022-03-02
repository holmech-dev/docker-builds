#!/bin/bash

# process 1: start carla server
cd /opt/carla-simulator/bin
SDL_VIDEODRIVER=offscreen ./CarlaUE4.sh -opengl & \

# process 2: simulation settings
# see: https://carla.readthedocs.io/en/latest/start_quickstart/#running-carla
sleep 15 && cd /opt/carla-simulator/PythonAPI/util \
&& ./config.py \
	--weather HardRainNoon \
	--map Town03 & \

# process 3: start carla example
sleep 15 && export PYTHONPATH=$PYTHONPATH:${CARLA_ROOT}/PythonAPI/carla/dist/carla-0.9.9-py2.7-linux-x86_64.egg:${CARLA_ROOT}/PythonAPI/carla/ \
&& cd /opt/carla-simulator/PythonAPI/examples/ \
&& python manual_control.py --filter vehicle.nissan.micra & \

# process 4: pawn some life into the city
# see: https://carla.readthedocs.io/en/latest/start_quickstart/#running-carla
sleep 20 && export PYTHONPATH=$PYTHONPATH:${CARLA_ROOT}/PythonAPI/carla/dist/carla-0.9.9-py2.7-linux-x86_64.egg:${CARLA_ROOT}/PythonAPI/carla/ \
&& cd /opt/carla-simulator/PythonAPI/examples/ \
&& python spawn_npc.py

