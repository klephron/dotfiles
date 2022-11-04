alias c="clear"
alias o="xdg-open"
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias info='info --vi-keys'

alias sysupdate="sudo eix-sync && sudo emerge -aDNuvq @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias sysupdateall="sudo eix-sync && sudo emerge -aDNuvq @world"

alias sysupdate.emerge="sudo emerge -aDNuvq @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias sysupdateall.emerge="sudo emerge -aDNuvq @world"

# Dirstack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# TMUX
alias ta="tmux attach || tmux"
