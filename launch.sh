#!/bin/bash

# Enable script debug output
[[ "${SOCAT_DEBUG}" = "true" ]] && set -x

# Create TCP wrapper file for ALLOW
[[ -z "${SOCAT_ALLOW}" ]] && SOCAT_ALLOW=ALL
echo "socat-proxy: ${SOCAT_ALLOW}" > ~/socat.allow

# Create TCP wrapper file for DENY
if [[ -z "${SOCAT_DENY}" ]] ; then
    [[ "${SOCAT_ALLOW}" = ALL ]] && SOCAT_DENY=NONE || SOCAT_DENY=ALL
fi
echo "socat-proxy: ${SOCAT_DENY}" > ~/socat.deny

# Reasonable defaults for source and target addresses regarding Docker Unix domain socket
[[ -z "${SOCAT_SRC}" ]] && SOCAT_SRC='unix-connect:/var/run/docker.sock'
[[ -z "${SOCAT_TGT}" ]] && SOCAT_TGT='TCP4-LISTEN:4550,fork'

# Run socat command line
exec socat ${SOCAT_OPTS} "${SOCAT_SRC}" "${SOCAT_TGT},tcpwrap=socat-proxy,allow-table=~/socat.allow,deny-table=~/socat.deny"
