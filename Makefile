.PHONY: all clean install test update

DOTFILES := .bashrc .bash_aliases .vimrc

all: install

clean:
	./bin/clean.sh

install:
	for file in $(DOTFILES); do install -m 600 "$$file" "$$HOME/$$file"; done
	mkdir -p "$$HOME/.vim/.undo"

test:
	shellcheck bin/* .bashrc .bash_aliases

update:
	./bin/update.sh
