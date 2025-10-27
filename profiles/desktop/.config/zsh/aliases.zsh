alias gentoo-sysupdate="sudo emerge --sync && sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias gentoo-sysupdateall="sudo emerge --sync && sudo emerge -aDNuv @world"

alias gentoo-sysupdate.emerge="sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias gentoo-sysupdateall.emerge="sudo emerge -aDNuv @world"

alias gentoo-ntp-sync="sudo ntpdate -b -u 0.gentoo.pool.ntp.org"


alias pacupdate="sudo pacman -Syu"
alias pacrmorph="sudo pacman -Rns \$(pacman -Qdtq)"
alias paclist="LC_ALL=C.UTF-8 pacman -Qi | awk '/^Name/{name=\$3} /^Installed Size/{print \$4\$5, name}' | LC_ALL=C.UTF-8 sort -h"
alias yayn="yay --answerdiff none --answerclean none --answeredit none"
alias yayni="yayn --ignore \$(< /etc/pacman-ignore.txt tr '\\n' ',' | sed 's/,$//')"


alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index


alias 2160p="sed -i --follow-symlinks -E 's/^Xft.dpi:.*/Xft.dpi:144/' ~/.Xresources && xrdb ~/.Xresources && autorandr --load 1080-1.25_2160 && xrandr --output eDP --filter bilinear && echo 'awesome.restart()' | awesome-client"
alias 1080p="sed -i --follow-symlinks -E 's/^Xft.dpi:.*/Xft.dpi:96/' ~/.Xresources && xrdb ~/.Xresources && autorandr --load 1080 && xrandr --output eDP --filter bilinear && echo 'awesome.restart()' | awesome-client"


alias ssh="TERM=tmux-256color COLORTERM=truecolor ssh"
alias sshnc="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null"
alias sshdev="TERM=tmux-256color COLORTERM=truecolor sshnc -p 2222 -l root"


alias dockerip='docker inspect -f "{{ .Name}} {{ .NetworkSettings.IPAddress }}"'
alias dockerips='docker inspect -f "{{.Config.Image}} {{.Name}} {{.NetworkSettings.IPAddress}}" $(docker ps -q) \
  | awk "{gsub(/^\//, \"\", \$2); print}"'


if [[ -x "$(command -v eza)" ]]; then
  alias ls="eza -F --sort Name"
else
  alias ls="ls --color -Fh"
fi

alias ll="ls -l"
alias lsa="ls -a"
alias lla="ls -la"
alias info='info --vi-keys'
alias grep="grep --color=auto"


alias o="xdg-open"
alias c="xclip -sel c"
alias ci="clipboard-get"
alias co="clipboard-set"


alias ta="tmux attach || tmux"
alias jl="lazygit"
alias jd="lazydocker"
alias v="nvim"
alias py="python"
alias k="kubectl"


alias chownr="sudo chown klephron:klephron -R ."
