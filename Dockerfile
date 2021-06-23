FROM php:7.4.20-apache

#install mysqli
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Install needed php extensions: gprc
RUN set -xe && \
    apt-get update && \
    apt-get -y --no-install-recommends install g++ zlib1g-dev libzip-dev && \
    rm -rf /var/lib/apt/lists/* && \
    pecl install grpc

RUN docker-php-ext-install zip && \
    docker-php-ext-install opcache && \
    docker-php-ext-enable grpc

RUN \
    a2enmod headers && \
    a2enmod cache && \
    a2enmod proxy && \
    a2enmod proxy_http && \
    a2enmod expires
	
#add Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

