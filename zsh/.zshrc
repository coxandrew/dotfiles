# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/cox/.oh-my-zsh

# Set DEFAULT_USER so you don't see user@hostname in prompt
DEFAULT_USER=`whoami`

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="avit"
ZSH_THEME="agnoster"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Does this need to be sourced before/after anything in particular?
source $ZSH/oh-my-zsh.sh

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Ruby
# -----------------------------------------------------------------------------
# Initialize rbenv
eval "$(rbenv init -)"

alias be="bundle exec"

# Personal
# -----------------------------------------------------------------------------
note() {
	cd "$HOME/Dropbox/notes" && vim "$1.md"
}
alias notes="code $HOME/Dropbox/notes"

# Use ag as default file search for fzf so we can respect .gitignore
export FZF_DEFAULT_COMMAND='ag --path-to-ignore ~/.gitignore --hidden -g ""'

# For mysql. See: https://github.com/brianmario/mysql2/issues/795#issuecomment-337006164
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

# Disable <C-s> in terminal so we can use it to save in vim
# alias vim="stty stop '' -ixoff ; vim"

# alias ovim="vim $(fzf)"
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Git
unalias gbr
function gbr () {
  COUNT=${1:-15}
  git for-each-ref --count=$((COUNT + 2)) --sort=-committerdate refs/heads/ --format='%(refname:short)' | egrep -v '(\*|dev|master|release-candidate)' | tail -r
}
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gdm='git branch --merged | egrep -v "(\*|dev|release-candidate|master)" | xargs -n 1 git branch -d'

# Doximity
alias doxprod="ssh prod-doximity-console.dox.box"
alias doxpreprod="ssh pre-doximity-1.dox.rox"
alias doxccprod="ssh prod-colleague-connect-console.dox.box"
alias doxccpreprod="ssh pre-colleague-connect-1.dox.rox"
alias dad="docker attach dox-compose_doximity_1"
alias dacc="docker attach dox-compose_colleague-connect_1"
alias gempush="gem build *.gemspec && fury push *.gem --as=doximity && rm *.gem"

export DOXCLI_GITHUB_TOKEN="151412b4476b945e5f0b9861559146bed89bd752"

# dox-compose
eval "$("/Users/cox/dev/dox-compose/bin/dox-init")"
alias drup='dox-do bundle && dox-do bundle exec rake db:migrate'
alias dspec="dox-dc run ${PWD##*/}-test bash"

