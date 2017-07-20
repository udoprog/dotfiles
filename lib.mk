ifndef ROOT
$(error ROOT is not set, are you calling lib.mk directly?)
endif

export PATH := $(ROOT)/bin:$(PATH)
export ROOT := $(ROOT)

config=$(ROOT)/config.yml

link=ln -sf
copy=cp
systemctl=systemctl --user

targets := $(targets:%=target/%)

.PHONY: all $(steps) $(post_hooks)

all: $(build) $(steps) $(post_hooks) $(targets)

target/%:
	make -f $(ROOT)/targets/$*.mk all

$(HOME)/.%: $(ROOT)/home/% $(config)
	m4tpl $@ $<
