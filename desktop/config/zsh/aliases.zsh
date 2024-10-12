# Gentoo
alias gentoo_sysupdate="sudo emerge --sync && sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias gentoo_sysupdateall="sudo emerge --sync && sudo emerge -aDNuv @world"

alias gentoo_sysupdate.emerge="sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias gentoo_sysupdateall.emerge="sudo emerge -aDNuv @world"

alias gentoo_ntp-sync="sudo ntpdate -b -u 0.gentoo.pool.ntp.org"

# Arch
alias pacupdate="sudo pacman -Syu"
alias yayupdate="yay --answerdiff None --answerclean None --answeredit None"

# Dirstack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Monitor
alias 2160p="sed -i --follow-symlinks -E 's/^Xft.dpi:.*/Xft.dpi:144/' ~/.Xresources && xrdb ~/.Xresources && autorandr --load dual_scale-1.25 && xrandr --output eDP --filter bilinear && echo 'awesome.restart()' | awesome-client"
alias 1080p="sed -i --follow-symlinks -E 's/^Xft.dpi:.*/Xft.dpi:96/' ~/.Xresources && xrdb ~/.Xresources && autorandr --load laptop && xrandr --output eDP --filter bilinear && echo 'awesome.restart()' | awesome-client"

# SSH
alias ssh="TERM=tmux-256color COLORTERM=truecolor ssh"
alias ssh-devpod="TERM=tmux-256color COLORTERM=truecolor ssh -p 2222 -l root"
alias ssh-nocheck="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null"

# Docker
alias docker-ip='docker inspect -f "{{ .Name}} {{ .NetworkSettings.IPAddress }}"'
alias docker-ips='docker inspect -f "{{ .Name}} {{ .NetworkSettings.IPAddress }}" $(docker ps -q)'

# Ownership
alias chownikit="sudo chown nikit:nikit -R ."

# Pacman
alias pacman-list="LC_ALL=C.UTF-8 pacman -Qi | awk '/^Name/{name=\$3} /^Installed Size/{print \$4\$5, name}' | LC_ALL=C.UTF-8 sort -h"

# Others
alias c="clear"
alias o="xdg-open"

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

