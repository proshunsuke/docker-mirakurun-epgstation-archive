FROM chinachu/mirakurun

RUN apt update && \
    apt upgrade -y && \
    apt install -y curl top less && \
\
# recdvb
\
    apt install -y cmake  build-essential && \
    git clone https://github.com/stz2012/libarib25 && \
    cd libarib25 && \
    cmake . && \
    make && \
    sudo make install && \
\
# recdvb
\
    git clone https://github.com/epgdatacapbon/recdvb /tmp/recdvb && \
    cd /tmp/recdvb && \
    ./autogen.sh && \
    ./configure --enable-b25 && \
    make && \
    make install && \
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
