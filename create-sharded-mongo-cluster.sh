#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Specify your machine's ip address (eg. 192.168.1.1)"
else
  # Connect to config1 (config server):
  # Create configrs (config server replica set):
  sleep 5
  mongo mongodb://$1:50001 <<EOF
  rs.initiate(
    {
      _id: "configrs",
      configsvr: true,
      members: [
        { _id : 0, host : "$1:50001" },
        { _id : 1, host : "$1:50002" },
        { _id : 2, host : "$1:50003" }
      ]
    }
  )
  exit
EOF

  # Connect to shard1_1 (shard 1):
  # Create shard1rs replica set:
  sleep 5
  mongo mongodb://$1:50004 <<EOF
  rs.initiate(
    {
      _id: "shard1rs",
      members: [
        { _id : 0, host : "$1:50004" },
        { _id : 1, host : "$1:50005" },
        { _id : 2, host : "$1:50006" }
      ]
    }
  )
  exit
EOF

  # Connect to shard2_1 (shard 2):
  # Create shard1rs replica set:
  sleep 5
  mongo mongodb://$1:50007 <<EOF
  rs.initiate(
    {
      _id: "shard2rs",
      members: [
        { _id : 0, host : "$1:50007" },
        { _id : 1, host : "$1:50008" },
        { _id : 2, host : "$1:50009" }
      ]
    }
  )
  exit
EOF

  # Connect to mongos:
  # Add shards:
  sleep 10
  mongo mongodb://$1:50000 <<EOF
  sh.addShard("shard1rs/$1:50004,$1:50005,$1:50006")
  sh.addShard("shard2rs/$1:50007,$1:50008,$1:50009")
  exit
EOF

  # Import data:
  sleep 5
  mongoimport -h $1:50000 -d nosql -c zipcodes --file zipcodes.json

  # Connect to mongos again and split data:
  # Show results:
  sleep 5
  mongo mongodb://$1:50000 <<EOF
  use admin
  db.runCommand({enableSharding: "nosql"})

  use nosql
  db.zipcodes.createIndex({state: 1})
  sh.shardCollection("nosql.zipcodes", {"state": 1})
  sh.splitAt("nosql.zipcodes", {state: 'LA'})

  db.zipcodes.getShardDistribution()
  sh.status()
  exit
EOF
fi