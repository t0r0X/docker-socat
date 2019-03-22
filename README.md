Docker image based on minideb (Debian) for running `socat`, with flexible configuration options nd TCP wrapper based access filtering. Has reasonable defaults for exporting the Docker Unix domain socket `/var/run/docker.sock` on port 4550, but is not restricted to that.

Environment variables:
* SOCAT_DEBUG: enable shell script debug output if value is 'true'.
    * default = 'false'
* SOCAT_ALLOW: TCP wrapper expression.
    * default = 'ALL'
* SOCAT_DENY: TCP wrapper expression.
    * default = 'NONE', if SOCAT_ALLOW is empty or 'ALL'
    * default = 'ALL', if SOCAT_ALLOW is not empty and not 'ALL'
* SOCAT_SRC: socat source address (what to export).
    * default = 'unix-connect:/var/run/docker.sock'
* SOCAT_TGT: socat target address (where and how to export).
    * default = 'TCP4-LISTEN:4550,fork'
* SOCAT_OPTS: additional optional socat parameters
    * default = ''

Examples:
* not recommended, because it exposes the Docker unix domain socket to the "world" on port 4550:<br/>
`docker run --name sock-exporter1 --detach -v /var/run/docker.sock:/var/run/docker.sock -p 4550:4550 t0r0x/socat`
* better restrict access to port 4550 by using TCP wrapper expressions:<br/>
`docker run --name sock-exporter2 --detach -v /var/run/docker.sock:/var/run/docker.sock -p 4550:4550 -e SOCAT_ALLOW=LOCAL,host.our-domain.com,11.22.33.44 t0r0x/socat`
* all parameters in action:<br/>
`docker run --name sock-exporter3 --detach -v /alternative-socket-location-on-my-host/name.sock:/path-in-container/othername.sock -p 9999:7777 -e SOCAT_DEBUG=true -e SOCAT_SRC='unix-connect:/path-in-container/othername.sock' -e SOCAT_TGT='TCP4-LISTEN:7777,fork' -e SOCAT_DENY=ALL -e SOCAT_ALLOW='LOCAL,host.our-domain.com,11.22.33.44,other-host.other-domain.org' -e SOCAT_OPTS='-d' t0r0x/socat`
