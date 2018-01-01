url := https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

once += oh-my-zsh
build += $(HOME)/.zshrc_custom
build += $(HOME)/.zshrc

setup := $(ROOT)/cache/oh-my-zsh.zsh

$(setup):
	curl -fsSL $(url) > $(setup)

oh-my-zsh: $(setup)
	sh $(setup) || true
	# remove garbage zshrc
	rm -f ~/.zshrc
