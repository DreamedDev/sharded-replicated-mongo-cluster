#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Specify your machine's ip address [eg. sh create.sh 192.168.1.1]"
else
    ./dependencies.sh
    ./create-containers.sh $1
    ./create-sharded-mongo-cluster.sh $1
fi