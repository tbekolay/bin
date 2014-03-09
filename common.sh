#!/bin/bash

package_installed() {
    INSTALLED="install ok installed"
    [[ `dpkg-query -W -f='${Status}\n' $1 2> /dev/null` == $INSTALLED ]]
}

install_packages() {
    for PACKAGE in "$@"; do
        if ! package_installed "$PACKAGE"; then
            sudo apt-get --no-install-recommends install $PACKAGE
        fi
    done
}

remove_packages() {
    for PACKAGE in "$@"; do
        if package_installed $PACKAGE; then
            sudo apt-get --purge remove $PACKAGE
        fi
    done
}

check_file() {
    if [[ -f $1 ]]; then
        read -p "$1 exists. Overwrite? [y/n] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            return 0
        else
            return 1
        fi
    else
        return 0
    fi
}

sanitycheck() {
    read -p "Keep going? [y/n] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi
}

section () {
    CH='-'
    if [[ $# -eq 2 ]]; then
        CH=$2
    fi
    head -c ${#1} < /dev/zero | tr '\0' $CH
    echo
    echo $1
    head -c ${#1} < /dev/zero | tr '\0' $CH
    echo
}

CODE=$HOME/Code
