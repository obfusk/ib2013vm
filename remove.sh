#!/bin/bash

set -xe

box=ib2013vm

trap 'read -p "press return"' EXIT

vagrant destroy

read -r -p "Remove the $box base box as well? [y/N] " q
[[ "$q" != [yY]* ]] || vagrant box remove "$box"
