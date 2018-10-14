#!/bin/bash

/etc/init.d/php7.1-fpm start
/etc/init.d/nginx start
find /var/lib/mysql/mysql -exec touch -c -a {} +
/etc/init.d/mysql restart