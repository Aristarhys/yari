FROM bitnami/minideb:latest

# RENPY_VERSION=7.7.1

ARG RENPY_VERSION=8.2.1
ENV RENPY_VERSION=$RENPY_VERSION

RUN install_packages curl tar bzip2 libgl1 git git-lfs ca-certificates \
&& curl -sSL https://www.renpy.org/dl/${RENPY_VERSION}/renpy-${RENPY_VERSION}-sdk.tar.bz2 | tar -xj \
&& mv renpy-${RENPY_VERSION}-sdk renpy

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
