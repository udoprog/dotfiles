url := https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

steps += oh-my-zsh

oh-my-zsh:
	$(Q)once oh-my-zsh "curl -fsSL $(url) | sh"
