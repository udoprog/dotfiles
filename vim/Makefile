CONFIGS+=$(HOME)/.vim
CONFIGS+=$(HOME)/.config/nvim
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

${HOME}/.config/nvim: $(PWD)
	ln -sf $< $@
