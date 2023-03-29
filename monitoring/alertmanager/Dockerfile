FROM fallgeratoor/alertmanager:alpine-r3.14

ENV SLACK_WEBHOOK=https://hooks.slack.com/services/

RUN apk add --no-cache unzip=6.0-r9 curl=7.79.1-r5 ca-certificates=20220614-r0 \
  && curl -sSL https://releases.hashicorp.com/consul-template/0.30.0/consul-template_0.30.0_linux_amd64.zip -o consul-template.zip \
  && unzip consul-template.zip -d /usr/local/bin/ \
  && chmod +x /usr/local/bin/consul-template \
  && rm -f consul-template.zip \
  && apk del unzip curl ca-certificates

COPY config.yml /etc/alertmanager/config.tmpl
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
