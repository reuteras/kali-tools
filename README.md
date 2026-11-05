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
- [masstin](https://github.com/jupyterj0nes/masstin) - `bin/install-masstin.sh`
- [Vespasian](https://github.com/praetorian-inc/vespasian) - `bin/install-vespasian.sh`

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

### Vespasian

[Vespasian](https://github.com/praetorian-inc/vespasian) from Praetorian discovers API endpoints by crawling a web application with headless Chromium, or from captured traffic (Burp Suite XML, HAR or mitmproxy), and generates OpenAPI, GraphQL SDL or WSDL specifications. See the [blog post](https://www.praetorian.com/blog/vespasian-api-endpoint-discovery-tool/) for background.

```bash
./bin/install-vespasian.sh
vespasian scan https://app.example.com -o api.yaml
```

The script installs the pinned release binary on x86_64 and builds the same tag with Go on arm64.

### masstin

[masstin](https://github.com/jupyterj0nes/masstin) parses evidence from Windows, Linux and macOS (EVTX, journald, unified logs, disk images and triage archives) into a lateral movement timeline and graph.

```bash
./bin/install-masstin.sh
masstin -a parse-massive -d /evidence/case -o timeline.csv
```

The script installs the pinned release binary on x86_64 and builds the same tag with Cargo on arm64. Use the GitHub releases, the version on crates.io is outdated.

## Other tools

Tools I've looked at that need more than a single install script.

### SightHouse

[SightHouse](https://github.com/quarkslab/sighthouse) from Quarkslab identifies functions in stripped binaries by matching them against signatures of known libraries and adds names to IDA, Ghidra or Binary Ninja. See the [blog post](https://blog.quarkslab.com/sighthouse-automated-function-identification.html) and the [documentation](https://quarkslab.github.io/sighthouse/).

It needs a SightHouse server (frontend, pipeline and Redis, available as Docker images) in addition to the disassembler plugin. The Ghidra plugin requires Ghidra 11.3 or later started with pyGhidra. Kali packages Ghidra 11.4 in _/usr/share/ghidra_:

```bash
sudo apt install -y ghidra
pipx install --include-deps sighthouse-client
sighthouse client install ghidra --ghidra-install-dir /usr/share/ghidra
/usr/share/ghidra/support/pyghidraRun
```
