# PHP 8.3
FROM php:8.3-fpm

USER root

# Libraries
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN apt update


# git, unzip - Composer Dependencies
# libicu-dev - Intl
# gettext - (bitbucket pipelines do not have it preinstalled)
RUN apt install -y git unzip libicu-dev gettext

RUN install-php-extensions @composer gd intl pdo_pgsql gettext

RUN mkdir -p /var/www/.composer/cache/vcs
RUN chmod 0777 -R /var/www/.composer

# Setup user
ARG UID=1000
ARG GID=1000

RUN usermod -u ${UID} www-data; groupmod -g ${GID} www-data

USER www-data
