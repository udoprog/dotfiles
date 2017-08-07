candidates=(
    $HOME/usr/bin
    $HOME/.npm/bin
    $HOME/node_modules/.bin
    $HOME/.local/bin
    $HOME/.gem/ruby/2.3.0/bin
    $HOME/.rvm/bin
    $HOME/.cargo/bin
)

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
