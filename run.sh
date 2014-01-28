#!/bin/bash

set -xe

trap 'read -p "press return"' EXIT

vagrant up

while read -r -p '[ib2013|firefox|shell|quit]> ' command; do
  case "$command" in
    ib2013)   vagrant ssh -c 'cd ib2013/bin; ./ib2013ux' ;;
    firefox)  vagrant ssh -c firefox ;;
    shell)    vagrant ssh ;;
    quit)     break ;;
  esac
done

vagrant halt
