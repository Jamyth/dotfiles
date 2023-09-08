install_homebrew_if_not_found() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not found, installing..."
        homebrew_script="$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        /bin/bash -c "$homebrew_script"
    fi
}

install_homebrew_if_not_found

export PATH="$HOMEBREW_PREFIX/bin/:$PATH"
