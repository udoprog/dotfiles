mutt_home=$(HOME)/.mutt

dirs+=$(mutt_home)
dirs+=$(mutt_home)/accounts
dirs+=$(G)/mutt
dirs+=$(G)/mutt/accounts

build+=$(mutt_home)/accounts/personal
build+=$(mutt_home)/accounts/work
build+=$(mutt_home)/base
build+=$(mutt_home)/colors
build+=$(mutt_home)/gpg
build+=$(mutt_home)/muttrc
build+=$(mutt_home)/signature

include $(ROOT)/config.mk

# mutt
$(mutt_home)/%: $(G)/mutt/%
	$(copy) $< $@

$(mutt_home)/accounts/personal: $(G)/mutt/accounts/personal
	chmod 0600 $<
	$(copy) $< $@

$(mutt_home)/accounts/work: $(G)/mutt/accounts/work
	chmod 0600 $<
	$(copy) $< $@
