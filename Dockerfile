FROM phusion/baseimage

RUN add-apt-repository ppa:ondrej/php && \
	apt-get update && \
    apt-get install nodejs npm unzip git nginx libmysqlclient-dev php7.1 php7.1-dom php7.1-mbstring php7.1-mysql php7.1-fpm mysql-server -y && \
    rm -rf /var/lib/apt/lists/*

COPY laravel.conf /etc/nginx/sites-available/default
RUN sed -i "s/;phar.readonly = On/phar.readonly = Off/g" /etc/php/7.1/fpm/php.ini
COPY ./data.sql /tmp/data.sql
RUN find /var/lib/mysql/mysql -exec touch -c -a {} + && \
    service mysql start && \
    mysql -uroot < /tmp/data.sql && \
    rm -rf /tmp/data.sql
COPY composer.phar /usr/local/bin/composer   
RUN chmod u+x /usr/local/bin/composer && composer config -g repo.packagist composer https://packagist.laravel-china.org
WORKDIR /usr/share/nginx/html
COPY ./www .
RUN composer update 
RUN cp .env.example .env && \
    sed -i "s/homestead/hwb/g" .env && \
    sed -i "s/=secret/=ataith3asheeh@e/g" .env && \
    sed -i "s/APP_DEBUG=true/APP_DEBUG=false/g" .env && \
    sed -i "s/MAIL_HOST=mailtrap.io/MAIL_HOST=smtp.exmail.qq.com/g" .env && \
    sed -i "s/MAIL_PORT=2525/MAIL_PORT=465/g" .env && \
    sed -i "s/MAIL_USERNAME=null/MAIL_USERNAME=mail@qvq.im/g" .env && \
    sed -i "s/MAIL_PASSWORD=null/MAIL_PASSWORD=Nya@4uuu/g" .env && \
    sed -i "s/MAIL_ENCRYPTION=null/MAIL_ENCRYPTION=ssl/g" .env && \
    php artisan key:generate && \
    find /var/lib/mysql/mysql -exec touch -c -a {} + && \
    service mysql start && \
    php artisan migrate && \
    php artisan db:seed && \
    php artisan vendor:publish --provider="Laracasts\\Flash\\FlashServiceProvider"
COPY ./flag.php ./storage/framework/views/34e41df0934a75437873264cd28e2d835bc38772.php
RUN touch -t 209912121212.12 ./storage/framework/views/34e41df0934a75437873264cd28e2d835bc38772.php
RUN touch ./storage/logs/laravel.log && chown -R www-data:www-data ./storage
COPY ./start.sh /etc/my_init.d/start.sh
RUN chmod u+x /etc/my_init.d/start.sh

RUN echo 'flag{test_flag}' > /th1s1s_F14g_2333333
