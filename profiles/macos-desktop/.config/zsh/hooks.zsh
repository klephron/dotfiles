# panel name
precmd()
{
  print -Pn "\e]0;$(id -u -n)@$(hostname) %~\a"
}
