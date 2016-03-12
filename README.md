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

I've only tested the script with [TP-Link TL-WN722N](http://www.tp-link.com/en/products/details/cat-11_TL-WN722N.html). In Sweden [Webhallen](http://www.webhallen.com/se-sv/datorer_och_tillbehor/109609-tp-link_tradlost_natverkskort_150mbps_80211n_tl-wn722n) has it for 109 kr (2016-03-03).

To install run:

    ./bin/setup-iSniff-GPS.sh

To use it run:

    ./bin/iSniff-GPS-listen.sh      # Start to listen
    ./bin/iSniff-GPS-web.sh         # Start web server and iceweasel

##TODO
* https://github.com/PicciMario/iPhone-Backup-Analyzer-2
