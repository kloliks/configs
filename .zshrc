# locale
#export LANG=ru_RU.UTF-8
#export LC_COLLATE=C
#export LC_NUMERIC=C

#export LANG=ru_RU.cp1251
#export LC_COLLATE=C


# colors
autoload -U colors && colors

if [ -r /etc/DIR_COLORS ]; then
  eval "$(dircolors -b /etc/DIR_COLORS)"
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias egrep='egrep --color=auto'
  alias fgrep='fgrep --color=auto'
fi

# alias
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='la -lh'

alias cal="cal -3"

alias less='less -M'

alias df='df -h'
alias du='du -h'

alias mount="mount | column -t"

alias -s {html,htm,xhtml}=firefox
alias -s {avi,mp4,mkv}="mplayer -fs"

alias racket="racket -il readline"

alias -s {bmp,jpg}="nohup gimp"

# enviropment
export PATH="$PATH:/sbin:/usr/sbin:$HOME/bin:$GOPATH/bin"
export AB_HOME="/home/yos/Trassir_3.2/tech1utils/ab"

export EDITOR=vim
export PAGER=vimpager
export MANPAGER=vimmanpager
export PERLDOC_PAGER="less -+C -M"

export MAKEFLAGS=j9

#>>>>>       zsh configure       <<<<<

#PS1="%{$fg[yellow]%}%~%% %{$reset_color%}"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt inc_append_history               # Appends every command to the history file once it is executed
setopt share_history                    # Reloads the history whenever you use it

setopt prompt_subst

bindkey -v
bindkey '^?' backward-delete-char
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward

source ${HOME}/.config/zsh/keybindings


# get git branch name for prompt
git_prompt() {
  local GREEN="%{$fg[green]%}"
  local RESET="%{$reset_color%}"

  ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)

  echo -n $GREEN
  echo -n $ref
  echo -n $RESET
}

# set indicator vi-mode

# change cursor color to reflect vicmd mode
#PS_LOCALE="%{$fg_bold[cyan]%}`echo $LANG | sed 's/.*\.\(.*\)/\1/'`%{$reset_color%}"
#PS_CURDIR="%{$fg[yellow]%}%~%{$reset_color%}"
#PS_VIMODE="[%{$fg[green]%}ins%{$reset_color%}]"
#PS_HOSTNAME="%{$fg[green]%}%n%{$fg_bold[blue]%}@%M%{$reset_color%}"
PS_LOCALE="%{$fg[cyan]%}`echo $LANG | sed 's/.*\.\(.*\)/\1/'`"
PS_CURDIR="%{$fg[yellow]%}%~"
PS_VIMODE="[%{$fg[green]%}ins%{$reset_color%}]"
PS_HOSTNAME="%{$fg[green]%}%n%{$fg[blue]%}%B@%M%b"

PSO="%{$fg[cyan]%}["
PSC="%{$fg[cyan]%}]"
#PSC="%{$fg[green]%}]%{$reset_color%}"

zle-keymap-select () {
    if [ $KEYMAP = vicmd ]; then
        PS_VIMODE="[%{$fg[red]%}cmd%{$reset_color%}]"
        PS1="$PS_VIMODE%{$fg[yellow]%}%% %{$reset_color%}"

        if [[ $TMUX != '' ]]; then
            printf '\033Ptmux;\033\033]12;brred\007\033\\'
        elif [ $TERM = "screen" ]; then
            echo -ne '\033P\033]12;#cb4b16\007\033\\'
        elif [ $TERM != "linux" ]; then
            echo -ne "\033]12;#cb4b16\007"
        fi
    else
        PS_VIMODE="[%{$fg[green]%}ins%{$reset_color%}]"
        PS1="$PS_VIMODE%{$fg[yellow]%}%% %{$reset_color%}"

        if [[ $TMUX != '' ]]; then
            printf '\033Ptmux;\033\033]12;brgreen\007\033\\'
        elif [ $TERM = "screen" ]; then
            echo -ne '\033P\033]12;#586e75\007\033\\'
        elif [ $TERM != "linux" ]; then
            echo -ne "\033]12;#586e75\007"
        fi
    fi

    zle reset-prompt
};

precmd() { print -rP "$PS_LOCALE $PS_HOSTNAME $PS_CURDIR $(git_prompt)" }
PS1="$PS_VIMODE%{$fg[yellow]%}%% %{$reset_color%}"

zle-line-init () {
    zle -K viins

    if [ $TERM = "screen" ]; then
        echo -ne '\033P\033]12;#586e75\007\033\\'
    elif [ $TERM != "linux" ]; then
        echo -ne "\033]12;#586e75\007"
    fi

    zle reset-prompt
};

zle -N zle-keymap-select
zle -N zle-line-init

# end set indicator vi-mode

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
