# udoprog's dotfiles

This is a simple framework for managing dotfiles.

To get started you need to install [quickcfg]:

```bash
$ cargo install quickcfg
```

Initialize the basic configuration (from this is your repo):

```bash
$ qc --init https://github.com/udoprog/dotfiles
```

Edit `secrets.yml`:

```bash
$ nvim $(qc --paths | grep "^Root:" | awk '{print $2}')/secrets.yml
```

With this:

```
mutt_signature: John-John Tedro
profile_name: John-John Tedro
name: John-John Tedro
gpg_key: AABBCC
user: udoprog
tmux_prefix: C-c
email: udoprog@example.com
```

Make sure to chmod it to something suitable:

```bash
$> chmod 0200 $(qc --paths | grep "^Root:" | awk '{print $2}')/secrets.yml
```

After this you can now run `quickcfg`:

```bash
$> qc
```

[quickcfg]: https://github.com/udoprog/quickcfg
