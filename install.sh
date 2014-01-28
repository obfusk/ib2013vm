#!/bin/bash

set -xe

box=ib2013vm

box_url='https://cloud-images.ubuntu.com/vagrant/precise/current/'
box_url+='precise-server-cloudimg-i386-vagrant-disk1.box'

ib_url='http://download.belastingdienst.nl/belastingdienst/apps/linux/'
ib_url+='ib2013_linux.tar.gz'

ib_sum='5db3ccfedf3d44ff13ae1ee4009d7e59bb88bf9d4f4d9ba6ac3fca28aaf98e7e'
ib_sum+='eb670426e4abc2167099279d2151e8721f38f6f58b658cc999e508ae875ea729'

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

read -r -p 'Run? [y/N] ' q
if [[ "$q" == [yY]* ]]; then
  exec ./run.sh
else
  vagrant halt
fi
