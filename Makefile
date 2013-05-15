.PHONY: submodules vim awesome configs

.SUFFIXES: .m4.gen

CONFIGS+=$(HOME)/.gitconfig
CONFIGS+=$(HOME)/.zshrc_custom
CONFIGS+=$(HOME)/.zshrc
CONFIGS+=$(HOME)/.tmux.conf

gen:
	mkdir $@

gen/%.gen: %.m4
	tools/generate.pl $@ $<

all: configs submodules vim awesome

submodules:
	git submodule update --init --recursive
	git submodule foreach --recursive git clean -fdx
	git submodule foreach --recursive git reset --hard HEAD

vim:
	cd vim && make

awesome:
	cd awesome && make

$(HOME)/.gitconfig: gen/gitconfig.gen
	ln -fs $(CURDIR)/$< $@

$(HOME)/.zshrc_custom: gen/zshrc_custom.gen
	ln -fs $(CURDIR)/$< $@

$(HOME)/.zshrc: zshrc
	ln -fs $(CURDIR)/$< $@

$(HOME)/.tmux.conf: gen/tmux.conf.gen
	ln -fs $(CURDIR)/$< $@

configs: gen ${CONFIGS}
