fzf_completion_helper() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(cd ~/projects/ && compgen -d -- "$cur"))
}

setup_fzf_completion() {
    complete -F fzf_completion_helper fcd
    complete -F fzf_completion_helper fnvim
}

setup_fzf_completion

