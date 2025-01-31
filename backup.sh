#!/bin/bash
#
#####################################################################
### Please set the paths accordingly. In case you don't have all  ###
### the listed folders, just keep that line commented out.        ###
#####################################################################
### Path to your config folder you want to backup
#this has been recently updated to /home/pi/printer_data/config 
#please check your config folder path and update it below
config_folder=/home/pi/printer_data/config
#
### Path to your Klipper folder, by default that is '~/klipper'
klipper_folder=/home/pi/klipper
#
### Path to your Moonraker folder, by default that is '~/moonraker'
moonraker_folder=/home/pi/moonraker
#
### Path to your Mainsail folder, by default that is '~/mainsail'
#mainsail_folder=/home/pi/mainsail
#
### Path to your Fluidd folder, by default that is '~/fluidd'
fluidd_folder=~/fluidd
#
#####################################################################
#####################################################################
#
#
#####################################################################
################ !!! DO NOT EDIT BELOW THIS LINE !!! ################
#####################################################################
grab_version(){
  if [ ! -z "$klipper_folder" ]; then
    echo -n "Getting klipper version="
    cd "$klipper_folder"
    klipper_commit=$(git rev-parse --short=7 HEAD)
    m1="Klipper on commit: $klipper_commit"
    echo $klipper_commit
    cd ..
  fi
  if [ ! -z "$moonraker_folder" ]; then
    echo -n "Getting moonraker version="
    cd "$moonraker_folder"
    moonraker_commit=$(git rev-parse --short=7 HEAD)
    m2="Moonraker on commit: $moonraker_commit"
    echo $moonraker_commit
    cd ..
  fi
  if [ ! -z "$mainsail_folder" ]; then
    echo -n "Getting mainsail version="
    mainsail_ver=$(head -n 1 $mainsail_folder/.version)
    m3="Mainsail version: $mainsail_ver"
    echo $mainsail_ver
  fi
  if [ ! -z "$fluidd_folder" ]; then
    echo -n "Getting fluidd version="
    fluidd_ver=$(head -n 1 $fluidd_folder/.version)
    m4="Fluidd version: $fluidd_ver"
    echo $fluidd_ver
  fi
}

push_config(){
  cd $config_folder
  echo Pushing updates
  sleep 1
  git pull -v
  sleep 1
  git add . -v
  sleep 1
  current_date=$(date +"%Y-%m-%d %T")
  git commit -m "Backup triggered on $current_date" -m "$m1" -m "$m2" -m "$m3" -m "$m4"
  git push
}

sleep 1
grab_version
sleep 1
push_config
