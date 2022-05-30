#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Specify your machine's ip address (eg. 192.168.1.1)"
else
    # Show results:
    sleep 3
    mongo mongodb://$1:50000 <<EOF
    use nosql
    db.zipcodes.getShardDistribution()
    sh.status()
    exit
EOF
fi
