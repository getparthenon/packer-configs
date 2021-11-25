#!/bin/sh
ln -sf /dev/stderr /var/log/php-fpm8.0.log;
php-fpm8.0 -F
