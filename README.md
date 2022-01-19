# redis-cluster

This bash script create a redis cluster with 9 docker container. 

My host ip address is 192.168.111.111

So you should change the ip address with ip address of your host.

accessing cluster;

redis-cli -c -h 192.168.111.111

( then 6379 port changed automaticaly 7001-7009 ) 


you should see like this for list all keys in cluster.

```
redis-cli --cluster call 192.168.111.111:6379 keys "*"
>>> Calling keys *
192.168.111.111:6379: b
192.168.111.111:7003: a
192.168.111.111:7004: a
192.168.111.111:7002:
192.168.111.111:7007:
192.168.111.111:7005: b
192.168.111.111:7008:
192.168.111.111:7009: a
192.168.111.111:7006: b
```

![image](https://user-images.githubusercontent.com/9527118/150087632-228b113d-9a62-4341-992a-3a5170e5c2d5.png)


