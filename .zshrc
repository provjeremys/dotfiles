# See https://github.com/robbyrussell/oh-my-zsh/blob/master/templates/zshrc.zsh-template
# This file is loaded after .zshenv

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="cobalt2"
plugins=(git extract node npm yarn z zsh-better-npm-completion kubectl)

export PATH="${HOME}/.nvm/versions/node/v5.9.0/bin:/usr/bin/env:${PATH}"

source $ZSH/oh-my-zsh.sh

# Iterm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Jira cli auto complete
eval "$(jira --completion-script-zsh > /dev/null 2>&1)"
#Setup NVM
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

here=$(pwd)
if [ -f "$here/.nvmrc" ] ; then
  nvm install
fi
