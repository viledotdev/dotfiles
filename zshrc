start_ssh_agent() {
  if [ -f "$HOME/.ssh/agent.env" ]; then
    source "$HOME/.ssh/agent.env" > /dev/null 2>&1
  fi

  if [ -z "$SSH_AGENT_PID" ] || ! ps -p $SSH_AGENT_PID > /dev/null 2>&1; then
    ssh_agent_output=$(ssh-agent -s)

    formatted_output=$(echo "$ssh_agent_output" | awk '{ gsub(/; /, "\n"); print}' | grep -v "echo" | tr '\n' '; ' | awk '{ gsub(/;;/, ";"); print}')
    
    echo "$formatted_output" > "$HOME/.ssh/agent.env"

    source "$HOME/.ssh/agent.env"

    ssh-add ~/.ssh/github
  fi
}
start_starship() {
    if command -v starship &> /dev/null; then
    	eval "$(starship init zsh)"
	export STARSHIP_CONFIG=~/.config/starship/starship.toml
    else
    	echo "Starship is not installed"
    fi
}
start_fastfetch() {
    if command -v fastfetch &> /dev/null; then
	fastfetch
    else	
        echo "Fastfetch is not installed"
    fi
}

export PATH=~/.bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export EDITOR='nvim'

alias ll='ls -laG'
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias oa='open -a'
#Go aliases
alias gt='go test -bench=. -benchmem -cover'
# Neovim
alias nv='nvim'
alias nvdot='cd ~/Development/dotfiles && nvim'
alias nvc='cd ~/Development/dotfiles/nvim && nvim'
# Brew
alias updall='brew update && brew upgrade'
alias buni='brew uninstall'
alias bi='brew install'
alias bt='brew tap'
# Miscellaneous
alias c='clear'
alias dock='open /Applications/Docker.app/'
alias disc='open /Applications/Discord.app/'
alias crm='cd ~/Development/crm/'
alias crmb='cd ~/Development/crm/backend/'
alias crmf='cd ~/Development/crm/frontend/'
#alias neo='clear && neofetch --source ~/Development/dotfiles/_assets/vile.txt'
alias neo='clear && fastfetch'
alias ..='cd ..'
alias ...='cd ../..'
# Obsidian shortcuts
alias oo='cd $HOME/library/Mobile\ Documents/iCloud~md~obsidian/Documents/Vile'
alias oor='nvim $HOME/library/Mobile\ Documents/iCloud~md~obsidian/Documents/Vile/inbox/*.md'
alias nvoo='cd $HOME/library/Mobile\ Documents/iCloud~md~obsidian/Documents/Vile && nvim'
#Apps
export PATH=$PATH:/usr/local/go/bin
#java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$JAVA_HOME/bin:$PATH"


start_ssh_agent
start_starship
#start_fastfetch

autoload -Uz compinit
compinit

# pnpm
export PNPM_HOME="/Users/victor/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
