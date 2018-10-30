FROM samirkherraz/alpine-s6

RUN set -x \
    && apk --no-cache --virtual add nginx \
    && mkdir -p /var/www/ /run/nginx/ \
    && rm -R /var/www/*  \
    && chown nginx:nginx /var/www/ /run/nginx/


ADD conf/ /
RUN set -x \
    && chmod +x /etc/cont-init.d/* \
    && chmod +x /etc/s6/services/*/*