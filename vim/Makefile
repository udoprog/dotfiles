all: vim
	vim +BundleInstall +qall
	build/make all

clean:
	build/make clean

.PHONY: vim

vim: $(HOME)/.vim $(HOME)/.vimrc

${HOME}/.vimrc: $(PWD)/vimrc
	ln -sf $< $@

${HOME}/.vim: $(PWD)
	ln -sf $< $@
