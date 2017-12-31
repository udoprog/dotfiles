once += rust
once += rls

rustup_init := $(ROOT)/cache/rustup-init.sh

rust: $(rustup_init)
	sh $(ROOT)/cache/rustup-init.sh -y

$(rustup_init):
	curl https://sh.rustup.rs -sSf > $@

rls: rust
	rustup self update
	rustup update nightly
	rustup component add rls-preview --toolchain nightly
	rustup component add rust-analysis --toolchain nightly
	rustup component add rust-src --toolchain nightly
