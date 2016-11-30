#!/bin/bash

# Requirements
apt-get update -y
apt-get install -y php5-cli php5-curl php5-mcrypt git
php5enmod mcrypt

# Installation steps
git clone https://github.com/openstack-infra/openstackid.git
cd openstackid/
curl -s https://getcomposer.org/installer | php
echo "production" > bootstrap/environment.php
chown -R vagrant:vagrant ../openstackid/
su vagrant -c "php composer.phar install --prefer-dist"
exit
php composer.phar dump-autoload --optimize
php artisan migrate --env=YOUR_ENVIRONMENT
php artisan db:seed --env=YOUR_ENVIRONMENT
phpunit --bootstrap vendor/autoload.php
give proper rights to app/storage folder (775 and proper users)
vendor/bin/behat --config /home/smarcet/git/openstackid/behat.ym
