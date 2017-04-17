# vim: filetype=make

build+=$(HOME)/.gitconfig
build+=$(HOME)/.profile
build+=$(HOME)/.zshrc_custom
build+=$(HOME)/.zshrc
build+=$(HOME)/.tmux.conf
build+=$(HOME)/.offlineimap/work.rc
build+=$(HOME)/.offlineimap/personal.rc
build+=$(HOME)/.dput.cf
build+=$(HOME)/repo/linux/.pvimrc

dirs+=$(HOME)/.offlineimap

services+=offlineimap@.service
services+=redshift.service

enabled+=offlineimap@work.service
enabled+=offlineimap@personal.service
enabled+=redshift.service

include $(ROOT)/config.mk

$(HOME)/.offlineimaprc: $(G)/offlineimaprc
	chmod 0600 $<
	$(copy) $< $@

$(HOME)/.offlineimaprc.work: $(G)/offlineimaprc.work
	chmod 0600 $<
	$(copy) $< $@

$(HOME)/.offlineimaprc.personal: $(G)/offlineimaprc.personal
	chmod 0600 $<
	$(copy) $< $@

$(HOME)/repo/linux/.pvimrc: $(G)/linux.pvimrc
	$(copy) $< $@
