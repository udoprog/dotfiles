# Udoprog's Dotfiles

I use a simple build-system which initially only depends on Make and Bash.

To get started, run:

```bash
$> utils/upd
```

The first step is to install system dependencies (listen in `packages/<distro>`).
After this, all configuration files are run through [`render`](/bin/render), which runs the
templates through pystache.

You must manually populate a `secrets.yml` file, which contains passwords or other sensitive
information.

This file should contain everything listen in [`config.yml`](/config.yml) under the `secrets`
section, and should look something like this:

```
# corresponds to the profile currently used
id: home

secrets:
  EMAIL: <email>
  SMTP_PASS: <password>
  IMAP_PASS: <password>
  SMTP_URL: <password>
  IMAP_URL: <password>
  WORK_EMAIL: <work-email>
  WORK_SMTP_PASS: <password>
  WORK_IMAP_PASS: <password>
  WORK_SMTP_URL: <url-with-password>
  WORK_IMAP_URL: <url-with-password>
```

All build configuration is handled using make, with a very simple dependency system as defined in
[`lib.mk`](/lib.mk).

# Features

* powerline for tmux
* airline for vim
* mutt, configured for two different mailboxes (work and home) with corresponding aliases
  (`mutt.work` and `mutt.home`).
* `.profile` with paths to loads of user-local binary locations (`$HOME/usr/bin`,
  `$HOME/.local/bin`, ...), only added if they exist.
* `oh-my-zsh`, with a custom `~/.zshrc_custom` for customization.

# repolib

This comes with two utility commands, `reposync` and `repologs`.

If your system has systemd, reposync will be setup to track remote repositories for all repos
mentioned in `targets/reposync.mk`.

Latest syncs can be checked by running the `repologs` command.
