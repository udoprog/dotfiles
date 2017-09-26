url := https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

once += oh-my-zsh

oh-my-zsh:
	curl -fsSL $(url) | sh
