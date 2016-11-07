build+=$(HOME)/.vim
build+=$(HOME)/.config/nvim
build+=$(HOME)/.vimrc

link=ln -sf

.PHONY: all clean

all: $(build)
	buildall all
	vim +NeoBundleInstall +qall

clean:
	buildall clean

$(HOME)/.vimrc: $(CURDIR)/vimrc
	$(link) $< $@

$(HOME)/.vim: $(CURDIR)
	$(link) $< $@

$(HOME)/.config/nvim: $(CURDIR)
	$(link) $< $@
