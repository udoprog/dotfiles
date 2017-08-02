url := https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

steps += oh-my-zsh

include $(ROOT)/lib.mk

oh-my-zsh:
	$(Q)once $(ROOT)/.oh-my-zsh "curl -fsSL $(url) | sh"
