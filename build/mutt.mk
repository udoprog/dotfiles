mutt=$(HOME)/.mutt

dirs+=$(mutt)
dirs+=$(mutt)/accounts
dirs+=$(gen)/mutt
dirs+=$(gen)/mutt/accounts

build+=$(HOME)/.muttrc
build+=$(mutt)
build+=$(mutt)/gpg
build+=$(mutt)/signature
build+=$(mutt)/accounts/personal
build+=$(mutt)/accounts/work

include $(ROOT)/config.mk

# mutt
$(mutt)/gpg: $(gen)/mutt/gpg
	$(copy) $< $@

$(mutt)/signature: $(gen)/mutt/signature
	$(copy) $< $@

$(mutt)/accounts/personal: $(gen)/mutt/accounts/personal
	chmod 0600 $<
	$(copy) $< $@

$(mutt)/accounts/work: $(gen)/mutt/accounts/work
	chmod 0600 $<
	$(copy) $< $@

$(HOME)/.muttrc: $(gen)/muttrc
	$(copy) $< $@
