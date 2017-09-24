steps += nvim-setup

build += $(HOME)/.vim
build += $(HOME)/.config/nvim
build += $(HOME)/.vimrc

nvim-setup:
	@once nvim-setup "nvim -u $(ROOT)/vim/setup.vim"

$(HOME)/.vimrc: $(ROOT)/vim/vimrc
	$(Q)$(link) $@ $<

$(HOME)/.vim: $(ROOT)/vim
	$(Q)$(link) $@ $<

$(HOME)/.config/nvim: $(ROOT)/vim
	$(Q)$(link) $@ $<
