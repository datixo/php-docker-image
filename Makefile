build-php:
	docker build . -f php-8.3-fpm/Dockerfile -t datixo/php-8.3-fpm
	docker build . -f php-8.3-xdebug-fpm/Dockerfile -t datixo/php-8.3-xdebug-fpm

build-bitbucket:
	docker build . -f bitbucket-runner/Dockerfile -t datixo/bitbucket-runner
