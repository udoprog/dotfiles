# vim: filetype=make

repo=$(HOME)/repo
mutt=$(HOME)/.mutt
systemd_user=$(HOME)/.local/systemd/user
gen=$(CURDIR)/gen
secrets=$(CURDIR)/secrets.yml
config=$(CURDIR)/config.yml

build+=$(HOME)/.gitconfig
build+=$(HOME)/.zshrc_custom
build+=$(HOME)/.zshrc
build+=$(HOME)/.tmux.conf
build+=$(HOME)/.muttrc
build+=$(HOME)/.offlineimaprc

dirs+=$(mutt)
dirs+=$(mutt)/accounts

build+=$(mutt)
build+=$(mutt)/gpg
build+=$(mutt)/signature
build+=$(mutt)/accounts/personal
build+=$(mutt)/accounts/work

dirs+=$(systemd_user)
dirs+=$(systemd_user)/default.target.wants

build+=$(systemd_user)
build+=$(systemd_user)/offlineimap.service
build+=$(systemd_user)/offlineimap.timer
build+=$(systemd_user)/default.target.wants/offlineimap.timer

build+=$(repo)/linux/.pvimrc

# generated directories
dirs+=$(gen)
dirs+=$(gen)/mutt
dirs+=$(gen)/mutt/accounts
dirs+=$(gen)/systemd

link=ln -sf

.PHONY: all generated

all: $(dirs) $(build)

$(gen)/%: configs/% $(secrets) $(config)
	$(M) $@ $<

$(dirs):
	mkdir -p $@

# git
$(HOME)/.gitconfig: $(gen)/gitconfig
	$(link) $< $@

# zsh
$(HOME)/.zshrc_custom: $(gen)/zshrc_custom
	$(link) $< $@

$(HOME)/.zshrc: $(gen)/zshrc
	$(link) $< $@

# tmux
$(HOME)/.tmux.conf: $(gen)/tmux.conf
	$(link) $< $@

# offlineimaprc
$(HOME)/.offlineimaprc: $(gen)/offlineimaprc
	chmod 0600 $<
	$(link) $< $@

# mutt
$(mutt)/gpg: $(gen)/mutt/gpg
	$(link) $< $@

$(mutt)/signature: $(gen)/mutt/signature
	$(link) $< $@

$(mutt)/accounts/personal: $(gen)/mutt/accounts/personal
	chmod 0600 $<
	$(link) $< $@

$(mutt)/accounts/work: $(gen)/mutt/accounts/work
	chmod 0600 $<
	$(link) $< $@

$(HOME)/.muttrc: $(gen)/muttrc
	$(link) $< $@

# project-specific pvimrc
$(repo)/linux/.pvimrc: $(gen)/linux.pvimrc
	$(link) $< $@

# systemd
$(systemd_user)/offlineimap.service: $(gen)/systemd/offlineimap.service
	$(link) $< $@

$(systemd_user)/offlineimap.timer: $(gen)/systemd/offlineimap.timer
	$(link) $< $@

$(systemd_user)/default.target.wants/offlineimap.timer:
	$(link) ../offlineimap.timer $@
