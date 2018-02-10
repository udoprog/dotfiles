candidates=(
    $HOME/usr/bin
    $HOME/.npm/bin
    $HOME/node_modules/.bin
    $HOME/.local/bin
    $HOME/.rvm/bin
    $HOME/.cargo/bin
    $HOME/google-cloud-sdk/bin
    $HOME/go/bin
)

if [[ -d $HOME/.gem/ruby ]]; then
    while read ver; do
        candidates+=($HOME/.gem/ruby/$ver/bin)
    done < <(ls -1 $HOME/.gem/ruby)
fi

for p in ${candidates[*]}; do
    if [[ -d $p ]]; then
        PATH="$p:$PATH"
    fi
done

if [[ -d $HOME/repo/rust/src ]]; then
    export RUST_SRC_PATH=$HOME/repo/rust/src
fi

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
