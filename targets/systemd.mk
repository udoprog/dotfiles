user=$(HOME)/.config/systemd/user

units+=offlineimap@.service
units+=offlineimap@.timer

enabled_timers+=offlineimap@work.timer
enabled_timers+=offlineimap@home.timer

units := $(units:%=$(user)/%)

build+=$(units)
build+=$(enabled_services:%=$(user)/default.target.wants/%)
build+=$(enabled_timers:%=$(user)/timers.target.wants/%)

include $(ROOT)/lib.mk

$(user)/default.target.wants/%: $(units)
	$(systemctl) enable $*

$(user)/timers.target.wants/%: $(units)
	$(systemctl) enable $*
