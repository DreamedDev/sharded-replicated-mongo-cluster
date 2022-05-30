#!/bin/bash

docker-compose -f sharded-mongo-compose.yaml down
docker volume rm sharded-mongo_config1 sharded-mongo_config2 sharded-mongo_config3 sharded-mongo_shard1_1 sharded-mongo_shard1_2 sharded-mongo_shard1_3 sharded-mongo_shard2_1 sharded-mongo_shard2_2 sharded-mongo_shard2_3
