secrets=$(CURDIR)/secrets.yml
config=$(CURDIR)/config.yml
gen=$(CURDIR)/gen

dirs+=$(gen)

link=ln -sf

$(gen)/%: $(CURDIR)/configs/% $(secrets) $(config)
	m4tpl $@ $<

$(dirs):
	mkdir -p $@

.PHONY: clean all

clean:
	rm -f $(g)

all: $(dirs) $(build)
