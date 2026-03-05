FROM ubuntu:22.04

LABEL maintainer="Padavan Docker Build"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential gawk flex bison gperf cmake git wget curl unzip \
    libtool-bin libtool autoconf automake autopoint gettext gettext-base \
    autoconf-archive python3-docutils texinfo help2man pkg-config \
    zlib1g-dev libgmp3-dev libmpc-dev libmpfr-dev libncurses5-dev \
    libltdl-dev xxd cpio kmod fakeroot nano xz-utils \
    && apt-get clean

RUN mkdir -p /opt/padavan/toolchain-mipsel/toolchain-3.4.x

RUN wget -O /tmp/toolchain.tar.xz \
    https://github.com/hanwckf/padavan-toolchain/releases/download/v1.0/mipsel-linux-uclibc.tar.xz \
    && tar -xf /tmp/toolchain.tar.xz -C /opt/padavan/toolchain-mipsel/toolchain-3.4.x --strip-components=1 \
    && rm /tmp/toolchain.tar.xz

ENV PATH=/opt/padavan/toolchain-mipsel/toolchain-3.4.x/bin:$PATH

WORKDIR /opt/padavan
