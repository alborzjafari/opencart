#FROM php:8.2-cli
#
#RUN mkdir /opencart
##RUN apt-get update && apt-get install -y libmemcached-dev libssl-dev zlib1g-dev \
##	&& pecl install memcached-3.2.0 \
##	&& docker-php-ext-enable memcached
#
#WORKDIR /opencart
#
##RUN chmod 0777 config.php
##RUN chmod 0777 admin/config.php
#
##CMD [ "php", "./index.php" ]
#CMD [ "sleep", "199009" ]

# Use an official PHP image as the base image
FROM php:8.2-apache

RUN apt-get update && apt-get install -y libzip-dev zip

# Install required PHP extensions and dependencies
RUN docker-php-ext-install mysqli pdo pdo_mysql zip
RUN apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd

# Copy the OpenCart source code into the container
COPY launch.sh /
RUN chmod +x /launch.sh
WORKDIR /

# Expose the Apache web server port
EXPOSE 80

# Start Apache when the container starts
CMD ["./launch.sh"]

