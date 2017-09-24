steps += $(CACHE)
steps += $(ROOT)/.submodules
steps += packages
steps += jshint

targets += targets/configs.mk
targets += targets/dein.mk
targets += targets/links.mk
targets += targets/mutt.mk
targets += targets/oh-my-zsh.mk
targets += targets/rust.mk
targets += targets/vim.mk
targets-$(has-systemd) += targets/reposync.mk

$(ROOT)/.submodules: $(ROOT)/.gitmodules
	run-with-state $@ "git submodule update --init"

packages:
	install-packages
	install-if-newer pip "pip install --user"
	install-if-newer pip3 "pip3 install --user"
	install-if-newer gem "gem install --user"

jshint:
	once jshint "npm install jshint"

$(CACHE):
	mkdir -p $@
