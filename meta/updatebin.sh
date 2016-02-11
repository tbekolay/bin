#!/usr/bin/env bash

# This is a script to update various files in the parent directory
# that were downloaded from various locations.
#
# Those files should therefore not be edited. Will I stick to that? We'll see!

# Ensure we run from the bin directory
cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ..

update() {
    local url=$1
    local outfile=$2
    if hash wget 2>/dev/null; then
        wget "$url" -O "$outfile"
    else
        curl -o "$outfile" "$url"
    fi
}

if [[ $# == 1 ]]; then
    outfile=${1:7}
    update "$1" "${outfile##/*/}"
elif [[ $# == 2 ]]; then
    update "$1" "$2"
else
    update https://raw.githubusercontent.com/pshved/timeout/master/timeout timeout
    update https://gist.githubusercontent.com/mikeflynn/4278796/raw/etchosts.sh etchosts
fi
