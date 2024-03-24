# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/joshuajamesventer/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/joshuajamesventer/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/joshuajamesventer/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/joshuajamesventer/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias vim=nvim

export PATH="/Users/joshuajamesventer/.npm-global/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="/usr/local/opt/gcc/bin:$PATH"
export GCC_PATH="/opt/homebrew/bin/"

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

export PATH="/usr/local/bin:$PATH"

export PATH="/opt/homebrew/bin:$PATH"

eval "$(starship init zsh)"