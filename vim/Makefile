ROOT := $(HOME)/.dotfiles

steps+=initialize

build+=$(HOME)/.vim
build+=$(HOME)/.config/nvim
build+=$(HOME)/.vimrc

include $(ROOT)/lib.mk

initialize:
	@once dein "nvim -u setup.vim"

$(HOME)/.vimrc: $(CURDIR)/vimrc
	$(link) $< $@

$(HOME)/.vim: $(CURDIR)
	$(link) $< $@

$(HOME)/.config/nvim: $(CURDIR)
	$(link) $< $@
