# installs visual studio code

once-$(call is-distro,fedora) += vscode-fedora

vscode-fedora:
	echo "Installing VSCode"
	sudo env FILES="$(FILES)" $(HELPERS)/fedora-install-vscode
