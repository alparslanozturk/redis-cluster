#!/bin/bash 




docker-compose up 



docker exec redis1 bash -c 'apt update && apt install iproute2 procps netcat -y'
docker exec redis1 bash -c 'echo yes |redis-cli --cluster create   172.72.72.11:7001   172.72.72.12:7002   172.72.72.13:7003   172.72.72.14:7004   172.72.72.15:7005   172.72.72.16:7006   172.72.72.17:7007   172.72.72.18:7008   172.72.72.19:7009   --cluster-replicas 2'
