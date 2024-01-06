#!/bin/sh
chown -R $(id -u):$(id -g) /source
exec "$@"
