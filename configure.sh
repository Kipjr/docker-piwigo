#!/bin/bash

set -eu

###
### Prepare docker-compose.yml
###

envsubst < docker-compose.template > docker-compose.yml


