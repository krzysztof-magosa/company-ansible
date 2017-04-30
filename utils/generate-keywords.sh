#! /bin/bash

ANSIBLE_VERSIONS=(
    stable-1.9
    stable-2.0
    stable-2.1
    stable-2.2
    stable-2.3
)



mkdir -p ./repos/
for version in ${ANSIBLE_VERSIONS[@]} ; do
    echo "Downloading modules for ansible $version..."
    if [ ! -d ./repos/$version ] ; then
        git clone https://github.com/ansible/ansible.git --branch=$version --depth=1 --recursive ./repos/$version/
    fi
done

./generator.rb './repos/*/lib/ansible/modules/**/*.py'
