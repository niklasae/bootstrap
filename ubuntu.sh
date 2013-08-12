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

#
# System packages and package manager (aptitude)
#
fancy_echo "Check package manager..."
if command -v aptitude >/dev/null; then
    fancy_echo "Using aptitude..."
else
    fancy_echo "Installing aptitude..."
    sudo apt-get update -y
    sudo apt-get install -y aptitude
fi
fancy_echo "Update system packages..."
sudo aptitude update
# sudo aptitude -y dist-upgrade
sudo aptitude -y safe-upgrade


#
# Setting up dirs
#
fancy_echo "Setting up directories"
mkdir ~/bin
mkdir -p ~/Code/projects
sudo ln -s ~/Code/projects /projects
mkdir -p ~/Code/work
sudo ln -s ~/Code/work /work


#
# CLI tools and utils
#
fancy_echo "Installing CLI tools and utils"

# ack-grep
sudo aptitude install -y ack-grep

# checkinstall - install nicely into /usr/local creates xyz.deb
# http://asic-linux.com.mx/~izto/checkinstall/
# http://blog.sanctum.geek.nz/packaging-built-software/
sudo aptitude install -y checkinstall

# at
sudo aptitude install -y at

# cURL
sudo aptitude install -y curl

# git
sudo aptitude install -y git

# htop
sudo aptitude install -y htop

# mutt - email
sudo aptitude install -y mutt
sudo sh -c "echo niklas@jobylon.com > /root/.forward"  # root forward

# tmux
sudo aptitude install -y tmux

# tree
sudo aptitude install -y tree

# vim
sudo aptitude install -y vim

# weechat - IRC
sudo aptitude install -y weechat

# zsh
sudo aptitude install -y zsh
chsh -s `which zsh`

# Other binaries - into ~/bin
sudo aptitude install -y ffmpeg
wget -qO ~/bin/svtget https://github.com/mmn/svtget/raw/master/bash/svtget
sudo chmod +x ~/bin/svtget

#
# GUI tools and utils
#
fancy_echo "Installing GUI tools & utils"

# calibre - ebook lib manager
sudo aptitude install -y calibre

# chromium
sudo aptitude install -y chromium-browser

# keepassx 
sudo aptitude install -y keepassx

# gimp
sudo aptitude install -y gimp

# git-gui
sudo aptitude install -y git-gui

# gSTM - manages ssh tunnels
sudo aptitude install -y gstm

# gVim
sudo aptitude install -y vim-gtk

# meld - file diff
sudo aptitude install -y meld

# mysql-workbench
sudo aptitude install -y mysql-workbench

# parcellite - clipboard manager
sudo aptitude install -y parcellite

# shutter - screenshot tool
sudo aptitude install -y shutter

# skype
sudo aptitude install -y skype

# spotify
sudo sh -c 'echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
sudo aptitude update
sudo aptitude install -y spotify-client

# synapse - application launcher
sudo aptitude install -y synapse

# vlc
sudo aptitude install -y vlc


#
# Dev-env
#
fancy_echo "Setting up dev env"

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

# node.js - nvm, latest as default and basic packages
git clone git://github.com/creationix/nvm.git ~/.nvm
source ~/.nvm/nvm.sh
node_version=$(wget -qO- http://nodejs.org | grep "Current Version" | grep -o '[0-9\.]*')
fancy_echo "Setting up node.js version (NVM) - "$node_version
nvm install $node_version
nvm alias default $node_version
npm install -g coffee-script
npm install -g coffeelint
npm install -g jshint
npm install -g less

# python
sudo aptitude install -y python-dev
sudo aptitdue install -y python-gpgme
sudo aptitude install -y python-pip
sudo aptitdue install -y build-essential
sudo aptitude install -y libevent-dev  # asynchronous IO
wget -qO- http://python-distribute.org/distribute_setup.py | sudo python
sudo easy_install pip
sudo pip install -U autoenv
sudo pip install -U fabric
sudo pip install -U virtualenv
sudo pip install -U virtualenvwrapper

# ruby - dependencies and rvm
sudo aptitude install -y libreadline6-dev
sudo aptitude install -y zlib1g-dev
sudo aptitude install -y libssl-dev
sudo aptitude install -y libyaml-dev
sudo aptitude install -y libsqlite3-dev
sudo aptitude install -y sqlite3
sudo aptitude install -y autoconf
sudo aptitude install -y libgdbm-dev
sudo aptitude install -y libncurses5-dev
sudo aptitude install -y automake
sudo aptitude install -y libtool
sudo aptitude install -y bison
sudo aptitude install -y libffi-dev
curl -L https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm

# heroku - toolbelt and accounts
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku plugins:install git://github.com/ddollar/heroku-accounts.git


#
# dotfiles
#
fancy_echo "Setting up dotfiles"
git clone ssh://git@github.com:niklasae/dotfiles ~/Code/dotfiles
cd ~/Code/dotfiles
./prereq.sh
./setup.sh


#
# UI specific settings
#
fancy_select "Which UI is in use?"
select ui in Cinnamon Other
do
    case $ui in
        Cinnamon)
            fancy_echo "Cinnamon specific settings it is!"
            #sudo aptitude install -y gsettings

            # Default workspaces, get back Super and no hot corners
            # Find more to set using `$ gsettings list-recursively | grep xyz`
            gsettings set org.cinnamon number-workspaces 4
            gsettings set org.cinnamon.muffin overlay-key 'Super_R'
            gsettings set org.cinnamon overview-corner "['false:false:false', 'false:false:false', 'false:false:false', 'false:false:false']"

            # Keybindings - switch, move, lock...
            gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Control><Super>Down']"
            gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left']"
            gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right']"
            gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Control><Super>Up']"
            gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Control><Shift><Super>Down']"
            gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Shift><Super>Left']"
            gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Shift><Super>Right']"
            gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Control><Shift><Super>Up']"
            gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Control><Super>l'

            break;;

        Other)
            fancy_echo "No further UI setup..."
            break;;
    esac
done

# End
echo -e ${GREEN}
echo "Do not forget to:"
echo
echo "  * Install Chrome" 
echo "  * Install Dropbox + run setup"
echo "  * Install Spotify"
echo "  * Install Vagrant"
echo "  * Install Valentina Studio (VStudio) + import bookmarks"
echo "  * Install Virtualbox"
echo
echo "  * Configure Parcellite"
echo "  * Configure Synapse"
echo
echo "  * Reboot to get ZSH working" 
echo
echo "Thanks for taking me for a spinn... :-)"
echo -e ${CLEAR}
