ARG phpversion
FROM ghcr.io/kipjr/docker-piwigo:php-apache-${phpversion}
RUN wget https://piwigo.org/download/dlcounter.php?code=latest -O /tmp/piwigo.zip && unzip -o /tmp/piwigo.zip  -d /app/
COPY 99-pwg_initdb.conf /opt/docker/etc/supervisor.d/
