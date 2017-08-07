steps += rust

rust:
	$(Q)once rustup "curl https://sh.rustup.rs -sSf | sh"
