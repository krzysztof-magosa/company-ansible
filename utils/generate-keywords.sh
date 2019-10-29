#! /bin/bash

ANSIBLE_VERSIONS=(
    stable-2.5
    stable-2.6
    stable-2.7
    stable-2.8
    stable-2.9
)



mkdir -p ./repos/
for version in ${ANSIBLE_VERSIONS[@]} ; do
    echo "Downloading modules for ansible $version..."
    if [ ! -d ./repos/$version ] ; then
        git clone https://github.com/ansible/ansible.git --branch=$version --depth=1 --recursive ./repos/$version/
    fi
done

./generator.rb './repos/*/lib/ansible/modules/**/*.py'
