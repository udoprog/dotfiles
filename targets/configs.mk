# vim: filetype=make

build += $(HOME)/.gitconfig
build += $(HOME)/.profile
build += $(HOME)/.zshrc_custom
build += $(HOME)/.zshrc
build += $(HOME)/.tmux.conf
build += $(HOME)/.offlineimap/work.rc
build += $(HOME)/.offlineimap/personal.rc
build += $(HOME)/.dput.cf
build += $(HOME)/.mailcap
build += $(HOME)/.ccacherc
build += $(HOME)/repo/linux/.pvimrc

post-hook += permissions

permissions:
	$(Q)chmod 0600 $(HOME)/.offlineimap/work.rc
	$(Q)chmod 0600 $(HOME)/.offlineimap/personal.rc
