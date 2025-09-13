# panel name
precmd()
{
# append the current directory (%~), substitute home directories with a tilde.
# "\a" bell (man 1 echo)
  print -Pn "\e]0;$(id --user --name)@$(hostname) %~\a"
}

# precmd() {
#   if [[ -n "$TMUX" ]]; then
#     tmux setenv "$(tmux display -p 'TMUX_PWD_#D')" "$PWD"
#   fi
# }
