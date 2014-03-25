#!/usr/bin/env bash

package_installed() {
    brew list "$1" &> /dev/null
}

install_packages() {
    for PACKAGE in "$@"; do
        if ! package_installed "$PACKAGE"; then
            brew install $PACKAGE
        fi
    done
}

remove_packages() {
    for PACKAGE in "$@"; do
        if package_installed $PACKAGE; then
            brew uninstall $PACKAGE
        fi
    done
}
