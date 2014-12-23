#!/bin/bash

export REDIS_URL=redis://${REDIS_PORT_6379_TCP_ADDR}:${REDIS_PORT_6379_TCP_PORT}
printenv
cd /var/www && bundle exec unicorn -c unicorn.conf
