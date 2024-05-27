iterate_dir() {
    local directory="$1"
    local callback="$2"
    local param="$3"

    while [ -n "$directory" ]; do
        local dir="${directory%%:*}"

        "$callback" "$dir" "$param"

        if [[ $? -ne 0 ]]; then
            return 1
        fi

        if [ "$directory" = "$dir" ]; then
            directory=""
        else
            directory="${directory#*:}"
        fi
    done
}

add_jamyth_projects() {
    local project

    check_if_includes() {
        local dir="$1"

        if ! [[ -n "$dir" && -d "$dir" ]] || [[ "$dir" == "$project" ]]; then
            echo "$project is already in JAMYTH_PROJECTS"
            return 1
        fi
    }

    if [[ -n "$1" && -d "$1" ]]; then
        project="$1"
    else
        project="$PWD"
    fi

    iterate_dir $JAMYTH_PROJECTS check_if_includes

    if [[ $? -ne 0 ]]; then
        return 0
    fi

    local current_dir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

    echo "export JAMYTH_PROJECTS=\"$JAMYTH_PROJECTS:$project\"" > "$current_dir/jamyth_project_env.sh"
    source  "$current_dir/jamyth_project_env.sh"
}

read_dir_and_save_temp() {
    local dir="$1"
    local temp_file="$2"

    if [[ -z "$dir" ]]; then
        return 1
    fi

    if [[ -z "$temp_file" ]] && ! [[ -e "$temp_file" && -w "$temp_file" ]]; then
        return 1
    fi

    if [[ -d "$dir" ]]; then
        find "$dir" -mindepth 1 -maxdepth 1 -type d >> "$temp_file"
    fi
}

read_projects() {
    local projects="$1"
    
    if ! [[ -n "$projects" ]]; then
        return 1
    fi

    local temp_file=$(mktemp)
    iterate_dir "$projects" read_dir_and_save_temp "$temp_file"
    cat "$temp_file"
    rm "$temp_file"
}

read_jamyth_projects() {
    read_projects "$JAMYTH_PROJECTS"
}

fcd() {
    local input="$1"
    local selected
    local matched_projects

    match_projects() {
        local dir="$1"

        if [[ -n "$dir" && -d "$dir/$input" ]]; then
            if [[ -n "$matched_projects" ]]; then
                matched_projects="$matched_projects:$dir/$input"
            else
                matched_projects="$dir/$input"
            fi
        fi
    }

    iterate_matched_projects() {
        local temp_file=$(mktemp)
        push_to_temp() {
            if [[ -n "$1" && -d "$1" ]]; then
                echo "$1" >> $temp_file
            fi
        }
        iterate_dir "$matched_projects" push_to_temp
        cat $temp_file
        rm $temp_file 
    }

    if [[ -n "$input" ]]; then
        iterate_dir "$JAMYTH_PROJECTS" match_projects


        if [[ "$match_projects" == *":"* ]]; then
            selected=$(iterate_matched_projects | fzf)
        else
            selected="$matched_projects"
        fi
    else
        selected=$(read_jamyth_projects | fzf)
    fi

    if [[ -z $selected ]]; then
        return 1
    fi

    cd $selected
}

fnvim() {
    fcd $1 && nvim
}

