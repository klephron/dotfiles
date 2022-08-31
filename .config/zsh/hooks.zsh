# panel name
precmd() 
{
# append the current directory (%~), substitute home directories with a tilde.
# "\a" bell (man 1 echo)
# "print" must be used here; echo cannot handle prompt expansions (%L)
  # print -Pn "\e]0;%~ zsh[%L] $(id --user --name)@$(hostname)\a"
  print -Pn "\e]0;$(id --user --name)@$(hostname): zsh[%L] %~\a"
}

# precmd() {
#   if [[ -n "$TMUX" ]]; then
#     tmux setenv "$(tmux display -p 'TMUX_PWD_#D')" "$PWD"
#   fi
# }
