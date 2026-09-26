# quickcfg: email, name
candidates=()

if [[ ! -z $HOME ]]; then
    candidates+=$HOME/.local/bin
    candidates+=$HOME/.cargo/bin
fi

for p in ${candidates[*]}; do
    if [[ -d $p ]]; then
        PATH="$PATH:$p"
    fi
done

if command -v nvim > /dev/null 2>&1; then
    export EDITOR=nvim
else
    export EDITOR=nano
fi

export CORRECT_IGNORE='_*:.*'
export DEBEMAIL="{{email}}"
export DEBFULLNAME="{{name}}"
export PATH
