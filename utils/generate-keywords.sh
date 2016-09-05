#! /bin/bash

ANSIBLE_VERSION=stable-2.1

mkdir -p ./repos/
[ ! -d ./repos/core/ ] && git clone https://github.com/ansible/ansible-modules-core.git --branch=$ANSIBLE_VERSION ./repos/core/
[ ! -d ./repos/extras/ ] && git clone https://github.com/ansible/ansible-modules-extras.git --branch=$ANSIBLE_VERSION ./repos/extras/

./generator.rb './repos/*/*/*.py'
