FROM hypriot/rpi-alpine-scratch:v3.4

MAINTAINER Mitsuharu Kurita

ENV BUILD_DEPS alpine-sdk cmake libusb-dev

ENV PERSISTENT_RUNTIME_DEPS libusb

RUN apk --no-cache add $BUILD_DEPS \
    && git clone git://git.osmocom.org/rtl-sdr.git \
    && mkdir rtl-sdr/build \
    && cd rtl-sdr/build \
    && cmake ../ \
             -DINSTALL_UDEV_RULES=ON \
             -DDETACH_KERNEL_DRIVER=ON \
    && make -j $(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && make install \
    && apk del --purge $BUILD_DEPS \
    && apk --no-cache add $PERSISTENT_RUNTIME_DEPS \
    && cd ../../ \
    && rm -rf rtl-sdr

CMD rtl_tcp -a 0.0.0.0
