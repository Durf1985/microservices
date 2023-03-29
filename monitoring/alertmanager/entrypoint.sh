#!/bin/sh

# Start consul-template with Alertmanager
consul-template -template="/etc/alertmanager/config.tmpl:/etc/alertmanager/config.yml" -once

exec alertmanager --config.file=/etc/alertmanager/config.yml
