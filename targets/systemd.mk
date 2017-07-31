units += offlineimap@.service
units += offlineimap@.timer

enabled_timers += offlineimap@work.timer
enabled_timers += offlineimap@personal.timer

include $(ROOT)/lib.mk
