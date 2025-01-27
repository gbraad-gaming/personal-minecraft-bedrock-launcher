ARG BASE_IMAGE="ghcr.io/gbraad-devenv/fedora/rdesktop"
ARG BASE_VERSION=41

FROM ${BASE_IMAGE}:${BASE_VERSION}

COPY assets/minecraft-linux-pkg.repo /etc/yum.repos.d/

USER root

RUN dnf install -y \
        mcpelauncher-manifest \
        mcpelauncher-ui-manifest \
        msa-manifest \
    && dnf clean all \
    && rm -rf /var/cache/yum

USER gbraad

RUN echo "exec mcpelauncher-ui-qt" >> $HOME/.config/i3/config

USER root
# ensure to become root for systemd
#ENTRYPOINT ["/sbin/init"]