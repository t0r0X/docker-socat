#!/bin/bash

# Enable script debug output
[[ "${SOCAT_DEBUG}" = "true" ]] && set -x

# Create TCP wrapper file for ALLOW
[[ -z "${SOCAT_ALLOW}" ]] && SOCAT_ALLOW=ALL
echo "socat-proxy: ${SOCAT_ALLOW}" > /root/socat.allow

# Create TCP wrapper file for DENY
if [[ -z "${SOCAT_DENY}" ]] ; then
    [[ "${SOCAT_ALLOW}" = ALL ]] && SOCAT_DENY=NONE || SOCAT_DENY=ALL
fi
echo "socat-proxy: ${SOCAT_DENY}" > /root/socat.deny

# Reasonable defaults for source and target addresses regarding Docker Unix domain socket
[[ -z "${SOCAT_SRC}" ]] && SOCAT_SRC='TCP4-LISTEN:4550,fork'
[[ -z "${SOCAT_TGT}" ]] && SOCAT_TGT='unix-connect:/var/run/docker.sock'

TCPWRAP_OPTS=',tcpwrap=socat-proxy,allow-table=/root/socat.allow,deny-table=/root/socat.deny'
[[ "${SOCAT_TCPWRAP_OFF}" = "true" ]] && TCPWRAP_OPTS=''

# Run socat command line
exec socat ${SOCAT_OPTS} "${SOCAT_SRC}${TCPWRAP_OPTS}" "${SOCAT_TGT}"
