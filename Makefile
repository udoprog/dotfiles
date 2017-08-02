ROOT := $(CURDIR)

steps += submodules
steps += packages
steps += vim
steps += jshint

targets += configs
targets += mutt
targets += systemd
targets += links
targets += oh-my-zsh
targets += rust

include $(ROOT)/lib.mk

submodules: $(ROOT)/.submodules

$(ROOT)/.submodules: $(ROOT)/.gitmodules
	$(Q)run-with-state $@ "git submodule update --init"

packages:
	$(Q)install-packages
	$(Q)install-if-newer "pip install --user" pip
	$(Q)install-if-newer "pip3 install --user" pip3
	$(Q)install-if-newer "gem install --user" gem

vim:
	$(Q)make $(make-opts) -C vim all

jshint:
	$(Q)once $(ROOT)/.jshint "npm install jshint"
