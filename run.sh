#!/bin/bash


cat > redis.conf <<EOF
bind 0.0.0.0
port 6379
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
dir /data
appendonly no
appendfsync no
protected-mode no
save ""
cluster-announce-ip 192.168.111.111
EOF



### delete
for i in {9..1}; do docker rm --force redis$i; done
docker network rm redis
rm -rf 700?/


### create
docker network create --subnet 172.72.72.0/24 redis 
for i in {9..1} 
do
 port=700$i
 mkdir $port
 cp redis.conf $port/redis.conf
 sed -i "s/6379/$port/g" $port/redis.conf
if [ $i == 1 ]; then 
 docker run -d --rm --name redis$i -h redis$i \
 --network redis --ip 172.72.72.1$i \
 -p 6379:$port \
 -p $port:$port \
 -p 1$port:1$port \
 -v $(pwd)/$port:/data \
 redis redis-server /data/redis.conf
else
 docker run -d --rm --name redis$i -h redis$i \
 --network redis --ip 172.72.72.1$i \
 -p $port:$port \
 -p 1$port:1$port \
 -v $(pwd)/$port:/data \
 redis redis-server /data/redis.conf
fi 
done

docker exec redis1 bash -c 'apt update && apt install iproute2 procps netcat -y' 
docker exec redis1 bash -c 'echo yes |redis-cli --cluster create   172.72.72.11:7001   172.72.72.12:7002   172.72.72.13:7003   172.72.72.14:7004   172.72.72.15:7005   172.72.72.16:7006   172.72.72.17:7007   172.72.72.18:7008   172.72.72.19:7009   --cluster-replicas 2'
