steps += nvim-setup

build += $(HOME)/.vim
build += $(HOME)/.config/nvim
build += $(HOME)/.vimrc

nvim-setup:
	@once nvim-setup "nvim -u setup.vim"

$(HOME)/.vimrc: vimrc
	$(Q)$(link) $@ $<

$(HOME)/.vim: .
	$(Q)$(link) $@ $<

$(HOME)/.config/nvim: .
	$(Q)$(link) $@ $<
