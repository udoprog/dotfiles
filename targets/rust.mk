once += rust
once += rls

rust:
	curl https://sh.rustup.rs -sSf | sh

rls: rust
	rustup self update
	rustup update nightly
	rustup component add rls --toolchain nightly
	rustup component add rust-analysis --toolchain nightly
	rustup component add rust-src --toolchain nightly
