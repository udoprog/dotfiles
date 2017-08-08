LOGDIR=$HOME/.cache/repolib-logs

repolib_setup() {
    if [[ ! -d $LOGDIR ]]; then
        echo "Creating: $LOGDIR"
        mkdir -p $LOGDIR
    fi
}
