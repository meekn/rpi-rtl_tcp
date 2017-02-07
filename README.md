# rtl_tcp on Raspberry Pi

Turns your Raspberry Pi into SDR (Software Defined Radio) server.

## Hardwares needed

* Raspberry Pi (install docker beforehand)
* Tuner dongle (about $20. google "rtl-sdr dongle" and buy one)

## Setting up

* Build docker image. (Sorry, prebuilt image is not prepared yet. Please build it by yourself.)

```bash
docker build -t rpi-rtl_tcp .
```

(in the root of this repository.)

* Turn off the default drivers for the dongle on Raspberry Pi (out of docker, not in the container).
    * Create a file /etc/modprobe.d/rtlsdr-blacklist.conf as below and reboot.

~~~
blacklist rtl2832
blacklist r820t
blacklist rtl2830
blacklist dvb_usb_rtl28xxu
~~~

* Plug the dongle into the Raspberry Pi.

* Run the dokcer container.
    * Map port 1234 to the host interface.
    * You have to show usb devices to the container with --device option.

```bash
docker run -d -p 1234:1234 --device=/dev/bus/usb rpi-rtl_tcp
```

* Now you will be able to connect to the Raspberry Pi (port 1234) with rtl_tcp client softwares. Enjoy!
