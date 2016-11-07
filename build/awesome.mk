dirs+=$(G)/awesome

build+=$(G)/awesome/rc.lua
build+=$(HOME)/.config/awesome

include $(ROOT)/config.mk

$(HOME)/.config/awesome: $(G)/awesome
	$(link) $< $@
