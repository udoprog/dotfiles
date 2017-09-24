url := https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh

steps += dein

dein: $(HOME)/.dein

$(HOME)/.dein: $(CACHE)/dein-install.sh
	sh $(CACHE)/dein-install.sh $(HOME)/.dein

$(CACHE)/dein-install.sh:
	curl $(url) > $(CACHE)/dein-install.sh
