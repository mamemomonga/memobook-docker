#!/bin/bash
set -xe

IMAGE_NAME=work2
CONTAINER_NAME=work2_1
LOCAL_PORT=2222

# docker build -t $IMAGE_NAME .
docker run -d --name $CONTAINER_NAME -p $LOCAL_PORT:22 $IMAGE_NAME
cat ~/.ssh/id_rsa.pub | docker exec -i $CONTAINER_NAME sh -c 'cat >> /root/.ssh/authorized_keys'
exec ssh -p 2222 root@localhost

