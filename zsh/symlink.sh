dir="$(dirname "${BASH_SOURCE[0]}")"

unlink() {
    if [[ -L "$HOME/$1" ]]; then
        echo "symlink found for $1"
    else
        echo "$1 is not a symlink or cannot be found in $HOME"
    fi
}

for file in $dir/.*; do
    filename="$(basename "$file")"
    if [[ "$filename" != "." && "$filename" != ".." ]]; then
        unlink $filename
    fi
done
