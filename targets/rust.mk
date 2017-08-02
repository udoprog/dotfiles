steps += rust

include $(ROOT)/lib.mk

rust:
	@once $(ROOT)/.rustup "curl https://sh.rustup.rs -sSf | sh"
