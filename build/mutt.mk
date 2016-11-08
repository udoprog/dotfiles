mutt_home=$(HOME)/.mutt

dirs+=$(mutt_home)
dirs+=$(mutt_home)/accounts
dirs+=$(G)/mutt
dirs+=$(G)/mutt/accounts

build+=$(HOME)/.muttrc
build+=$(mutt_home)/gpg
build+=$(mutt_home)/signature
build+=$(mutt_home)/accounts/personal
build+=$(mutt_home)/accounts/work

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
