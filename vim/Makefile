CONFIGS+=$(HOME)/.vim
CONFIGS+=$(HOME)/.nvim
CONFIGS+=$(HOME)/.vimrc

.PHONY: all clean

all: $(CONFIGS)
	$(B) all
	vim +NeoBundleInstall +qall

clean:
	$(B) clean

${HOME}/.vimrc: $(PWD)/vimrc
	ln -sf $< $@

${HOME}/.vim: $(PWD)
	ln -sf $< $@

${HOME}/.nvim: $(PWD)
	ln -sf $< $@
