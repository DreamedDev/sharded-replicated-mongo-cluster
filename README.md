# Sharded replicated mongo cluster

The above project presents how to automate mongo cluster building with nodes replication and collection sharding. Example sharded collection is zipcodes placed in this repository. Scripts split zipcodes into 2 shards:
1. AL to LA
2. Other

### How it works:
1. Sharded-mongo.txt file contains all commands for mannual cluster build.
2. All nodes are running as docker containers defined in sharded-mongo-compose.yaml file.
3. A few result output information you can read in results.txt file. The most important lines are:
```shell
        chunks: 
           [ { min: { state: MinKey() },
               max: { state: 'LA' },
               'on shard': 'shard2rs',
               'last modified': Timestamp({ t: 2, i: 0 }) },
             { min: { state: 'LA' },
               max: { state: MaxKey() },
               'on shard': 'shard1rs',
               'last modified': Timestamp({ t: 2, i: 1 }) } ],
          tags: [] } } } ]
```
4. Automated cluster building script uses installed docker and docker-compose.
5. To build this cluster just use command *create.sh \<ip device\>*

The script creates cluster with following params:
- Config server: replica set (3 nodes) ports: 50001, 50002, 50003
- Shard 1: replica set (3 nodes) ports: 50004, 50005, 50006
- Shard 2: replica set (3 nodes) ports: 50007, 50008, 50009
- Mongos: (1 node) port: 50000

6. To completely remove the cluster created using the *create.sh \<ipdevice\>* script run the delete.sh command. The command deletes all 10 nodes with data volumes allocated to them so if you need these data volumes be careful and make the copy of them.

#### For more information about nodes check sharded-mongo-compose.yaml