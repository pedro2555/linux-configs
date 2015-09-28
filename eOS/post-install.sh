#!/bin/bash

# install curl
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# start the the laptop-mode-tools
tlp start

# enable mod_rewrite on apache
sudo a2enmod rewrite
# copy pre-made php config file
cp php.ini /etc/php5/apache2/php.ini
# redirect apache document root to /var/www/
sed -i '/DocumentRoot/c\        DocumentRoot /var/www' /etc/apache2/sites-enabled/000-default.conf 
rm -rf /var/www
mkdir /var/www
chgrp www-data /var/www/
chmod g+w /var/www/
service apache2 restart
