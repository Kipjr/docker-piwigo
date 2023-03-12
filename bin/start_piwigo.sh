#!/bin/bash
echo -e "\nRunning $0 in $PWD"
VERSION_PHP=${1-8.1}
VERSION_PIWIGO=${2-13.6}
NO_START=${3:-0}

if [[ $NO_START -eq 1 || $NO_START == 1 || $NO_START == "TRUE" ]]; then
   NO_START="TRUE"
else
   NO_START="FALSE"
fi

declare -x VERSION_PHP
declare -x VERSION_PIWIGO
ROOTPATH=$(realpath "$( dirname $0)/..")
cd $ROOTPATH

function GetRandom(){
    head -n 10 /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1
}

docker-compose down --volumes
/bin/rm $ROOTPATH/docker-compose.yml

###
### BUILD
###

# git config --get  remote.origin.url # https://github.com/kipjr/docker-piwigo or empty
if [ -z "$(git config --get remote.origin.url)" ]; then
    echo "Clone docker-piwigo"
    git clone https://github.com/Kipjr/docker-piwigo docker-piwigo
    REPOPATH="docker-piwigo"
else
    echo -e "Already in repo $(git config --get  remote.origin.url)\n"
    REPOPATH="."
fi


# check remote
if [ "$(docker image pull "ghcr.io/kipjr/docker-piwigo:php-apache-$VERSION_PHP-$VERSION_PIWIGO"  >/dev/null 2>&1)" ]; then
    # image remote found
    echo "Remote image pulled from ghcr.io/kipjr/docker-piwigo:php-apache-$VERSION_PHP-$VERSION_PIWIGO" 
else
    if [ "$(docker image ls ghcr.io/kipjr/docker-piwigo:php-apache-"$VERSION_PHP"-"$VERSION_PIWIGO" -q |wc -l)" == 0 ];then
    # no local image found
    echo "Building image: kipjr/docker-piwigo:php-apache-$VERSION_PHP-$VERSION_PIWIGO"
    ./build.sh "$VERSION_PHP" "$VERSION_PIWIGO"

    echo "Login to GitHub Container Registry"
    docker login ghcr.io

    echo "Push PHP image"
    docker push "ghcr.io/kipjr/docker-piwigo:php-apache-$VERSION_PHP"

    echo "Push PHP/Piwigo image"
    docker push "ghcr.io/kipjr/docker-piwigo:php-apache-$VERSION_PHP-$VERSION_PIWIGO"

    else
    # local image found
    echo "Found local image:"
    docker image ls "ghcr.io/kipjr/docker-piwigo:php-apache-$VERSION_PHP-$VERSION_PIWIGO"
    fi
fi



###
### Build Piwigo
###

if [ ! -f "$REPOPATH/docker-compose.yml" ]; then
    echo "Prepare docker-compose.yml"
    PASSWORD_DB_ROOT=$(GetRandom)
    PASSWORD_DB_PWG=$(GetRandom)
    PASSWORD_PIWIGO_ADMIN=$(GetRandom)

    declare -x PASSWORD_DB_ROOT
    declare -x PASSWORD_DB_PWG
    declare -x PASSWORD_PIWIGO_ADMIN

    envsubst < $REPOPATH/docker-compose.template > $REPOPATH/docker-compose.yml
    grep 'image: ghcr.io/kipjr/docker-piwigo:php-apache.*$' $REPOPATH/docker-compose.yml
    grep -Pe 'ports' -A1 "$REPOPATH/docker-compose.yml"   | sort -ru
fi


###
### Start
###

if [ $NO_START == "FALSE" ]; then
   echo -e "\nCreate container + volumes"
   docker-compose up --no-start

   echo -e "\nStart containers"
   cd $REPOPATH || return
   # docker-compose up -d --no-recreate
   docker-compose start
   cd "$ROOTPATH" || return
fi

echo -e "\nExiting $0\n"

