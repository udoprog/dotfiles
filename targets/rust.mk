steps += rust

include $(ROOT)/lib.mk

rust:
	$(Q)once $(ROOT)/.rustup "curl https://sh.rustup.rs -sSf | sh"
