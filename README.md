# docker-piwigo
[![Deploy](https://github.com/Kipjr/docker-piwigo/actions/workflows/deploy.yml/badge.svg?event=workflow_dispatch)](https://github.com/Kipjr/docker-piwigo/actions/workflows/deploy.yml)
1. Execute `./bin/create_env.sh` and edit `.env` if needed
2. `docker compose up -d`

## Result

- Image based on linuxserver/docker-piwigo but with a completed setup:
  - Pre-initialized database
  - admin account

#### Prebuilt docker images:

- PHP:
  - 8.2+
- Piwigo: 
  - 14.4+

#### Usage

- `docker pull ghcr.io/kipjr/docker-piwigo:14.4.0`
