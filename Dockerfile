FROM php:7-apache

ARG VERSION=3254

RUN apt-get update \
 && apt-get install -y \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libmcrypt-dev \
        unzip \
 && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
 && docker-php-ext-install gd mbstring mysqli pdo_mysql zip

RUN a2enmod rewrite actions

ENV VERSION=${VERSION}
ENV DIST e2_distr_v${VERSION}.zip
ENV URL https://blogengine.ru/download/${DIST}

RUN curl -O ${URL} && unzip ${DIST} -d /var/www/html

EXPOSE 80
