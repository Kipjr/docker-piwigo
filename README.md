# docker-piwigo
[![Deploy](https://github.com/Kipjr/docker-piwigo/actions/workflows/deploy.yml/badge.svg?event=workflow_dispatch)](https://github.com/Kipjr/docker-piwigo/actions/workflows/deploy.yml)
1. Run `./bin/create_env.sh` and edit .env if needed
2. `docker compose build`
3. `docker compose up -d`

## Result
#### Prebuilt docker images:

- PHP:
  - 8.x
- Piwigo: 
  - 13.x

#### Usage

- `docker pull ghcr.io/kipjr/docker-piwigo:php-apache-${VERSION_PHP}-${VERSION_PIWIGO}`
