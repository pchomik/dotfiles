function set_aliases() {
    alias noproxy='unset https_proxy http_proxy no_proxy'
    alias check-net='curl -vL https://wp.pl'
    alias ls='ls --color=auto'
    alias cat='bat -p'
    alias ls='eza --icons=auto'
    alias ll='ls -l'
    alias tl='tldr'
    alias ssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ServerAliveInterval=10 -o ServerAliveCountMax=1000 -o TCPKeepAlive=yes'
    alias scp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
    alias gen_pass='openssl rand -base64 16'
}
