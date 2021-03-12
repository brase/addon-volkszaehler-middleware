ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

COPY init.sh ./
COPY start.sh ./

COPY init.sql /sql/init.sql

WORKDIR /vz

RUN apk add --no-cache \
        mariadb-client=10.5.8-r0 \
        python3 \
        postgresql-dev \
        nginx=1.18.0-r13 \
        php7-curl=7.4.15-r0 \
        php7-dom=7.4.15-r0 \
        php7-fpm=7.4.15-r0 \
        php7-gd=7.4.15-r0 \
        php7-iconv=7.4.15-r0 \
        php7-json=7.4.15-r0 \
        php7-mbstring=7.4.15-r0 \
        php7-mysqli=7.4.15-r0 \
        php7-opcache=7.4.15-r0 \
        php7-pcntl=7.4.15-r0 \
        php7-pdo=7.4.15-r0 \
        php7-pdo_mysql=7.4.15-r0 \
        php7-pdo_pgsql=7.4.15-r0 \
        php7-phar=7.4.15-r0 \
        php7-session=7.4.15-r0 \
        php7-tokenizer=7.4.15-r0 \
        php7-xml=7.4.15-r0 \
        php7-xmlwriter=7.4.15-r0 \
        php7-zip=7.4.15-r0 \
        php7=7.4.15-r0 \
    && apk add --no-cache --virtual .build-dependencies \
        build-base \
        curl-dev \
        git \
    && git clone --depth 1 https://github.com/volkszaehler/volkszaehler.org.git . \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
    && composer install --no-ansi --no-scripts --no-dev --no-interaction --no-progress --optimize-autoloader \
    && cp ./etc/config.dist.yaml ./etc/config.yaml \
    && sed -i "s/url: 'api'/url: '',/" ./htdocs/js/options.js

WORKDIR /

EXPOSE 8080
EXPOSE 8082
EXPOSE 5582

CMD /start.sh
