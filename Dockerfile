FROM debian:trixie-slim

LABEL org.opencontainers.image.title="Hyperion NG" \
      org.opencontainers.image.description="Open-source ambient lighting software" \
      org.opencontainers.image.source="https://github.com/tbringuier/hyperionng-dockerized"

ENV DEBIAN_FRONTEND=noninteractive

# Install Hyperion from official apt repository
# 1. Install temporary deps for GPG key + apt source setup
# 2. Add Hyperion repo and install hyperion
# 3. Purge temporary deps to minimize image size
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
    ; \
    . /etc/os-release; \
    curl -fsSL https://releases.hyperion-project.org/hyperion.pub.key \
      | gpg --dearmor -o /usr/share/keyrings/hyperion.pub.gpg; \
    printf 'deb [arch=%s signed-by=/usr/share/keyrings/hyperion.pub.gpg] https://apt.releases.hyperion-project.org/ %s main\n' \
      "$(dpkg --print-architecture)" "$VERSION_CODENAME" \
      > /etc/apt/sources.list.d/hyperion.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends hyperion; \
    apt-get purge -y --auto-remove curl gnupg; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV HYPERION_USERDATA_DIR=/config
VOLUME ["/config"]

EXPOSE 8090 8092 19444 19445

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

STOPSIGNAL SIGTERM
ENTRYPOINT ["/entrypoint.sh"]
