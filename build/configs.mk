# vim: filetype=make

repo=$(HOME)/repo
mutt=$(HOME)/.mutt
systemd_user=$(HOME)/.config/systemd/user
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

build+=$(repo)/linux/.pvimrc

# generated directories

dirs+=$(gen)
dirs+=$(gen)/mutt
dirs+=$(gen)/mutt/accounts
dirs+=$(gen)/systemd
dirs+=$(gen)/systemd/default.target.wants

systemd_configs+=$(gen)/systemd/offlineimap.service
systemd_configs+=$(gen)/systemd/default.target.wants/offlineimap.service

systemd_configs+=$(gen)/systemd/redshift.service
systemd_configs+=$(gen)/systemd/default.target.wants/redshift.service

build+=$(systemd_configs)
build+=$(systemd_user)

link=ln -sf

.PHONY: clean all generated

clean:
	rm -rf $(gen)

all: $(dirs) $(build)

$(gen)/systemd/default.target.wants/offlineimap.service:
	$(link) ../offlineimap.service $@

$(gen)/systemd/default.target.wants/redshift.service:
	$(link) ../redshift.service $@

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
$(systemd_user): $(gen)/systemd
	$(link) $(gen)/systemd $@
