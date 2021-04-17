FROM l3tnun/epgstation:master-debian

ENV DEV="make cmake gcc git g++ automake curl wget autoconf build-essential libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo zlib1g-dev procps less autoconf automake locales"
ENV FFMPEG_VERSION=4.4

RUN echo "deb-src http://deb.debian.org/debian buster main" >> /etc/apt/sources.list && \
    echo "deb-src http://security.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list && \
    echo "deb-src http://deb.debian.org/debian buster-updates main" >> /etc/apt/sources.list && \
    echo "/opt/vc/lib" >> /etc/ld.so.conf && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install $DEV && \
    apt -y build-dep ffmpeg && \
    apt-get -y install yasm libx264-dev libmp3lame-dev libopus-dev libvpx-dev && \
    apt-get -y install libx265-dev libnuma-dev && \
    apt-get -y install libasound2 libass9 libvdpau1 libva-x11-2 libva-drm2 libxcb-shm0 libxcb-xfixes0 libxcb-shape0 libvorbisenc2 libtheora0 libjack0 libsdl2-2.0-0 libxv-dev libopenmpt-dev libbluray-dev libssh-gcrypt-4
# fdk-aac
RUN mkdir -p /tmp/aac && \
    cd /tmp/aac && \
    git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git && \
    cd fdk-aac && \
    ./autogen.sh && \
    ./configure && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/aac

# avisynth-headers
RUN mkdir /tmp/avisynth-headers && \
    cd /tmp/avisynth-headers && \
    git clone --depth 1 git://github.com/AviSynth/AviSynthPlus.git && \
    cd AviSynthPlus && \
    mkdir avisynth-build && \
    cd avisynth-build && \
    cmake ../ -DHEADERS_ONLY:bool=on && \
    make install && \
    rm -rf /tmp/avisynth-headers

# raspberrypi userland
RUN mkdir /tmp/userland && \
    cd /tmp/userland && \
    git clone --depth 1 git://github.com/raspberrypi/userland.git && \
    cd userland && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make install && \
    rm -rf /tmp/userland

#ffmpeg build
RUN mkdir /tmp/ffmpeg_sources && \
    cd /tmp/ffmpeg_sources && \
    wget http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 -O ffmpeg.tar.bz2 && \
    tar xjvf ffmpeg.tar.bz2 && \
    cd /tmp/ffmpeg_sources/ffmpeg* && \
    ./configure \
      --extra-version='1+rpt1~deb10u1' \
      --toolchain=hardened \
      --libdir=/usr/lib/arm-linux-gnueabihf \
      --incdir=/usr/include/arm-linux-gnueabihf \
      --arch=arm \
      --enable-gpl \
      --disable-stripping \
      --enable-avresample \
      --disable-filter=resample \
      --enable-avisynth \
      --enable-gnutls \
      --enable-ladspa \
      --enable-libaom \
      --enable-libass \
      --enable-libbluray \
      --enable-libbs2b \
      --enable-libcaca \
      --enable-libcdio \
      --enable-libcodec2 \
      --enable-libflite \
      --enable-libfontconfig \
      --enable-libfreetype \
      --enable-libfribidi \
      --enable-libgme \
      --enable-libgsm \
      --enable-libjack \
      --enable-libmp3lame \
      --enable-libopenjpeg \
      --enable-libopenmpt \
      --enable-libopus \
      --enable-libpulse \
      --enable-librsvg \
      --enable-librubberband \
      --enable-libshine \
      --enable-libsnappy \
      --enable-libsoxr \
      --enable-libspeex \
      --enable-libssh \
      --enable-libtheora \
      --enable-libtwolame \
      --enable-libvidstab \
      --enable-libvorbis \
      --enable-libvpx \
      --enable-libwebp \
      --enable-libx265 \
      --enable-libxml2 \
      --enable-libxvid \
      --enable-libzmq \
      --enable-libzvbi \
      --enable-lv2 \
      --enable-omx \
      --enable-openal \
      --enable-opengl \
      --enable-sdl2 \
      --enable-omx-rpi \
      --enable-mmal \
      --enable-libdc1394 \
      --enable-libdrm \
      --enable-libiec61883 \
      --enable-chromaprint \
      --enable-frei0r \
      --enable-libx264 \
      --enable-shared \
      --enable-libfdk-aac \
      --enable-nonfree \
    && \
    cd /tmp/ffmpeg_sources/ffmpeg* && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/ffmpeg_sources

# 不要なパッケージを削除
RUN apt-get -y remove $DEV && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 日本語入力
RUN sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen && \
    locale-gen && \
    echo "export LANG=ja_JP.UTF-8" >> ~/.bashrc

ENV LANG ja_JP.UTF-8
