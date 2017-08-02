# Useful environment variables:
# build - unconditionally build
# build-y - conditionally build, used in conjunction with some variable.

ifndef ROOT
$(error ROOT is not set, are you calling lib.mk directly?)
endif

export PATH := $(ROOT)/bin:$(PATH)
export ROOT := $(ROOT)
export DISTRO := $(shell $(ROOT)/bin/detect-distro)
export BIN := $(HOME)/usr/bin

ifeq ($(DEBUG),yes)
make-opts :=
Q :=
else
make-opts := -s --no-print-directory
Q := @
endif

config := $(ROOT)/config.yml
secrets := $(ROOT)/secrets.yml
systemctl := systemctl --user
systemd-user := $(HOME)/.config/systemd/user

link := ln -sf
copy := cp

targets := $(targets:%=target/%)
sd-unit := $(sd-unit:%=$(systemd-user)/%)

build += $(sd-unit)
build += $(sd-service:%=$(systemd-user)/default.target.wants/%)
build += $(sd-timer:%=$(systemd-user)/timers.target.wants/%)

all: $(ROOT) $(build) $(build-y) $(steps) $(post-hook) $(targets)

$(systemd-user)/default.target.wants/%: $(units)
	$(Q)$(systemctl) enable $*

$(systemd-user)/timers.target.wants/%: $(units)
	$(Q)$(systemctl) enable $*

target/%:
	$(Q)make $(make-opts) -f $(ROOT)/targets/$*.mk all

$(HOME)/.%: $(ROOT)/home/% $(config) $(secrets)
	$(Q)render $@ $<

$(HOME)/%: $(ROOT)/home/% $(config) $(secrets)
	$(Q)render $@ $<

$(secrets):
	@echo "Missing: $@"
	@exit 1

$(ROOT):
	@echo "Missing: $@"
	@exit 1

.PHONY: all $(steps) $(post-hook)
