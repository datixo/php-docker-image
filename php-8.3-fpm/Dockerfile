# PHP 8.3
FROM php:8.3-fpm

USER root

# Composer
COPY --from=composer/composer:2-bin /composer /usr/bin/composer

# Libraries
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN apt update
RUN apt install -y git unzip # Composer Dependencies
RUN apt install -y libicu-dev # Intl Dependencies

RUN sync

RUN install-php-extensions gd intl pdo_pgsql gettext

# Setup user
ARG UID=1000
ARG GID=1000

RUN usermod -u ${UID} www-data; groupmod -g ${GID} www-data

USER www-data
