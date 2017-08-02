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
	@run-with-state $@ "git submodule update --init"

packages:
	@bin/install-packages
	@bin/install-if-newer "pip install --user" pip
	@bin/install-if-newer "pip3 install --user" pip3
	@bin/install-if-newer "gem install --user" gem

vim:
	make -C vim all

jshint:
	@once $(ROOT)/.jshint "npm install jshint"
