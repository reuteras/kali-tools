.PHONY: install

all: install

install:
	cp .bashrc ~/ && chmod 600 ~/.bashrc && chown root:root ~/.bashrc
	cp .vimrc ~/ && chmod 600 ~/.vimrc && chown root:root ~/.vimrc

