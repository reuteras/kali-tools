.PHONY: clean install test

all: install

clean:
	./bin/clean.sh

install:
	cp .bashrc ~/ && chmod 600 ~/.bashrc && chown kali:kali ~/.bashrc
	cp .bash_aliases ~/ && chmod 600 ~/.bash_aliases && chown kali:kali ~/.bashrc
	cp .vimrc ~/ && chmod 600 ~/.vimrc && chown kali:kali ~/.vimrc

test:
	shellcheck -f checkstyle bin/*.sh > checkstyle.out || true

