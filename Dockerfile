FROM balenalib/rpi-raspbian:buster
# by cyberdork33 <cyberdork33@gmail.com>
# derived from work by Carl Seelye <cseelye@gmail.com>

RUN apt update && \
    apt --assume-yes upgrade && \
    apt --assume-yes install curl python3 python3-dev python3-pip uwsgi supervisor nginx && \
    pip3 install flask && \
    mkdir --parents /app && \
    apt autoremove && \
    apt clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY uwsgi-common.ini /etc/uwsgi/uwsgi-common.ini
COPY app.conf /etc/nginx/conf.d/app.conf
RUN rm /etc/nginx/sites-enabled/default

WORKDIR /app
CMD ["/usr/bin/supervisord"]
