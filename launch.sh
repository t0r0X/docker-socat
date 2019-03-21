#!/bin/bash

# Create TCP wrapper file for ALLOW
[[ -n "${SOCAT_ALLOW}" ]] || SOCAT_ALLOW=ALL
echo "socat-proxy: ${SOCAT_ALLOW}" > ~/socat.allow

# Create TCP wrapper file for DENY
[[ -n "${SOCAT_DENY}" ]] || SOCAT_DENY=NONE
echo "socat-proxy: ${SOCAT_DENY}" > ~/socat.deny

# Validate source and target addresses
if [[ -z "${SOCAT_SRC}" ]] ; then
    echo "ERROR: $0: need 'socat' source address (what to export) in variable 'SOCAT_SRC'!"
    exit 1
fi
if [[ -z "${SOCAT_TGT}" ]] ; then
    echo "ERROR: $0: need 'socat' target address (where to export) in variable 'SOCAT_TGT'!"
    exit 1
fi

# Run socat command line
socat ${SOCAT_OPTS} "${SOCAT_SRC}" "${SOCAT_TGT},tcpwrap=socat-proxy,allow-table=~/socat.allow,deny-table=~/socat.deny"
