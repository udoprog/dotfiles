CONFIGS+=$(HOME)/.vim
CONFIGS+=$(HOME)/.nvim
CONFIGS+=$(HOME)/.vimrc

.PHONY: all clean

all: $(CONFIGS)
	$(B) all
	#env VIMINIT=$(VIMINIT) vim +BundleInstall +qall
	nvim +BundleInstall +qall

clean:
	$(B) clean

${HOME}/.vimrc: $(PWD)/vimrc
	ln -sf $< $@

${HOME}/.nvimrc: $(PWD)/nvimrc
	ln -sf $< $@

${HOME}/.vim: $(PWD)
	ln -sf $< $@

${HOME}/.nvim: $(PWD)
	ln -sf $< $@
