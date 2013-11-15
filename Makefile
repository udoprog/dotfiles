.PHONY: submodules vim powerline awesome configs

.SUFFIXES: .m4.gen

CONFIGS+=$(HOME)/.gitconfig
CONFIGS+=$(HOME)/.zshrc_custom
CONFIGS+=$(HOME)/.zshrc
CONFIGS+=$(HOME)/.tmux.conf

gen/%.gen: %.m4
	tools/generate.pl $@ $<

all: configs submodules vim powerline awesome

update:
	git submodule foreach --recursive git fetch -a origin
	git submodule foreach --recursive git clean -fdx
	git submodule foreach --recursive git reset --hard origin/master
	cd powerline && git reset --hard origin/develop

gen:
	mkdir $@

.PHONY: submodules

submodules:
	git submodule update --init --recursive

vim:
	cd vim && make

vim/bundle/powerline: vim/bundle
	mkdir -p $@

vim/bundle/powerline/plugin: vim/bundle/powerline
	ln -fs $(CURDIR)/powerline/powerline/bindings/vim/plugin $@

powerline: vim/bundle/powerline/plugin

awesome:
	cd awesome && make

$(HOME)/.gitconfig: gen/gitconfig.gen
	ln -fs $(CURDIR)/$< $@

$(HOME)/.zshrc_custom: gen/zshrc_custom.gen
	ln -fs $(CURDIR)/$< $@

$(HOME)/.zshrc: gen/zshrc.gen
	ln -fs $(CURDIR)/$< $@

$(HOME)/.tmux.conf: gen/tmux.conf.gen
	ln -fs $(CURDIR)/$< $@

configs: gen ${CONFIGS}
