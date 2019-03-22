FROM bitnami/minideb:stretch

MAINTAINER t0r0X <docker.com@zeckenmagnet.de>

RUN install_packages socat

USER root

COPY launch.sh /root

ENTRYPOINT [ "bash", "/root/launch.sh" ]
