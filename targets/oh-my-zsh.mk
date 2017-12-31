url := https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

once += oh-my-zsh

setup := $(ROOT)/cache/oh-my-zsh.zsh

$(setup):
	curl -fsSL $(url) > $(setup)

oh-my-zsh: $(setup)
	sh $(setup) || true
