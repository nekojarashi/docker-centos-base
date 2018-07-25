# centos-base

```
$ docker run -d --name ac3agrtp -p 2222:22/tcp -p 8080:8080/tcp -v `pwd`:/rails --privileged ac3agrtp/centos7 /sbin/init
$ ssh-keygen -R [localhost]:2222 && ssh root@localhost -p 2222 -o StrictHostKeyChecking=no
```