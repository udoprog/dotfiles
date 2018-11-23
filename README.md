# udoprog's dotfiles

This is a simple framework for managing dotfiles.

To get started you need to install [quickcfg]:

```bash
$> cargo +nightly install quickcfg
```

You must manually populate a `secrets.yml` file, which might contain passwords or other sensitive
information.

```
mutt_signature: John-John Tedro
profile_name: John-John Tedro
name: John-John Tedro
gpg_key: AABBCC
user: udoprog
```

Make sure to chmod it to something suitable:

```bash
$> chmod 0200 secrets.yml
```

After this you can now run `quickcfg`:

```bash
$> quickcfg
```

[quickcfg]: https://github.com/udoprog/quickcfg
