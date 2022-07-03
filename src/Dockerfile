FROM kipjr/php-apache:8.0
# FROM php:apache
# Install dependencies
#RUN apt-get update && apt-get install -y --no-install-recommends \
#zlib1g-dev \
##unzip \
#zip \ 
#curl \
#wget \
#ghostscript \
#xpdf-utils \
#libmagickwand-dev \
#libimage-exiftool-perl \
#libzip-dev \
#libonig-dev \
#libldb-dev \
#libldap2-dev \
#libpng-dev \
#libxml2-dev \
#libjpeg-dev

# Exiftool
# ffmpeg
# pdftoppm
# imagemagick


RUN wget https://piwigo.org/download/dlcounter.php?code=latest -O /tmp/piwigo.zip && unzip -o /tmp/piwigo.zip  -d /app/
COPY 99-pwg_initdb.conf /opt/docker/etc/supervisor.d/

# Galleries
# Upload
# Plugins
# Themes
# Template-extension
# Local
# _data

## CMD curl 'http://192.168.2.6/piwigo/install.php?language=en_GB' --data-raw 'language=en_GB&dbhost=db&dbuser=pwg12.1&dbpasswd=pwg12.1&dbname=pwg&prefix=piwigo_&admin_name=admin&admin_pass1=password&admin_pass2=password&admin_mail=info%40noreply.com&install=Start+installation' --compressed --insecure
