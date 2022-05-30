#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Specify your machine's ip address (eg. 192.168.1.1)"
else
    sleep 5
    # Create .env with IP for docker compose
    echo "IP=$1" > .env
    sleep 5
    # Run mongo nodes in containers using docker-compose:
    sudo docker-compose -f sharded-mongo-compose.yaml up --build -d
fi
