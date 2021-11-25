#!/bin/sh
ln -sf /dev/stdout /var/log/php-fpm8.0.log;
php-fpm8.0 -F
