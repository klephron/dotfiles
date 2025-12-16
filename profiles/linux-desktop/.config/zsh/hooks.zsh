precmd() {
  # append the current directory (%~), substitute home directories with a tilde.
  # "\a" bell (man 1 echo)

  # print -Pn "\e]0;$(id -u -n)@$(hostname):%~\a"

  print -Pn "\e]0;%~\a"

  # if [[ -n "$TMUX" ]]; then
  #   tmux setenv "$(tmux display -p 'TMUX_PWD_#D')" "$PWD"
  # fi
}
