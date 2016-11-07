# vim: filetype=make

repo=$(HOME)/repo
systemd_user=$(HOME)/.config/systemd/user

build+=$(HOME)/.gitconfig
build+=$(HOME)/.zshrc_custom
build+=$(HOME)/.zshrc
build+=$(HOME)/.tmux.conf
build+=$(HOME)/.offlineimaprc
build+=$(HOME)/.dput.cf

build+=$(repo)/linux/.pvimrc

# generated directories

dirs+=$(gen)/systemd
dirs+=$(gen)/systemd/default.target.wants

systemd_configs+=$(gen)/systemd/offlineimap.service
systemd_configs+=$(gen)/systemd/default.target.wants/offlineimap.service

systemd_configs+=$(gen)/systemd/redshift.service
systemd_configs+=$(gen)/systemd/default.target.wants/redshift.service

build+=$(systemd_configs)
build+=$(systemd_user)

include $(ROOT)/config.mk

$(gen)/systemd/default.target.wants/offlineimap.service:
	$(link) ../offlineimap.service $@

$(gen)/systemd/default.target.wants/redshift.service:
	$(link) ../redshift.service $@

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

$(HOME)/.dput.cf: $(gen)/dput.cf
	$(link) $< $@

# project-specific pvimrc
$(repo)/linux/.pvimrc: $(gen)/linux.pvimrc
	$(link) $< $@

# systemd
$(systemd_user): $(gen)/systemd
	$(link) $(gen)/systemd $@
