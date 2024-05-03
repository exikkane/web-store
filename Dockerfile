FROM php:7.4-apache
RUN apt-get update && apt-get install -y libzip-dev libpq-dev
RUN docker-php-ext-install zip pdo pdo_pgsql
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"
WORKDIR /var/www/html
COPY . .
EXPOSE 80
RUN composer install
CMD ["apache2-foreground"]
