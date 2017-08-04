sd-unit += reposync@.service
sd-unit += reposync@.timer

has-linux := $(shell has-path $(REPO)/linux/.git)
sd-timer-$(has-linux) += reposync@linux.timer

has-systemd := $(shell has-path $(REPO)/systemd/.git)
sd-timer-$(has-systemd) += reposync@systemd.timer

has-rust := $(shell has-path $(REPO)/rust/.git)
sd-timer-$(has-rust) += reposync@rust.timer

include $(ROOT)/lib.mk
