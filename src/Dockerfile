ARG PHPVERSION=8.2
FROM webdevops/php-apache:${PHPVERSION}-alpine
VOLUME /app
ARG PWGVERSION=13.8.0
RUN wget https://piwigo.org/download/dlcounter.php?code=${PWGVERSION} -O /tmp/piwigo.zip && unzip -o /tmp/piwigo.zip -d /app
COPY 99-pwg_initdb.conf /opt/docker/etc/supervisor.d/
