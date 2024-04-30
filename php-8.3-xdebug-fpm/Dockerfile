# Base Image
FROM datixo/php-8.3-fpm:latest

USER root

RUN install-php-extensions xdebug && \
    echo "xdebug.mode=coverage,develop,profile,trace" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.coverage_enable" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

USER www-data
