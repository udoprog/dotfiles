steps += submodules
steps += packages
steps += vim
steps += jshint

has-systemd += $(shell has-command systemctl)

targets += configs
targets += mutt
targets += links
targets += oh-my-zsh
targets += rust
targets-$(has-systemd) += systemd
targets-$(has-systemd) += reposync

include $(ROOT)/lib.mk

submodules: $(ROOT)/.submodules

$(ROOT)/.submodules: $(ROOT)/.gitmodules
	$(Q)run-with-state $@ "git submodule update --init"

packages:
	$(Q)install-packages
	$(Q)install-if-newer pip "pip install --user"
	$(Q)install-if-newer pip3 "pip3 install --user"
	$(Q)install-if-newer gem "gem install --user"

vim:
	$(Q)make $(make-opts) -C vim all

jshint:
	$(Q)once jshint "npm install jshint"
