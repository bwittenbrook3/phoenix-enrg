#!/bin/bash
set -ex

# update to correct port for heroku
sed -i "s/listen 80/listen ${PORT:-80}/g" /etc/nginx/nginx.conf

/usr/bin/nf start
