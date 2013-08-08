#!/usr/bin/env bash
#
# Stuff I have to install at times, which really should live in my Vagrant files...
#

# gettext & language-packs - not quite sure it works...
sudo aptitude install -y gettext
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
sudo aptitude install -y memcached

# mysql
sudo aptitude install -y mysql-server-5.5

# nginx
sudo aptitude install -y nginx

# PHP
sudo aptitude install -y php5-cgi
sudo aptitude install -y php5-curl
sudo aptitude install -y php-gettext
sudo aptitude install -y php5-gd
sudo aptitude install -y php5-mcrypt
sudo aptitude install -y php5-json
sudo aptitude install -y php5-memcache
sudo aptitude install -y php5-tidy
sudo aptitude install -y php-pear
sudo pear install Net_GeoIP

# rabbitmq
sudo aptitude install -y rabbitmq-server
sudo rabbitmq-plugins enable rabbitmq_tracing && sudo rabbitmq-plugins enable rabbitmq_management && sudo service rabbitmq-server restart

# supervisor
sudo aptitude install -y supervisor
