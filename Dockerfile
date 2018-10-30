FROM samirkherraz/alpine-s6

RUN set -x \
    && apk --no-cache --virtual add nginx \
    && mkdir -p /var/www/ /run/nginx/ \
    && rm -R /var/www/*  \
    && chown nginx:nginx /var/www/ /run/nginx/


RUN set -x \
    && wget https://dl.eff.org/certbot-auto -O /usr/sbin/certbot-auto \
    && chmod +x /usr/sbin/certbot-auto

ADD conf/ /
RUN set -x \
    && chmod +x /etc/cont-init.d/* \
    && chmod +x /etc/s6/services/*/*