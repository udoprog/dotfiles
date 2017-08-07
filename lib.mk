# Udoprog's Build Lib
# This is a wrapper make script that surrounds a build-target in an attempt to make it a bit more
# declarative.

ifndef ROOT
$(error ROOT is not set, are you calling lib.mk directly?)
endif

ifndef target-file
$(error target-file is not set)
endif

# Is debugging enabled?
ifeq ($(DEBUG),yes)
make-opts :=
Q :=
else
make-opts := -s --no-print-directory
Q := @
endif

target-file := $(shell realpath $(target-file))
target-dir := $(shell dirname $(target-file))

config := $(ROOT)/config.yml
secrets := $(ROOT)/secrets.yml
systemctl := systemctl --user
systemd-user := $(HOME)/.config/systemd/user

link := relative-ln
copy := cp

# default target
__build: all

# unconditional build
build :=
# conditional build, use with `build-$(should-build) += target`
build-y :=
# specialized build targets
sd-unit :=
sd-unit-y :=
sd-timer :=
sd-timer-y :=
steps :=
post-hook :=
targets :=

# include target file with build rules
include $(target-file)

sd-unit := $(sd-unit) $(sd-unit-y)
sd-timer := $(sd-timer) $(sd-timer-y)
build := $(build) $(build-y)
targets := $(targets) $(targets-y)

# convert special targets to regular build targets
build += $(sd-unit:%=$(systemd-user)/%)
build += $(sd-service:%=$(systemd-user)/default.target.wants/%)
build += $(sd-timer:%=$(systemd-user)/timers.target.wants/%)
build += $(utils:%=$(BIN)/%)

all: $(ROOT) $(REPO) $(build) $(steps) $(post-hook) $(targets)

$(systemd-user)/default.target.wants/%: $(units)
	$(Q)$(systemctl) enable $*

$(systemd-user)/timers.target.wants/%: $(units)
	$(Q)$(systemctl) enable $*

$(targets):
	$(Q)$(MAKE) $(make-opts) \
		-C $(shell dirname $(target-dir)/$@) \
		-f $(ROOT)/lib.mk \
		target-file=$(target-dir)/$@

$(HOME)/.%: $(ROOT)/home/% $(config) $(secrets)
	$(Q)render $@ $(ROOT)/home/$*

$(HOME)/repo/%: $(REPO) $(ROOT)/repo/% $(config) $(secrets)
	$(Q)render $@ $(ROOT)/repo/$*

$(BIN)/%: $(ROOT)/utils/%
	@echo "Linking $@ -> $<"
	$(Q)$(link) $@ $<

$(secrets):
	@echo "Missing: $@"
	@exit 1

$(ROOT):
	@echo "Missing: $@"
	@exit 1

$(REPO):
	$(Q)mkdir -p $@

.PHONY: __build all $(steps) $(post-hook) $(targets)
