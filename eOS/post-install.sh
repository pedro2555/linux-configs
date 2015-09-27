#!/bin/bash

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

tlp start

sed -i '/DocumentRoot/c\        DocumentRoot /var/www' /etc/apache2/sites-enabled/000-default.conf 
rm -rf /var/www
mkdir /var/www
chgrp www-data /var/www/
chmod g+w /var/www/
service apache2 restart