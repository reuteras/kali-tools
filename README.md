# kali-tools

[![Linter](https://github.com/reuteras/kali-tools/actions/workflows/linter.yml/badge.svg)](https://github.com/reuteras/kali-tools/actions/workflows/linter.yml)

Tools and configurations for my [Kali](https://www.kali.org/) installation.

Basic installation is done with:

```bash
./bin/setup.sh
```

The repository includes a Makefile with the following targets:

- `make install` - install my versions of _.bashrc_, _.bash_aliases_ and _.vimrc_
- `make update` - update the installed packages
- `make clean` - remove cached packages and zero free disk space before shrinking a VM disk
- `make test` - run shellcheck on the scripts

Install scripts exist for the following tools:

- [bbot](https://github.com/blacklanternsecurity/bbot) - `bin/install-bbot.sh`
- [capa](https://github.com/mandiant/capa) - `bin/update-capa.sh` installs or updates capa in _~/bin_
- [Docker](https://www.kali.org/docs/containers/installing-docker-on-kali/) - `bin/install-docker.sh`
- [howmanypeoplearearound](https://github.com/schollz/howmanypeoplearearound) - `bin/install-howmanypeoplearearound.sh`

Shared folders in VMware are mounted under _/mnt/hgfs_ with `sudo bin/mount-shared-folders`.

## Tools

### Alfa wireless card

I have a wireless card from [Alfa](https://www.alfa.com.tw/). To install the driver and put the card in monitor mode after connecting it with USB 3.0 (if run in VMware Fusion) run:

```bash
./bin/configure-alfa-monitor.sh
```

The script does the following:

```bash
sudo apt install -y realtek-rtl88xxau-dkms
sudo modprobe 88XXau
sudo ip link set wlan0 down
sudo iw dev wlan0 set type monitor
sudo ip link set wlan0 up
```

More information can be found in this blog about [How to get your new 5 GHz wireless penetration gear up and working](https://medium.com/@adam.toscher/configure-your-new-wireless-ac-1fb65c6ada57).

### howmanypeoplearearound

Count the number of people around you by monitoring Wi-Fi signals with the help of [howmanypeoplearearound](https://github.com/schollz/howmanypeoplearearound). Note that the upstream project hasn't had a release since 2019.

```bash
cd ~/kali-tools/bin
./configure-alfa-monitor.sh
./install-howmanypeoplearearound.sh
cd ~/src/howmanypeoplearearound && . venv/bin/activate && howmanypeoplearearound -a wlan0
```

To create a graph, run the following command in one window:

```bash
cd ~/src/howmanypeoplearearound && . venv/bin/activate && howmanypeoplearearound -o test.json -a wlan0 --loop
```

After a couple of points have been collected, run this command in another window:

```bash
cd ~/src/howmanypeoplearearound && . venv/bin/activate && howmanypeoplearearound --analyze test.json
```

### bbot

For more information see the GitHub [repository](https://github.com/blacklanternsecurity/bbot).

```bash
./bin/install-bbot.sh
bbot --help
```
