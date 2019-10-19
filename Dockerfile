FROM alpine:latest
RUN apk --update --no-cache add bash \
    && mkdir -p /home/work
COPY /config /home/work

RUN set -x && \
    chown root:root /home/work/* && \
    chmod 755 /home/work/* && \
    ln -s /home/work/ss /bin/ss

# install supervisor
RUN apk --update add --no-cache supervisor \
    && mkdir -p /etc/supervisord.d
COPY /config/supervisord.conf /etc
COPY /config/process.conf /etc/supervisord.d
STOPSIGNAL SIGTERM
EXPOSE 8388
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
