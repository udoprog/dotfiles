candidates=(
    $HOME/usr/bin
    $HOME/.npm/bin
    $HOME/node_modules/.bin
    $HOME/.local/bin
    $HOME/.rvm/bin
    $HOME/.cargo/bin
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

export EDITOR=nvim
export RUST_SRC_PATH=$HOME/repo/rust/src

export PATH
export CORRECT_IGNORE='_*:.*'

export DEBEMAIL="{{email}}"
export DEBFULLNAME="{{name}}"

export GOPATH=$HOME/usr/go
