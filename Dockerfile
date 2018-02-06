FROM centos:7

RUN yum install -y epel-release \
    && yum clean all \
    && yum install -y nginx \
    && yum clean all

RUN mkdir /var/cache/nginx \
    && chmod -R g+w /var/cache/nginx \
    && chmod -R 0666 /var/log/nginx /var/lib/nginx \
    && sed -i -e '/listen/!b' -e '/80;/!b' -e 's/80;/8080;/' /etc/nginx/nginx.conf \
    && sed -i 's!80!8080!g' /etc/nginx/nginx.conf \
	&& sed -i -e '/user/!b' -e '/nginx/!b' -e '/nginx/d' /etc/nginx/nginx.conf \
	&& sed -i 's!/run/nginx.pid!/var/cache/nginx/nginx.pid!g' /etc/nginx/nginx.conf

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY . /usr/share/nginx/html

EXPOSE 8080

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]