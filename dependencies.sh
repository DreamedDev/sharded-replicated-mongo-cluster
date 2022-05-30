#!/bin/bash

echo -n "Do you want to install dependensied? [y/n] "
read answer
if [ $answer == "y" ]; then
  echo -n "Do you want to update apt package manager? [y/n] "
  read answer
  if [ $answer == "y" ]; then
    sudo apt-get update
  fi
  echo -n "Do you want to install docker ? [y/n] "
  read answer
  if [ $answer == "y" ]; then
    sudo apt install docker.io -y
  fi
  echo -n "Do you want to install docker-compose? [y/n] "
  read answer
  if [ $answer == "y" ]; then
    sudo apt install docker-compose -y
  fi
  echo -n "Do you want to install mongodb? [y/n] "
  read answer
  if [ $answer == "y" ]; then
    sudo apt install mongodb -y
  fi
fi