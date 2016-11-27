FROM transmission-build

ENV TRANSMISSION_VERSION 2.92

RUN mkdir -p /tmp/transmission && \
   curl -L https://github.com/transmission/transmission-releases/raw/master/transmission-${TRANSMISSION_VERSION}.tar.xz | tar -xvJC /tmp/transmission --strip-components=1 && \
   cd /tmp/transmission && \
   cp /tmp/version.h ./libtransmission/version.h && \
   ./configure --prefix=/usr/local --disable-shared --enable-static \
              --disable-dependency-tracking --disable-debug \
              --enable-cli --enable-utp && \
   make install-strip && \
   rm -rf /tmp/transmission

EXPOSE 9999 9999/udp 8080

ADD . /app
WORKDIR /app
CMD /app/run
USER 5000
