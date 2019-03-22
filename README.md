Docker image running socat, based on minideb, with flexible configuration options, and TCP wrapper based access filtering.

Environment variables:
* SOCAT_DEBUG: optional, enable shell script debug output if 'true'
* SOCAT_ALLOW: TCP wrapper expression, optional, default = 'ALL'
* SOCAT_DENY: TCP wrapper expression, optional, default = 'NONE'
* SOCAT_SRC: socat source address (what to export)
* SOCAT_TGT: socat target address (where to export)
* SOCAT_OPTS: additional parameters, optional
