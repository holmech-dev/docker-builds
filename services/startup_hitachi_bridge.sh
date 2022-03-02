#!/bin/bash

countdown()
{
        local OLD_IFS="${IFS}"
        IFS=":"
        local ARR=( $1 )
        local SECONDS=$((  (ARR[0] * 60 * 60) + (ARR[1] * 60) + ARR[2]  ))
        local START=$(date +%s)
        local END=$((START + SECONDS))
        local CUR=$START

        while [[ $CUR -lt $END ]]
        do
                CUR=$(date +%s)
                LEFT=$((END-CUR))

                printf "\r%02d:%02d:%02d" \
                        $((LEFT/3600)) $(( (LEFT/60)%60)) $((LEFT%60))

                sleep 1
        done
        IFS="${OLD_IFS}"
        echo "        "
}

terminator()
{
    # kill all processes
    (for pid in $(ps -ax | awk '{print  $  1 }' | grep -i '[0-9]'); do
        declare process_name1=$(ps aux | awk '$2 == '$pid'  { print $11 }')
        declare process_name2=$(ps aux | awk '$2 == '$pid'  { print $12 }')
        if  [ "$process_name1" == "/bin/bash" ] && [ ${#process_name2} > 0 ]
        then
            rm -rf 0
            continue
        fi
            kill -9 $pid
    done)
}

usage()
{
    echo "Usage:"
    echo "startup_hitachi_bridge [options]"
    echo "Options:"
    echo "-h, --help         Show help."
    echo "--smll             Run smll map."
    echo "--scenarios        Run batch scenarios."
    echo "--town             Select town."
}


town="Town01"

while [ "$1" != "" ]; do
    case $1 in
        --town )        shift
                        town=$1
                        ;;
        --smll )        smll=True
                        ;;
        --scenarios )   scenarios=True
                        ;;
        -h | --help )   usage
                        exit
                        ;;
        * )             usage
                        exit 1
    esac
    shift
done


if [ $smll ]; then
  echo "STARTUP SMLL MAP..."

  # process 1: start carla server
  ./smll_standalone.sh & \

  # process 2: start carla example
  sleep 10 && source env_setup.sh \
  && roslaunch hit_carla_ad_servcity hit_carla_ad_servcity_with_rviz.launch hitachi_bridge:=True town:=ServCity_RR2

else

  if [ $scenarios ]; then 

    # directory with all scenarios that we want to run
    scenario_path='/home/hitachi/hitGit/had-sim/hit_ros_bridge/hit_carla_scenarios/hit-scenarios/'
    cd ${scenario_path%%/}/scenarios/pending

    # loop through each scenario
    for i in *.xosc; do

        echo ''
        echo "Starting scenario: $i"
        echo ''

        # move to main run directory
        mv $i ${scenario_path%%/}/scenarios

        cd /home/hitachi/hitGit/had-sim/utils
        # process 1: start carla server
        ./carla_standalone.sh & \

        # process 2: start carla example with batch scenarios
        sleep 10 && source env_setup.sh
        roslaunch hit_carla_ad_servcity hit_carla_ad_servcity_with_rviz.launch hitachi_bridge:=True town:=$town \
        & sleep 15 && roslaunch hit_carla_scenarios batch_scenario_runner.launch &&\

        # kill all processes
        terminator

        # move scenario to completed folder
        cd ${scenario_path%%/}/scenarios
        mv $i ${scenario_path%%/}/scenarios/completed

        # go back to folder with pending scenarios
        cd ${scenario_path%%/}/scenarios/pending

        # wait for 2 mins for the pc to cool down
        echo ''
        echo 'Please wait for the PC to cool down, will continue in:'
        countdown "00:02:00"

    done

  else
    # process 2: start carla example
    sleep 10 && source env_setup.sh \
    && roslaunch hit_carla_ad_servcity hit_carla_ad_servcity_with_rviz.launch hitachi_bridge:=True town:=$town
  fi


fi

pkill CarlaUE4 && sleep 0.5 && pkill CarlaUE4

