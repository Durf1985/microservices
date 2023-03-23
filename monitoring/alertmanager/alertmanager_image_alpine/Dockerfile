FROM alpine:3.14

ARG ALERTMANAGER_VERSION=0.25.0

RUN apk add --no-cache curl=7.79.1-r5 ca-certificates=20220614-r0 \
    && curl -sSL -o /tmp/alertmanager.tar.gz https://github.com/prometheus/alertmanager/releases/download/v${ALERTMANAGER_VERSION}/alertmanager-${ALERTMANAGER_VERSION}.linux-amd64.tar.gz \
    && tar -xzf /tmp/alertmanager.tar.gz -C /tmp/ \
    && mv /tmp/alertmanager-${ALERTMANAGER_VERSION}.linux-amd64/alertmanager /usr/local/bin/ \
    && rm -rf /tmp/alertmanager.tar.gz /tmp/alertmanager-${ALERTMANAGER_VERSION}.linux-amd64 \
    && apk del curl ca-certificates

EXPOSE 9093

ENTRYPOINT ["/usr/local/bin/alertmanager"]
CMD ["--config.file=/etc/alertmanager/alertmanager.yml", "--storage.path=/alertmanager"]
