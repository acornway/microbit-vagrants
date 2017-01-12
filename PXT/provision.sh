#!/bin/bash
#
# This script is run by Vagrant when a new machine is provisioned.
#
# can be checked as vagrant user with sudo su - provison.sh

LOG=/tmp/vagrant.log

function get-info(){
  whoami
  set
}

function add-local(){
  mkdir -p ~vagrant/local
  echo 'export PATH=~vagrant/local/bin:$PATH' >>~vagrant/.bashrc
}

function basic-apt-get(){
  apt-get update
# apt-get -y dist-upgrade #TODO:Solve grub problem http://askubuntu.com/questions/325872/ubuntu-unattended-apt-get-upgrade-grub-install-dialog
  apt-get -y install git build-essential
}

function local-node-install(){
    mkdir ~vagrant/local
    chown vagrant ~vagrant/local
    cd ~vagrant/local 
    runuser - vagrant -c '
      cd ~vagrant/local;
      curl https://nodejs.org/download/release/latest-v6.x/node-v6.9.4-linux-x64.tar.gz | tar xz --strip-components=1;
    '
}

function install-pxt(){
  runuser - vagrant -c '
    . ~vagrant/.bashrc;
    npm install -g jake typings;
    npm install -g typings;
    mkdir -p ~vagrant/pxt/pxt; 
    ~vagrant/pxt/pxt-microbit;
    git clone https://github.com/microsoft/pxt ~vagrant/pxt/pxt
    git clone https://github.com/microsoft/pxt-microbit ~vagrant/pxt/pxt-microbit
    cd ~vagrant/pxt/pxt;
    npm install; 
    typings install; 
    jake; 
    npm install -g pxt;
    cd ~vagrant/pxt/pxt-microbit;
    npm install ../pxt; 
    npm install;
  '
}

echo start
#get-info 
#add-local
#basic-apt-get& # let this run in background so finished quicker (hopefully)
#local-node-install

cat >/dev/null 2>&1 <<EOF
echo pxt
{
  runuser - vagrant -c '
    . ~vagrant/.bashrc;
    npm install -g jake typings;
    mkdir -p ~vagrant/pxt/pxt ~vagrant/pxt/pxt-microbit
    git clone https://github.com/microsoft/pxt ~vagrant/pxt/pxt
    git clone https://github.com/microsoft/pxt-microbit ~vagrant/pxt/pxt-microbit
    cd ~vagrant/pxt/pxt;
    npm install; 
    typings install; 
    jake; 
    npm install -g pxt;
    cd ~vagrant/pxt/pxt-microbit;
    npm install ../pxt; 
    npm install; 
    '
} >>/tmp/vagrant-debug-info-log 2>&1

echo 'ssh vagrant@127.0.0.1:2222'

#cat <<EOF

echo x-apt-get
{
  apt-get -y install xauth xterm firefox
}>/tmp/x-apt-get-log

# What is this for ...
sudo apt-get --qq -y install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
EOF
###
