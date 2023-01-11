#!/usr/bin/env bash
/usr/bin/mongod --fork --logpath /var/log/mongod.log --config /etc/mongod.conf

# shellcheck source=/dev/null
source /reddit/db_config

cd /reddit && puma || exit
