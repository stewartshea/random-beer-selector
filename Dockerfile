FROM nginx:stable

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./site.conf /etc/nginx/conf.d/default.conf
COPY . /var/www/htdocs

RUN touch /var/run/nginx.pid && \
  chown -R 101:101 /var/run/nginx.pid && \
  chown -R 101:101 /var/cache/nginx && \
  chmod 0777 -R /var

USER 101

VOLUME /var/www
