FROM balenalib/rpi-raspbian:buster
# by cyberdork33 <cyberdork33@gmail.com>
# derived from work by Carl Seelye <cseelye@gmail.com>

## Install needed packages
RUN apt update
RUN apt --assume-yes full-upgrade
RUN apt --assume-yes install python3 python3-pip
RUN apt --assume-yes install supervisor uwsgi uwsgi-plugin-python3 nginx
RUN pip3 install flask
RUN mkdir --parents /app
RUN apt autoremove
RUN apt clean
RUN rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Put files into place
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY uwsgi-common.ini /etc/uwsgi/uwsgi-common.ini
COPY app.conf /etc/nginx/conf.d/app.conf
RUN rm /etc/nginx/sites-enabled/default

## Execute
WORKDIR /app
CMD ["/usr/bin/supervisord"]
