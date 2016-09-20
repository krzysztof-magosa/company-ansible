#! /bin/bash

ANSIBLE_VERSIONS=(
    stable-1.9
    stable-2.0
    stable-2.1
)

#

mkdir -p ./repos/
for version in ${ANSIBLE_VERSIONS[@]} ; do
    echo "Downloading modules for ansible $version..."
    [ ! -d ./repos/core/$version ] && git clone https://github.com/ansible/ansible-modules-core.git --branch=$version ./repos/core/$version/
    [ ! -d ./repos/extras/$version ] && git clone https://github.com/ansible/ansible-modules-extras.git --branch=$version ./repos/extras/$version/
done

./generator.rb './repos/*/*/*/*.py'
