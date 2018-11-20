# kali-tools
Tools and configs for my Kali installation.

Basic installation is done with:

    ./bin/setup.sh

To get my version of _.bashrc_, _.vimrc_ run *make*.

Some of the added alias are:

* *act*=". .env/bin/activate"
* *zerodisk*="dd if=/dev/zero of=zero; rm -f zero"

Configuration scripts exists for the following tools.

* [drown](https://github.com/nimia/public_drown_scanner)
* [iSniff-GPS](https://github.com/hubert3/iSniff-GPS)

## Tools
### drown

To install run:

    ./bin/setup-drown.sh

### iSniff-GPS

I've only tested the script with [TP-Link TL-WN722N](http://www.tp-link.com/en/products/details/cat-11_TL-WN722N.html). It has to be hardware version 1.10. The current hardware version 2 and 3 doesn't work.

To install run:

    ./bin/setup-iSniff-GPS.sh

To use it run:

    ./bin/iSniff-GPS-listen.sh      # Start to listen
    ./bin/iSniff-GPS-web.sh         # Start web server and iceweasel

### Alfa wireless card

I have a wireless card from [Alfa](https://www.alfa.com.tw/). To get it working do the following after connecting with USB 3.0 if run in Fusion:

    apt-get install realtek-rtl88xxau-dkms
    modprobe 88XXau

To activate it in monitoring mode run:

    iwconfig wlan0 mode monitor

More information can be found in this blog about [How to get your new 5 GHz wireless penetration gear up and working](https://medium.com/@adam.toscher/configure-your-new-wireless-ac-1fb65c6ada57).
