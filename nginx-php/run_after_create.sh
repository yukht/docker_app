chmod 755 ./logs
docker exec -i php-fpm /bin/sh -c "chown -R www-data /var/www && chmod 755 /var/www"
