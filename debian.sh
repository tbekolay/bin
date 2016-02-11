#!/usr/bin/env bash

package_installed() {
    INSTALLED="install ok installed"
    # shellcheck disable=SC2016
    #  We want to pass this string directly to dpkg-query
    [[ $(dpkg-query --show --showformat='${Status}\n' "$1" 2> /dev/null) == "$INSTALLED" ]]
}

install_packages() {
    for PACKAGE in "$@"; do
        if ! package_installed "$PACKAGE"; then
            sudo apt-get --no-install-recommends install "$PACKAGE"
        fi
    done
}

remove_packages() {
    for PACKAGE in "$@"; do
        if package_installed "$PACKAGE"; then
            sudo apt-get --purge remove "$PACKAGE"
        fi
    done
}
