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
	$(link) $< $@

$(mutt)/signature: $(gen)/mutt/signature
	$(link) $< $@

$(mutt)/accounts/personal: $(gen)/mutt/accounts/personal
	chmod 0600 $<
	$(link) $< $@

$(mutt)/accounts/work: $(gen)/mutt/accounts/work
	chmod 0600 $<
	$(link) $< $@

$(HOME)/.muttrc: $(gen)/muttrc
	$(link) $< $@
