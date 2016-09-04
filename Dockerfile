FROM alpine:edge
MAINTAINER Chris Goller <goller@gmail.com>

ADD . /src
ADD run.sh create_keys.sh /usr/local/bin/

RUN apk update && \
  apk add ncurses libevent openssh ncurses-terminfo && \
  apk add git automake autoconf libtool pkgconf build-base zlib-dev \
  openssl-dev libevent-dev ncurses-dev cmake ruby libssh libssh-dev \
  libexecinfo libexecinfo-dev linux-headers && \
  git clone https://github.com/msgpack/msgpack-c.git && \
  cd msgpack-c && \
  cmake -DMSGPACK_CXX11=ON -DCMAKE_INSTALL_PREFIX=/usr . && \
  make && \
  make install && \
  cd .. && \
  rm -rf msgpack-c && \
  cd src && \
  mkdir -p etc && \
  aclocal && \
  automake --add-missing --force-missing --copy --foreign && \
  autoreconf && \
  LIBS='-lexecinfo' CFLAGS='-DCLONE_NEWPID -DCLONE_NEWIPC -DCLONE_NEWNS -DCLONE_NEWNET' ./configure # && \
  make && \
  make install && \
  apk del git automake autoconf libtool pkgconf build-base zlib-dev \
  openssl-dev libevent-dev ncurses-dev cmake ruby libssh-dev \
  linux-headers libexecinfo-dev && \
  cd .. && \
  rm -rf /src

CMD ["/usr/local/bin/run.sh"]
