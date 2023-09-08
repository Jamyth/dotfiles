install_nvm_if_not_found() {
    if ! command -v nvm &> /dev/null; then
        echo "Node Version Manager is not found, installing..."
        # Tell NVM not to touch .zshrc
        PROFILE=/dev/null
        nvm_script="curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh"
        /bin/bash -c "$nvm_script"
    fi
}

load_nvm() {
    local nvm_script="$NVM_DIR/nvm.sh"
    local bash_completion_script="$NVM_DIR/bash_completion"
    if [[ -s "$nvm_script" ]]; then
        /bin/bash "$nvm_script"
    fi
    if [[ -s "$bash_completion_script" ]]; then
        /bin/bash "$bash_completion_script"
    fi
}

install_nvm_if_not_found
load_nvm


