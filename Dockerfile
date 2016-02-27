FROM ubuntu:14.04
MAINTAINER telminov@soft-way.biz

# Expose port 80 from the container to the host
EXPOSE 80

# config directory
VOLUME /config

RUN apt-get -qqy update && apt-get install nginx php-pear php5-dev php5-fpm -qqy

RUN printf "\n" | pecl install mongo

RUN echo '[Mongo]' >> /etc/php5/fpm/php.ini
RUN echo 'extension=mongo.so' >> /etc/php5/fpm/php.ini

COPY nginx_vhost.conf /etc/nginx/sites-enabled/default
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

ADD https://github.com/iwind/rockmongo/archive/1.1.7.tar.gz /tmp/rockmongo.tar.gz
RUN mkdir -p /var/www/rockmongo
RUN tar zxf /tmp/rockmongo.tar.gz -C /var/www/rockmongo/ --strip-components=1
RUN chown -R www-data:www-data /var/www/rockmongo

CMD test "$(ls -A /config/config.php)" || /var/www/rockmongo/config.sample.php; \
    rm /var/www/rockmongo/config.php; \
    ln -s /config/config.php /var/www/rockmongo/config.php; \
    service php5-fpm start; \
    /usr/sbin/nginx
