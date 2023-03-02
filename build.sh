#!/bin/bash

set -eu

source=${1:-webdevops}
target=${2:-kipjr}
version=${3:-8.1}
pwgversion=${4:-13.6}
arch=$(uname -m)
root=$PWD

echo "$source $target $arch"

#if [ -d ./base ]; then
 # rm -rf ./base
  #cd src && git pull -f
#else
#  git clone https://github.com/$source/Dockerfile.git base
#fi

git clone https://github.com/vslcatena/docker-web-base.git base


function ArchCheck () {
        if [[ "$arch" != 'x86_64' ]]; then
		echo replace amd64 with arm64
		sed "s/gosu-amd64/gosu-arm64/g" -i "$1"
		sed "s/gr-64-linux/gr-arm64-linux/g" -i "$1"
	else
		echo replace arm64 with amd64
		sed "s/gosu-arm64/gosu-amd64/g" -i "$1"
		sed "s/gr-arm64-linux/gr-64-linux/g" -i "$1"
	fi
}

#toolbox
cd "$root"
cd "$root"/base/docker/toolbox/latest && \
# $source/php:${version}-alpine
# sed "s@$source@${target}@g" -i Dockerfile && \

sed "s@$source\/toolbox@${target}\/toolbox@g" -i Dockerfile && \
ArchCheck Dockerfile
docker build  -f Dockerfile -t "${target}/toolbox" . | tee -a $root/dockerbuild.log

#php alpine
cd "$root"
cd "$root"/base/docker/php/${version}-alpine && \
ArchCheck Dockerfile
# sed "s@$source@${target}@g" -i Dockerfile && \
sed "s@$source\/toolbox@${target}\/toolbox@g" -i Dockerfile && \
sed "s@$source\/php:${version}-alpine@${target}\/php:${version}-alpine@g" -i Dockerfile && \
sed "s@sockets@#sockets@g" -i Dockerfile && \
docker build  -f Dockerfile -t "${target}/php:${version}-alpine" . | tee -a $root/dockerbuild.log

#php alpine apache
cd "$root"
cd "$root"/base/docker/php-apache/${version}-alpine && \
ArchCheck Dockerfile
# sed "s@$source@${target}@g" -i Dockerfile && \
sed "s@$source\/php-apache:${version}@${target}\/php-apache:${version}@g" -i Dockerfile && \
sed "s@$source\/php:${version}-alpine@${target}\/php:${version}-alpine@g" -i Dockerfile && \
docker build  -f Dockerfile -t "${target}/php-apache:${version}" . | tee -a $root/dockerbuild.log

# base php-apache image
cd "$root"/src
# rename to follow naming convention
docker tag ${target}/php-apache:${version} ghcr.io/${target}/docker-piwigo:php-apache-${version}

## build image with piwigo inside
docker build -f Dockerfile --build-arg phpversion=${version} -t "ghcr.io/${target}/docker-piwigo:php-apache-${version}-${pwgversion}" . | tee -a $root/dockerbuild.log

######
#
# Update Github package
#
######
# docker login -u <username> -p {[token](https://github.com/settings/tokens)} ghcr.io
# docker push ghcr.io/${target}/docker-piwigo:php-apache-${version}
# docker push ghcr.io/${target}/docker-piwigo:php-apache-${version}-${pwgversion}
#

