#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Specify your machine's ip address [eg. sh create.sh 192.168.1.1]"
else
    sh create-containers.sh $1
    sh create-sharded-mongo-cluster.sh $1
fi