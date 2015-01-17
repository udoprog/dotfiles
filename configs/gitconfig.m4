# vim: filetype=gitconfig
[core]
    excludesfile = ~/.gitignore
[user]
    email = PROFILE_EMAIL
    name = PROFILE_NAME
[alias]
    lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
[color]
    ui = true
[push]
	default = simple
