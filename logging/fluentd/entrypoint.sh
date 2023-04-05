#!/bin/sh
set -x
consul-template -template="/fluentd/etc/fluent.tmpl:/fluentd/etc/fluent.conf" -once
exec fluentd -c /fluentd/etc/fluent.conf
