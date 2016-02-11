#!/usr/bin/env bash

checkfile() {
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
    head -c ${#1} < /dev/zero | tr '\0' "$CH"
    echo
    echo "$1"
    head -c ${#1} < /dev/zero | tr '\0' "$CH"
    echo
}

checkandlink () {
    SRC=$1
    DST=$2
    if [[ ! -h $DST || $(readlink "$DST") != $SRC ]]; then
        echo "--- Linking $DST to $SRC"
        rm -rf "$DST"
        ln -s "$SRC" "$DST"
    fi
}

export CODE=$HOME/Code
