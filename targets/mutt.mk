home := $(HOME)/.mutt

profiles := $(shell render keys mail)

build += $(foreach profile,$(profiles),$(home)/accounts/$(profile))
build += $(foreach profile,$(profiles),$(HOME)/.offlineimap/$(profile).rc)
build += $(home)/base
build += $(home)/colors
build += $(home)/gpg
build += $(home)/muttrc
build += $(home)/signature

post-hook += permissions

# files containing passwords
permissions:
	$(Q)chmod 0600 $(home)/accounts/personal
	$(Q)chmod 0600 $(home)/accounts/work
	$(Q)chmod 0600 $(HOME)/.offlineimap/work.rc
	$(Q)chmod 0600 $(HOME)/.offlineimap/personal.rc

$(home)/accounts/%: $(ROOT)/home/mutt/accounts/template
	render --set id=$* --scope mail.$* render $< $@

$(HOME)/.offlineimap/%.rc: $(ROOT)/home/offlineimap/template.rc
	render --set id=$* --scope mail.$* render $< $@
