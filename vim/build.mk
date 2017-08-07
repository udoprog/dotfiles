steps += initialize

build += $(HOME)/.vim
build += $(HOME)/.config/nvim
build += $(HOME)/.vimrc

initialize:
	@once dein "nvim -u setup.vim"

$(HOME)/.vimrc: vimrc
	$(Q)$(link) $@ $<

$(HOME)/.vim: .
	$(Q)$(link) $@ $<

$(HOME)/.config/nvim: .
	$(Q)$(link) $@ $<
