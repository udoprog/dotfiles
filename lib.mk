# Useful environment variables:
# build - unconditionally build
# build-y - conditionally build, used in conjunction with some variable.

ifndef ROOT
$(error ROOT is not set, are you calling lib.mk directly?)
endif

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

sd-unit := $(sd-unit) $(sd-unit-y)
sd-timer := $(sd-timer) $(sd-timer-y)
build := $(build) $(build-y)
targets := $(targets) $(targets-y)

build += $(sd-unit:%=$(systemd-user)/%)
build += $(sd-service:%=$(systemd-user)/default.target.wants/%)
build += $(sd-timer:%=$(systemd-user)/timers.target.wants/%)

.PHONY: all $(steps) $(post-hook) $(targets)

all: $(ROOT) $(REPO) $(build) $(steps) $(post-hook) $(targets)

$(systemd-user)/default.target.wants/%: $(units)
	$(Q)$(systemctl) enable $*

$(systemd-user)/timers.target.wants/%: $(units)
	$(Q)$(systemctl) enable $*

$(targets):
	$(Q)make $(make-opts) -f $(ROOT)/targets/$@.mk all

$(HOME)/.%: $(ROOT)/home/% $(config) $(secrets)
	$(Q)render $@ $(ROOT)/home/$*

$(HOME)/repo/%: $(REPO) $(ROOT)/repo/% $(config) $(secrets)
	$(Q)render $@ $(ROOT)/repo/$*

$(secrets):
	@echo "Missing: $@"
	@exit 1

$(ROOT):
	@echo "Missing: $@"
	@exit 1

$(REPO):
	$(Q)mkdir -p $@
