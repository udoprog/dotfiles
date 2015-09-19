CONFIGS+=$(HOME)/.gitconfig
CONFIGS+=$(HOME)/.zshrc_custom
CONFIGS+=$(HOME)/.zshrc
CONFIGS+=$(HOME)/.tmux.conf
CONFIGS+=$(HOME)/.muttrc
CONFIGS+=$(HOME)/.offlineimaprc

.PHONY: all

all: gen ${CONFIGS}

gen/%: configs/%
	$(M) $@ $<

gen:
	mkdir $@

$(HOME)/.gitconfig: gen/gitconfig
	ln -fs $(CURDIR)/$< $@

$(HOME)/.zshrc_custom: gen/zshrc_custom
	ln -fs $(CURDIR)/$< $@

$(HOME)/.zshrc: gen/zshrc
	ln -fs $(CURDIR)/$< $@

$(HOME)/.tmux.conf: gen/tmux.conf
	ln -fs $(CURDIR)/$< $@

$(HOME)/.muttrc: gen/muttrc
	ln -fs $(CURDIR)/$< $@

$(HOME)/.offlineimaprc: gen/offlineimaprc
	ln -fs $(CURDIR)/$< $@
