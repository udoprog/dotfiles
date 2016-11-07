systemd_user=$(HOME)/.config/systemd/user

dirs+=$(gen)/systemd
dirs+=$(gen)/systemd/default.target.wants

systemd_configs+=$(gen)/systemd/offlineimap.service
systemd_configs+=$(gen)/systemd/default.target.wants/offlineimap.service

systemd_configs+=$(gen)/systemd/redshift.service
systemd_configs+=$(gen)/systemd/default.target.wants/redshift.service

build+=$(systemd_configs)
build+=$(systemd_user)

include $(ROOT)/config.mk

# systemd
$(systemd_user): $(gen)/systemd
	$(link) $(gen)/systemd $@

$(gen)/systemd/default.target.wants/offlineimap.service:
	$(link) ../offlineimap.service $@

$(gen)/systemd/default.target.wants/redshift.service:
	$(link) ../redshift.service $@

