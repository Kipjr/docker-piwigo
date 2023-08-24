ARG phpversion=8.2
FROM webdevops/php-apache:${phpversion}-alpine
# RUN wget https://piwigo.org/download/dlcounter.php?code=latest -O /tmp/piwigo.zip && unzip -o /tmp/piwigo.zip  -d /app/
ARG pwgversion=13.7.0
RUN wget https://piwigo.org/download/dlcounter.php?code=${pwgversion} -O /tmp/piwigo.zip && unzip -o /tmp/piwigo.zip
COPY 99-pwg_initdb.conf /opt/docker/etc/supervisor.d/
