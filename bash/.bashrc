# See following for more information: http://www.infinitered.com/blog/?p=19

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Colors ----------------------------------------------------------
# export TERM=xterm-color
export CLICOLOR=1
export TERM=xterm-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

if [ `uname -s` == 'Darwin' ]; then
  # OS-X SPECIFIC - the -G command in OS-X is for colors, in Linux it's no groups
  alias ls='ls -F'
else
  # For linux, etc
  alias ls='ls --color=auto -F'
fi

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[1;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'
alias colorslist="set | egrep 'COLOR_\w*'"  # Lists all the colors, uses vars in .bashrc_non-interactive

# Prompt ----------------------------------------------------------
export PS1="
\[${COLOR_LIGHT_BLUE}\]\u\[\e[1;30m\]@\[\e[1;33m\]\h \[\e[1;30m\]\d \[\e[1;33m\]\@ \[\e[0m\]-- \[\e[0;32m\]\w
\[\e[1;37m\]\$(__git_ps1 '(%s)') \[\e[0;32m\]∴ \[\e[0m\]"
export PS1="
\[${COLOR_LIGHT_BLUE}\]\u\[${COLOR_GRAY}\]@\[${COLOR_YELLOW}\]\h \[${COLOR_GRAY}\]\d \[${COLOR_GREEN}\]\@ \[${COLOR_WHITE}\]-- \[${COLOR_GREEN}\]\w
\[${COLOR_WHITE}\]\$(git_info)\[${COLOR_GREEN}\]∴ \[${COLOR_NC}\]"

# Editors ----------------------------------------------------------
export EDITOR=vim

# Misc -------------------------------------------------------------
export HISTCONTROL=ignoredups
export LC_CTYPE=en_US.UTF-8 # For using svn with TextMate Bundles
shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
#bind "set show-all-if-ambiguous On" # show list automatically, without double tab

# Turn on advanced bash completion if the file exists (get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# This runs before the prompt and sets the title of the xterm* window.  If you set the title in the prompt
# weird wrapping errors occur on some systems, so this method is superior
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME} ${PWD}"; echo -ne "\007"'  # user@host path

export PS2='> '    # Secondary prompt
export PS3='#? '   # Prompt 3
export PS4='+'     # Prompt 4

function xtitle {  # change the title of your xterm* window
  unset PROMPT_COMMAND
  echo -ne "\033]0;$1\007"
}

# Navigation -------------------------------------------------------
alias ..='cd ..'
alias ...='cd .. ; cd ..'

# Go ---------------------------------------------------------------
export GOGO_HOME=~/.gogo
if [ -f $GOGO_HOME/gogo ]; then
  . "$GOGO_HOME/gogo"
fi
if [ -f $GOGO_HOME/projects ]; then
  . $GOGO_HOME/projects
fi

# set the bash option so that no '$' is required when using the above facility
shopt -s cdable_vars

# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

# Git ------------------------------------------------------
source ~/.git-completion.sh
source ~/.git-prompt.sh
git_info() {
  local GIT_BRANCH=$(__git_ps1 '%s')
  local GIT_MODIFIED=`git stat 2>/dev/null | wc -l | awk '{if ($1 > 2) print "|*"}'`
	if [ -n "${GIT_BRANCH}" ]; then
		echo "(${GIT_BRANCH}${GIT_MODIFIED}) "
	fi
}

alias git='hub'
alias gb='git branch'
alias gc='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gap='git add -p'
alias gci='git commit'
alias gca='git commit -a'
alias gf='git fetch'
alias gm='git merge --log'
alias gs='git status'
alias gdm='git branch --merged | egrep -v "(\*|dev|release-candidate|master)" | xargs -n 1 git branch -d'
alias grc='git rebase --continue'
alias pr='git pull-request'

function gbr () {
  COUNT=${1:-15}
  git for-each-ref --count=$((COUNT + 2)) --sort=-committerdate refs/heads/ --format='%(refname:short)' | egrep -v '(\*|dev|master|release-candidate)' | tail -r
}

# Get the difference between local and remote logs
gl() {
	local GIT_BRANCH=$(__git_ps1 '%s')
	git log origin/${GIT_BRANCH}..
}

# Misc ------------------------------------------------------
alias g='grep -i'  # Case insensitive grep
alias f='find . -iname'
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias top='top -o cpu'
alias systail='tail -f /var/log/system.log'
alias m='more'
alias df='df -h'
alias sqlite3='sqlite3 -header -column'
alias tm_update="osascript -e 'tell app \"TextMate\" to reload bundles'"
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias go='gogo'
alias pg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log'
alias cshot='ls -tr tmp/capybara/*png | tail -1 | xargs open'
alias rserver='ruby -run -e httpd . -p 9090'
alias subl='subl -n'
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias ip_internal='ifconfig | egrep "inet " | grep -v 127.0.0.1 | cut -d " " -f 2'
alias notes='code ~/Dropbox/notes/programming/notes-programming.code-workspace'
alias toiletcat='cd ~/Dropbox/projects/toiletcat && code .'

export HISTIGNORE="[ ]*"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# EC2
export EC2_HOME=~/bin/ec2
export PATH=$PATH:$EC2_HOME/bin
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

# RVM ------------------------------------------------------
# if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi

# Ruby

## bundler
alias be="bundle exec"
alias bo="EDITOR=code bundle open"

## chruby
# source /usr/local/opt/chruby/share/chruby/chruby.sh
# source /usr/local/opt/chruby/share/chruby/auto.sh

# rbenv
# export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Prioritize project-specific binstubs:
# export PATH=./bin:$PATH

## Ruby aliases

# Zeus
alias rcop='rubocop --display-cop-names'
alias zrake='zeus rake'
alias zspec='zeus rspec'
alias zcuke='zeus cucumber'
alias ztest='FAIL_FAST=true zspec spec && zcuke && rcop'

# Misc Rails
alias bspec='bin/rspec spec'
alias rt='RAILS_ENV=test rake'
alias mig='bin/rails db:migrate'
alias migtest='bin/rails db:migrate RAILS_ENV=test'
alias rup='bundle && mig && migtest'
alias mysqlwat='lsof -nP +c 15 | grep LISTEN | grep 3306'
alias wport='lsof -nP +c 15 | grep LISTEN | grep '

# exercism
alias ex='ruby -r ../test_helper.rb *_test.rb'

RUBYGEMS_GEMDEPS=-

# python
alias python=python3

# tmux
source ~/bin/tmuxinator.bash
alias tmux="TERM=screen-256color-bce tmux"
alias tml="tmux list-sessions"
alias tma="tmux -2 attach -t $1"
alias tmk="tmux kill-session -t $1"

# added by travis gem
[ -f /Users/cox/.travis/travis.sh ] && source /Users/cox/.travis/travis.sh

# random aliases
alias pnotes="code ~/Dropbox/notes/programming/notes-programming.code-workspace"
alias brewup="brew update && brew upgrade"

dsync() {
	cd ~/dev/dox-compose && docker-sync start -f -n $1-sync
}

# Doximity
alias doxprod="ssh prod-doximity-console-1.dox.box"
alias doxpreprod="ssh pre-doximity-1.dox.rox"
alias doxccprod="ssh prod-colleague-connect-1.dox.box"
alias doxccpreprod="ssh pre-colleague-connect-1.dox.rox"
alias dc="docker-compose -f ~/dev/docker-compose/docker-compose.yml"
alias doxdev="bin/rails s webrick -p 5000"
alias ccdev="bin/rails s webrick -p 5030"
alias drup='dox-do bundle && dox-do bundle exec rake db:migrate'
alias dce="dox-dc exec ${PWD##*/}"
alias dcstartapp="dox-dc up -d ${PWD##*/} && dox-dc logs -f ${PWD##*/}"
alias dspec="dce bundle exec rspec"
alias dpry='dce pry-remote'
alias dacc='docker attach dox-compose_colleague-connect_1'
alias dad='docker attach dox-compose_doximity_1'
alias ddo='dox-do bundle exec'
alias staging-chamber='AWS_REGION=us-east-1 CHAMBER_KMS_KEY_ALIAS=staging-parameter-store aws-vault exec legacy -- chamber'
alias pre-chamber='AWS_REGION=us-east-1 CHAMBER_KMS_KEY_ALIAS=pre-parameter-store aws-vault exec hipaa -- chamber'
alias prod-chamber='AWS_REGION=us-east-1 CHAMBER_KMS_KEY_ALIAS=prod-parameter-store aws-vault exec hipaa -- chamber'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
eval "$(~/dev/dox-compose/bin/dox-init)"

# Enable homebrew bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
