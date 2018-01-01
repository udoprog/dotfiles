# udoprog's dotfiles

This is a simple framework for managing dotfiles.

To get started, run:

```bash
$> bin/upd
```

The first step is to install system dependencies (listen in `packages/<distro>`).
After this, all configuration files are run through [`tpl`](/utils/tpl), which runs the
templates through pystache.

You must manually populate a `secrets.yml` file, which contains passwords or other sensitive
information.

```
mutt_signature: John-John Tedro
profile_name: John-John Tedro
name: John-John Tedro
gpg_key: AABBCC
user: udoprog

mail:
    personal:
        email: <email>
        smtp_url: <password>
        smtp_pass: <password>
        imap_url: <password>
        imap_pass: <password>
    other:
        email: <other-email>
        smtp_url: <password>
        smtp_pass: <password>
        imap_url: <password>
        imap_pass: <password>
```

# Features

* powerline for tmux
* airline for vim
* mutt, configured for two different mailboxes (work and home) with corresponding aliases
  (`mutt.work` and `mutt.home`).
* `.profile` with paths to loads of user-local binary locations (`$HOME/usr/bin`,
  `$HOME/.local/bin`, ...), only added if they exist.
* `oh-my-zsh`, with a custom `~/.zshrc_custom` for customization.

## repolib

This comes with two utility commands, `reposync` and `repologs`.

If your system has systemd, reposync will be setup to track remote repositories for all repos
mentioned in `targets/reposync.mk`.

Latest syncs can be checked by running the `repologs` command.
