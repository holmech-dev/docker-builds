#!/bin/sh

if [ $TestTrack_DIR ]
then
  echo "TestTrack Directory is set: " $TestTrack_DIR

  sudo rm /opt/carla-simulator/PythonAPI/carla/agents/navigation/global_route_planner.py
  sudo cp $TestTrack_DIR/global_route_planner.py /opt/carla-simulator/PythonAPI/carla/agents/navigation/global_route_planner.py

  sudo rm /opt/carla-simulator/PythonAPI/carla/agents/navigation/global_route_planner_dao.py
  sudo cp $TestTrack_DIR/global_route_planner_dao.py /opt/carla-simulator/PythonAPI/carla/agents/navigation/global_route_planner_dao.py

  sudo rm /opt/carla-simulator/PythonAPI/carla/dist/*
  #cp $TestTrack_DIR/carla-0.9.9-py2.7-linux-x86_64.egg /opt/carla-simulator/PythonAPI/carla/dist/carla-0.9.9-py2.7-linux-x86_64.egg
  #cp $TestTrack_DIR/carla-0.9.9-py3.6-linux-x86_64.egg /opt/carla-simulator/PythonAPI/carla/dist/carla-0.9.9-py3.6-linux-x86_64.egg
  sudo cp $TestTrack_DIR/carla-0.9.11-py2.7-linux-x86_64.egg /opt/carla-simulator/PythonAPI/carla/dist/carla-0.9.11-py2.7-linux-x86_64.egg
  sudo cp $TestTrack_DIR/carla-0.9.11-py3.6-linux-x86_64.egg /opt/carla-simulator/PythonAPI/carla/dist/carla-0.9.11-py3.6-linux-x86_64.egg


  if [ -e ../TestTrack ]
  then
    rm -r ../TestTrack
  fi

  ln -s $TestTrack_DIR ../TestTrack

  echo "SUCCESSFULLY SETUP TestTrack ENVIRONMENT"
else

  echo "ERROR: Set TestTrack Directory using TestTrack_DIR environment variable"
fi



