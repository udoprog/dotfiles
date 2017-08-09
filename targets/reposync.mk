sd-unit += reposync@.service
sd-unit += reposync@.timer

has-linux := $(call has-dir,$(REPO)/linux/.git)
sd-timer-$(has-linux) += reposync@linux.timer

has-systemd := $(call has-dir,$(REPO)/systemd/.git)
sd-timer-$(has-systemd) += reposync@systemd.timer

has-rust := $(call has-dir,$(REPO)/rust/.git)
sd-timer-$(has-rust) += reposync@rust.timer
