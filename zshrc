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
start_starship(){
    eval "$(starship init zsh)"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Loading macOS zsh config..."

    export PATH="/opt/homebrew/bin:$PATH"

    alias ll='ls -laG'
    alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
    alias oa='open -a'
    alias updall='brew update && brew upgrade'

    echo "Loaded macOS"


elif [[ "$OSTYPE" == "linux-gnu"* ]]; then

    if command -v pacman &>/dev/null; then
        echo "Loading Arch zsh config..."

        alias updall='sudo pacman -Syu'
    elif command -v apt &>/dev/null; then
        echo "Loading Debian zsh config..."

        alias updall='sudo apt update && sudo apt upgrade'
	alias i='sudo apt install'

    fi

    echo "Loading linux zsh config..."

    export PATH="/usr/local/bin:$PATH"

    alias sudonvim='sudo -E nvim'
    alias ll='ls -lah --color=auto'
fi

echo "Loading unix zsh config"

start_ssh_agent
if command -v starship &> /dev/null; then
	echo "Launching starship..."
        start_starship()
else
	echo "Starship is not installed"
fi

export EDITOR='nvim'

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
