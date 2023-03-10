FROM nginx:alpine

RUN apk update \
    && apk upgrade \
    && apk --update add logrotate \
    && apk add --no-cache openssl \
    && apk add --no-cache bash \
    && apk add --no-cache certbot \
    && apk add --no-cache inotify-tools \
    && apk add --no-cache certbot-nginx

RUN set -x ; \
    addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

ADD ./startup.sh /opt/startup.sh
ADD ./certbot.sh /opt/certbot.sh

COPY ./crontab /opt/crontab
RUN cat /opt/crontab >> /var/spool/cron/crontabs/root

RUN sed -i 's/\r//g' /opt/startup.sh
RUN sed -i 's/\r//g' /opt/certbot.sh

CMD ["/bin/bash", "/opt/startup.sh"]