FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y ca-certificates curl gnupg wget gpg apt-transport-https lsb-release \
 && curl -fsSL https://releases.hyperion-project.org/hyperion.pub.key | gpg --dearmor -o /usr/share/keyrings/hyperion.pub.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hyperion.pub.gpg] https://apt.releases.hyperion-project.org/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hyperion.list \
 && apt-get update \
 && apt-get install -y hyperion \
 && rm -rf /var/lib/apt/lists/*

ENV HYPERION_USERDATA_DIR=/config
VOLUME ["/config"]

EXPOSE 8090 8092 19444 19445

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]