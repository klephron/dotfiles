# Gentoo
alias gentoo-sysupdate="sudo emerge --sync && sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias gentoo-sysupdateall="sudo emerge --sync && sudo emerge -aDNuv @world"

alias gentoo-sysupdate.emerge="sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias gentoo-sysupdateall.emerge="sudo emerge -aDNuv @world"

alias gentoo-ntp-sync="sudo ntpdate -b -u 0.gentoo.pool.ntp.org"

# Arch
alias pac-update="sudo pacman -Syu"
alias pac-rmorph="sudo pacman -Rns \$(pacman -Qdtq)"
alias pac-list="LC_ALL=C.UTF-8 pacman -Qi | awk '/^Name/{name=\$3} /^Installed Size/{print \$4\$5, name}' | LC_ALL=C.UTF-8 sort -h"
alias yayn="yay --answerdiff none --answerclean none --answeredit none"
alias yayni="yayn --ignore \$(< /etc/pacman-ignore.txt tr '\\n' ',' | sed 's/,$//')"

# Dirstack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Monitor
alias 2160p="sed -i --follow-symlinks -E 's/^Xft.dpi:.*/Xft.dpi:144/' ~/.Xresources && xrdb ~/.Xresources && autorandr --load 1080-1.25_2160 && xrandr --output eDP --filter bilinear && echo 'awesome.restart()' | awesome-client"
alias 1080p="sed -i --follow-symlinks -E 's/^Xft.dpi:.*/Xft.dpi:96/' ~/.Xresources && xrdb ~/.Xresources && autorandr --load 1080 && xrandr --output eDP --filter bilinear && echo 'awesome.restart()' | awesome-client"

# SSH
alias ssh="TERM=tmux-256color COLORTERM=truecolor ssh"
alias ssh-devpod="TERM=tmux-256color COLORTERM=truecolor ssh -p 2222 -l root"
alias ssh-nc="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null"

# Docker
alias docker-ip='docker inspect -f "{{ .Name}} {{ .NetworkSettings.IPAddress }}"'
alias docker-ips='docker inspect -f "{{ .Name}} {{ .NetworkSettings.IPAddress }}" $(docker ps -q)'

# Ownership
alias chownikit="sudo chown nikit:nikit -R ."

# Others
alias c="clear"
alias o="xdg-open"

# Clipboard
alias clip="xclip -sel c"

# alias ls="ls --color -F"
# alias ll="ls --color -lh"
alias ls="eza -F"
alias ll="ls -l"
alias lsa="ls -a"
alias lla="ls -la"

alias info='info --vi-keys'

alias ta="tmux attach || tmux"
alias jl="lazygit"
alias jd="lazydocker"
alias v="nvim"
alias py="python"
