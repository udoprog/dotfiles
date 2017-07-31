# vim: filetype=make

build+=$(HOME)/.gitconfig
build+=$(HOME)/.profile
build+=$(HOME)/.zshrc_custom
build+=$(HOME)/.zshrc
build+=$(HOME)/.tmux.conf
build+=$(HOME)/.offlineimap/work.rc
build+=$(HOME)/.offlineimap/personal.rc
build+=$(HOME)/.dput.cf
build+=$(HOME)/.mailcap
build+=$(HOME)/repo/linux/.pvimrc
build+=$(HOME)/usr/bin/vim

enabled_timers+=offlineimap@work.timer
enabled_timers+=offlineimap@personal.timer

post_hooks+=permissions

include $(ROOT)/lib.mk

$(HOME)/usr/bin/vim: /usr/bin/nvim
	ln -f -s $< $@

permissions:
	@chmod 0600 $(HOME)/.offlineimap/work.rc
	@chmod 0600 $(HOME)/.offlineimap/personal.rc
