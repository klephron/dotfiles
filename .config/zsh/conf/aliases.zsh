alias ls="ls --color -F"
alias ll="ls --color -lh"

alias sysupdate="sudo emaint sync -A && sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias sysupdateall="sudo emaint sync -A && sudo emerge -aDNuv @world"

alias sysupdate_emerge="sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias sysupdateall_emerge="sudo emerge -aDNuv @world"

# Dirstack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index
