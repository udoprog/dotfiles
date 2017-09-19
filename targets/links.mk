source-nvim := $(call bin-path,nvim)
has-nvim := $(if $(source-nvim),y,n)

build-$(has-nvim) += $(BIN)/vim
build-$(has-nvim) += $(BIN)/view

IDEA := $(HOME)/usr/idea/bin/idea.sh
has-idea := $(call has-file,$(IDEA))

build-$(has-idea) += $(BIN)/idea

MVN := $(HOME)/usr/apache-maven/bin/mvn
has-maven := $(call has-file,$(MVN))

build-$(has-maven) += $(BIN)/mvn

bins += reposync
bins += repologs
bins += upd
bins += patch-from-mutt
bins += apply-incoming

$(BIN)/vim: $(source-nvim)
	relative-ln $@ $<

$(BIN)/view: $(source-nvim)
	relative-ln $@ $<

$(BIN)/idea: $(IDEA)
	relative-ln $@ $<

$(BIN)/mvn: $(MVN)
	relative-ln $@ $<
