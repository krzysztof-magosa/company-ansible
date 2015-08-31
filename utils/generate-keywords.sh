#! /bin/bash

mkdir -p ./repos/
[ ! -d ./repos/core/ ] && git clone https://github.com/ansible/ansible-modules-core.git ./repos/core/
[ ! -d ./repos/extras/ ] && git clone https://github.com/ansible/ansible-modules-extras.git ./repos/extras/

./generator.rb './repos/*/*/*.py'
