function restart () {
  sudo rc-service $1 restart
}

function venv () {
  source $1/bin/activate
}
