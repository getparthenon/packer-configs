#!/bin/sh
ln -sf /dev/stdout /var/log/nginx/access.log;
ln -sf /dev/stderr /var/log/nginx/error.log;
php-fpm8.1
nginx -g 'daemon off;'
