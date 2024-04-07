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

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=1000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

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

