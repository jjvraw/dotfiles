# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('~/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "~/anaconda3/etc/profile.d/conda.sh" ]; then
        . "~/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="~/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

function mkcd() {
  mkdir -p "$1" && cd "$1"
}

alias pcr="pre-commit run --all-files"

alias cl=clear

alias ls='ls -Gh'
alias la='ls -la'
alias vim="nvim"
export EDITOR='vim'

alias py="python3"
alias senv="source venv/bin/activate"
alias nenv="python3 -m venv ./venv && source venv/bin/activate"

alias mumi="magic update && magic install"
alias ms="magic shell"
alias minit="magic init --format mojoproject -c conda-forge -c https://conda.modular.com/max-nightly/"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/usr/local/opt/gcc/bin:$PATH"
export GCC_PATH="/opt/homebrew/bin/"

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export PATH="$PATH:/Users/joshuajamesventer/.modular/bin"

export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

export JAVA_HOME=$(/usr/libexec/java_home -v 21)

export GPG_TTY=$(tty)

export PATH="/opt/homebrew/opt/ghc@9.6/bin:$PATH"

# Workaround for tmux's issues
bindkey '^R' history-incremental-search-backward
bindkey '^P' up-history

eval "$(starship init zsh)"
