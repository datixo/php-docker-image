# Base Image
FROM ghcr.io/datixo/php-8.3-fpm:latest

USER root

RUN install-php-extensions xdebug

RUN echo "xdebug.mode=coverage,develop,profile,trace" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.coverage_enable" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

USER www-data
