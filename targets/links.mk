has-nvim := $(shell has-command nvim)

build-$(has-nvim) += $(BIN)/vim
build-$(has-nvim) += $(BIN)/view

IDEA := $(HOME)/usr/idea/bin/idea.sh
has-idea := $(shell has-path $(IDEA))

build-$(has-idea) += $(BIN)/idea

MVN := $(HOME)/usr/apache-maven/bin/mvn
has-maven := $(shell has-path $(MVN))

build-$(has-maven) += $(BIN)/mvn

$(BIN)/vim: /usr/bin/nvim
	$(Q)relative-ln $@ $<

$(BIN)/view: /usr/bin/nvim
	$(Q)relative-ln $@ $<

$(BIN)/idea: $(IDEA)
	$(Q)relative-ln $@ $<

$(BIN)/mvn: $(MVN)
	$(Q)relative-ln $@ $<

include $(ROOT)/lib.mk
