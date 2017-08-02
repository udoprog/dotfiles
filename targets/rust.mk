steps += rust

rust:
	@once $(ROOT)/.rustup "curl https://sh.rustup.rs -sSf | sh"

include $(ROOT)/lib.mk
