#!/bin/sh
# Kali Build Script

GITLIST="gitlist.txt"

## Add Albert repos
curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/Debian_9.0/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list
apt install albert

# install packages
apt install tmuxinator polenum graphviz autoconf automake albert htop strace npm ascii w3m ntpdate swig swig3.0 libssl-dev python-dev libjpeg-dev xvfb python-pip npm dkms impacket-scripts

cd /opt

for i in $(cat $GITLIST); do
    git clone $i
done

cd $HOME

git clone https://github.com/longld/peda.git
