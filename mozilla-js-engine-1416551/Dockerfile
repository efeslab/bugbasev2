FROM ubuntu:16.04

COPY index.js /

RUN apt-get update
RUN apt-get install -y wget python
RUN wget -O bootstrap.py https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py
RUN apt-get install -y autoconf2.13 build-essential nodejs python-dev python-pip python-setuptools unzip uuid zip python3 python3-dev
RUN apt-get install -y libasound2-dev libcurl4-openssl-dev libdbus-1-dev libdbus-glib-1-dev libgconf2-dev libgtk-3-dev libgtk2.0-dev libpulse-dev libx11-xcb-dev libxt-dev python-dbus xvfb yasm
RUN apt-get install -y mercurial
RUN sh -c '/bin/echo -e "1\n2\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" | python bootstrap.py' || true
RUN wget https://ftp.mozilla.org/pub/spidermonkey/releases/45.0.2/mozjs-45.0.2.tar.bz2
RUN tar -xvf mozjs-45.0.2.tar.bz2
WORKDIR /mozjs-45.0.2/js/src
RUN mkdir obj
WORKDIR /mozjs-45.0.2/js/src/obj
RUN export SHELL=/bin/bash && ../configure
RUN make
WORKDIR /mozjs-45.0.2/js/src/obj/js/src
CMD ./js -f /index.js

