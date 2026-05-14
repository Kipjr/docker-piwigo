# syntax=docker/dockerfile:1

ARG PIWIGO_VERSION="16.4.0"
FROM ghcr.io/piwigo/piwigo:${PIWIGO_VERSION}

ARG PIWIGO_VERSION
ARG PHP_VERSION="84"

# set version label
LABEL org.opencontainers.image.description Image for Piwigo Photoalbum software

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    php${PHP_VERSION}-phar && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

# copy local files
COPY root/ /
