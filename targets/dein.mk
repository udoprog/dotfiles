url := https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh

steps += dein

dein:
	once dein "curl $(url) > $(CACHE)/dein-install.sh"
	sh $(CACHE)/dein-install.sh $(HOME)/.dein
