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
start_neofetch() {
    if command -v neofetch &> /dev/null; then
        neofetch --source ~/Development/dotfiles/_assets/vile.txt
    else	
        echo "Neofetch is not installed"
    fi
}

export PATH="/opt/homebrew/bin:$PATH"
export EDITOR='nvim'

alias ll='ls -laG'
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias oa='open -a'
alias nv='nvim'
alias nvdot='cd ~/Development/dotfiles && nvim'
alias updall='brew update && brew upgrade'
alias uninst='brew uninstall'
alias c='clear'
alias neo='clear && neofetch --source ~/Development/dotfiles/_assets/vile.txt'
alias ..='cd ..'
alias ...='cd ../..'

start_ssh_agent
start_starship
start_neofetch

