FROM transmission-build

ENV TRANSMISSION_VERSION 2.92

RUN mkdir -p /tmp/transmission && \
   curl -L https://download.transmissionbt.com/files/transmission-${TRANSMISSION_VERSION}.tar.xz | tar -xvJC /tmp/transmission --strip-components=1 && \
   cd /tmp/transmission && \
   cp /tmp/version.h ./libtransmission/version.h && \
   ./configure --prefix=/usr/local --disable-shared --enable-static \
              --disable-dependency-tracking --disable-debug \
              --enable-cli --enable-utp && \
   make install-strip && \
   rm -rf /tmp/transmission

USER nobody
