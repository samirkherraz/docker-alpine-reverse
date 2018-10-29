FROM samirkherraz/alpine-s6

RUN set -x \
    && apk --no-cache --virtual add nginx \
    && mkdir -p /var/www/ /run/nginx/ /etc/nginx/template/ \
    && rm -R /var/www/*  \
    && chown nginx:nginx /var/www/ /run/nginx/

ADD init/* /etc/cont-init.d/
ADD template/* /etc/nginx/template/

RUN set -x \
    && chmod +x /etc/cont-init.d/*
