# vim: filetype=make

REPO=$(HOME)/repo

DEST+=$(HOME)/.gitconfig
DEST+=$(HOME)/.zshrc_custom
DEST+=$(HOME)/.zshrc
DEST+=$(HOME)/.tmux.conf
DEST+=$(HOME)/.muttrc
DEST+=$(HOME)/.offlineimaprc
DEST+=$(HOME)/.mutt/accounts
DEST+=$(HOME)/.mutt/accounts/personal
DEST+=$(HOME)/.mutt/accounts/work
DEST+=$(HOME)/repo/linux/.pvimrc

SYSTEMD_USER=$(HOME)/.local/systemd/user

DEST+=$(SYSTEMD_USER)
DEST+=$(SYSTEMD_USER)/offlineimap.service
DEST+=$(SYSTEMD_USER)/offlineimap.timer
DEST+=$(SYSTEMD_USER)/default.target.wants
DEST+=$(SYSTEMD_USER)/default.target.wants/offlineimap.timer

.PHONY: all

all: gen gen/systemd ${DEST}

gen/%: configs/%
	$(M) $@ $<

gen:
	mkdir $@

gen/systemd:
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

# project-specific pvimrc
$(HOME)/repo/linux/.pvimrc: gen/linux.pvimrc
	ln -fs $(CURDIR)/$< $@

# systemd
$(SYSTEMD_USER):
	mkdir -p $@

$(SYSTEMD_USER)/default.target.wants:
	mkdir -p $@

$(SYSTEMD_USER)/offlineimap.service: gen/systemd/offlineimap.service
	ln -fs $(CURDIR)/$< $@

$(SYSTEMD_USER)/offlineimap.timer: gen/systemd/offlineimap.timer
	ln -fs $(CURDIR)/$< $@

$(SYSTEMD_USER)/default.target.wants/offlineimap.timer:
	ln -s ../offlineimap.timer $@
