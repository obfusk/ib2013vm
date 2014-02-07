#!/bin/bash

set -xe

ib_url='http://download.belastingdienst.nl/belastingdienst/apps/linux/'
ib_url+='ib2013_linux.tar.gz'

ib_sum='5db3ccfedf3d44ff13ae1ee4009d7e59bb88bf9d4f4d9ba6ac3fca28aaf98e7e'
ib_sum+='eb670426e4abc2167099279d2151e8721f38f6f58b658cc999e508ae875ea729'

ib_tgz=ib2013.tgz

packages=(
  firefox mc tightvncserver openbox xterm
)

rm_packages=(
  rpcbind cloud-init
)

passwd -l vagrant

aptitude update
aptitude -y safe-upgrade

aptitude install -y -R "${packages[@]}"
aptitude purge -y "${rm_packages[@]}"

cat <<__END | sed 's!^  !!' | sudo -H -u vagrant bash -xe
  cd
  wget "$ib_url" -O "$ib_tgz"
  if ! test "\$( sha512sum "$ib_tgz" | awk '{print \$1}' )" = "$ib_sum"; then
    echo 'sha512sum does not match' >&2
    rm "$ib_tgz"
    exit 1
  fi
  tar xf "$ib_tgz"
  cat <<__END | sed 's!^  !!' > ib2013.sh
    font='-schumacher-clean-medium-r-normal-*-*-120-*-*-c-*-iso8859-15'
    cd ~/ib2013/bin && exec ./ib2013ux -L "\\\$font"
  __END
  chmod +x ib2013.sh
__END
