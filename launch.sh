#!/bin/bash

chown -R www-data:www-data /var/www/html
mv /var/www/html/admin/config-dist.php /var/www/html/admin/config.php

apache2-foreground
