function restart () {
  sudo rc-service $1 restart
}

function venv () {
  source $1/bin/activate
}

function asdf-latest () {
  for tool in $(asdf plugin list); do
    asdf install "${tool}" latest  \
      &&  asdf global "${tool}" latest  \
      &&  echo "${tool} set globally"
  done
}
