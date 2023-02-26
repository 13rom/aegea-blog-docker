FROM php:7-apache

ARG AEGEA_VERSION=4079

RUN apt-get update && apt-get install -y \
       libfreetype6-dev \
       libjpeg62-turbo-dev \
       libpng-dev \
       libonig-dev \
       unzip \
       && docker-php-ext-configure gd --with-freetype --with-jpeg \
       && docker-php-ext-install -j$(nproc) gd mbstring pdo_mysql mysqli \
       && docker-php-source delete \
       && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite actions

ENV AEGEA_VERSION=${AEGEA_VERSION}
ENV DIST e2_distr_v${AEGEA_VERSION}.zip
ENV URL https://blogengine.ru/download/${DIST}

RUN curl -O ${URL} && unzip ${DIST} -d /var/www/html

EXPOSE 80
