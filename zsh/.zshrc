# Node version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# DACS NPM Binary Path
export PATH="$(npm config get prefix):$PATH"

# Yarn Binary Path
export PATH="$(yarn global bin):$PATH"

# Homebrew bin
export PATH="/opt/homebrew/bin/:$PATH"

# Alias
alias y="yarn"
alias yade="yarn add --dev --exact"
alias yae="yarn add --exact"
alias yga="yarn global add"
alias ygls="yarn global ls"
alias yuil="yarn upgrade-interactive --latest"
alias ll="ls -l"
alias p="git pull --rebase --autostash"
alias P="git push -u"
alias commit="git commit -m"
alias lg="lazygit"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

source ~/.zsh_dacs
source ~/.zsh_utils
