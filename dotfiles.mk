steps += $(CACHE)
steps += $(ROOT)/.submodules
steps += packages
steps-$(call has-command,pip) += packages-pip
steps-$(call has-command,pip3) += packages-pip3
steps-$(call has-command,gem) += packages-gem

targets += targets/configs.mk
targets += targets/dein.mk
targets += targets/links.mk
targets += targets/mutt.mk
targets += targets/oh-my-zsh.mk
targets += targets/rust.mk
targets += targets/vim.mk
targets += targets/vscode.mk
targets-$(has-systemd) += targets/reposync.mk

once += jshint

$(ROOT)/.submodules: $(ROOT)/.gitmodules
	run-with-state $@ "git submodule update --init"

packages-pip:
	install-if-newer pip "pip install --user"

packages-pip3:
	install-if-newer pip3 "pip3 install --user"

packages-gem:
	install-if-newer gem "gem install --user"

packages:
	install-packages

jshint:
	npm install jshint

$(CACHE):
	mkdir -p $@
