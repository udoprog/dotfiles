.PHONY: all

all: bundle/YouCompleteMe/python/ycm_core.so

bundle/YouCompleteMe/python/ycm_core.so:
	cd bundle/YouCompleteMe && ./install.sh
