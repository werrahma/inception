#!/bin/bash

sleep 5

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

wp config create --dbname=$sdb1_name --dbuser=$sdb1_user --dbpass=$sdb1_pwd --dbhost=$sdbhost --allow-root
# installs WordPress and sets up the basic configuration for the site. The --url option specifies the URL of the site, --title sets the site's title, --admin_user and --admin_password set the username and password for the site's administrator account, and --admin_email sets the email address for the administrator. The --skip-email flag prevents WP-CLI from sending an email to the administrator with the login details.
wp core install --url=$sDOMAIN_NAME --title=$sWP_TITLE --admin_user=$sWP_ADMIN_USR --admin_password=$sWP_ADMIN_PWD --admin_email=$sWP_ADMIN_EMAIL  --allow-root

wp user create $sWP_USR $sWP_EMAIL --role=author --user_pass=$sWP_PWD --allow-root

mkdir /run/php

# starts the PHP-FPM service in the foreground. The -F flag tells PHP-FPM to run in the foreground, rather than as a daemon in the background.
exec /usr/sbin/php-fpm7.4 -F
