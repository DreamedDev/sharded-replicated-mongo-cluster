#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Specify your machine's ip address (eg. 192.168.1.1)"
else
    # Create .env with IP for docker compose
    echo "IP=$1" > .env
    # Run mongo nodes in containers using docker-compose:
    docker-compose -f sharded-mongo-compose.yaml up --build -d
fi
