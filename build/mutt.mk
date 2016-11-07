mutt=$(HOME)/.mutt

dirs+=$(mutt)
dirs+=$(mutt)/accounts
dirs+=$(G)/mutt
dirs+=$(G)/mutt/accounts

build+=$(HOME)/.muttrc
build+=$(mutt)
build+=$(mutt)/gpg
build+=$(mutt)/signature
build+=$(mutt)/accounts/personal
build+=$(mutt)/accounts/work

include $(ROOT)/config.mk

# mutt
$(mutt)/gpg: $(G)/mutt/gpg
	$(copy) $< $@

$(mutt)/signature: $(G)/mutt/signature
	$(copy) $< $@

$(mutt)/accounts/personal: $(G)/mutt/accounts/personal
	chmod 0600 $<
	$(copy) $< $@

$(mutt)/accounts/work: $(G)/mutt/accounts/work
	chmod 0600 $<
	$(copy) $< $@

$(HOME)/.muttrc: $(G)/muttrc
	$(copy) $< $@
