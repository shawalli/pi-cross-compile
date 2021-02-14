FROM ubuntu:16.04

MAINTAINER Shawn Wallis "shawn.p.wallis@gmail.com"

ARG APT_PACKAGES="""\
    build-essential \
    gcc-5-arm-linux-gnueabi \
    gcc-arm-linux-gnueabihf \
    git \
    wget \
"""

RUN apt-get update -y && \
    apt-get install -y ${APT_PACKAGES}

RUN git clone --progress https://github.com/raspberrypi/tools.git --depth=1 pitools

# CMD ["/bin/bash", "-c", "make", "-f", "${BUILD_FOLDER}/Makefile"]

ARG GO_VERSION=1.13.9
ARG TINYGO_VERSION=0.12.0

# Install Go
RUN wget https://dl.google.com/go/go${GO_VERSION}.linux-armv6l.tar.gz
RUN tar -xvzf go${GO_VERSION}.linux-armv6l.tar.gz -C ${HOME}

ENV GOROOT=${HOME}/go
ENV PATH=${PATH}:${GOROOT}/bin

# Install TinyGo
#RUN wget https://github.com/tinygo-org/tinygo/releases/download/v${TINYGO_VERSION}/tinygo_${TINYGO_VERSION}_armhf.deb
#RUN dpkg -i tinygo_${TINYGO_VERSION}_armhf.deb

#ENV PATH=${PATH}:/usr/local/tinygo/bin

RUN go version
#RUN go version && tinygo version
