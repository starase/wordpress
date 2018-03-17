FROM ubuntu:16.04
MAINTAINER Paolo De Michele <paolo@starase.com>

RUN apt-get update
 
RUN apt-get install -y nginx php7.0-fpm php7.0-mysql supervisor git-core zsh curl && \
    curl -L http://install.ohmyz.sh | sh || true && \
    chsh -s $(which zsh) && \
    rm -rf /var/lib/apt/lists/*


ENV nginx_vhost /etc/nginx/sites-available/default
ENV php_conf /etc/php/7.0/fpm/php.ini
ENV nginx_conf /etc/nginx/nginx.conf
ENV supervisor_conf /etc/supervisor/supervisord.conf


COPY default ${nginx_vhost}
COPY zsh.sh /opt

RUN chmod 700 /opt/zsh.sh && \
    /bin/bash /opt/zsh.sh

RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_conf} && \
    echo "\ndaemon off;" >> ${nginx_conf}
 
COPY supervisord.conf ${supervisor_conf}
 
RUN mkdir -p /run/php && \
    chown -R www-data:www-data /var/www/html && \
    chown -R www-data:www-data /run/php && \
    ln -s /var/www/html /app
 
VOLUME ["/app"]

 
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["./start.sh"]
 
EXPOSE 80
