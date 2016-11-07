secrets=$(ROOT)/secrets.yml
config=$(ROOT)/config.yml
systemd_user=$(HOME)/.config/systemd/user

dirs+=$(G)/systemd
dirs+=$(G)

build+=$(systemd_user)
build+=$(services:%=$(G)/systemd/%)
build+=$(services:%=$(systemd_user)/default.target.wants/%)

link=ln -sf
copy=cp
systemctl=systemctl --user

$(systemd_user): $(G)/systemd
	$(link) $(G)/systemd $@

$(systemd_user)/default.target.wants/%: $(G)/systemd/%
	$(systemctl) add-wants default.target $*

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
