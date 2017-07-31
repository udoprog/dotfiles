build += $(HOME)/usr/bin/vim

$(HOME)/usr/bin/vim: /usr/bin/nvim
	ln -f -s $$(realpath --relative-to="$$(dirname $@)" $<) $@

include $(ROOT)/lib.mk
