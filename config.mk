secrets=$(ROOT)/secrets.yml
config=$(ROOT)/config.yml
systemd_user=$(HOME)/.config/systemd/user

dirs+=$(G)/systemd
dirs+=$(G)

build+=$(systemd_user)
build+=$(units:%=$(G)/systemd/%)
build+=$(enabled_services:%=$(systemd_user)/default.target.wants/%)
build+=$(enabled_timers:%=$(systemd_user)/timer.target.wants/%)

link=ln -sf
copy=cp
systemctl=systemctl --user

$(systemd_user): $(G)/systemd
	$(link) $(G)/systemd $@

$(systemd_user)/default.target.wants/%:
	$(systemctl) enable $*

$(systemd_user)/timer.target.wants/%:
	$(systemctl) enable $*

$(HOME)/.%: $(ROOT)/configs/% $(secrets) $(config)
	m4tpl $@ $<

$(G)/%: $(ROOT)/configs/% $(secrets) $(config)
	m4tpl $@ $<

$(dirs):
	mkdir -p $@

.PHONY: clean all

clean:
	rm -rf $(G)

all: $(dirs) $(build)
