Docker image based on minideb (Debian) for running `socat`, with flexible configuration options and TCP wrapper based access filtering. Has reasonable defaults for exporting the Docker Unix domain socket `/var/run/docker.sock` on port 4550, but is not restricted to that.

Environment variables:
* SOCAT_DEBUG: enable shell script debug output if value is 'true'.
    * default = 'false'
* SOCAT_ALLOW: TCP wrapper expression, saved into '`/root/socat.allow`'
    * default = 'ALL'
* SOCAT_DENY: TCP wrapper expression, saved into '`/root/socat.deny`'
    * default = 'NONE', if SOCAT_ALLOW is empty or 'ALL'
    * default = 'ALL', if SOCAT_ALLOW is not empty and not 'ALL'
* SOCAT_SRC: socat target address (what to redirect).
    * default = 'TCP4-LISTEN:4550,fork,reuseaddr'
* SOCAT_TGT: socat source address (where to redirect).
    * default = 'unix-connect:/var/run/docker.sock'
* SOCAT_OPTS: additional optional socat parameters
    * default = ''
* SOCAT_NO_DEFAULT_TCPWRAP: if 'true', do not use script default TCP wrapper options
('`tcpwrap=socat-proxy,allow-table=/root/socat.allow,deny-table=/root/socat.deny`')
    * default = 'false'

Examples:
* not recommended, because it exposes the Docker unix domain socket to the "world" on port 4550:<br/>
`docker run --name sock-exporter1 --detach -v /var/run/docker.sock:/var/run/docker.sock -p 4550:4550 t0r0x/socat`
* better restrict access to port 4550 by using TCP wrapper expressions:<br/>
`docker run --name sock-exporter2 --detach -v /var/run/docker.sock:/var/run/docker.sock -p 4550:4550 -e SOCAT_ALLOW=localhost,host.our-domain.com,11.22.33.44 t0r0x/socat`
* all parameters in action:<br/>
`docker run --name sock-exporter3 --detach -v /alternative-socket-location-on-my-host/name.sock:/path-in-container/othername.sock -p 9999:7777 -e SOCAT_DEBUG=true -e SOCAT_SRC='TCP4-LISTEN:7777,fork,reuseaddr' -e SOCAT_TGT='unix-connect:/path-in-container/othername.sock' -e SOCAT_DENY=ALL -e SOCAT_ALLOW='localhost,host.our-domain.com,11.22.33.44,other-host.other-domain.org' -e SOCAT_OPTS='-d -d' t0r0x/socat`
* something completely different:<br/>
`docker run --name sock-exporter4 --detach --tty -p 9999:7777 -e SOCAT_DEBUG=true -e SOCAT_SRC='TCP4-LISTEN:7777,fork,reuseaddr' -e SOCAT_TGT='unix-connect:/path-in-container/othername.sock' -e SOCAT_DENY=ALL -e SOCAT_ALLOW='localhost,host.our-domain.com,11.22.33.44,other-host.other-domain.org' -e SOCAT_OPTS='-d -d' t0r0x/socat`
