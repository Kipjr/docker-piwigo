# syntax=docker/dockerfile:1
FROM lscr.io/linuxserver/piwigo:${VERSION_PIWIGO:-13.8.0}
# set version label
LABEL org.opencontainers.image.description Image for Piwigo Photoalbum software

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    php83-phar \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

# copy local files
COPY root/ /
