# kali-tools

![Linter](https://github.com/reuteras/kali-tools/workflows/Linter/badge.svg)

Tools and configurations for my Kali installation.

Basic installation is done with:

    ./bin/setup.sh

To get my version of _.bashrc_, _.vimrc_ run *make*.

Configuration scripts exists for the following tools.

* [iSniff-GPS](https://github.com/hubert3/iSniff-GPS)
* [howmanypeoplearearound](https://github.com/schollz/howmanypeoplearearound)

## Tools

### iSniff-GPS

I've only tested the script with [TP-Link TL-WN722N](http://www.tp-link.com/en/products/details/cat-11_TL-WN722N.html). It has to be hardware version 1.10. The current hardware version 2 and 3 doesn't work.

To install run:

    ./bin/setup-iSniff-GPS.sh

To use it run:

    ./bin/iSniff-GPS-listen.sh      # Start to listen
    ./bin/iSniff-GPS-web.sh         # Start web server and iceweasel

### Alfa wireless card

I have a wireless card from [Alfa](https://www.alfa.com.tw/). To get it working do the following after connecting with USB 3.0 if run in Fusion:

    sudo apt-get install realtek-rtl88xxau-dkms
    sudo modprobe 88XXau

To activate it in monitoring mode run:

    sudo ip link set wlan0 down
    sudo iwconfig wlan0 mode monitor
    sudo ip link set wlan0 up

More information can be found in this blog about [How to get your new 5 GHz wireless penetration gear up and working](https://medium.com/@adam.toscher/configure-your-new-wireless-ac-1fb65c6ada57).

### howmanypeoplearearound

How Count the number of people around you by monitoring wifi signals with the help of [howmanypeoplearearound](https://github.com/schollz/howmanypeoplearearound).

    cd ~/kali-tools/bin
    ./configure-alfa-monitor.sh
    ./install-howmanypeoplearearound.sh
    cd ~/src/howmanypeoplearearound && . venv/bin/activate && howmanypeoplearearound -a wlan0

To create a graph of run the following command in one window:

    cd ~/src/howmanypeoplearearound && . venv/bin/activate && howmanypeoplearearound -o test.json -a wlan0 --loop

After a couple of points been created run this command in another window:

    cd ~/src/howmanypeoplearearound && . venv/bin/activate && howmanypeoplearearound --analyze test.json
