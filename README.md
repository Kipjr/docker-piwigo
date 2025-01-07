# docker-piwigo
[![Deploy](https://github.com/Kipjr/docker-piwigo/actions/workflows/deploy.yml/badge.svg?event=workflow_dispatch)](https://github.com/Kipjr/docker-piwigo/actions/workflows/deploy.yml)
1. Edit `.env`
2. `docker compose up -d`

## Result

- Image based on linuxserver/docker-piwigo but with a completed setup:
  - Pre-initialized database
  - admin account

#### Prebuilt docker images:

- PHP:
  - 8.2+
- Piwigo: 
  - 15.3+

#### Usage

- `docker pull ghcr.io/kipjr/docker-piwigo:15.3.0`
