sd-unit += offlineimap@.service
sd-unit += offlineimap@.timer

sd-timer += offlineimap@work.timer
sd-timer += offlineimap@personal.timer

include $(ROOT)/lib.mk
