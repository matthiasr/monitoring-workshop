#!/bin/sh

echo "----- Docker Version Information ------"
docker version
if [ $? -ne 0 ]
then
  cat <<EOF
---------------------------------------
Ooops! There seems to be an issue with your Docker installation.

If you do not have Docker yet, please install it:
    https://www.docker.com/products/docker

If you have Docker installed, please make sure it is running.
EOF
  exit 1
fi
echo "----- Docker Compose Information ------"
docker-compose version
if [ $? -ne 0 ]
then
  cat <<EOF
---------------------------------------
Ooops! There seems to be an issue with your Docker Compose installation.

If you do not have Docker Compose yet, please install it:
    https://docs.docker.com/compose/
EOF
  exit 1
fi
echo '---------------------------------------'

for image in golang:1.6-onbuild prom/prometheus:0.20.0 prom/alertmanager:0.2.1 prom/blackbox-exporter:master google/cadvisor:v0.23.2 grafana/grafana:3.0.4
do
  docker pull "${image}"
done

docker-compose build
