#!/bin/bash

set -xe

box=ib2013vm

box_url='https://cloud-images.ubuntu.com/vagrant/precise/current/'
box_url+='precise-server-cloudimg-i386-vagrant-disk1.box'

trap 'read -p "press return"' EXIT

if ! test -e id_rsa; then
  ssh-keygen -f id_rsa -P ''
fi

if ! vagrant box list | awk '{print $1}' | grep -qxF "$box"; then
  vagrant box add "$box" "$box_url"
fi

export OLD_KEY=yes

vagrant up

cp id_rsa.pub shared/
vagrant ssh -c 'cp ~/shared/id_rsa.pub ~/.ssh/authorized_keys'
rm shared/id_rsa.pub

export OLD_KEY=no

vagrant ssh-config > .ssh-config

read -r -p 'Run? [y/N] ' q
if [[ "$q" == [yY]* ]]; then
  exec ./run.sh
else
  vagrant halt
fi
