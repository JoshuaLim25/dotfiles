#!/usr/bin/env bash

set -euo pipefail

watchfile=/var/log/syslog
pattern='file system mounted'

tail -f -n0 "${watchfile}" | grep -qe "${pattern}"

if [ $? -ne 0 ]; then
    echo "Stopped searching: pattern not found"
fi
