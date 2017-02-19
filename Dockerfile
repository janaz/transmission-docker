FROM ubuntu:xenial-20170119

ENV TRANSMISSION_VERSION 2.92

RUN apt-get update && \
  apt-get install -y \
  curl \
  xz-utils \
  build-essential \
  automake \
  autoconf \
  libtool \
  pkg-config \
  intltool \
  libcurl4-openssl-dev \
  libssl-dev \
  libglib2.0-dev \
  libevent-dev \
  libminiupnpc-dev \
  libminiupnpc10 \
  libappindicator-dev \
  perl \
  libjson-perl \
  && \
  mkdir -p /tmp/transmission && \
     curl -L https://github.com/transmission/transmission-releases/raw/master/transmission-${TRANSMISSION_VERSION}.tar.xz | tar -xvJC /tmp/transmission --strip-components=1 && \
     cd /tmp/transmission && \
     ./configure --prefix=/usr/local --disable-shared --enable-static \
                --disable-dependency-tracking --disable-debug \
                --enable-cli --enable-utp && \
     make install-strip && \
     rm -rf /tmp/transmission && \
  apt-get -y remove \
    xz-utils \
    build-essential \
    automake \
    autoconf \
    libtool \
    pkg-config \
    intltool  && \
  apt-get -y autoremove && \
  apt-get -y clean all

EXPOSE 9999 9999/udp 8080

ADD run /app/run
ADD make_config.pl /app/make_config.pl
ADD done-script.sh /app/done-script.sh
WORKDIR /app
CMD /app/run
