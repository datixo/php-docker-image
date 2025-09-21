# PHP 8.3
FROM php:8.3-fpm-alpine

# Memory Limit:
RUN echo 'memory_limit = 4096M' >> /usr/local/etc/php/conf.d/docker-php-memory-limit.ini;

USER root

# Libraries
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer/composer:2-bin /composer /usr/bin/

# User Args
ARG UID=1000
ARG GID=1000

# System Packages
RUN apk update && apk --update-cache upgrade \
&& apk add --update-cache --no-cache --update su-exec tini busybox-suid shadow git unzip icu-dev gettext-envsubst bash curl

# Bash as a default shell...
RUN sed -i 's@root:x:0:0:root:/root:/bin/ash@root:x:0:0:root:/root:/bin/bash@g' /etc/passwd

# Del user `21` (possible mac error)
RUN deluser --remove-home ftp

# ODBC Driver
COPY --chown=${UID}:${GID} --chmod=0777 ./install-odbc-driver.sh .
RUN /bin/bash install-odbc-driver.sh
RUN rm ./install-odbc-driver.sh

RUN mkdir -p /var/www/.composer/cache/vcs \
    && mkdir -p /var/log/cron \
    && chmod 0777 -R /var/log/cron \
    && chown -R www-data.www-data /var/www/.composer/cache/vcs  \
    && chmod 0777 /sbin/su-exec \
    && install-php-extensions gd intl pdo pdo_pgsql pdo_mysql pdo_sqlsrv pdo_odbc bcmath excimer opcache redis soap \
    && usermod -u ${UID} www-data \
    && groupmod -g ${GID} www-data \
    && touch /etc/crontab \
    && chmod 0777 -R /tmp

COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini

ENTRYPOINT ["/sbin/tini", "--"]
CMD crontab -u www-data /etc/crontab && (crond -f -d 0 & su-exec var-www:var-www php-fpm -F -R)
