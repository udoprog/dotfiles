# quickcfg: email, name
candidates=()
# Directories which have a versioned release in them with a <version>/bin directory.
version_dirs=()

if [[ ! -z $HOME ]]; then
    candidates+=$HOME/usr/bin
    candidates+=$HOME/.npm/bin
    candidates+=$HOME/node_modules/.bin
    candidates+=$HOME/.local/bin
    candidates+=$HOME/.rvm/bin
    candidates+=$HOME/.cargo/bin
    candidates+=$HOME/.reproto/bin
    candidates+=$HOME/google-cloud-sdk/bin
    candidates+=$HOME/go/bin

    version_dirs+=$HOME/.gem/ruby
    # osx is special
    version_dirs+=$HOME/Library/Python
fi

for d in ${version_dirs[*]}; do
    if [[ -d $d ]]; then
        while read ver; do
            candidates+=($d/$ver/bin);
        done < <(ls -1 $d)
    fi
done

for p in ${candidates[*]}; do
    if [[ -d $p ]]; then
        PATH="$p:$PATH"
    fi
done

if [[ -d $HOME/usr/go ]]; then
    export GOPATH=$HOME/usr/go
fi

if command -v nvim > /dev/null 2>&1; then
    export EDITOR=nvim
else
    export EDITOR=nano
fi

export CORRECT_IGNORE='_*:.*'
export DEBEMAIL="{{email}}"
export DEBFULLNAME="{{name}}"
export PATH
