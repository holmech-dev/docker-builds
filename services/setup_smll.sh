#!/bin/sh

if [ $SMLL_DIR ]
then
  echo "SMLL Directory is set: " $SMLL_DIR

  rm /opt/carla-simulator/PythonAPI/carla/agents/navigation/global_route_planner.py
  cp $SMLL_DIR/global_route_planner.py /opt/carla-simulator/PythonAPI/carla/agents/navigation/global_route_planner.py

  rm /opt/carla-simulator/PythonAPI/carla/agents/navigation/global_route_planner_dao.py
  cp $SMLL_DIR/global_route_planner_dao.py /opt/carla-simulator/PythonAPI/carla/agents/navigation/global_route_planner_dao.py

  rm /opt/carla-simulator/PythonAPI/carla/dist/*
  cp $SMLL_DIR/carla-0.9.9-py2.7-linux-x86_64.egg /opt/carla-simulator/PythonAPI/carla/dist/carla-0.9.9-py2.7-linux-x86_64.egg
  cp $SMLL_DIR/carla-0.9.9-py3.6-linux-x86_64.egg /opt/carla-simulator/PythonAPI/carla/dist/carla-0.9.9-py3.6-linux-x86_64.egg

  if [ -e ../smll ]
  then
    rm -r ../smll
  fi

  ln -s $SMLL_DIR ../smll

  echo "SUCCESSFULLY SETUP SMLL ENVIRONMENT"
else

  echo "ERROR: Set SMLL Directory using SMLL_DIR environment variable"
fi



