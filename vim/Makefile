CONFIGS+=$(HOME)/.vim
CONFIGS+=$(HOME)/.vimrc
CONFIGS+=$(HOME)/.nvimrc

.PHONY: all clean

all: $(CONFIGS)
	$(B) all
	env VIMINIT=$(VIMINIT) vim +BundleInstall +qall

clean:
	$(B) clean

${HOME}/.vimrc: $(PWD)/vimrc
	ln -sf $< $@

${HOME}/.nvimrc: $(PWD)/nvimrc
	ln -sf $< $@

${HOME}/.vim: $(PWD)
	ln -sf $< $@
