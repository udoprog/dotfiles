all: ${HOME}/.config ${HOME}/.config/awesome 

${HOME}/.config:
	mkdir -p $@

${HOME}/.config/awesome: ${PWD}
	ln -sf $< $@
