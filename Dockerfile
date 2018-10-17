FROM bitnami/minideb:stretch

MAINTAINER t0r0X <docker.com@zeckenmagnet.de>

RUN install_packages socat

USER root

VOLUME /var/run/docker.sock

COPY launch.sh .

ENTRYPOINT ["launch.sh"]
