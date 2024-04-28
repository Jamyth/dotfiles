fcd() {
    local selected
    if [[ -n "$1" && -d "$HOME/projects/$1" ]]; then
        selected="$HOME/projects/$1"
    else
        selected=$(find ~/projects -mindepth 1 -maxdepth 1 -type d | fzf)
    fi

    if [[ -z $selected ]]; then
        return 1
    fi

    cd $selected
}

fnvim() {
    fcd $1 && nvim .
}
