ROOT := $(CURDIR)
include env.mk

steps+=packages
steps+=submodules
steps+=configs
steps+=utils
steps+=vim
steps+=rust
steps+=jshint

.PHONY: $(steps)
.PHONY: all clean

all: $(steps)

clean:
	buildall clean
	make -C vim clean

submodules: $(ROOT)/.submodules

$(ROOT)/.submodules: $(ROOT)/.gitmodules
	@run $@ "git submodule update --init"

packages:
	bin/install-packages
	bin/install-if-newer "pip3 install --user" pip3
	bin/install-if-newer "gem install --user" gem

configs:
	buildall all

vim:
	make -C vim all

jshint:
	@once $(ROOT)/.jshint "npm install jshint"

rust:
	@once $(ROOT)/.rustup "curl https://sh.rustup.rs -sSf | sh"
