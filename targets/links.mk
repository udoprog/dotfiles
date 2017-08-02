HAS_NVIM := $(shell has-command nvim)

build-$(HAS_NVIM) += $(BIN)/vim
build-$(HAS_NVIM) += $(BIN)/view

$(BIN)/vim: /usr/bin/nvim
	relative-ln $@ $<

$(BIN)/view: /usr/bin/nvim
	relative-ln $@ $<

include $(ROOT)/lib.mk
