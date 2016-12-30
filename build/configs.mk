# vim: filetype=make

build+=$(HOME)/.gitconfig
build+=$(HOME)/.profile
build+=$(HOME)/.zshrc_custom
build+=$(HOME)/.zshrc
build+=$(HOME)/.tmux.conf
build+=$(HOME)/.offlineimaprc
build+=$(HOME)/.dput.cf
build+=$(HOME)/repo/linux/.pvimrc

services+=offlineimap.service
services+=redshift.service

include $(ROOT)/config.mk

$(HOME)/.offlineimaprc: $(G)/offlineimaprc
	chmod 0600 $<
	$(copy) $< $@

$(HOME)/repo/linux/.pvimrc: $(G)/linux.pvimrc
	$(copy) $< $@
