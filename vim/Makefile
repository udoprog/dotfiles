steps += initialize

build += $(HOME)/.vim
build += $(HOME)/.config/nvim
build += $(HOME)/.vimrc

include $(ROOT)/lib.mk

initialize:
	@once dein "nvim -u setup.vim"

$(HOME)/.vimrc: $(CURDIR)/vimrc
	$(Q)$(link) $< $@

$(HOME)/.vim: $(CURDIR)
	$(Q)$(link) $< $@

$(HOME)/.config/nvim: $(CURDIR)
	$(Q)$(link) $< $@
