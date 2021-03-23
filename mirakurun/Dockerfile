FROM chinachu/mirakurun

ENV DEV="make cmake gcc git g++ automake curl wget autoconf build-essential libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo zlib1g-dev procps less autoconf automake"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install $DEV && \
\
# libarib25
\
    git clone https://github.com/stz2012/libarib25 /tmp/libarib25 && \
    cd /tmp/libarib25 && \
    cmake . && \
    make && \
    make install && \
    rm -rf /tmp/libarib25 && \
\
# recdvb
\
    wget -P /tmp/ http://www13.plala.or.jp/sat/recdvb/recdvb-1.3.3.tgz && \
    tar xvzf recdvb-1.3.3.tgz && \
    cd recdvb-1.3.3 && \
    ./autogen.sh && \
    ./configure --enable-b25 && \
    make && \
    make install && \
    rm -rf /tmp/recdvb-1.3.3* && \
\
# recpt1
\
    git clone https://github.com/stz2012/recpt1 /tmp/recpt1 && \
    cd /tmp/recpt1/recpt1 && \
    sed -i -e 's/arib25/aribb25/g' configure.ac && \
    sed -i -e 's/arib25/aribb25/g' -e 's/HAVE_LIBARIB25/HAVE_LIBARIBB25/g' -e '/#include <aribb25\/arib_std_b25.h>/a#include <aribb25\/arib_std_b25_error_code.h>' decoder.h && \
    sed -i -e 's/HAVE_LIBARIB25/HAVE_LIBARIBB25/g' decoder.c && \
    sed -i -e 's/HAVE_LIBARIB25/HAVE_LIBARIBB25/g' recpt1.c && \
    ./autogen.sh && \
    ./configure --enable-b25 && \
    make && \
    make install && \
    rm -rf /tmp/recpt1
