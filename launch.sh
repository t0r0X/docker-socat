#!/bin/bash

# Create TCP wrapper file for ALLOW
[[ -n "${SOCAT_ALLOW}" ]] || SOCAT_ALLOW=ALL
echo "docker-proxy: ${SOCAT_ALLOW}" > ~/socat.allow

# Create TCP wrapper file for DENY
[[ -n "${SOCAT_DENY}" ]] || SOCAT_DENY=
echo "docker-proxy: ${SOCAT_DENY}" > ~/socat.deny

# Validate source and target addresses
if [[ -z "${SOCAT_ADDRESS_SRC}" || -z "${SOCAT_ADDRESS_TGT}" ]] ; then
    echo "ERROR: $0: need two addresses in variables 'SOCAT_ADDRESS_SRC' and 'SOCAT_ADDRESS_TGT'!"
    exit 1
fi

# Run socat command line
socat ${SOCAT_OPTS} "${SOCAT_ADDRESS_SRC}" "${SOCAT_ADDRESS_TGT}"
