# PHP 8.3
FROM php:8.3-fpm-alpine

USER root

# Libraries
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer/composer:2-bin /composer /usr/bin/

# User Args
ARG UID=1000
ARG GID=1000

RUN mkdir -p /var/www/.composer/cache/vcs \
    && mkdir -p /var/log/cron \
    && chmod 0777 -R /var/log/cron \
    && chown -R www-data.www-data /var/www/.composer/cache/vcs  \
    && apk add --no-cache --update su-exec tini busybox-suid shadow git unzip icu-dev gettext-envsubst bash \
    && chmod 0777 /sbin/su-exec \
    && install-php-extensions gd intl pdo pdo_pgsql pdo_mysql bcmath excimer \
    && usermod -u ${UID} www-data \
    && groupmod -g ${GID} www-data \
    && touch /etc/crontab \
    && chmod 0777 -R /tmp

# Bash as a default shell...
RUN sed -i 's@root:x:0:0:root:/root:/bin/ash@root:x:0:0:root:/root:/bin/bash@g' /etc/passwd

ENTRYPOINT ["/sbin/tini", "--"]
CMD crontab -u www-data /etc/crontab && (crond -f -d 0 & su-exec var-www:var-www php-fpm -F -R)
