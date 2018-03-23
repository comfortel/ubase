FROM ubuntu:xenial
MAINTAINER GateSPb <i@gatespb.com>

# ------------------------------------------------------------------------------
# Install base
ARG DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.utf8

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install \
            python-software-properties \
            software-properties-common \
            curl \
            locales \
            tzdata \
            supervisor \
            enca \
            git \
            sshfs \
            python3 \
            python3-venv \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf \
    && update-rc.d supervisor defaults \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ------------------------------------------------------------------------------
# Add volumes
VOLUME ["/etc/supervisor/conf.d"]

# ------------------------------------------------------------------------------
# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

