#!/bin/sh
#
# -----------------------------------------------------------------------------

echo "** Preparing Crowi plus"

echo "** Waiting for other containers"

dockerize \
    -wait tcp://mongo:27017 \
    -wait tcp://redis:6379 \
    -wait tcp://elasticsearch:9200 \
    -timeout 60s

echo "########################################################"

echo "** Executing crowi-plus"

exec npm run server:prod:container