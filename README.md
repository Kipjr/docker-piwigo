# docker-piwigo
[![Deploy](https://github.com/Kipjr/docker-piwigo/actions/workflows/deploy.yml/badge.svg?event=workflow_dispatch)](https://github.com/Kipjr/docker-piwigo/actions/workflows/deploy.yml)
1. Run build.sh
2. Set env variables
3. `envsubst < docker-compose.template > docker-compose.yml`
4. `docker-compose up -d`

## Result
#### Prebuilt docker images:

- PHP:
  - 8.1
  - 8.2
- Piwigo: 
  - 13.6

#### Usage

- Without Piwigo, omit the `-$VERSION_PIWIGO`

- `docker pull ghcr.io/kipjr/docker-piwigo:php-apache-$VERSION_PHP-$VERSION_PIWIGO`
