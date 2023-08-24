#!/bin/bash
ROOTPATH=$(realpath "$( dirname $0)/..")
cd $ROOTPATH

function GetRandom(){
    head -n 10 /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1
}

cat << EOF > ${ROOTPATH}/.env
DB_PASSWORD=$(GetRandom)
DB_ROOT_PASSWORD=$(GetRandom)
PWG_ADMIN_USERNAME=admin
PWG_ADMIN_PASSWORD=$(GetRandom)
VERSION_PHP=8.2
VERSION_PIWIGO=13.8.0
EOF
