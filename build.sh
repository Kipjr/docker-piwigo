#!/bin/bash

set -eu

source=${1:-webdevops}
target=${2:-kipjr}
arch=$(uname -m)
root=$PWD

echo $source $target $arch

if [ -d ./base ]; then
  rm -rf ./base
  #cd src && git pull -f
#else
#  git clone https://github.com/$source/Dockerfile.git base
fi

git clone https://github.com/vslcatena/docker-web-base.git base


function ArchCheck () {
        if [[ "$arch" != 'x86_64' ]]; then
		echo replace amd64 with arm64
		sed "s/gosu-amd64/gosu-arm64/g" -i $1
		sed "s/gr-64-linux/gr-arm64-linux/g" -i $1
	else
		echo replace arm64 with amd64
		sed "s/gosu-arm64/gosu-amd64/g" -i $1
		sed "s/gr-arm64-linux/gr-64-linux/g" -i $1
	fi
}

#toolbox
cd $root
cd $root/base/docker/toolbox/latest && \
# $source/php:8.0-alpine
# sed "s@$source@${target}@g" -i Dockerfile && \

sed "s@$source\/toolbox@${target}\/toolbox@g" -i Dockerfile && \
ArchCheck Dockerfile
docker build  -f Dockerfile -t "${target}/toolbox" . | tee -a ./dockerbuild.log

#php alpine
cd $root
cd $root/base/docker/php/8.0-alpine && \
ArchCheck Dockerfile
# sed "s@$source@${target}@g" -i Dockerfile && \
sed "s@$source\/toolbox@${target}\/toolbox@g" -i Dockerfile && \
sed "s@$source\/php:8.0-alpine@${target}\/php:8.0-alpine@g" -i Dockerfile && \
sed "s@sockets@#sockets@g" -i Dockerfile && \
docker build  -f Dockerfile -t "${target}/php:8.0-alpine" . | tee -a ./dockerbuild.log

#php alpine apache
cd $root
cd $root/base/docker/php-apache/8.0-alpine && \
ArchCheck Dockerfile
# sed "s@$source@${target}@g" -i Dockerfile && \
sed "s@$source\/php-apache:8.0@${target}\/php-apache:8.0@g" -i Dockerfile && \
sed "s@$source\/php:8.0-alpine@${target}\/php:8.0-alpine@g" -i Dockerfile && \
docker build  -f Dockerfile -t "${target}/php-apache:8.0" . | tee -a ./dockerbuild.log

cd $root
#docker-compose up -d
