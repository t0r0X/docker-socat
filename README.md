Docker image running socat, based on minideb, with flexible configuration options, and TCP wrapper based access filtering.

Environment variables:
* SOCAT_DEBUG: optional, enable shell script debug output if 'true'
* SOCAT_ALLOW: TCP wrapper expression, optional, default = 'ALL'
* SOCAT_DENY: TCP wrapper expression, optional, default = 'NONE'
* SOCAT_SRC: socat source address (what to export)
* SOCAT_TGT: socat target address (where to export)
* SOCAT_OPTS: additional parameters, optional

Example:
`docker run --name sock-exporter --rm --detach -v /var/run/docker.sock:/var/run/docker.sock -p4550:4550 -e SOCAT_SRC='unix-connect:/var/run/docker.sock' -e SOCAT_TGT='TCP4-LISTEN:4550,fork' -e SOCAT_DENY=ALL -e SOCAT_ALLOW=LOCAL,1.2.3.4,11.22.33.44 -e SOCAT_DEBUG=true t0r0x/socat`
