has-systemd := $(shell has-command systemctl)

steps += submodules
steps += packages
steps += vim
steps += jshint

targets += targets/configs.mk
targets += targets/mutt.mk
targets += targets/links.mk
targets += targets/oh-my-zsh.mk
targets += targets/rust.mk
targets-$(has-systemd) += targets/systemd.mk
targets-$(has-systemd) += targets/reposync.mk
targets += vim/Makefile

submodules: $(ROOT)/.submodules

$(ROOT)/.submodules: $(ROOT)/.gitmodules
	$(Q)run-with-state $@ "git submodule update --init"

packages:
	$(Q)install-packages
	$(Q)install-if-newer pip "pip install --user"
	$(Q)install-if-newer pip3 "pip3 install --user"
	$(Q)install-if-newer gem "gem install --user"

jshint:
	$(Q)once jshint "npm install jshint"
