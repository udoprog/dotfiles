CONFIGS+=$(HOME)/.gitconfig
CONFIGS+=$(HOME)/.zshrc_custom
CONFIGS+=$(HOME)/.zshrc
CONFIGS+=$(HOME)/.tmux.conf
CONFIGS+=$(HOME)/.muttrc
CONFIGS+=$(HOME)/.offlineimaprc
CONFIGS+=$(HOME)/.mutt/accounts
CONFIGS+=$(HOME)/.mutt/accounts/personal
CONFIGS+=$(HOME)/.mutt/accounts/work

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

# offlineimaprc
$(HOME)/.offlineimaprc: gen/offlineimaprc
	chmod 0600 $(CURDIR)/$<
	ln -fs $(CURDIR)/$< $@

# mutt
$(HOME)/.mutt/accounts:
	mkdir -p $@

$(HOME)/.mutt/accounts/personal: gen/muttrc.personal
	chmod 0600 $(CURDIR)/$<
	ln -fs $(CURDIR)/$< $@

$(HOME)/.mutt/accounts/work: gen/muttrc.work
	chmod 0600 $(CURDIR)/$<
	ln -fs $(CURDIR)/$< $@

$(HOME)/.muttrc: gen/muttrc
	ln -fs $(CURDIR)/$< $@
