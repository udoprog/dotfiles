# vim: filetype=make

build+=$(HOME)/.gitconfig
build+=$(HOME)/.zshrc_custom
build+=$(HOME)/.zshrc
build+=$(HOME)/.tmux.conf
build+=$(HOME)/.offlineimaprc
build+=$(HOME)/.dput.cf

build+=$(HOME)/repo/linux/.pvimrc

# generated directories

include $(ROOT)/config.mk

# git
$(HOME)/.gitconfig: $(gen)/gitconfig
	$(copy) $< $@

# zsh
$(HOME)/.zshrc_custom: $(gen)/zshrc_custom
	$(copy) $< $@

$(HOME)/.zshrc: $(gen)/zshrc
	$(copy) $< $@

# tmux
$(HOME)/.tmux.conf: $(gen)/tmux.conf
	$(copy) $< $@

# offlineimaprc
$(HOME)/.offlineimaprc: $(gen)/offlineimaprc
	chmod 0600 $<
	$(copy) $< $@

$(HOME)/.dput.cf: $(gen)/dput.cf
	$(copy) $< $@

# project-specific pvimrc
$(repo)/linux/.pvimrc: $(gen)/linux.pvimrc
	$(copy) $< $@
