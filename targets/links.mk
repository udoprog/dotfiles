HAS_NVIM := $(shell has-command nvim)

build-$(HAS_NVIM) += $(BIN)/vim
build-$(HAS_NVIM) += $(BIN)/view

IDEA := $(HOME)/usr/idea/bin/idea.sh
HAS_IDEA := $(shell has-path $(IDEA))

build-$(HAS_IDEA) += $(BIN)/idea

$(BIN)/vim: /usr/bin/nvim
	relative-ln $@ $<

$(BIN)/view: /usr/bin/nvim
	relative-ln $@ $<

$(BIN)/idea: $(IDEA)
	relative-ln $@ $<

include $(ROOT)/lib.mk
