#!/usr/bin/env bash
#
# Setup script for Ubuntu based boxes (Ubuntu, Mint...)
#
# Inspired by https://github.com/thoughtbot/laptop
#
CLEAR="\033[0m"
GREEN="\033[32m"
ORANGE="\033[33m"
CYAN="\033[36m"

successfully() {
    $* || (echo "failed" 1>&2 && exit 1)
}

fancy_echo() {
    echo -e ${ORANGE}$1${CLEAR}
    echo
}

fancy_select() {
    echo
    echo -e ${CYAN}$1${CLEAR}
}

# Begin
echo

# Fail and stop on error
set -e

#
# System packages and general update
#
fancy_echo "Check package manager..."
sudo apt-get update

fancy_echo "Update system packages..."
#sudo apt-get -y dist-upgrade
sudo apt-get -y upgrade


#
# Setting up dirs
#
fancy_echo "Setting up directories"
mkdir -p ~/bin
mkdir -p ~/tmp && sudo chown niklas:niklas ~/tmp
mkdir -p ~/Code/contrib
mkdir -p ~/Code/projects
test -d /projects || sudo ln -s ~/Code/projects /projects
mkdir -p ~/Code/work
test -d /work || sudo ln -s ~/Code/work /work
mkdir -p ~/Code/tmp
mkdir -p ~/Software


#
# CLI tools and utils
#
fancy_echo "Installing CLI tools and utils"

# ack-grep
sudo apt-get install -y ack-grep

# AWS RDS
#wget -qO ~/Software/RDSCli.zip http://s3.amazonaws.com/rds-downloads/RDSCli.zip
#unzip ~/Software/RDSCli.zip
#rdscli_version=$(ls ~/Software | grep -o 'RDSCli-[0-9\.]*')
#ln -s ~/Software/$rdscli_version ~/Software/RDSCli
#chmod +x ~/Software/RDSCli/bin/*

# checkinstall - install nicely into /usr/local creates xyz.deb
# http://asic-linux.com.mx/~izto/checkinstall/
# http://blog.sanctum.geek.nz/packaging-built-software/
sudo apt-get install -y checkinstall

# at
sudo apt-get install -y at

# cURL
sudo apt-get install -y curl

# docker
sudo apt-get install -y docker.io

# git
sudo apt-get install -y git

# htop
sudo apt-get install -y htop

# inotify
sudo apt-get install -y inotify-tools

# mutt - email
sudo apt-get install -y mutt
sudo sh -c "echo niklas@jobylon.com > /root/.forward"  # root forward

# nfs
sudo apt-get install -y nfs-kernel-server nfs-common portmap

# pdftk - PDF tools
sudo apt-get install -y pdftk

# tmate
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:nviennot/tmate
sudo apt-get update
sudo apt-get install -y tmate

# tmux
sudo apt-get install -y tmux

# tree
sudo apt-get install -y tree

# vim
sudo apt-get install -y vim

# weechat - IRC
sudo apt-get install -y weechat

# xclip - used with tmux copy/paste
sudo apt-get install -y xclip

# zsh
sudo apt-get install -y zsh
chsh -s `which zsh`


#
# Dev-env
#
fancy_echo "Setting up dev env"

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

# node.js - nvm, latest as default and basic packages
git clone git://github.com/creationix/nvm.git ~/.nvm
source ~/.nvm/nvm.sh
node_version=$(wget -qO- http://nodejs.org | grep "Current Version" | grep -o '[0-9\.]*')
fancy_echo "Setting up node.js version (NVM) - "$node_version
nvm install $node_version
nvm alias default $node_version
npm install -g bower
npm install -g coffee-script
npm install -g coffeelint
npm install -g grunt-cli
npm install -g gulp
npm install -g js2coffee
npm install -g jshint
npm install -g less
npm install -g npm-check-updates
# npm:s for testing
npm install -g phantomjs
npm install -g casperjs
# npm:s for UI:s
npm install -g redis-commander
npm install -g ripple-emulator

# python
sudo apt-get install -y python-dev
sudo apt-get install -y python-gpgme
sudo apt-get install -y python-pip
sudo apt-get install -y build-essential
sudo apt-get install -y libevent-dev  # asynchronous IO
sudo apt-get install -y libpq-dev  # PostgreSQL lib for ORM
sudo apt-get install -y libmysqlclient-dev  # MySQL lib for ORM
wget -qO- http://python-distribute.org/distribute_setup.py | sudo python
sudo easy_install pip
sudo pip install -U pip
sudo pip install -U docker-compose
sudo pip install -U fabric
sudo pip install -U virtualenv
sudo pip install -U virtualenvwrapper
# python autoenv - installing using pip didn't work too well
git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv

# ruby - dependencies and rvm
sudo apt-get install -y libreadline6-dev
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y libyaml-dev
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y sqlite3
sudo apt-get install -y autoconf
sudo apt-get install -y libgdbm-dev
sudo apt-get install -y libncurses5-dev
sudo apt-get install -y automake
sudo apt-get install -y libtool
sudo apt-get install -y bison
sudo apt-get install -y libffi-dev
curl -L https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm


# heroku - toolbelt and accounts
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku plugins:install git://github.com/ddollar/heroku-accounts.git


#
# Clean up
#
fancy_echo "Cleaning up packages"
sudo apt-get autoremove -y


# End
echo -e ${GREEN}
echo "Do not forget to:"
echo
echo "  * Check the README file for software that needs to be installed manually"
echo "  * Install the dotfiles"
echo "  * Reboot to get ZSH working" 
echo
echo "Thanks for taking me for a spin... :-)"
echo -e ${CLEAR}
