.PHONY: generated submodules vim awesome configs

all: generated submodules vim awesome configs

generated:
	tools/generate.pl

submodules:
	git submodule update --init --recursive
	git submodule foreach --recursive git clean -fdx
	git submodule foreach --recursive git reset --hard HEAD

vim:
	cd vim && make

awesome:
	cd awesome && make

$(HOME)/.gitconfig: gitconfig
	ln -fs $(PWD)/gitconfig $@

configs: $(HOME)/.gitconfig
