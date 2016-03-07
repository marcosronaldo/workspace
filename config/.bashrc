RESET="\[\017\]"
NORMAL="\[\033[0m\]"
RED="\[\033[0;31m\]"
YELLOW="\[\033[33;1m\]"
GREEN="\[\033[32;1m\]"
BROWN="\[\033[0;33m\]"
BLUE="\[\033[34;1m\]"
WHITE="\[\033[37;1m\]"
SMILEY="${GREEN}:)${NORMAL}"
FROWNY="${RED}:(${NORMAL}"
SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

USER_DISTRO="${BROWN}[${GREEN}\u ${BLUE}$(lsb_release -is)${BROWN}]"

#----------------------- GIT INFO on PROMPT -------------------------
#parse_git_branch() {
# git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
#}

# Get number of files added to the index (but uncommitted)
function git_num_added_files {
	expr $(git status --porcelain 2>/dev/null| grep "^M" | wc -l)
}

# Get number of files that are uncommitted and not added
function git_num_not_added {
	expr $(git status --porcelain 2>/dev/null| grep "^ M" | wc -l)
}

# Get number of total uncommited files
#expr $(git status --porcelain 2>/dev/null| egrep "^(M| M)" | wc -l)

function git_num_untracked_files {
  expr $(git status --porcelain 2>/dev/null| grep "^??" | wc -l)
}

function parse_git_deleted {
  [[ $(git status 2> /dev/null | grep deleted:) != "" ]] && echo "-"
}
function parse_git_untracked {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo '!'
}
function parse_git_added {
  [[ $(git status 2> /dev/null | grep "new file:") != "" ]] && echo '+'
}
function parse_git_modified {
  [[ $(git status 2> /dev/null | grep modified:) != "" ]] && echo "*"
}
function parse_git_dirty {
  echo " $(parse_git_added)$(parse_git_deleted)$(parse_git_modified)$(parse_git_untracked)"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
GIT_BRANCH="${RED}\$(parse_git_branch)"

#---------------------------------------------------------------------------
#
#
PS1="${BROWN}\342\224\214\342\224\200[\`${SELECT}\`${BROWN}]-${USER_DISTRO}-[${YELLOW}\w${BROWN}]${GIT_BRANCH}${BROWN}\n${BROWN}\342\224\224\342\224\200> \$ ${NORMAL}"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias la='ls -la'
    alias ~='cd ~'
    alias cd..='cd ..'
    alias ..='cd ..'
    alias .2='cd ../..'
    alias .3='cd ../../..'
    alias .4='cd ../../../..'
    alias .5='cd ../../../../..'
    alias path='echo -e ${PATH//:/\\n}'
    alias sudoe='sudo -E'
    alias svi='sudoe vim'
    alias edit='vim'
    alias mv='mv -i'
    alias cp='cp -i'
    alias ln='ln -i'
    alias rm='rm -i'
    alias histg="history | grep"
    alias tmux4='tmux new-session -d && tmux split-window -h && tmux split-window -v -t 0 && tmux split-window -v -t 1 && tmux -2 attach-session -d'
    alias tmuxback='tmux -2 attach-session -d'
    alias grep='grep --color=auto'
    eval $(thefuck --alias)
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'

fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/gems/ruby-2.2.1/bin"
export GEM_HOME=$(ruby -e 'print Gem.user_dir')
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/Downloads/firefox"
