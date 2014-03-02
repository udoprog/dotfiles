CONFIGS+=$(HOME)/.vim
CONFIGS+=$(HOME)/.vimrc

.PHONY: all clean

all: $(CONFIGS)
	$(B) all
	vim +BundleInstall +qall

clean:
	$(B) clean

${HOME}/.vimrc: $(PWD)/vimrc
	ln -sf $< $@

${HOME}/.vim: $(PWD)
	ln -sf $< $@
