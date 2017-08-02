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

all: $(build) $(build-y) $(steps) $(post-hook) $(targets)

$(systemd-user)/default.target.wants/%: $(units)
	$(systemctl) enable $*

$(systemd-user)/timers.target.wants/%: $(units)
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

.PHONY: all $(steps) $(post-hook)
