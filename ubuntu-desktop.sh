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


#
# CLI tools and utils
#
fancy_echo "Installing CLI tools and utils"

# Ubuntu restriced extras (mp3, avi, mpeg, TrueType, Java, Flash, Codecs...)
sudo apt-get install -y ubuntu-restricted-extras

# Enable HDMI audio output
sudo apt-get install -y pavucontrol

# Clipboard cli
sudo apt-get install -y xclip
sudo apt-get install -y xsel

# Redshift adjusts the color temperature of the screen
sudo apt-get install -y redshift redshift-gtk

# Other binaries - into ~/bin
#sudo apt-get install -y libav-tools
#wget -qO ~/bin/svtget https://github.com/mmn/svtget/raw/master/bash/svtget
#sudo chmod +x ~/bin/svtget
#
#sudo apt-get install -y libnotify-bin
#git clone https://gist.github.com/3083085.git ~/bin/dropshot_gist
#mv ~/bin/dropshot_gist/dropshot.py ~/bin/.
#sudo chmod +x ~/bin/dropshot.py
#rm -rf ~/bin/dropshot_gist


#
# GUI tools and utils
#
fancy_echo "Installing GUI tools & utils"

# calibre - ebook lib manager
sudo apt-get install -y calibre

# chromium
sudo apt-get install -y chromium-browser

# dragondisk
#sudo apt-get install -y dragondisk

# keepassx
sudo apt-get install -y keepassx

# geary - email client
#sudo add-apt-repository -y ppa:yorba/ppa
#sudo apt-get update
#sudo apt-get install -y geary

# gimp
sudo apt-get install -y gimp

# git-gui
sudo apt-get install -y git-gui

# gSTM - manages ssh tunnels
sudo apt-get install -y gstm

# gVim
sudo apt-get install -y vim-gtk

# meld - file diff
sudo apt-get install -y meld

# mysql-workbench
sudo apt-get install -y mysql-workbench

# clipit or parcellite - clipboard manager
sudo apt-get install -y clipit
#sudo apt-get install -y parcellite

# shutter - screenshot tool
sudo apt-get install -y shutter

## skype
#sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
#sudo apt-get update
#sudo apt-get install -y skype

# spotify
sudo sh -c 'echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
sudo apt-get update
sudo apt-get install -y spotify-client --force-yes

# synapse - application launcher
#sudo apt-add-repository -y ppa:synapse-core/testing
#sudo apt-get update
#sudo apt-get install -y synapse
# synapse alternativ Albert launcher - albertlauncher.github.io
#sudo add-apt-repository -y ppa:nilarimogard/webupd8
#sudo apt-get update
#sudo apt-get install -y albert
# synapse alternativ Ulauncher - https://ulauncher.io
sudo add-apt-repository -y ppa:agornostal/ulauncher
sudo apt-get update
sudo apt-get install -y ulauncher

# tomate - pomodoro timer
#sudo apt-add-repository -y ppa:stvs/tomate
#sudo apt-get update
#sudo apt-get install -y tomate

# vlc
sudo apt-get install -y vlc

# zeal - offline API document browser inspired by Dash (OS X app)
sudo apt-get install -y zeal


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


#
# Clean up
#
fancy_echo "Cleaning up packages"
sudo apt-get autoremove -y


# End
echo -e ${GREEN}
echo "Do not forget to:"
echo
echo "Configure dropshot.py"
echo
echo "Check the README for more actions."
echo
echo "Thanks for taking me for a spin... :-)"
echo -e ${CLEAR}
