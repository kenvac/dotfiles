# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand suffix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/ondra/.zshrc'

zstyle ':completion:*:files' ignored-patterns '*?.o' '*?~'
zstyle ':completion:*:functions-non-comp' ignored-patterns '_*'

zstyle ':completion:*:*:vim:*' ignored-patterns '*.o' '*.so' '*.lo'
zstyle ':completion:*:functions' ignored-patterns '_*'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install

setopt prompt_subst

setopt hist_ignore_dups hist_save_no_dups hist_expire_dups_first
setopt print_exit_value

bindkey '^H' backward-delete-word
bindkey '^[[3;5~' delete-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;2A' history-beginning-search-backward
bindkey '^[[1;2B' history-beginning-search-forward
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

export PS1="%n@%m:%~%# "

export EDITOR=vim

export PATH=~/bin:"/usr/lib/ccache:$PATH"
#export CC=clang

#export http_proxy="http://proxy:3128/"
#export https_proxy="$http_proxy"

#Debian stuff
DEBEMAIL="ondra@mistotebe.net"
DEBFULLNAME="Ondřej Kuzník"
DEBSIGN_KEYID="CB61484B"

export DEBEMAIL DEBFULLNAME DEBSIGN_KEYID

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

for file in ~/.zsh.d/*; do
    [ -r "$file" ] && source "$file"
done

if [ -n "$(whence __git_ps1)" ]; then
    PROMPT='%n@%m:%~$(__git_ps1 ":%s")%# '
fi

if [ -n "$TMUX" ]; then refreshTmuxEnvironment; fi

fortune
