mutt := $(HOME)/.mutt

profiles := $(shell tpl keys mail)

sd-unit += offlineimap@.service
sd-unit += offlineimap@.timer

sd-timer += $(profiles:%=offlineimap@%.timer)

build += $(foreach profile,$(profiles),$(mutt)/accounts/$(profile))
build += $(foreach profile,$(profiles),$(HOME)/.offlineimap/$(profile).rc)
build += $(mutt)/base
build += $(mutt)/colors
build += $(mutt)/gpg
build += $(mutt)/muttrc
build += $(mutt)/signature

$(mutt)/accounts/%: $(ROOT)/home/.mutt/accounts/template $(depends)
	$(Q)tpl --set id=$* --scope mail.$* render $< $@
	$(Q)chmod 0600 $<

$(HOME)/.offlineimap/%.rc: $(ROOT)/home/.offlineimap/template.rc $(depends)
	$(Q)tpl --set id=$* --scope mail.$* render $< $@
	$(Q)chmod 0600 $<
