FROM fluent/fluentd:v1.16-1
ENV ELASTIC_PASSWORD=some_password
ENV ZIPKIN_ENABLED=false
# Use root account to use apk
USER root
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps curl \
  && curl -sSL https://releases.hashicorp.com/consul-template/0.30.0/consul-template_0.30.0_linux_amd64.zip -o consul-template.zip \
  && unzip consul-template.zip -d /usr/local/bin/ \
  && chmod +x /usr/local/bin/consul-template \
  && rm -f consul-template.zip \
  && apk add --no-cache build-base ruby-dev \
  && gem install fluent-plugin-elasticsearch \
  && gem install fluent-plugin-grok-parser \
  && gem sources --clear-all \
  && apk del .build-deps \
  && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent
COPY fluent.conf /fluentd/etc/fluent.tmpl

ENTRYPOINT [ "/entrypoint.sh" ]
