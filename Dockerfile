FROM ubuntu:17.10

RUN apt-get update && apt-get -y install git curl
RUN apt-get install -y --allow-unauthenticated php7.1 php7.1-xml php7.1-mbstring php7.1-mysql php7.1-json php7.1-curl php7.1-cli php7.1-common php7.1-mcrypt php7.1-gd php7.1-fpm php7.1-zip
RUN apt-get install -y composer nginx
ADD nginx/default /etc/nginx/sites-available
WORKDIR /var/www
RUN git clone https://github.com/jbsn94/laravel-horarioaulas.git laravel
WORKDIR /var/www/laravel
RUN composer install
COPY .env /var/www/laravel
RUN php artisan key:generate
RUN chown -R www-data:www-data \
    storage \
    bootstrap/cache
RUN service nginx start
EXPOSE 80 443
CMD /etc/init.d/php7.1-fpm start && exec nginx -g 'daemon off;' 