mutt := $(HOME)/.mutt

profiles := $(shell tpl keys mail)

sd-unit += offlineimap@.service
sd-unit += offlineimap@.timer

sd-timer += $(profiles:%=offlineimap@%.timer)

build += $(profiles:%=$(mutt)/accounts/%)
build += $(profiles:%=$(HOME)/.offlineimap/%.rc)
build += $(mutt)/base
build += $(mutt)/colors
build += $(mutt)/gpg
build += $(mutt)/muttrc
build += $(mutt)/signature

$(mutt)/accounts/%: $(ROOT)/home/.mutt/accounts/template $(cdeps)
	$(Q)tpl --set id=$* --scope mail.$* render $< $@
	$(Q)chmod 0600 $<

$(HOME)/.offlineimap/%.rc: $(ROOT)/home/.offlineimap/template.rc $(cdeps)
	$(Q)tpl --set id=$* --scope mail.$* render $< $@
	$(Q)chmod 0600 $<
