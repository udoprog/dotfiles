.PHONY: all

all: vim/bundle/powerline/plugin

vim/bundle/powerline: vim/bundle
	mkdir -p $@

vim/bundle/powerline/plugin: vim/bundle/powerline
	ln -fs $(CURDIR)/powerline/powerline/bindings/vim/plugin $@
