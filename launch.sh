#!/bin/bash

[[ -n "${SOCAT_ALLOW}" ]] || SOCAT_ALLOW=ALL
echo "docker-proxy: ${SOCAT_ALLOW}" > ~/socat.allow

[[ -n "${SOCAT_DENY}" ]] || SOCAT_DENY=
echo "docker-proxy: ${SOCAT_DENY}" > ~/socat.deny

if [[ -z "${SOCAT_ADDRESS_1}" || -z "${SOCAT_ADDRESS_2}" ]] ; then
    echo 'ERROR: $0: need two addresses!'
    extit 1
fi

socat ${SOCAT_OPTS} "${SOCAT_ADDRESS_1}" "${SOCAT_ADDRESS_2}"
