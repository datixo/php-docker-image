# PHP 8.3
FROM php:8.3-fpm-alpine

USER root

# Libraries
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer/composer:2-bin /composer /usr/bin/

# User Args
ARG UID=1000
ARG GID=1000

RUN mkdir -p /var/www/.composer/cache/vcs && \
    chown -R www-data.www-data /var/www/.composer/cache/vcs && \
    apk add --no-cache --update shadow git unzip icu-dev gettext-envsubst && \
    install-php-extensions gd intl pdo_pgsql excimer && \
    usermod -u ${UID} www-data && \
    groupmod -g ${GID} www-data

USER www-data
