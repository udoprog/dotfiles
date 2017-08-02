steps += rust

include $(ROOT)/lib.mk

rust:
	$(Q)once rustup "curl https://sh.rustup.rs -sSf | sh"
