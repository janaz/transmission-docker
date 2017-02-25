FROM ubuntu:xenial-20170119

RUN /bin/echo -e "deb http://ppa.launchpad.net/transmissionbt/ppa/ubuntu xenial main\ndeb-src http://ppa.launchpad.net/transmissionbt/ppa/ubuntu xenial main" > /etc/apt/sources.list.d/transmission.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 365C5CA1

RUN apt-get update && \
  apt-get -y install \
    transmission-daemon=2.92-1ubuntu1~16.104.2 \
    perl \
    libjson-perl \
  && apt-get -y clean all

EXPOSE 9999 9999/udp 8080

ADD run /app/
ADD make_config.pl /app/
ADD done-script.sh /app/
WORKDIR /app
CMD /app/run
