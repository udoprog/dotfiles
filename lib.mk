ifndef ROOT
$(error ROOT is not set, are you calling lib.mk directly?)
endif

export PATH := $(ROOT)/bin:$(PATH)
export ROOT := $(ROOT)
export DISTRO := $(shell $(ROOT)/bin/detect-distro)

config := $(ROOT)/config.yml
secrets := $(ROOT)/secrets.yml
systemctl := systemctl --user
systemd_user := $(HOME)/.config/systemd/user

link := ln -sf
copy := cp

targets := $(targets:%=target/%)
units := $(units:%=$(systemd_user)/%)

build += $(units)
build += $(enabled_services:%=$(systemd_user)/default.target.wants/%)
build += $(enabled_timers:%=$(systemd_user)/timers.target.wants/%)

.PHONY: all $(steps) $(post_hooks)

all: $(build) $(steps) $(post_hooks) $(targets)

$(systemd_user)/default.target.wants/%: $(units)
	$(systemctl) enable $*

$(systemd_user)/timers.target.wants/%: $(units)
	$(systemctl) enable $*

target/%:
	make -f $(ROOT)/targets/$*.mk all

$(HOME)/.%: $(ROOT)/home/% $(config) $(secrets)
	render $@ $<

$(HOME)/%: $(ROOT)/home/% $(config) $(secrets)
	render $@ $<

$(secrets):
	@echo "Missing $@"
	@exit 1
