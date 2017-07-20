home=$(HOME)/.mutt

build+=$(home)/accounts/personal
build+=$(home)/accounts/work
build+=$(home)/base
build+=$(home)/colors
build+=$(home)/gpg
build+=$(home)/muttrc
build+=$(home)/signature

post_hook+=permissions

include $(ROOT)/lib.mk

permissions:
	@chmod 0600 $(home)/accounts/personal
	@chmod 0600 $(home)/accounts/work
