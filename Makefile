.PHONY: vim awesome configs

all: vim awesome configs

vim:
	cd vim && make

awesome:
	cd awesome && make

$(HOME)/.gitconfig: gitconfig
	ln -fs $(PWD)/gitconfig $@

configs: $(HOME)/.gitconfig
