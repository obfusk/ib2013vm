#!/bin/bash

set -xe

export LC_ALL=C

p='[start|stop|ib2013|firefox|mc|xterm|shell|quit]> '

trap 'read -p "press return"' EXIT

vagrant up

ssh -F .ssh-config default -N -L 5901:localhost:5901 & pid="$!"

while read -r -p "$p" command; do
  case "$command" in
    start)    vagrant ssh -c 'vncserver :1 ; DISPLAY=:1 openbox'  & ;;
    stop)     vagrant ssh -c 'vncserver -kill :1'                   ;;
    ib2013)   vagrant ssh -c 'DISPLAY=:1 ./ib2013.sh'             & ;;
    firefox)  vagrant ssh -c 'DISPLAY=:1 firefox'                 & ;;
    mc)       vagrant ssh -c 'DISPLAY=:1 xterm -e mc'             & ;;
    xterm)    vagrant ssh -c 'DISPLAY=:1 xterm'                   & ;;
    shell)    vagrant ssh                                           ;;
    quit)     break                                                 ;;
  esac
done

kill "$pid"

vagrant halt
