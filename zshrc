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
    eval "$(starship init zsh)"
}
OS_ICON=""
if [[ "$OSTYPE" == "darwin"* ]]; then

    export PATH="/opt/homebrew/bin:$PATH"

    alias ll='ls -laG'
    alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
    alias oa='open -a'
    alias updall='brew update && brew upgrade'

    OS_ICON=""


elif [[ "$OSTYPE" == "linux-gnu"* ]]; then

    if command -v pacman &>/dev/null; then

        alias updall='sudo pacman -Syu'

        OS_ICON="󰣇"
    elif command -v apt &>/dev/null; then

        alias updall='sudo apt update && sudo apt upgrade'
	alias i='sudo apt install'

        OS_ICON="󰕈"
    fi


    export PATH="/usr/local/bin:$PATH"

    alias sudonvim='sudo -E nvim'
    alias ll='ls -lah --color=auto'

fi


start_ssh_agent
if command -v starship &> /dev/null; then
        start_starship
else
	echo "Starship is not installed"
fi

if command -v neofetch &> /dev/null; then
    neofetch
else	
    echo "Neofetch is not installed"
fi

export EDITOR='nvim'

# Aliases
alias ..='cd ..'
alias ...='cd ../..'

echo "Welcome aboard, $USER! $OS_ICON"
