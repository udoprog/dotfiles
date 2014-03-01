all:
	make vim
	git submodule update --init --recursive
	make -f YouCompleteMe.mk all
	make -f command-t.mk all

clean:
	git submodule foreach --recursive git clean -fdx
	git submodule foreach --recursive git reset --hard HEAD

.PHONY: vim

vim: $(HOME)/.vim $(HOME)/.vimrc

${HOME}/.vimrc: $(PWD)/vimrc
	ln -sf $< $@

${HOME}/.vim: $(PWD)
	ln -sf $< $@
