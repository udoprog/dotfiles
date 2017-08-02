url := https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

steps += oh-my-zsh

oh-my-zsh:
	@once $(ROOT)/.oh-my-zsh "curl -fsSL $(url) | sh"

include $(ROOT)/lib.mk
