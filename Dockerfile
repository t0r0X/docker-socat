FROM bitnami/minideb:stretch

MAINTAINER t0r0X <docker.com@zeckenmagnet.de>

RUN install_packages socat

USER root

EXPOSE 4550/tcp

VOLUME /var/run/docker.sock

COPY launch.sh /root

ENTRYPOINT [ "bash", "-x", "/root/launch.sh" ]
