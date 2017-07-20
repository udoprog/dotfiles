ROOT := $(HOME)/.dotfiles
include $(ROOT)/env.mk

build+=initialize
build+=$(HOME)/.vim
build+=$(HOME)/.config/nvim
build+=$(HOME)/.vimrc

link=ln -sf

.PHONY: all clean

include ../env.mk

all: $(build)
	buildall all

initialize:
	@once dein "nvim -u setup.vim"

clean:
	buildall clean

$(HOME)/.vimrc: $(CURDIR)/vimrc
	$(link) $< $@

$(HOME)/.vim: $(CURDIR)
	$(link) $< $@

$(HOME)/.config/nvim: $(CURDIR)
	$(link) $< $@
