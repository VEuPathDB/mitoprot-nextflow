FROM ubuntu:22.04

Label maintainer="rdemko2332@gmail.com"

WORKDIR /usr/bin/

RUN apt-get -qq update --fix-missing && \
    apt-get install -y \
    wget \
    gcc \
    make \
    gnat

COPY /bin/Makefile .

WORKDIR /build

RUN wget ftp://ftp.biologie.ens.fr:21/pub/molbio/mitoprotII.tar.gz \
  && tar -zxvf mitoprotII.tar.gz \
  && cd mitoprotII-v1.101 \
  && rm Makefile \
  && cp /usr/bin/Makefile . \
  && gnatmake mitoprot \
  && make install

WORKDIR /work
