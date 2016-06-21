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
echo '---------------------------------------'

for image in golang:1.6-onbuild prom/prometheus prom/alertmanager google/cadvisor grafana/grafana
do
  docker pull "${image}"
done
