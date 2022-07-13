if [ -f ~/.aliases ] ; then
	source ~/.aliases
fi

if [ -f ~/.profile ] ; then
	source ~/.profile
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="aih1013"
#ZSH_THEME="agnoster"

# Example aliases
#alias zshconfig="mate ~/.zshrc"
#alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git macos brew virtualenv docker kubectl gcloud zsh-autosuggestions history-substring-search zsh-syntax-highlighting terraform kube-ps1)

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

test -e "$ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" && source "$ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [ -x /home/linuxbrew/.linuxbrew/bin/brew ];
then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv) "
fi

if [ -x "$HOME/.pyenv/bin/pyenv" ]; then
    export PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH"
    eval "$($HOME/.pyenv/bin/pyenv init -)"
fi

if [ -x ~/.jenv/bin/jenv ]; then 
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(~/.jenv/bin/jenv init -)"
fi

if [ -x "$(which direnv)" ]; then
    eval "$(direnv hook zsh)"
fi

if [ -d "$HOME/.nvm" ]; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
fi

if [ -d "$HOME/bin" ]; then
	export PATH="$HOME/bin:$PATH"
fi

