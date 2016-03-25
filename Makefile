.PHONY: install test

all: install

install:
	cp .bashrc ~/ && chmod 600 ~/.bashrc && chown root:root ~/.bashrc
	cp .bash_aliases ~/ && chmod 600 ~/.bash_aliases && chown root:root ~/.bashrc
	cp .vimrc ~/ && chmod 600 ~/.vimrc && chown root:root ~/.vimrc

test:
	shellcheck -f checkstyle bin/*.sh > checkstyle.out || true

