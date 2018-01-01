build += $(HOME)/.vim
build += $(HOME)/.config/nvim
build += $(HOME)/.vimrc

once += nvim-setup
once += nvim-python

nvim-setup: nvim-python
	VIMINIT='source ~/.vim/bundles.vim | call dein#install() | q!' nvim
	nvim -c 'call dein#update() | q!'

nvim-python:
	pip3 install --user --upgrade neovim

$(HOME)/.vimrc: $(ROOT)/vim/vimrc
	$(Q)$(link) $@ $<

$(HOME)/.vim: $(ROOT)/vim
	$(Q)$(link) $@ $<

$(HOME)/.config/nvim: $(ROOT)/vim
	mkdir -p $(HOME)/.config
	$(Q)$(link) $@ $<
