FROM php:8.2-apache

RUN apt-get update && apt-get install -y libzip-dev zip

RUN docker-php-ext-install mysqli pdo pdo_mysql zip
RUN apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd

COPY launch.sh /
RUN chmod +x /launch.sh
WORKDIR /

CMD ["./launch.sh"]

