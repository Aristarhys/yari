FROM bitnami/minideb:bullseye

ARG renpy_version=7.4.11
ENV RENPY_VERSION=$renpy_version

RUN install_packages curl tar bzip2 libgl1 git git-lfs ca-certificates \
    && curl -sSL https://www.renpy.org/dl/${RENPY_VERSION}/renpy-${RENPY_VERSION}-sdk.tar.bz2 | tar -xj \
    && mv renpy-${RENPY_VERSION}-sdk renpy

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
