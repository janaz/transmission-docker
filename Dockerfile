FROM debian:sid-slim
RUN apt-get update && \
  apt-get -y install \
    transmission-daemon=2.92-2 \
    perl \
    libjson-perl \
  && apt-get -y clean all

EXPOSE 9999 9999/udp 8080

ADD run /app/
ADD make_config.pl /app/
ADD done-script.sh /app/
WORKDIR /app
CMD /app/run
