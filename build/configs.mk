CONFIGS+=$(HOME)/.gitconfig
CONFIGS+=$(HOME)/.zshrc_custom
CONFIGS+=$(HOME)/.zshrc
CONFIGS+=$(HOME)/.tmux.conf

.PHONY: all

all: gen ${CONFIGS}

.SUFFIXES: .m4.gen

gen/%.gen: configs/%.m4
	tools/generate.pl $@ $<

gen:
	mkdir $@

$(HOME)/.gitconfig: gen/gitconfig.gen
	ln -fs $(CURDIR)/$< $@

$(HOME)/.zshrc_custom: gen/zshrc_custom.gen
	ln -fs $(CURDIR)/$< $@

$(HOME)/.zshrc: gen/zshrc.gen
	ln -fs $(CURDIR)/$< $@

$(HOME)/.tmux.conf: gen/tmux.conf.gen
	ln -fs $(CURDIR)/$< $@
