# Useful environment variables:
# build - unconditionally build
# build-y - conditionally build, used in conjunction with some variable.

ifndef ROOT
$(error ROOT is not set, are you calling lib.mk directly?)
endif

ifndef TARGET
$(error TARGET is not set)
endif

ifeq ($(DEBUG),yes)
make-opts :=
Q :=
else
make-opts := -s --no-print-directory
Q := @
endif

TARGET := $(shell realpath $(TARGET))
DIR := $(shell dirname $(TARGET))

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
include $(TARGET)

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
	$(Q)make $(make-opts) \
		-C $(shell dirname $(DIR)/$@) \
		-f $(ROOT)/lib.mk \
		TARGET=$(DIR)/$@

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
