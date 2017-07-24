ROOT := $(CURDIR)

steps+=submodules
steps+=packages
steps+=oh-my-zsh
steps+=vim
steps+=rust
steps+=jshint

targets+=configs
targets+=mutt
targets+=systemd

include $(ROOT)/lib.mk

submodules: $(ROOT)/.submodules

$(ROOT)/.submodules: $(ROOT)/.gitmodules
	@run-with-state $@ "git submodule update --init"

packages:
	@bin/install-packages
	@bin/install-if-newer "pip install --user" pip
	@bin/install-if-newer "pip3 install --user" pip3
	@bin/install-if-newer "gem install --user" gem

oh-my-zsh:
	@once $(ROOT)/.oh-my-zsh 'sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'

vim:
	make -C vim all

jshint:
	@once $(ROOT)/.jshint "npm install jshint"

rust:
	@once $(ROOT)/.rustup "curl https://sh.rustup.rs -sSf | sh"
