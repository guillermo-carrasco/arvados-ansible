#!/bin/bash

set -e
exec 2>&1

# Uncomment the line below if you're using RVM.
#source /etc/profile.d/rvm.sh

envdir="`pwd`/env"
mkdir -p "$envdir"
echo ws-only > "$envdir/ARVADOS_WEBSOCKETS"

cd /var/www/arvados-api/current
echo "Starting puma in `pwd`"

# Change arguments below to match your deployment, "webserver-user" and
# "webserver-group" should be changed to the user and group of the web server
# process.  This is typically "www-data:www-data" on Debian systems by default,
# other systems may use different defaults such the name of the web server
# software (for example, "nginx:nginx").
exec chpst -m 1073741824 -u nginx:nginx -e "$envdir" \
  bundle exec puma -t 0:512 -e production -b tcp://127.0.0.1:8100
