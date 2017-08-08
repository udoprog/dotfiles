has-nvim := $(shell has-command nvim)

build-$(has-nvim) += $(BIN)/vim
build-$(has-nvim) += $(BIN)/view

IDEA := $(HOME)/usr/idea/bin/idea.sh
has-idea := $(shell has-path $(IDEA))

build-$(has-idea) += $(BIN)/idea

MVN := $(HOME)/usr/apache-maven/bin/mvn
has-maven := $(shell has-path $(MVN))

build-$(has-maven) += $(BIN)/mvn

bins += reposync
bins += repologs
bins += upd
bins += patch-from-mutt
bins += apply-incoming

$(BIN)/vim: /usr/bin/nvim
	relative-ln $@ $<

$(BIN)/view: /usr/bin/nvim
	relative-ln $@ $<

$(BIN)/idea: $(IDEA)
	relative-ln $@ $<

$(BIN)/mvn: $(MVN)
	relative-ln $@ $<
