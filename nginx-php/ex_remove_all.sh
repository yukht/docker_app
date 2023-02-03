# docker rm php-fpm nginx -f
# docker image prune -a -f
docker volume rm -f nginx-php_web_data nginx-php_web_logs nginx-php_web_templates nginx-php_php_data
docker image rm -f php-fpm-7.4-custom:0.1 php:7.4-fpm nginx:1.22-alpine
unlink logs/access.log && unlink logs/error.log && rm -f logs/*
