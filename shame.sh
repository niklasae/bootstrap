#!/usr/bin/env bash
#
# Stuff I have to install at times, which really should live in my Vagrant
# or docker files...
#

# gettext & language-packs - not quite sure it works...
sudo apt-get install -y gettext
current_dir=$PWD 
cd /usr/share/locales
sudo /usr/share/locales/install-language-pack da_DK
sudo /usr/share/locales/install-language-pack en_GB
sudo /usr/share/locales/install-language-pack en_US
sudo /usr/share/locales/install-language-pack fi_FI
sudo /usr/share/locales/install-language-pack nb_NO
sudo /usr/share/locales/install-language-pack sv_SE
sudo locale-gen
cd $current_dir

# memcached
sudo apt-get install -y memcached

# mysql
sudo apt-get install -y mysql-server-5.5

# nginx
sudo apt-get install -y nginx

# PHP
sudo apt-get install -y php5-cgi
sudo apt-get install -y php5-curl
sudo apt-get install -y php-gettext
sudo apt-get install -y php5-gd
sudo apt-get install -y php5-mcrypt
sudo apt-get install -y php5-json
sudo apt-get install -y php5-memcache
sudo apt-get install -y php5-tidy
sudo apt-get install -y php-pear
sudo pear install Net_GeoIP

# rabbitmq
sudo apt-get install -y rabbitmq-server
sudo rabbitmq-plugins enable rabbitmq_tracing && sudo rabbitmq-plugins enable rabbitmq_management && sudo service rabbitmq-server restart

# supervisor
sudo apt-get install -y supervisor

# django-skel
sudo apt-get install -y libevent-dev
sudo apt-get install -y libpq-dev
sudo apt-get install -y libmemcache-dev
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y python-dev
sudo apt-get install -y build-essential

# splinter
sudo apt-get install -y build-essential
sudo apt-get install -y python-dev
sudo apt-get install -y libxml2-dev
sudo apt-get install -y libxslt1-dev

# Python Image stuff for pillow
sudo apt-get install -y libjpeg-dev

# XXX - if panel indicators are missing
sudo apt-get install -y libindicator1
