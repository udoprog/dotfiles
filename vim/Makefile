all: vim
	vim +BundleInstall +qall
	build/make all

.PHONY: vim

vim: $(HOME)/.vim $(HOME)/.vimrc

${HOME}/.vimrc: $(PWD)/vimrc
	ln -sf $< $@

${HOME}/.vim: $(PWD)
	ln -sf $< $@
